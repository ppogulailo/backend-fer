import {
  Body,
  Controller,
  ForbiddenException,
  Get,
  Post,
  Req,
  Res,
  UseGuards,
} from '@nestjs/common';
import type { Response } from 'express';
import { UserType } from '@prisma/client';
import { AuthService } from './auth.service';
import {
  COOKIE_ACCESS_TOKEN,
  COOKIE_REFRESH_TOKEN,
  COOKIE_OPTIONS,
  COOKIE_CLEAR_OPTIONS,
} from './auth.constants';
import { AuthDto } from './dto/auth.dto';
import { SignUpDto } from './dto/sign-up.dto';
import { JwtAuthGuard } from './jwt-auth.guard';
import type { RequestWithAuth } from '../common/context/request.types';

type RequestWithCookies = RequestWithAuth & {
  cookies?: Record<string, string | undefined>;
};

@Controller('auth')
export class AuthController {
  constructor(private readonly auth: AuthService) {}

  @Post('signup')
  async signup(
    @Body() dto: SignUpDto,
    @Res({ passthrough: true }) res: Response,
  ) {
    const tokens = await this.auth.signUp({
      email: dto.email,
      password: dto.password,
    });
    this.setAuthCookies(res, tokens.accessToken, tokens.refreshToken);
    return { jwt: tokens.accessToken, id: tokens.id };
  }

  @Post('signin')
  async signin(
    @Body() dto: AuthDto,
    @Res({ passthrough: true }) res: Response,
  ) {
    const tokens = await this.auth.signIn({
      email: dto.email,
      password: dto.password,
    });
    this.setAuthCookies(res, tokens.accessToken, tokens.refreshToken);
    return { jwt: tokens.accessToken, id: tokens.id };
  }

  @UseGuards(JwtAuthGuard)
  @Get('me')
  async me(@Req() req: RequestWithAuth) {
    const user = await this.auth.getMe(req.user!.userId);
    const role = user.type === UserType.CANDIDATE ? 'candidate' : 'client';
    return { id: user.id, email: user.email, role };
  }

  @UseGuards(JwtAuthGuard)
  @Get('logout')
  async logout(
    @Req() req: RequestWithAuth,
    @Res({ passthrough: true }) res: Response,
  ) {
    if (req.user?.userId) await this.auth.logout(req.user.userId);
    this.clearAuthCookies(res);
    return { ok: true };
  }

  @Get('refresh')
  async refresh(
    @Req() req: RequestWithCookies,
    @Res({ passthrough: true }) res: Response,
  ) {
    const refreshToken = req.cookies?.[COOKIE_REFRESH_TOKEN] as string;
    const result = await this.auth.refreshTokens(refreshToken);
    if (!result) {
      throw new ForbiddenException('Invalid or expired refresh token');
    }
    res.cookie(COOKIE_ACCESS_TOKEN, result.accessToken, COOKIE_OPTIONS);
    return { jwt: result.accessToken };
  }

  private setAuthCookies(
    res: Response,
    accessToken: string,
    refreshToken: string,
  ): void {
    res.cookie(COOKIE_ACCESS_TOKEN, accessToken, COOKIE_OPTIONS);
    res.cookie(COOKIE_REFRESH_TOKEN, refreshToken, COOKIE_OPTIONS);
  }

  private clearAuthCookies(res: Response): void {
    res.clearCookie(COOKIE_ACCESS_TOKEN, COOKIE_CLEAR_OPTIONS);
    res.clearCookie(COOKIE_REFRESH_TOKEN, COOKIE_CLEAR_OPTIONS);
  }
}
