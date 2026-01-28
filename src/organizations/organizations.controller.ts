import {
  Controller,
  Get,
  Param,
  ParseIntPipe,
  Post,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { OrgContextGuard } from '../common/context/org-context.guard';
import { AuthCtx } from '../common/context/auth-context.decorators';
import type { AuthContext } from '../common/context/auth-context.types';
import { OrganizationsService } from './organizations.service';

@UseGuards(JwtAuthGuard, OrgContextGuard)
@Controller('orgs')
export class OrganizationsController {
  constructor(private readonly orgs: OrganizationsService) {}

  @Get()
  async list(@AuthCtx() ctx: AuthContext) {
    return {
      currentOrgId: ctx.currentOrgId,
      orgs: await this.orgs.listForUser(
        Number(ctx.userId),
        Number(ctx.currentOrgId),
      ),
    };
  }

  @Post(':orgId/switch')
  async switchOrg(
    @AuthCtx() ctx: AuthContext,
    @Param('orgId', ParseIntPipe) orgId: number,
  ) {
    return this.orgs.switchOrg(Number(ctx.userId), ctx.email, orgId);
  }
}
