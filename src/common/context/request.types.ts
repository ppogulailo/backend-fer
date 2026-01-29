import { Request } from 'express';
import { RequestUser } from '../../auth/auth.types';
import { AuthContext } from './auth-context.types';

/** Express request with JWT user (and optional auth context from OrgContextGuard). */
export type RequestWithAuth = Request & {
  user?: RequestUser;
  authContext?: AuthContext;
};
