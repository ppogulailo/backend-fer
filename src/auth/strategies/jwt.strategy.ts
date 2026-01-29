import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import type { Request } from 'express';
import { ConfigService } from '@nestjs/config';

import { COOKIE_ACCESS_TOKEN } from '../auth.constants';
import type { JwtPayload, RequestUser } from '../auth.types';

function fromCookieOrBearer(req: Request): string | null {
  const cookie = req.cookies?.[COOKIE_ACCESS_TOKEN];
  if (cookie) return cookie;
  return ExtractJwt.fromAuthHeaderAsBearerToken()(req);
}

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly config: ConfigService) {
    super({
      jwtFromRequest: fromCookieOrBearer,
      ignoreExpiration: false,
      secretOrKey: config.getOrThrow<string>('JWT_SECRET'),
    });
  }

  validate(payload: JwtPayload): RequestUser {
    return { userId: Number(payload.sub), email: payload.email };
  }
}
