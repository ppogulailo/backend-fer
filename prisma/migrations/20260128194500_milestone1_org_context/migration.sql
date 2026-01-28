-- Add VIEWER role to existing enum
ALTER TYPE "AccessRole" ADD VALUE IF NOT EXISTS 'VIEWER';

-- CreateTable
CREATE TABLE "user_current_orgs" (
    "userId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_current_orgs_pkey" PRIMARY KEY ("userId")
);

-- CreateIndex
CREATE INDEX "user_current_orgs_companyId_idx" ON "user_current_orgs"("companyId");

-- AddForeignKey
ALTER TABLE "user_current_orgs" ADD CONSTRAINT "user_current_orgs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_current_orgs" ADD CONSTRAINT "user_current_orgs_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

