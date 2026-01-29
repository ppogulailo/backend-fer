/** JWT payload (access or refresh). */
export type JwtPayload = {
  sub: string;
  email: string;
};

/** User attached to request by JwtAuthGuard. */
export type RequestUser = {
  userId: number;
  email: string;
};

export type SignUpInput = { email: string; password: string };
export type SignInInput = { email: string; password: string };
export type AuthTokens = {
  accessToken: string;
  refreshToken: string;
  id: number;
};
