import { Global, Module } from '@nestjs/common';
import { OrgContextService } from './org-context.service';
import { OrgContextGuard } from './org-context.guard';

@Global()
@Module({
  providers: [OrgContextService, OrgContextGuard],
  exports: [OrgContextService, OrgContextGuard],
})
export class ContextModule {}
