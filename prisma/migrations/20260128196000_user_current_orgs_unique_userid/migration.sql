-- Ensure `user_current_orgs.userId` is a unique selector (not necessarily a PK)
-- and align the DB with the Prisma model (`userId Int @unique`).

-- Drop the PK on userId (created in an earlier migration)
ALTER TABLE "user_current_orgs" DROP CONSTRAINT IF EXISTS "user_current_orgs_pkey";

-- Add a unique index on userId (idempotent)
CREATE UNIQUE INDEX IF NOT EXISTS "user_current_orgs_userId_key" ON "user_current_orgs"("userId");

