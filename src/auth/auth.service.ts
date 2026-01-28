import { Injectable, NotFoundException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UserType } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

function assertDevOnly() {
  if (process.env.NODE_ENV === 'production') {
    // Intentionally not exposing this in prod.
    throw new NotFoundException();
  }
}

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
  ) {}

  async devLogin(email: string): Promise<{ accessToken: string }> {
    assertDevOnly();

    const user = await this.prisma.user.upsert({
      where: { email },
      create: {
        email,
        password: 'dev',
        type: UserType.TEAM_MEMBER,
        isActive: true,
      },
      update: {
        isActive: true,
      },
      select: {
        id: true,
        email: true,
      },
    });

    const accessToken = await this.jwt.signAsync(
      { email: user.email },
      {
        subject: String(user.id),
      },
    );

    return { accessToken };
  }
}
