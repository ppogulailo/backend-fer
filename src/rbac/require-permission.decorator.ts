import { SetMetadata } from '@nestjs/common';
import { RBAC_REQUIRED_PERMISSIONS_KEY } from './rbac.constants';

export function RequirePermission(...permissions: string[]) {
  return SetMetadata(RBAC_REQUIRED_PERMISSIONS_KEY, permissions);
}
