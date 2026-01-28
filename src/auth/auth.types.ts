export type JwtPayload = {
  sub: string; // userId
  email: string;
};

export type RequestUser = {
  userId: number;
  email: string;
};
