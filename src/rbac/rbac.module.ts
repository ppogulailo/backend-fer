import { Module } from '@nestjs/common';
import { RequirePermissionGuard } from './require-permission.guard';

@Module({
  providers: [RequirePermissionGuard],
  exports: [RequirePermissionGuard],
})
export class RbacModule {}
