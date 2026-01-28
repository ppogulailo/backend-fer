import { AuthContext } from '../common/context/auth-context.types';

export function hasPermission(ctx: AuthContext, permission: string): boolean {
  return ctx.permissions.includes(permission);
}
