/*
  Warnings:

  - The primary key for the `user_current_orgs` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[userId]` on the table `user_current_orgs` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
DO $$
BEGIN
  -- When applying migrations from scratch (e.g. Prisma shadow DB), the
  -- `user_current_orgs` table may not exist yet because it is created later.
  -- Make this migration safe to apply on an empty database.
  IF to_regclass('public.user_current_orgs') IS NOT NULL THEN
    EXECUTE 'ALTER TABLE "user_current_orgs" DROP CONSTRAINT IF EXISTS "user_current_orgs_pkey"';
    EXECUTE 'CREATE UNIQUE INDEX IF NOT EXISTS "user_current_orgs_userId_key" ON "user_current_orgs"("userId")';
  END IF;
END $$;
