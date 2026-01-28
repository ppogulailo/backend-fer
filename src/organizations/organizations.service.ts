import { Injectable, NotFoundException } from '@nestjs/common';
import { AccessRole } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';
import { OrgContextService } from '../common/context/org-context.service';

function roleKey(role: AccessRole): string {
  switch (role) {
    case AccessRole.ORG_ADMIN:
      return 'admin';
    case AccessRole.RECRUITER:
      return 'recruiter';
    case AccessRole.VIEWER:
      return 'viewer';
    case AccessRole.HM:
      return 'hm';
    case AccessRole.REVIEWER:
      return 'reviewer';
    default:
      return String(role).toLowerCase();
  }
}

@Injectable()
export class OrganizationsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly orgContext: OrgContextService,
  ) {}

  async listForUser(userId: number, currentOrgId: number) {
    const memberships = await this.prisma.organizationMembership.findMany({
      where: { userId, isActive: true },
      orderBy: { joinedAt: 'asc' },
      select: {
        company: { select: { id: true, name: true } },
        roleAssignments: {
          where: { isActive: true, departmentId: null },
          orderBy: { assignedAt: 'desc' },
          take: 1,
          select: { role: true },
        },
      },
    });

    return memberships.map((m) => {
      const role = m.roleAssignments[0]?.role ?? AccessRole.RECRUITER;
      return {
        orgId: String(m.company.id),
        name: m.company.name,
        isCurrent: m.company.id === currentOrgId,
        roleKey: roleKey(role),
      };
    });
  }

  async switchOrg(userId: number, email: string, orgId: number) {
    const membership = await this.prisma.organizationMembership.findFirst({
      where: { userId, companyId: orgId, isActive: true },
      select: { id: true },
    });

    if (!membership) {
      throw new NotFoundException('Organization not found for user');
    }

    await this.orgContext.setCurrentOrg(userId, orgId);
    return this.orgContext.resolveAuthContextForOrg({ userId, email }, orgId);
  }
}
