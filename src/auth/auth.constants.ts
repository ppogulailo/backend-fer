export const ACCESS_TOKEN_EXPIRY = '1h';
export const REFRESH_TOKEN_EXPIRY = '7d';
export const COOKIE_ACCESS_TOKEN = 'access_token';
export const COOKIE_REFRESH_TOKEN = 'refresh_token';

const THIRTY_DAYS_MS = 30 * 24 * 60 * 60 * 1000;
export const COOKIE_MAX_AGE_MS = THIRTY_DAYS_MS;

export const COOKIE_OPTIONS = {
  maxAge: COOKIE_MAX_AGE_MS,
  httpOnly: true,
  sameSite: 'lax' as const,
};

export const COOKIE_CLEAR_OPTIONS = {
  httpOnly: true,
  sameSite: 'lax' as const,
};
