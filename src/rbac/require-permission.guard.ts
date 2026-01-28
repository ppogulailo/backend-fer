import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { RBAC_REQUIRED_PERMISSIONS_KEY } from './rbac.constants';
import { RequestWithAuth } from '../common/context/request.types';

@Injectable()
export class RequirePermissionGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const required = this.reflector.getAllAndOverride<string[]>(
      RBAC_REQUIRED_PERMISSIONS_KEY,
      [context.getHandler(), context.getClass()],
    );

    if (!required || required.length === 0) return true;

    const req = context.switchToHttp().getRequest<RequestWithAuth>();
    const ctx = req.authContext;

    if (!ctx) {
      throw new ForbiddenException('Missing auth context');
    }

    const ok = required.every((p) => ctx.permissions.includes(p));
    if (!ok) {
      throw new ForbiddenException('Missing required permission');
    }

    return true;
  }
}
