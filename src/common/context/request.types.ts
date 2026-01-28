import { Request } from 'express';
import { RequestUser } from '../../auth/auth.types';
import { AuthContext } from './auth-context.types';

export type RequestWithAuth = Request & {
  user?: RequestUser;
  authContext?: AuthContext;
};
