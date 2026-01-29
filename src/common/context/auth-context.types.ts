/** Resolved auth + org context after JwtAuthGuard and OrgContextGuard. */
export type AuthContext = {
  userId: string;
  email: string;
  currentOrgId: string;
  roleKey: string;
  permissions: string[];
};
