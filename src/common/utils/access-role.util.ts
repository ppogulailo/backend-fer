import { AccessRole } from '@prisma/client';

const ROLE_TO_KEY: Record<AccessRole, string> = {
  [AccessRole.ORG_ADMIN]: 'admin',
  [AccessRole.RECRUITER]: 'recruiter',
  [AccessRole.VIEWER]: 'viewer',
  [AccessRole.HM]: 'hm',
  [AccessRole.REVIEWER]: 'reviewer',
};

export function accessRoleToKey(role: AccessRole): string {
  return ROLE_TO_KEY[role] ?? String(role).toLowerCase();
}
