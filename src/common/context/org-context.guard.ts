import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { OrgContextService } from './org-context.service';
import { RequestWithAuth } from './request.types';

@Injectable()
export class OrgContextGuard implements CanActivate {
  constructor(private readonly orgContext: OrgContextService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const req = context.switchToHttp().getRequest<RequestWithAuth>();
    // JwtAuthGuard populates req.user
    if (!req.user) return false;

    req.authContext = await this.orgContext.resolveAuthContext(req.user);
    return true;
  }
}
