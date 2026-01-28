import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { AuthContext } from './auth-context.types';
import { RequestWithAuth } from './request.types';

export const AuthCtx = createParamDecorator(
  (_: unknown, ctx: ExecutionContext): AuthContext => {
    const req = ctx.switchToHttp().getRequest<RequestWithAuth>();
    return req.authContext as AuthContext;
  },
);

export const CurrentOrgId = createParamDecorator(
  (_: unknown, ctx: ExecutionContext): string => {
    const req = ctx.switchToHttp().getRequest<RequestWithAuth>();
    return (req.authContext as AuthContext).currentOrgId;
  },
);

export const UserId = createParamDecorator(
  (_: unknown, ctx: ExecutionContext): string => {
    const req = ctx.switchToHttp().getRequest<RequestWithAuth>();
    return (req.authContext as AuthContext).userId;
  },
);
