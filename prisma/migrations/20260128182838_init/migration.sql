-- Required for Prisma fields using @db.Citext
CREATE EXTENSION IF NOT EXISTS citext;

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('RECRUITER_NEW_APPLICATION', 'REVIEWER_REQUEST_FEEDBACK', 'INTERVIEW_SCHEDULED', 'INTERVIEW_FEEDBACK_DUE', 'JOB_APPROVAL_REQUEST', 'JOB_APPROVED', 'JOB_REJECTED', 'PIPELINE_MOVED', 'MESSAGE_NEW', 'SYSTEM_ALERT');

-- CreateEnum
CREATE TYPE "NotificationChannel" AS ENUM ('IN_APP', 'EMAIL', 'PUSH');

-- CreateEnum
CREATE TYPE "NotificationDeliveryStatus" AS ENUM ('PENDING', 'SENT', 'FAILED', 'SKIPPED');

-- CreateEnum
CREATE TYPE "AccessApplyMode" AS ENUM ('PER_ROLE', 'PER_JOB_AND_CANDIDATE');

-- CreateEnum
CREATE TYPE "ApplicationFileType" AS ENUM ('RESUME', 'COVER_LETTER', 'PORTFOLIO', 'OTHER');

-- CreateEnum
CREATE TYPE "ApplicationStatus" AS ENUM ('SUBMITTED', 'SHORTLISTED', 'INTERVIEW_SCHEDULED', 'INTERVIEWED', 'OFFERED', 'REJECTED', 'WITHDRAWN', 'HIRED');

-- CreateEnum
CREATE TYPE "CandidateCompanyType" AS ENUM ('SME', 'STARTUP', 'CORPORATION');

-- CreateEnum
CREATE TYPE "CandidateLevel" AS ENUM ('JUNIOR', 'MID', 'SENIOR');

-- CreateEnum
CREATE TYPE "CandidateValuesMatchType" AS ENUM ('PRE_SHORTLISTED_INSIGHT', 'ADVANCED_FIT_REVIEW');

-- CreateEnum
CREATE TYPE "CompanySize" AS ENUM ('1-50', '51-100', '101-500', '501-1000', '1001-5000', '5001-10000', '10001-50000', '50001-100000');

-- CreateEnum
CREATE TYPE "CompanyType" AS ENUM ('SME', 'STARTUP', 'CORPORATION');

-- CreateEnum
CREATE TYPE "DevelopmentStrategy" AS ENUM ('SKILLS_FIRST', 'CULTURE_FIRST');

-- CreateEnum
CREATE TYPE "EmploymentType" AS ENUM ('FREELANCE', 'LONG_TERM');

-- CreateEnum
CREATE TYPE "ExperienceLevel" AS ENUM ('JUNIOR', 'MID', 'SENIOR');

-- CreateEnum
CREATE TYPE "FeedbackVerdict" AS ENUM ('THUMBS_UP', 'THUMBS_DOWN');

-- CreateEnum
CREATE TYPE "HiringFocus" AS ENUM ('BEST_SKILLS_FIT', 'BEST_CULTURE_FIT');

-- CreateEnum
CREATE TYPE "InterviewCandidateStatus" AS ENUM ('PENDING', 'ACCEPTED', 'DECLINED', 'RESCHEDULED');

-- CreateEnum
CREATE TYPE "InvitationStatus" AS ENUM ('PENDING', 'ACCEPTED', 'EXPIRED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "JobLanguage" AS ENUM ('EN', 'FR', 'ES', 'DE');

-- CreateEnum
CREATE TYPE "JobStatus" AS ENUM ('DRAFT', 'LIVE', 'APPROVED', 'REJECTED', 'APPROVAL_PENDING', 'ARCHIVED', 'HIDDEN', 'EXPIRED');

-- CreateEnum
CREATE TYPE "JobType" AS ENUM ('FULL_TIME', 'PART_TIME', 'CONTRACT', 'TEMPORARY', 'INTERNSHIP', 'REMOTE');

-- CreateEnum
CREATE TYPE "LongTermAlignment" AS ENUM ('IMMEDIATE_IMPACT', 'GROWTH_POTENTIAL');

-- CreateEnum
CREATE TYPE "QuestionGroup" AS ENUM ('PRE_SHORTLIST', 'PRE_INTERVIEW');

-- CreateEnum
CREATE TYPE "QuestionType" AS ENUM ('LIKERT', 'OPEN');

-- CreateEnum
CREATE TYPE "StageType" AS ENUM ('CUSTOM', 'INITIAL', 'SHORTLIST', 'INTERVIEW', 'OFFER', 'REJECT', 'WITHDRAWN');

-- CreateEnum
CREATE TYPE "InterviewType" AS ENUM ('PHONE', 'VIDEO', 'ONSITE', 'TAKE_HOME', 'OTHER');

-- CreateEnum
CREATE TYPE "InterviewStatus" AS ENUM ('SCHEDULED', 'COMPLETED', 'NO_SHOW', 'CANCELED', 'RESCHEDULED');

-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('ACTIVE', 'CANCELLED', 'EXPIRED', 'SUSPENDED');

-- CreateEnum
CREATE TYPE "SubscriptionTier" AS ENUM ('BASIC', 'PRO', 'CORPORATE');

-- CreateEnum
CREATE TYPE "TodoStatus" AS ENUM ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "TodoType" AS ENUM ('JOB_APPROVAL', 'INTERVIEW_FEEDBACK', 'OFFER_APPROVAL');

-- CreateEnum
CREATE TYPE "Visibility" AS ENUM ('VISIBLE_TO_MATCHED_RECRUITER', 'AVAILABLE_UPON_REQUEST', 'PUBLIC');

-- CreateEnum
CREATE TYPE "WorkArrangement" AS ENUM ('ON_SITE', 'REMOTE', 'HYBRID');

-- CreateEnum
CREATE TYPE "CompensationPeriod" AS ENUM ('YEAR', 'MONTH', 'DAY', 'HOUR');

-- CreateEnum
CREATE TYPE "TalentSource" AS ENUM ('IMPORT', 'APPLIED', 'REFERRED', 'OUTBOUND', 'EVENT', 'OTHER');

-- CreateEnum
CREATE TYPE "TalentStage" AS ENUM ('NEW', 'CONTACTED', 'ENGAGED', 'INTERVIEWING', 'ON_HOLD', 'DISQUALIFIED');

-- CreateEnum
CREATE TYPE "TalentPriority" AS ENUM ('LOW', 'MEDIUM', 'HIGH');

-- CreateEnum
CREATE TYPE "AccessRole" AS ENUM ('ORG_ADMIN', 'HM', 'RECRUITER', 'REVIEWER');

-- CreateEnum
CREATE TYPE "FeedbackMoment" AS ENUM ('T0_POST_INTERVIEW', 'T3_MONTHS', 'T6_MONTHS');

-- CreateEnum
CREATE TYPE "FeedbackStatus" AS ENUM ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'OVERDUE', 'SKIPPED');

-- CreateEnum
CREATE TYPE "ReviewerSessionStatus" AS ENUM ('ACTIVE', 'EXPIRED', 'REVOKED');

-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('TEAM_MEMBER', 'CANDIDATE');

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "email" CITEXT NOT NULL,
    "password" TEXT NOT NULL,
    "type" "UserType" NOT NULL DEFAULT 'TEAM_MEMBER',
    "emailVerified" BOOLEAN NOT NULL DEFAULT false,
    "lastLogin" TIMESTAMP(3),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isLocked" BOOLEAN NOT NULL DEFAULT false,
    "firstTimeLogin" BOOLEAN NOT NULL DEFAULT true,
    "resetTokenHash" TEXT,
    "resetTokenExpires" TIMESTAMP(3),
    "isRoleActive" BOOLEAN NOT NULL DEFAULT false,
    "companyId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "profiles" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "firstName" TEXT,
    "lastName" TEXT,
    "jobTitle" TEXT,
    "phone" TEXT,
    "profilePicture" TEXT,
    "companyEmail" TEXT,
    "preferredLanguage" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissions" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_roles" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,

    CONSTRAINT "user_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role_permissions" (
    "id" SERIAL NOT NULL,
    "roleId" INTEGER NOT NULL,
    "permissionId" INTEGER NOT NULL,

    CONSTRAINT "role_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_permissions" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "permissionId" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "user_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_sessions" (
    "id" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "deviceInfo" JSONB,
    "ipAddress" TEXT,
    "location" TEXT,
    "userAgent" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "lastActivity" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PipelineStage" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "position" INTEGER NOT NULL,
    "companyId" INTEGER,
    "jobId" INTEGER,
    "isInitialStage" BOOLEAN NOT NULL DEFAULT false,
    "type" "StageType" NOT NULL DEFAULT 'CUSTOM',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PipelineStage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationFile" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "type" "ApplicationFileType" NOT NULL,
    "fileUrl" TEXT,
    "resumeId" INTEGER,
    "coverLetterId" INTEGER,
    "uploadedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ApplicationFile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Application" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "createdById" INTEGER,
    "status" "ApplicationStatus" NOT NULL DEFAULT 'SUBMITTED',
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "text" TEXT,
    "currentStageId" INTEGER,
    "offerSentAt" TIMESTAMP(3),
    "offerAcceptedAt" TIMESTAMP(3),
    "hiredAt" TIMESTAMP(3),
    "offerConfirmedById" INTEGER,
    "hireConfirmedById" INTEGER,

    CONSTRAINT "Application_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "application_decision_logs" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "action" TEXT NOT NULL,
    "actorId" INTEGER,
    "comment" TEXT,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "application_decision_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pipeline" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "stageId" INTEGER NOT NULL,
    "movedById" INTEGER,
    "movedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "order" INTEGER,

    CONSTRAINT "Pipeline_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ApplicationHistory" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "fromStageId" INTEGER,
    "toStageId" INTEGER,
    "changedById" INTEGER,
    "changedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "note" TEXT,
    "pipelineStageId" INTEGER,

    CONSTRAINT "ApplicationHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Interview" (
    "id" SERIAL NOT NULL,
    "applicationId" INTEGER NOT NULL,
    "scheduledById" INTEGER,
    "scheduledAt" TIMESTAMP(3) NOT NULL,
    "type" "InterviewType" NOT NULL,
    "status" "InterviewStatus" NOT NULL,
    "candidateStatus" "InterviewCandidateStatus",
    "description" TEXT,
    "feedback" TEXT,
    "pipelineId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Interview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CandidateProfile" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "phone" TEXT,
    "country" TEXT,
    "state" TEXT,
    "jobTitle" TEXT,
    "profilePicture" TEXT,
    "aboutMe" TEXT,
    "contactInfoId" INTEGER,
    "professionalProfileId" INTEGER,
    "jobPreferenceId" INTEGER,
    "profileLinksId" INTEGER,
    "enable2fa" BOOLEAN NOT NULL DEFAULT false,
    "hideMyAccount" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CandidateProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ContactInfo" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "linkedin" TEXT,
    "location" TEXT,

    CONSTRAINT "ContactInfo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProfessionalProfile" (
    "id" SERIAL NOT NULL,
    "currentTitle" TEXT,

    CONSTRAINT "ProfessionalProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Resume" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "title" TEXT,
    "uploadedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "professionalProfileId" INTEGER,
    "candidateProfileId" INTEGER,
    "useForApplication" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Resume_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CoverLetter" (
    "id" SERIAL NOT NULL,
    "content" TEXT,
    "url" TEXT,
    "title" TEXT,
    "uploadedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "professionalProfileId" INTEGER,
    "candidateProfileId" INTEGER,
    "useForApplication" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "CoverLetter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JobPreference" (
    "id" SERIAL NOT NULL,
    "preferredRoles" TEXT[],
    "desiredLocations" TEXT[],
    "tags" TEXT[],
    "availability" TEXT,
    "workArrangement" TEXT,
    "salaryExpectation" INTEGER,
    "jobType" "JobType",
    "visibility" "Visibility" NOT NULL DEFAULT 'VISIBLE_TO_MATCHED_RECRUITER',
    "candidateProfileId" INTEGER NOT NULL,

    CONSTRAINT "JobPreference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProfileLinks" (
    "id" SERIAL NOT NULL,
    "github" TEXT,
    "behance" TEXT,
    "dribbble" TEXT,
    "personalSite" TEXT,
    "other" TEXT,
    "candidateProfileId" INTEGER NOT NULL,

    CONSTRAINT "ProfileLinks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NotificationPreference" (
    "id" SERIAL NOT NULL,
    "jobAlertUpdates" BOOLEAN NOT NULL DEFAULT false,
    "interviewCalendarUpdates" BOOLEAN NOT NULL DEFAULT true,
    "customJobSuggestions" BOOLEAN NOT NULL DEFAULT true,
    "candidateProfileId" INTEGER NOT NULL,

    CONSTRAINT "NotificationPreference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProfileVisibilityPreference" (
    "id" SERIAL NOT NULL,
    "showProfileToRecruiters" BOOLEAN NOT NULL DEFAULT false,
    "hideContactDetails" BOOLEAN NOT NULL DEFAULT false,
    "showJobPreferences" BOOLEAN NOT NULL DEFAULT false,
    "dataDownloadConsent" BOOLEAN NOT NULL DEFAULT false,
    "candidateProfileId" INTEGER NOT NULL,

    CONSTRAINT "ProfileVisibilityPreference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CandidateSignatures" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "twoFactorSecret" TEXT,
    "backupCodesHash" TEXT[],
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CandidateSignatures_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CandidateSavedJob" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CandidateSavedJob_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CandidateValuesMatchSession" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "type" "CandidateValuesMatchType" NOT NULL,
    "mvmScore" DOUBLE PRECISION,
    "answers" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "applicationId" INTEGER,

    CONSTRAINT "CandidateValuesMatchSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CandidateValuesMatch" (
    "id" SERIAL NOT NULL,
    "sessionId" INTEGER NOT NULL,
    "coreValueId" INTEGER NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "CandidateValuesMatch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate_questions" (
    "id" SERIAL NOT NULL,
    "group" "QuestionGroup" NOT NULL,
    "roleLevel" "CandidateLevel",
    "companyType" "CandidateCompanyType" NOT NULL,
    "type" "QuestionType" NOT NULL,
    "code" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "evp" INTEGER[],
    "scaleMin" INTEGER,
    "scaleMax" INTEGER,
    "scaleMinLabel" TEXT,
    "scaleMaxLabel" TEXT,
    "maxWords" INTEGER,
    "order" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "candidate_questions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate_questionnaire_responses" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "applicationId" INTEGER,
    "group" "QuestionGroup" NOT NULL,
    "roleLevel" "CandidateLevel",
    "companyType" "CandidateCompanyType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "candidate_questionnaire_responses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate_question_answers" (
    "id" SERIAL NOT NULL,
    "responseId" INTEGER NOT NULL,
    "questionCode" TEXT NOT NULL,
    "questionType" "QuestionType" NOT NULL,
    "likertValue" INTEGER,
    "textValue" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "candidate_question_answers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate_questionnaire_summaries" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "preShortlistScore" DOUBLE PRECISION DEFAULT 0,
    "preInterviewScore" DOUBLE PRECISION DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "candidate_questionnaire_summaries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chat_conversations" (
    "id" SERIAL NOT NULL,
    "isGroup" BOOLEAN NOT NULL DEFAULT false,
    "title" TEXT,
    "createdById" INTEGER NOT NULL,
    "lastMessageAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "chat_conversations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chat_participants" (
    "id" SERIAL NOT NULL,
    "conversationId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastReadAt" TIMESTAMP(3),

    CONSTRAINT "chat_participants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chat_messages" (
    "id" SERIAL NOT NULL,
    "conversationId" INTEGER NOT NULL,
    "senderId" INTEGER NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "chat_messages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "companies" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "industryId" INTEGER,
    "location" TEXT,
    "contactEmail" TEXT,
    "logoUrl" TEXT,
    "description" TEXT,
    "website" TEXT,
    "size" "CompanySize" DEFAULT '1-50',
    "type" "CompanyType" DEFAULT 'STARTUP',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "isHidden" BOOLEAN NOT NULL DEFAULT false,
    "profilePictureIsHidden" BOOLEAN NOT NULL DEFAULT false,
    "subscriptionTier" "SubscriptionTier" NOT NULL DEFAULT 'BASIC',
    "subscriptionStatus" "SubscriptionStatus" NOT NULL DEFAULT 'ACTIVE',
    "billingEmail" TEXT,
    "twoFactorEnabled" BOOLEAN NOT NULL DEFAULT false,
    "sessionTimeout" INTEGER NOT NULL DEFAULT 30,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "companies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "departments" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "companyId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "departments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "core_values" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "category" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "core_values_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "qualities" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "category" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "qualities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company_core_values" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "departmentId" INTEGER,
    "coreValueId" INTEGER NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL DEFAULT 20.0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "company_core_values_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company_qualities" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "departmentId" INTEGER,
    "qualityId" INTEGER NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL DEFAULT 20.0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "company_qualities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company_matching_weights" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "coreValuesWeight" DOUBLE PRECISION NOT NULL DEFAULT 30.0,
    "hardSkillsWeight" DOUBLE PRECISION NOT NULL DEFAULT 40.0,
    "benchmarkProfileWeight" DOUBLE PRECISION NOT NULL DEFAULT 30.0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "departmentId" INTEGER,

    CONSTRAINT "company_matching_weights_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MatchingWeight" (
    "id" SERIAL NOT NULL,
    "coreValuesWeight" DOUBLE PRECISION NOT NULL DEFAULT 30.0,
    "hardSkillsWeight" DOUBLE PRECISION NOT NULL DEFAULT 40.0,
    "benchmarkProfileWeight" DOUBLE PRECISION NOT NULL DEFAULT 30.0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MatchingWeight_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company_notification_settings" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "candidateApplies" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "candidateResponds" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "hiringManagerComment" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "newMessage" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "mentionsInComments" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "jobPostApproved" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "recruiterAssigned" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "subscriptionChanges" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "securityAlerts" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "productUpdates" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "company_notification_settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BaseNotificationSetting" (
    "id" SERIAL NOT NULL,
    "key" TEXT NOT NULL,
    "header" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "shortText" TEXT NOT NULL,
    "defaultValue" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BaseNotificationSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company_invitations" (
    "id" TEXT NOT NULL,
    "companyId" INTEGER NOT NULL,
    "email" CITEXT NOT NULL,
    "role" TEXT NOT NULL,
    "invitedById" INTEGER NOT NULL,
    "tokenHash" TEXT NOT NULL,
    "status" "InvitationStatus" NOT NULL DEFAULT 'PENDING',
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "acceptedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "departmentId" INTEGER,

    CONSTRAINT "company_invitations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "company_access_policies" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "applyMode" "AccessApplyMode" NOT NULL DEFAULT 'PER_ROLE',
    "rolePolicies" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "company_access_policies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScoreThreshold" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER,
    "level" "CandidateLevel" NOT NULL,
    "ideal" INTEGER NOT NULL,
    "acceptable" INTEGER NOT NULL,
    "disqualify" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ScoreThreshold_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "industries" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "industries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Job" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "experience" "ExperienceLevel" NOT NULL,
    "employmentType" "EmploymentType" NOT NULL,
    "workArrangement" "WorkArrangement" NOT NULL,
    "responsibilities" TEXT[],
    "requirements" TEXT[],
    "niceToHave" TEXT[],
    "perks" TEXT[],
    "whoYouAre" TEXT[],
    "education" TEXT,
    "location" TEXT,
    "tags" TEXT[],
    "minSalary" INTEGER,
    "maxSalary" INTEGER,
    "hoursPerWeek" INTEGER,
    "timeToHireDays" INTEGER,
    "status" "JobStatus" NOT NULL DEFAULT 'DRAFT',
    "departmentId" INTEGER,
    "companySize" "CompanySize",
    "companyType" "CompanyType",
    "videoUrl" TEXT,
    "recruiterId" INTEGER,
    "applicationClosingDate" TIMESTAMP(3),
    "jobNumber" TEXT,
    "companyId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "introduction" TEXT,
    "salary" TEXT,
    "languages" "JobLanguage"[],
    "publishedAt" TIMESTAMP(3),
    "archivedAt" TIMESTAMP(3),
    "expiredAt" TIMESTAMP(3),
    "currency" TEXT,
    "period" "CompensationPeriod",
    "mvmProfileVersion" INTEGER NOT NULL DEFAULT 1,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdById" INTEGER,

    CONSTRAINT "Job_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JobCoreValueKeyword" (
    "id" SERIAL NOT NULL,
    "jobId" INTEGER NOT NULL,
    "coreValueId" INTEGER NOT NULL,
    "keyword" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JobCoreValueKeyword_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JobCoreValueWeighting" (
    "id" SERIAL NOT NULL,
    "jobId" INTEGER NOT NULL,
    "coreValueId" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JobCoreValueWeighting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JobBenchmarkProfile" (
    "id" SERIAL NOT NULL,
    "jobId" INTEGER NOT NULL,
    "jobPostRole" TEXT NOT NULL,
    "benchmarkRole" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JobBenchmarkProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JobBenchmarkCoreValue" (
    "id" SERIAL NOT NULL,
    "benchmarkId" INTEGER NOT NULL,
    "coreValueId" INTEGER NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JobBenchmarkCoreValue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JobBenchmarkTeamStyleTag" (
    "id" SERIAL NOT NULL,
    "benchmarkId" INTEGER NOT NULL,
    "tag" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JobBenchmarkTeamStyleTag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TeamStyleTag" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TeamStyleTag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CandidateTagFeedback" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "teamStyleTagId" INTEGER NOT NULL,
    "rating" INTEGER NOT NULL,
    "feedbackText" TEXT,
    "verdict" "FeedbackVerdict" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CandidateTagFeedback_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecruiterCoreValueFeedback" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "reviewerId" INTEGER NOT NULL,
    "recommend" BOOLEAN NOT NULL,
    "comment" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RecruiterCoreValueFeedback_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecruiterCoreValueRating" (
    "id" SERIAL NOT NULL,
    "feedbackId" INTEGER NOT NULL,
    "coreValueId" INTEGER NOT NULL,
    "rating" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RecruiterCoreValueRating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SixMonthEVPFeedback" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "reviewerId" INTEGER NOT NULL,
    "comment" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SixMonthEVPFeedback_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SixMonthEVPRating" (
    "id" SERIAL NOT NULL,
    "feedbackId" INTEGER NOT NULL,
    "coreValueId" INTEGER NOT NULL,
    "rating" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SixMonthEVPRating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CandidateEmployerFeedback" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "missionVisionImportance" INTEGER NOT NULL,
    "learningGrowthPriority" INTEGER NOT NULL,
    "workplaceCultureImportance" INTEGER NOT NULL,
    "roleFitStrengths" INTEGER NOT NULL,
    "socialCulturalFitImportance" INTEGER NOT NULL,
    "comment" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CandidateEmployerFeedback_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JobBenchmarkFitPriority" (
    "id" SERIAL NOT NULL,
    "benchmarkId" INTEGER NOT NULL,
    "hiringFocus" "HiringFocus" NOT NULL,
    "devStrategy" "DevelopmentStrategy" NOT NULL,
    "longTerm" "LongTermAlignment" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JobBenchmarkFitPriority_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JobBenchmarkQuality" (
    "id" SERIAL NOT NULL,
    "benchmarkId" INTEGER NOT NULL,
    "qualityId" INTEGER NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JobBenchmarkQuality_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "job_invitations" (
    "id" SERIAL NOT NULL,
    "jobId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "invitedById" INTEGER NOT NULL,
    "tokenHash" TEXT NOT NULL,
    "status" "InvitationStatus" NOT NULL DEFAULT 'PENDING',
    "message" TEXT,
    "expiresAt" TIMESTAMP(3),
    "acceptedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "job_invitations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Todo" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "type" "TodoType" NOT NULL,
    "status" "TodoStatus" NOT NULL DEFAULT 'PENDING',
    "companyId" INTEGER NOT NULL,
    "jobId" INTEGER,
    "applicationId" INTEGER,
    "assignedToId" INTEGER,
    "createdById" INTEGER,
    "dueAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Todo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "job_titles" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "searchTitle" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "job_titles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" SERIAL NOT NULL,
    "recipientId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT,
    "type" "NotificationType" NOT NULL,
    "actionText" TEXT,
    "actionUrl" TEXT,
    "actionPayload" JSONB,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "readAt" TIMESTAMP(3),
    "archivedAt" TIMESTAMP(3),
    "channel" "NotificationChannel" NOT NULL DEFAULT 'IN_APP',
    "deliveryStatus" "NotificationDeliveryStatus" NOT NULL DEFAULT 'PENDING',
    "deliveredAt" TIMESTAMP(3),
    "clickedAt" TIMESTAMP(3),
    "companyId" INTEGER,
    "dedupeKey" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "talent_pools" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "ownerRecruiterId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "addedById" INTEGER,
    "source" "TalentSource",
    "sourceDetail" TEXT,
    "stage" "TalentStage" DEFAULT 'NEW',
    "priority" "TalentPriority" DEFAULT 'MEDIUM',
    "lastContactAt" TIMESTAMP(3),
    "nextActionAt" TIMESTAMP(3),
    "note" TEXT,
    "archivedAt" TIMESTAMP(3),

    CONSTRAINT "talent_pools_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "organization_memberships" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "leftAt" TIMESTAMP(3),
    "invitedById" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "organization_memberships_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "membership_roles" (
    "id" SERIAL NOT NULL,
    "membershipId" INTEGER NOT NULL,
    "role" "AccessRole" NOT NULL DEFAULT 'RECRUITER',
    "departmentId" INTEGER,
    "assignedById" INTEGER,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "membership_roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "access_permissions" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "domain" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "access_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role_permission_mappings" (
    "id" SERIAL NOT NULL,
    "role" "AccessRole" NOT NULL,
    "permissionId" INTEGER NOT NULL,
    "scopeRestriction" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "role_permission_mappings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "subscription_plan_features" (
    "id" SERIAL NOT NULL,
    "tier" "SubscriptionTier" NOT NULL,
    "featureKey" TEXT NOT NULL,
    "featureName" TEXT NOT NULL,
    "description" TEXT,
    "isEnabled" BOOLEAN NOT NULL DEFAULT false,
    "quotaLimit" INTEGER,
    "quotaPeriod" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "subscription_plan_features_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "organization_quota_usage" (
    "id" SERIAL NOT NULL,
    "companyId" INTEGER NOT NULL,
    "featureKey" TEXT NOT NULL,
    "currentUsage" INTEGER NOT NULL DEFAULT 0,
    "periodStart" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "periodEnd" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "organization_quota_usage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "job_assignments" (
    "id" SERIAL NOT NULL,
    "jobId" INTEGER NOT NULL,
    "recruiterId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "assignedById" INTEGER,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "job_assignments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate_job_mvm" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "score" DOUBLE PRECISION,
    "lastCalculatedAt" TIMESTAMP(3),
    "jobProfileVersionAtCalculation" INTEGER,
    "needsUpdate" BOOLEAN NOT NULL DEFAULT false,
    "notifiedAt" TIMESTAMP(3),
    "calculationMethod" TEXT,
    "calculationMetadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "candidate_job_mvm_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "job_stats" (
    "id" SERIAL NOT NULL,
    "jobId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "avgMvmScore" DOUBLE PRECISION,
    "applicantCount" INTEGER NOT NULL DEFAULT 0,
    "shortlistedCount" INTEGER NOT NULL DEFAULT 0,
    "interviewedCount" INTEGER NOT NULL DEFAULT 0,
    "offeredCount" INTEGER NOT NULL DEFAULT 0,
    "hiredCount" INTEGER NOT NULL DEFAULT 0,
    "lastCalculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "calculationVersion" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "job_stats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "feedback_tasks" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER,
    "placementId" INTEGER,
    "companyId" INTEGER NOT NULL,
    "moment" "FeedbackMoment" NOT NULL,
    "status" "FeedbackStatus" NOT NULL DEFAULT 'PENDING',
    "dueAt" TIMESTAMP(3) NOT NULL,
    "completedAt" TIMESTAMP(3),
    "notifiedAt" TIMESTAMP(3),
    "recruiterFeedbackId" INTEGER,
    "sixMonthFeedbackId" INTEGER,
    "candidateFeedbackId" INTEGER,
    "notificationSent" BOOLEAN NOT NULL DEFAULT false,
    "emailLinkToken" TEXT,
    "emailLinkExpiresAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "feedback_tasks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reviewer_sessions" (
    "id" TEXT NOT NULL,
    "jobId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "tokenHash" TEXT NOT NULL,
    "status" "ReviewerSessionStatus" NOT NULL DEFAULT 'ACTIVE',
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "lastActivityAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reviewerId" INTEGER,
    "reviewerEmail" CITEXT,
    "allowedStages" "StageType"[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reviewer_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "talent_pool_sources" (
    "id" SERIAL NOT NULL,
    "talentPoolId" INTEGER NOT NULL,
    "sourcedById" INTEGER,
    "source" "TalentSource" NOT NULL,
    "sourceDetail" TEXT,
    "sourcedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "talent_pool_sources_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recruiter_performance_logs" (
    "id" SERIAL NOT NULL,
    "recruiterId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "jobId" INTEGER,
    "activityType" TEXT NOT NULL,
    "activityDetails" JSONB,
    "candidatesContacted" INTEGER DEFAULT 0,
    "interviewsScheduled" INTEGER DEFAULT 0,
    "offersSent" INTEGER DEFAULT 0,
    "loggedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "recruiter_performance_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" SERIAL NOT NULL,
    "action" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "entityId" INTEGER,
    "actorUserId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "talent_pool_entries" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "ownerRecruiterId" INTEGER,
    "addedById" INTEGER NOT NULL,
    "addedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "talent_pool_entries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "internal_feedback_post_interview" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "jobId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "feedbackTaskId" INTEGER NOT NULL,
    "submittedById" INTEGER NOT NULL,
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "valueRatings" JSONB NOT NULL,
    "feedbackText" TEXT,
    "recommendation" BOOLEAN,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "internal_feedback_post_interview_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "internal_feedback_6_month_client" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "placementId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "feedbackTaskId" INTEGER NOT NULL,
    "submittedById" INTEGER NOT NULL,
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "feedbackText" TEXT,
    "metrics" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "internal_feedback_6_month_client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "candidate_feedback_6_month" (
    "id" SERIAL NOT NULL,
    "candidateProfileId" INTEGER NOT NULL,
    "placementId" INTEGER NOT NULL,
    "feedbackTaskId" INTEGER NOT NULL,
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "feedbackText" TEXT,
    "experienceRating" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "candidate_feedback_6_month_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recruiter_activity_metrics" (
    "id" SERIAL NOT NULL,
    "recruiterId" INTEGER NOT NULL,
    "companyId" INTEGER NOT NULL,
    "periodStart" TIMESTAMP(3) NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,
    "jobsCreated" INTEGER NOT NULL DEFAULT 0,
    "candidatesViewed" INTEGER NOT NULL DEFAULT 0,
    "pipelineMoves" INTEGER NOT NULL DEFAULT 0,
    "feedbackSubmitted" INTEGER NOT NULL DEFAULT 0,
    "interviewsScheduled" INTEGER NOT NULL DEFAULT 0,
    "offersSent" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "recruiter_activity_metrics_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_resetTokenHash_idx" ON "users"("resetTokenHash");

-- CreateIndex
CREATE UNIQUE INDEX "profiles_userId_key" ON "profiles"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "roles_name_key" ON "roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "permissions_name_key" ON "permissions"("name");

-- CreateIndex
CREATE UNIQUE INDEX "user_roles_userId_roleId_key" ON "user_roles"("userId", "roleId");

-- CreateIndex
CREATE UNIQUE INDEX "role_permissions_roleId_permissionId_key" ON "role_permissions"("roleId", "permissionId");

-- CreateIndex
CREATE UNIQUE INDEX "user_permissions_userId_permissionId_key" ON "user_permissions"("userId", "permissionId");

-- CreateIndex
CREATE UNIQUE INDEX "user_sessions_sessionToken_key" ON "user_sessions"("sessionToken");

-- CreateIndex
CREATE INDEX "user_sessions_userId_idx" ON "user_sessions"("userId");

-- CreateIndex
CREATE INDEX "user_sessions_expiresAt_idx" ON "user_sessions"("expiresAt");

-- CreateIndex
CREATE INDEX "PipelineStage_jobId_position_idx" ON "PipelineStage"("jobId", "position");

-- CreateIndex
CREATE UNIQUE INDEX "PipelineStage_companyId_name_key" ON "PipelineStage"("companyId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "PipelineStage_jobId_name_key" ON "PipelineStage"("jobId", "name");

-- CreateIndex
CREATE INDEX "Application_candidateProfileId_idx" ON "Application"("candidateProfileId");

-- CreateIndex
CREATE INDEX "Application_companyId_jobId_status_idx" ON "Application"("companyId", "jobId", "status");

-- CreateIndex
CREATE INDEX "Application_jobId_status_updatedAt_idx" ON "Application"("jobId", "status", "updatedAt");

-- CreateIndex
CREATE INDEX "Application_status_updatedAt_idx" ON "Application"("status", "updatedAt");

-- CreateIndex
CREATE INDEX "Application_offerSentAt_idx" ON "Application"("offerSentAt");

-- CreateIndex
CREATE INDEX "Application_offerAcceptedAt_idx" ON "Application"("offerAcceptedAt");

-- CreateIndex
CREATE INDEX "Application_hiredAt_idx" ON "Application"("hiredAt");

-- CreateIndex
CREATE INDEX "application_decision_logs_applicationId_timestamp_idx" ON "application_decision_logs"("applicationId", "timestamp");

-- CreateIndex
CREATE INDEX "application_decision_logs_action_timestamp_idx" ON "application_decision_logs"("action", "timestamp");

-- CreateIndex
CREATE INDEX "Pipeline_applicationId_movedAt_idx" ON "Pipeline"("applicationId", "movedAt");

-- CreateIndex
CREATE INDEX "Pipeline_stageId_movedAt_idx" ON "Pipeline"("stageId", "movedAt");

-- CreateIndex
CREATE UNIQUE INDEX "Pipeline_applicationId_stageId_key" ON "Pipeline"("applicationId", "stageId");

-- CreateIndex
CREATE INDEX "Interview_applicationId_scheduledAt_idx" ON "Interview"("applicationId", "scheduledAt");

-- CreateIndex
CREATE INDEX "Interview_status_scheduledAt_idx" ON "Interview"("status", "scheduledAt");

-- CreateIndex
CREATE INDEX "Interview_candidateStatus_scheduledAt_idx" ON "Interview"("candidateStatus", "scheduledAt");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateProfile_userId_key" ON "CandidateProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateProfile_contactInfoId_key" ON "CandidateProfile"("contactInfoId");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateProfile_professionalProfileId_key" ON "CandidateProfile"("professionalProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateProfile_jobPreferenceId_key" ON "CandidateProfile"("jobPreferenceId");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateProfile_profileLinksId_key" ON "CandidateProfile"("profileLinksId");

-- CreateIndex
CREATE UNIQUE INDEX "ContactInfo_email_key" ON "ContactInfo"("email");

-- CreateIndex
CREATE INDEX "CoverLetter_candidateProfileId_idx" ON "CoverLetter"("candidateProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "JobPreference_candidateProfileId_key" ON "JobPreference"("candidateProfileId");

-- CreateIndex
CREATE INDEX "JobPreference_candidateProfileId_idx" ON "JobPreference"("candidateProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "ProfileLinks_candidateProfileId_key" ON "ProfileLinks"("candidateProfileId");

-- CreateIndex
CREATE INDEX "ProfileLinks_candidateProfileId_idx" ON "ProfileLinks"("candidateProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "NotificationPreference_candidateProfileId_key" ON "NotificationPreference"("candidateProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "ProfileVisibilityPreference_candidateProfileId_key" ON "ProfileVisibilityPreference"("candidateProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateSignatures_candidateProfileId_key" ON "CandidateSignatures"("candidateProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateSavedJob_candidateProfileId_jobId_key" ON "CandidateSavedJob"("candidateProfileId", "jobId");

-- CreateIndex
CREATE INDEX "CandidateValuesMatchSession_candidateProfileId_type_created_idx" ON "CandidateValuesMatchSession"("candidateProfileId", "type", "createdAt");

-- CreateIndex
CREATE INDEX "CandidateValuesMatchSession_applicationId_createdAt_idx" ON "CandidateValuesMatchSession"("applicationId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateValuesMatch_sessionId_coreValueId_key" ON "CandidateValuesMatch"("sessionId", "coreValueId");

-- CreateIndex
CREATE UNIQUE INDEX "candidate_questions_code_key" ON "candidate_questions"("code");

-- CreateIndex
CREATE INDEX "candidate_questions_group_roleLevel_companyType_type_idx" ON "candidate_questions"("group", "roleLevel", "companyType", "type");

-- CreateIndex
CREATE INDEX "candidate_questionnaire_responses_jobId_createdAt_idx" ON "candidate_questionnaire_responses"("jobId", "createdAt");

-- CreateIndex
CREATE INDEX "candidate_questionnaire_responses_userId_createdAt_idx" ON "candidate_questionnaire_responses"("userId", "createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "candidate_questionnaire_responses_userId_jobId_group_key" ON "candidate_questionnaire_responses"("userId", "jobId", "group");

-- CreateIndex
CREATE UNIQUE INDEX "candidate_question_answers_responseId_questionCode_key" ON "candidate_question_answers"("responseId", "questionCode");

-- CreateIndex
CREATE UNIQUE INDEX "candidate_questionnaire_summaries_candidateProfileId_jobId_key" ON "candidate_questionnaire_summaries"("candidateProfileId", "jobId");

-- CreateIndex
CREATE INDEX "chat_conversations_lastMessageAt_updatedAt_idx" ON "chat_conversations"("lastMessageAt", "updatedAt");

-- CreateIndex
CREATE INDEX "chat_participants_userId_conversationId_idx" ON "chat_participants"("userId", "conversationId");

-- CreateIndex
CREATE INDEX "chat_participants_conversationId_lastReadAt_idx" ON "chat_participants"("conversationId", "lastReadAt");

-- CreateIndex
CREATE INDEX "chat_messages_conversationId_createdAt_idx" ON "chat_messages"("conversationId", "createdAt");

-- CreateIndex
CREATE INDEX "chat_messages_conversationId_deletedAt_createdAt_idx" ON "chat_messages"("conversationId", "deletedAt", "createdAt");

-- CreateIndex
CREATE INDEX "companies_industryId_idx" ON "companies"("industryId");

-- CreateIndex
CREATE UNIQUE INDEX "departments_companyId_name_key" ON "departments"("companyId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "core_values_name_key" ON "core_values"("name");

-- CreateIndex
CREATE UNIQUE INDEX "qualities_name_key" ON "qualities"("name");

-- CreateIndex
CREATE UNIQUE INDEX "company_core_values_companyId_departmentId_coreValueId_key" ON "company_core_values"("companyId", "departmentId", "coreValueId");

-- CreateIndex
CREATE UNIQUE INDEX "company_qualities_companyId_departmentId_qualityId_key" ON "company_qualities"("companyId", "departmentId", "qualityId");

-- CreateIndex
CREATE INDEX "company_matching_weights_companyId_idx" ON "company_matching_weights"("companyId");

-- CreateIndex
CREATE INDEX "company_matching_weights_departmentId_idx" ON "company_matching_weights"("departmentId");

-- CreateIndex
CREATE UNIQUE INDEX "company_matching_weights_companyId_departmentId_key" ON "company_matching_weights"("companyId", "departmentId");

-- CreateIndex
CREATE UNIQUE INDEX "company_notification_settings_companyId_key" ON "company_notification_settings"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "BaseNotificationSetting_key_key" ON "BaseNotificationSetting"("key");

-- CreateIndex
CREATE UNIQUE INDEX "company_invitations_tokenHash_key" ON "company_invitations"("tokenHash");

-- CreateIndex
CREATE INDEX "company_invitations_companyId_status_expiresAt_idx" ON "company_invitations"("companyId", "status", "expiresAt");

-- CreateIndex
CREATE UNIQUE INDEX "company_invitations_companyId_email_key" ON "company_invitations"("companyId", "email");

-- CreateIndex
CREATE UNIQUE INDEX "company_access_policies_companyId_key" ON "company_access_policies"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "ScoreThreshold_companyId_level_key" ON "ScoreThreshold"("companyId", "level");

-- CreateIndex
CREATE UNIQUE INDEX "industries_name_key" ON "industries"("name");

-- CreateIndex
CREATE UNIQUE INDEX "industries_slug_key" ON "industries"("slug");

-- CreateIndex
CREATE INDEX "Job_companyId_status_updatedAt_idx" ON "Job"("companyId", "status", "updatedAt");

-- CreateIndex
CREATE INDEX "Job_departmentId_status_updatedAt_idx" ON "Job"("departmentId", "status", "updatedAt");

-- CreateIndex
CREATE INDEX "Job_applicationClosingDate_idx" ON "Job"("applicationClosingDate");

-- CreateIndex
CREATE INDEX "Job_isActive_status_idx" ON "Job"("isActive", "status");

-- CreateIndex
CREATE UNIQUE INDEX "Job_companyId_jobNumber_key" ON "Job"("companyId", "jobNumber");

-- CreateIndex
CREATE INDEX "JobCoreValueKeyword_jobId_idx" ON "JobCoreValueKeyword"("jobId");

-- CreateIndex
CREATE INDEX "JobCoreValueKeyword_coreValueId_idx" ON "JobCoreValueKeyword"("coreValueId");

-- CreateIndex
CREATE UNIQUE INDEX "JobCoreValueKeyword_jobId_coreValueId_keyword_key" ON "JobCoreValueKeyword"("jobId", "coreValueId", "keyword");

-- CreateIndex
CREATE UNIQUE INDEX "JobCoreValueWeighting_jobId_coreValueId_key" ON "JobCoreValueWeighting"("jobId", "coreValueId");

-- CreateIndex
CREATE UNIQUE INDEX "JobBenchmarkCoreValue_benchmarkId_coreValueId_key" ON "JobBenchmarkCoreValue"("benchmarkId", "coreValueId");

-- CreateIndex
CREATE UNIQUE INDEX "TeamStyleTag_name_key" ON "TeamStyleTag"("name");

-- CreateIndex
CREATE UNIQUE INDEX "TeamStyleTag_slug_key" ON "TeamStyleTag"("slug");

-- CreateIndex
CREATE INDEX "CandidateTagFeedback_candidateProfileId_idx" ON "CandidateTagFeedback"("candidateProfileId");

-- CreateIndex
CREATE INDEX "CandidateTagFeedback_jobId_idx" ON "CandidateTagFeedback"("jobId");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateTagFeedback_candidateProfileId_jobId_teamStyleTagI_key" ON "CandidateTagFeedback"("candidateProfileId", "jobId", "teamStyleTagId");

-- CreateIndex
CREATE INDEX "RecruiterCoreValueFeedback_candidateProfileId_idx" ON "RecruiterCoreValueFeedback"("candidateProfileId");

-- CreateIndex
CREATE INDEX "RecruiterCoreValueFeedback_jobId_idx" ON "RecruiterCoreValueFeedback"("jobId");

-- CreateIndex
CREATE UNIQUE INDEX "RecruiterCoreValueFeedback_candidateProfileId_jobId_reviewe_key" ON "RecruiterCoreValueFeedback"("candidateProfileId", "jobId", "reviewerId");

-- CreateIndex
CREATE UNIQUE INDEX "RecruiterCoreValueRating_feedbackId_coreValueId_key" ON "RecruiterCoreValueRating"("feedbackId", "coreValueId");

-- CreateIndex
CREATE INDEX "SixMonthEVPFeedback_candidateProfileId_idx" ON "SixMonthEVPFeedback"("candidateProfileId");

-- CreateIndex
CREATE INDEX "SixMonthEVPFeedback_jobId_idx" ON "SixMonthEVPFeedback"("jobId");

-- CreateIndex
CREATE UNIQUE INDEX "SixMonthEVPFeedback_candidateProfileId_jobId_reviewerId_key" ON "SixMonthEVPFeedback"("candidateProfileId", "jobId", "reviewerId");

-- CreateIndex
CREATE UNIQUE INDEX "SixMonthEVPRating_feedbackId_coreValueId_key" ON "SixMonthEVPRating"("feedbackId", "coreValueId");

-- CreateIndex
CREATE INDEX "CandidateEmployerFeedback_candidateProfileId_idx" ON "CandidateEmployerFeedback"("candidateProfileId");

-- CreateIndex
CREATE INDEX "CandidateEmployerFeedback_jobId_idx" ON "CandidateEmployerFeedback"("jobId");

-- CreateIndex
CREATE UNIQUE INDEX "CandidateEmployerFeedback_candidateProfileId_jobId_key" ON "CandidateEmployerFeedback"("candidateProfileId", "jobId");

-- CreateIndex
CREATE UNIQUE INDEX "JobBenchmarkFitPriority_benchmarkId_key" ON "JobBenchmarkFitPriority"("benchmarkId");

-- CreateIndex
CREATE UNIQUE INDEX "JobBenchmarkQuality_benchmarkId_qualityId_key" ON "JobBenchmarkQuality"("benchmarkId", "qualityId");

-- CreateIndex
CREATE UNIQUE INDEX "job_invitations_tokenHash_key" ON "job_invitations"("tokenHash");

-- CreateIndex
CREATE INDEX "job_invitations_companyId_idx" ON "job_invitations"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "job_invitations_jobId_candidateProfileId_key" ON "job_invitations"("jobId", "candidateProfileId");

-- CreateIndex
CREATE INDEX "Todo_companyId_idx" ON "Todo"("companyId");

-- CreateIndex
CREATE INDEX "Todo_jobId_idx" ON "Todo"("jobId");

-- CreateIndex
CREATE INDEX "Todo_applicationId_idx" ON "Todo"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "job_titles_title_key" ON "job_titles"("title");

-- CreateIndex
CREATE INDEX "job_titles_title_idx" ON "job_titles"("title");

-- CreateIndex
CREATE INDEX "job_titles_searchTitle_idx" ON "job_titles"("searchTitle");

-- CreateIndex
CREATE UNIQUE INDEX "notifications_dedupeKey_key" ON "notifications"("dedupeKey");

-- CreateIndex
CREATE INDEX "notifications_recipientId_isRead_idx" ON "notifications"("recipientId", "isRead");

-- CreateIndex
CREATE INDEX "notifications_recipientId_createdAt_idx" ON "notifications"("recipientId", "createdAt");

-- CreateIndex
CREATE INDEX "notifications_companyId_createdAt_idx" ON "notifications"("companyId", "createdAt");

-- CreateIndex
CREATE INDEX "notifications_type_createdAt_idx" ON "notifications"("type", "createdAt");

-- CreateIndex
CREATE INDEX "notifications_deliveryStatus_createdAt_idx" ON "notifications"("deliveryStatus", "createdAt");

-- CreateIndex
CREATE INDEX "talent_pools_companyId_updatedAt_idx" ON "talent_pools"("companyId", "updatedAt");

-- CreateIndex
CREATE INDEX "talent_pools_companyId_stage_priority_idx" ON "talent_pools"("companyId", "stage", "priority");

-- CreateIndex
CREATE INDEX "talent_pools_companyId_lastContactAt_idx" ON "talent_pools"("companyId", "lastContactAt");

-- CreateIndex
CREATE INDEX "talent_pools_ownerRecruiterId_idx" ON "talent_pools"("ownerRecruiterId");

-- CreateIndex
CREATE UNIQUE INDEX "talent_pools_companyId_candidateProfileId_ownerRecruiterId_key" ON "talent_pools"("companyId", "candidateProfileId", "ownerRecruiterId");

-- CreateIndex
CREATE INDEX "organization_memberships_userId_idx" ON "organization_memberships"("userId");

-- CreateIndex
CREATE INDEX "organization_memberships_companyId_idx" ON "organization_memberships"("companyId");

-- CreateIndex
CREATE INDEX "organization_memberships_companyId_isActive_idx" ON "organization_memberships"("companyId", "isActive");

-- CreateIndex
CREATE UNIQUE INDEX "organization_memberships_userId_companyId_key" ON "organization_memberships"("userId", "companyId");

-- CreateIndex
CREATE INDEX "membership_roles_membershipId_idx" ON "membership_roles"("membershipId");

-- CreateIndex
CREATE INDEX "membership_roles_role_idx" ON "membership_roles"("role");

-- CreateIndex
CREATE UNIQUE INDEX "membership_roles_membershipId_role_departmentId_key" ON "membership_roles"("membershipId", "role", "departmentId");

-- CreateIndex
CREATE UNIQUE INDEX "access_permissions_name_key" ON "access_permissions"("name");

-- CreateIndex
CREATE INDEX "access_permissions_domain_action_idx" ON "access_permissions"("domain", "action");

-- CreateIndex
CREATE INDEX "role_permission_mappings_role_idx" ON "role_permission_mappings"("role");

-- CreateIndex
CREATE UNIQUE INDEX "role_permission_mappings_role_permissionId_key" ON "role_permission_mappings"("role", "permissionId");

-- CreateIndex
CREATE INDEX "subscription_plan_features_tier_idx" ON "subscription_plan_features"("tier");

-- CreateIndex
CREATE UNIQUE INDEX "subscription_plan_features_tier_featureKey_key" ON "subscription_plan_features"("tier", "featureKey");

-- CreateIndex
CREATE INDEX "organization_quota_usage_companyId_featureKey_idx" ON "organization_quota_usage"("companyId", "featureKey");

-- CreateIndex
CREATE UNIQUE INDEX "organization_quota_usage_companyId_featureKey_periodStart_key" ON "organization_quota_usage"("companyId", "featureKey", "periodStart");

-- CreateIndex
CREATE INDEX "job_assignments_recruiterId_isActive_idx" ON "job_assignments"("recruiterId", "isActive");

-- CreateIndex
CREATE INDEX "job_assignments_jobId_idx" ON "job_assignments"("jobId");

-- CreateIndex
CREATE INDEX "job_assignments_companyId_idx" ON "job_assignments"("companyId");

-- CreateIndex
CREATE UNIQUE INDEX "job_assignments_jobId_recruiterId_key" ON "job_assignments"("jobId", "recruiterId");

-- CreateIndex
CREATE INDEX "candidate_job_mvm_candidateProfileId_idx" ON "candidate_job_mvm"("candidateProfileId");

-- CreateIndex
CREATE INDEX "candidate_job_mvm_jobId_idx" ON "candidate_job_mvm"("jobId");

-- CreateIndex
CREATE INDEX "candidate_job_mvm_companyId_idx" ON "candidate_job_mvm"("companyId");

-- CreateIndex
CREATE INDEX "candidate_job_mvm_needsUpdate_lastCalculatedAt_idx" ON "candidate_job_mvm"("needsUpdate", "lastCalculatedAt");

-- CreateIndex
CREATE UNIQUE INDEX "candidate_job_mvm_candidateProfileId_jobId_key" ON "candidate_job_mvm"("candidateProfileId", "jobId");

-- CreateIndex
CREATE UNIQUE INDEX "job_stats_jobId_key" ON "job_stats"("jobId");

-- CreateIndex
CREATE INDEX "job_stats_companyId_idx" ON "job_stats"("companyId");

-- CreateIndex
CREATE INDEX "job_stats_lastCalculatedAt_idx" ON "job_stats"("lastCalculatedAt");

-- CreateIndex
CREATE UNIQUE INDEX "feedback_tasks_recruiterFeedbackId_key" ON "feedback_tasks"("recruiterFeedbackId");

-- CreateIndex
CREATE UNIQUE INDEX "feedback_tasks_sixMonthFeedbackId_key" ON "feedback_tasks"("sixMonthFeedbackId");

-- CreateIndex
CREATE UNIQUE INDEX "feedback_tasks_candidateFeedbackId_key" ON "feedback_tasks"("candidateFeedbackId");

-- CreateIndex
CREATE UNIQUE INDEX "feedback_tasks_emailLinkToken_key" ON "feedback_tasks"("emailLinkToken");

-- CreateIndex
CREATE INDEX "feedback_tasks_companyId_moment_status_idx" ON "feedback_tasks"("companyId", "moment", "status");

-- CreateIndex
CREATE INDEX "feedback_tasks_candidateProfileId_status_idx" ON "feedback_tasks"("candidateProfileId", "status");

-- CreateIndex
CREATE INDEX "feedback_tasks_dueAt_status_idx" ON "feedback_tasks"("dueAt", "status");

-- CreateIndex
CREATE INDEX "feedback_tasks_emailLinkToken_idx" ON "feedback_tasks"("emailLinkToken");

-- CreateIndex
CREATE UNIQUE INDEX "feedback_tasks_candidateProfileId_jobId_placementId_moment_key" ON "feedback_tasks"("candidateProfileId", "jobId", "placementId", "moment");

-- CreateIndex
CREATE UNIQUE INDEX "reviewer_sessions_tokenHash_key" ON "reviewer_sessions"("tokenHash");

-- CreateIndex
CREATE INDEX "reviewer_sessions_jobId_status_idx" ON "reviewer_sessions"("jobId", "status");

-- CreateIndex
CREATE INDEX "reviewer_sessions_companyId_idx" ON "reviewer_sessions"("companyId");

-- CreateIndex
CREATE INDEX "reviewer_sessions_tokenHash_idx" ON "reviewer_sessions"("tokenHash");

-- CreateIndex
CREATE INDEX "reviewer_sessions_expiresAt_status_idx" ON "reviewer_sessions"("expiresAt", "status");

-- CreateIndex
CREATE UNIQUE INDEX "talent_pool_sources_talentPoolId_key" ON "talent_pool_sources"("talentPoolId");

-- CreateIndex
CREATE INDEX "talent_pool_sources_sourcedById_idx" ON "talent_pool_sources"("sourcedById");

-- CreateIndex
CREATE INDEX "recruiter_performance_logs_recruiterId_loggedAt_idx" ON "recruiter_performance_logs"("recruiterId", "loggedAt");

-- CreateIndex
CREATE INDEX "recruiter_performance_logs_companyId_loggedAt_idx" ON "recruiter_performance_logs"("companyId", "loggedAt");

-- CreateIndex
CREATE INDEX "recruiter_performance_logs_jobId_loggedAt_idx" ON "recruiter_performance_logs"("jobId", "loggedAt");

-- CreateIndex
CREATE INDEX "recruiter_performance_logs_activityType_loggedAt_idx" ON "recruiter_performance_logs"("activityType", "loggedAt");

-- CreateIndex
CREATE INDEX "audit_logs_actorUserId_createdAt_idx" ON "audit_logs"("actorUserId", "createdAt");

-- CreateIndex
CREATE INDEX "audit_logs_companyId_createdAt_idx" ON "audit_logs"("companyId", "createdAt");

-- CreateIndex
CREATE INDEX "audit_logs_entity_entityId_idx" ON "audit_logs"("entity", "entityId");

-- CreateIndex
CREATE INDEX "audit_logs_action_createdAt_idx" ON "audit_logs"("action", "createdAt");

-- CreateIndex
CREATE INDEX "talent_pool_entries_companyId_idx" ON "talent_pool_entries"("companyId");

-- CreateIndex
CREATE INDEX "talent_pool_entries_ownerRecruiterId_idx" ON "talent_pool_entries"("ownerRecruiterId");

-- CreateIndex
CREATE INDEX "talent_pool_entries_candidateProfileId_idx" ON "talent_pool_entries"("candidateProfileId");

-- CreateIndex
CREATE UNIQUE INDEX "talent_pool_entries_candidateProfileId_companyId_ownerRecru_key" ON "talent_pool_entries"("candidateProfileId", "companyId", "ownerRecruiterId");

-- CreateIndex
CREATE INDEX "internal_feedback_post_interview_candidateProfileId_jobId_idx" ON "internal_feedback_post_interview"("candidateProfileId", "jobId");

-- CreateIndex
CREATE INDEX "internal_feedback_post_interview_companyId_idx" ON "internal_feedback_post_interview"("companyId");

-- CreateIndex
CREATE INDEX "internal_feedback_post_interview_submittedById_idx" ON "internal_feedback_post_interview"("submittedById");

-- CreateIndex
CREATE UNIQUE INDEX "internal_feedback_post_interview_feedbackTaskId_key" ON "internal_feedback_post_interview"("feedbackTaskId");

-- CreateIndex
CREATE INDEX "internal_feedback_6_month_client_candidateProfileId_placeme_idx" ON "internal_feedback_6_month_client"("candidateProfileId", "placementId");

-- CreateIndex
CREATE INDEX "internal_feedback_6_month_client_companyId_idx" ON "internal_feedback_6_month_client"("companyId");

-- CreateIndex
CREATE INDEX "internal_feedback_6_month_client_submittedById_idx" ON "internal_feedback_6_month_client"("submittedById");

-- CreateIndex
CREATE UNIQUE INDEX "internal_feedback_6_month_client_feedbackTaskId_key" ON "internal_feedback_6_month_client"("feedbackTaskId");

-- CreateIndex
CREATE INDEX "candidate_feedback_6_month_candidateProfileId_idx" ON "candidate_feedback_6_month"("candidateProfileId");

-- CreateIndex
CREATE INDEX "candidate_feedback_6_month_placementId_idx" ON "candidate_feedback_6_month"("placementId");

-- CreateIndex
CREATE UNIQUE INDEX "candidate_feedback_6_month_feedbackTaskId_key" ON "candidate_feedback_6_month"("feedbackTaskId");

-- CreateIndex
CREATE INDEX "recruiter_activity_metrics_recruiterId_periodStart_idx" ON "recruiter_activity_metrics"("recruiterId", "periodStart");

-- CreateIndex
CREATE INDEX "recruiter_activity_metrics_companyId_periodStart_idx" ON "recruiter_activity_metrics"("companyId", "periodStart");

-- CreateIndex
CREATE UNIQUE INDEX "recruiter_activity_metrics_recruiterId_companyId_periodStar_key" ON "recruiter_activity_metrics"("recruiterId", "companyId", "periodStart", "periodEnd");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_roles" ADD CONSTRAINT "user_roles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_roles" ADD CONSTRAINT "user_roles_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permissions" ADD CONSTRAINT "role_permissions_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permissions" ADD CONSTRAINT "role_permissions_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "permissions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_permissions" ADD CONSTRAINT "user_permissions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_permissions" ADD CONSTRAINT "user_permissions_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "permissions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_sessions" ADD CONSTRAINT "user_sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PipelineStage" ADD CONSTRAINT "PipelineStage_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PipelineStage" ADD CONSTRAINT "PipelineStage_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationFile" ADD CONSTRAINT "ApplicationFile_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationFile" ADD CONSTRAINT "ApplicationFile_resumeId_fkey" FOREIGN KEY ("resumeId") REFERENCES "Resume"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationFile" ADD CONSTRAINT "ApplicationFile_coverLetterId_fkey" FOREIGN KEY ("coverLetterId") REFERENCES "CoverLetter"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_currentStageId_fkey" FOREIGN KEY ("currentStageId") REFERENCES "PipelineStage"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_offerConfirmedById_fkey" FOREIGN KEY ("offerConfirmedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_hireConfirmedById_fkey" FOREIGN KEY ("hireConfirmedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "application_decision_logs" ADD CONSTRAINT "application_decision_logs_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "application_decision_logs" ADD CONSTRAINT "application_decision_logs_actorId_fkey" FOREIGN KEY ("actorId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pipeline" ADD CONSTRAINT "Pipeline_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pipeline" ADD CONSTRAINT "Pipeline_stageId_fkey" FOREIGN KEY ("stageId") REFERENCES "PipelineStage"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pipeline" ADD CONSTRAINT "Pipeline_movedById_fkey" FOREIGN KEY ("movedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationHistory" ADD CONSTRAINT "ApplicationHistory_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationHistory" ADD CONSTRAINT "ApplicationHistory_fromStageId_fkey" FOREIGN KEY ("fromStageId") REFERENCES "PipelineStage"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationHistory" ADD CONSTRAINT "ApplicationHistory_toStageId_fkey" FOREIGN KEY ("toStageId") REFERENCES "PipelineStage"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationHistory" ADD CONSTRAINT "ApplicationHistory_changedById_fkey" FOREIGN KEY ("changedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ApplicationHistory" ADD CONSTRAINT "ApplicationHistory_pipelineStageId_fkey" FOREIGN KEY ("pipelineStageId") REFERENCES "PipelineStage"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_scheduledById_fkey" FOREIGN KEY ("scheduledById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_pipelineId_fkey" FOREIGN KEY ("pipelineId") REFERENCES "Pipeline"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateProfile" ADD CONSTRAINT "CandidateProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateProfile" ADD CONSTRAINT "CandidateProfile_contactInfoId_fkey" FOREIGN KEY ("contactInfoId") REFERENCES "ContactInfo"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateProfile" ADD CONSTRAINT "CandidateProfile_professionalProfileId_fkey" FOREIGN KEY ("professionalProfileId") REFERENCES "ProfessionalProfile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Resume" ADD CONSTRAINT "Resume_professionalProfileId_fkey" FOREIGN KEY ("professionalProfileId") REFERENCES "ProfessionalProfile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Resume" ADD CONSTRAINT "Resume_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoverLetter" ADD CONSTRAINT "CoverLetter_professionalProfileId_fkey" FOREIGN KEY ("professionalProfileId") REFERENCES "ProfessionalProfile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoverLetter" ADD CONSTRAINT "CoverLetter_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobPreference" ADD CONSTRAINT "JobPreference_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProfileLinks" ADD CONSTRAINT "ProfileLinks_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationPreference" ADD CONSTRAINT "NotificationPreference_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProfileVisibilityPreference" ADD CONSTRAINT "ProfileVisibilityPreference_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateSignatures" ADD CONSTRAINT "CandidateSignatures_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateSavedJob" ADD CONSTRAINT "CandidateSavedJob_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateSavedJob" ADD CONSTRAINT "CandidateSavedJob_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateValuesMatchSession" ADD CONSTRAINT "CandidateValuesMatchSession_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateValuesMatchSession" ADD CONSTRAINT "CandidateValuesMatchSession_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateValuesMatch" ADD CONSTRAINT "CandidateValuesMatch_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES "CandidateValuesMatchSession"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateValuesMatch" ADD CONSTRAINT "CandidateValuesMatch_coreValueId_fkey" FOREIGN KEY ("coreValueId") REFERENCES "core_values"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_questionnaire_responses" ADD CONSTRAINT "candidate_questionnaire_responses_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_questionnaire_responses" ADD CONSTRAINT "candidate_questionnaire_responses_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_questionnaire_responses" ADD CONSTRAINT "candidate_questionnaire_responses_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_question_answers" ADD CONSTRAINT "candidate_question_answers_responseId_fkey" FOREIGN KEY ("responseId") REFERENCES "candidate_questionnaire_responses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_question_answers" ADD CONSTRAINT "candidate_question_answers_questionCode_fkey" FOREIGN KEY ("questionCode") REFERENCES "candidate_questions"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_questionnaire_summaries" ADD CONSTRAINT "candidate_questionnaire_summaries_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_questionnaire_summaries" ADD CONSTRAINT "candidate_questionnaire_summaries_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_conversations" ADD CONSTRAINT "chat_conversations_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_participants" ADD CONSTRAINT "chat_participants_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "chat_conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_participants" ADD CONSTRAINT "chat_participants_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_messages" ADD CONSTRAINT "chat_messages_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "chat_conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_messages" ADD CONSTRAINT "chat_messages_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "companies" ADD CONSTRAINT "companies_industryId_fkey" FOREIGN KEY ("industryId") REFERENCES "industries"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "departments" ADD CONSTRAINT "departments_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_core_values" ADD CONSTRAINT "company_core_values_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_core_values" ADD CONSTRAINT "company_core_values_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_core_values" ADD CONSTRAINT "company_core_values_coreValueId_fkey" FOREIGN KEY ("coreValueId") REFERENCES "core_values"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_qualities" ADD CONSTRAINT "company_qualities_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_qualities" ADD CONSTRAINT "company_qualities_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_qualities" ADD CONSTRAINT "company_qualities_qualityId_fkey" FOREIGN KEY ("qualityId") REFERENCES "qualities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_matching_weights" ADD CONSTRAINT "company_matching_weights_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_matching_weights" ADD CONSTRAINT "company_matching_weights_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_notification_settings" ADD CONSTRAINT "company_notification_settings_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_invitations" ADD CONSTRAINT "company_invitations_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_invitations" ADD CONSTRAINT "company_invitations_invitedById_fkey" FOREIGN KEY ("invitedById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_invitations" ADD CONSTRAINT "company_invitations_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "company_access_policies" ADD CONSTRAINT "company_access_policies_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScoreThreshold" ADD CONSTRAINT "ScoreThreshold_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job" ADD CONSTRAINT "Job_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job" ADD CONSTRAINT "Job_recruiterId_fkey" FOREIGN KEY ("recruiterId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job" ADD CONSTRAINT "Job_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Job" ADD CONSTRAINT "Job_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobCoreValueKeyword" ADD CONSTRAINT "JobCoreValueKeyword_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobCoreValueKeyword" ADD CONSTRAINT "JobCoreValueKeyword_coreValueId_fkey" FOREIGN KEY ("coreValueId") REFERENCES "core_values"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobCoreValueWeighting" ADD CONSTRAINT "JobCoreValueWeighting_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobCoreValueWeighting" ADD CONSTRAINT "JobCoreValueWeighting_coreValueId_fkey" FOREIGN KEY ("coreValueId") REFERENCES "core_values"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobBenchmarkProfile" ADD CONSTRAINT "JobBenchmarkProfile_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobBenchmarkCoreValue" ADD CONSTRAINT "JobBenchmarkCoreValue_benchmarkId_fkey" FOREIGN KEY ("benchmarkId") REFERENCES "JobBenchmarkProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobBenchmarkCoreValue" ADD CONSTRAINT "JobBenchmarkCoreValue_coreValueId_fkey" FOREIGN KEY ("coreValueId") REFERENCES "core_values"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobBenchmarkTeamStyleTag" ADD CONSTRAINT "JobBenchmarkTeamStyleTag_benchmarkId_fkey" FOREIGN KEY ("benchmarkId") REFERENCES "JobBenchmarkProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateTagFeedback" ADD CONSTRAINT "CandidateTagFeedback_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateTagFeedback" ADD CONSTRAINT "CandidateTagFeedback_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateTagFeedback" ADD CONSTRAINT "CandidateTagFeedback_teamStyleTagId_fkey" FOREIGN KEY ("teamStyleTagId") REFERENCES "TeamStyleTag"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecruiterCoreValueFeedback" ADD CONSTRAINT "RecruiterCoreValueFeedback_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecruiterCoreValueFeedback" ADD CONSTRAINT "RecruiterCoreValueFeedback_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecruiterCoreValueFeedback" ADD CONSTRAINT "RecruiterCoreValueFeedback_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecruiterCoreValueRating" ADD CONSTRAINT "RecruiterCoreValueRating_feedbackId_fkey" FOREIGN KEY ("feedbackId") REFERENCES "RecruiterCoreValueFeedback"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecruiterCoreValueRating" ADD CONSTRAINT "RecruiterCoreValueRating_coreValueId_fkey" FOREIGN KEY ("coreValueId") REFERENCES "core_values"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SixMonthEVPFeedback" ADD CONSTRAINT "SixMonthEVPFeedback_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SixMonthEVPFeedback" ADD CONSTRAINT "SixMonthEVPFeedback_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SixMonthEVPFeedback" ADD CONSTRAINT "SixMonthEVPFeedback_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SixMonthEVPRating" ADD CONSTRAINT "SixMonthEVPRating_feedbackId_fkey" FOREIGN KEY ("feedbackId") REFERENCES "SixMonthEVPFeedback"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SixMonthEVPRating" ADD CONSTRAINT "SixMonthEVPRating_coreValueId_fkey" FOREIGN KEY ("coreValueId") REFERENCES "core_values"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateEmployerFeedback" ADD CONSTRAINT "CandidateEmployerFeedback_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CandidateEmployerFeedback" ADD CONSTRAINT "CandidateEmployerFeedback_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobBenchmarkFitPriority" ADD CONSTRAINT "JobBenchmarkFitPriority_benchmarkId_fkey" FOREIGN KEY ("benchmarkId") REFERENCES "JobBenchmarkProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobBenchmarkQuality" ADD CONSTRAINT "JobBenchmarkQuality_benchmarkId_fkey" FOREIGN KEY ("benchmarkId") REFERENCES "JobBenchmarkProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "JobBenchmarkQuality" ADD CONSTRAINT "JobBenchmarkQuality_qualityId_fkey" FOREIGN KEY ("qualityId") REFERENCES "qualities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_invitations" ADD CONSTRAINT "job_invitations_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_invitations" ADD CONSTRAINT "job_invitations_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_invitations" ADD CONSTRAINT "job_invitations_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_invitations" ADD CONSTRAINT "job_invitations_invitedById_fkey" FOREIGN KEY ("invitedById") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Todo" ADD CONSTRAINT "Todo_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Todo" ADD CONSTRAINT "Todo_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Todo" ADD CONSTRAINT "Todo_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Todo" ADD CONSTRAINT "Todo_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Todo" ADD CONSTRAINT "Todo_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_recipientId_fkey" FOREIGN KEY ("recipientId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pools" ADD CONSTRAINT "talent_pools_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pools" ADD CONSTRAINT "talent_pools_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pools" ADD CONSTRAINT "talent_pools_ownerRecruiterId_fkey" FOREIGN KEY ("ownerRecruiterId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pools" ADD CONSTRAINT "talent_pools_addedById_fkey" FOREIGN KEY ("addedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "organization_memberships" ADD CONSTRAINT "organization_memberships_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "organization_memberships" ADD CONSTRAINT "organization_memberships_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "organization_memberships" ADD CONSTRAINT "organization_memberships_invitedById_fkey" FOREIGN KEY ("invitedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "membership_roles" ADD CONSTRAINT "membership_roles_membershipId_fkey" FOREIGN KEY ("membershipId") REFERENCES "organization_memberships"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "membership_roles" ADD CONSTRAINT "membership_roles_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "membership_roles" ADD CONSTRAINT "membership_roles_assignedById_fkey" FOREIGN KEY ("assignedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_permission_mappings" ADD CONSTRAINT "role_permission_mappings_permissionId_fkey" FOREIGN KEY ("permissionId") REFERENCES "access_permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "organization_quota_usage" ADD CONSTRAINT "organization_quota_usage_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_assignments" ADD CONSTRAINT "job_assignments_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_assignments" ADD CONSTRAINT "job_assignments_recruiterId_fkey" FOREIGN KEY ("recruiterId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_assignments" ADD CONSTRAINT "job_assignments_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_assignments" ADD CONSTRAINT "job_assignments_assignedById_fkey" FOREIGN KEY ("assignedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_job_mvm" ADD CONSTRAINT "candidate_job_mvm_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_job_mvm" ADD CONSTRAINT "candidate_job_mvm_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_job_mvm" ADD CONSTRAINT "candidate_job_mvm_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_stats" ADD CONSTRAINT "job_stats_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "job_stats" ADD CONSTRAINT "job_stats_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_tasks" ADD CONSTRAINT "feedback_tasks_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_tasks" ADD CONSTRAINT "feedback_tasks_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_tasks" ADD CONSTRAINT "feedback_tasks_placementId_fkey" FOREIGN KEY ("placementId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_tasks" ADD CONSTRAINT "feedback_tasks_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_tasks" ADD CONSTRAINT "feedback_tasks_recruiterFeedbackId_fkey" FOREIGN KEY ("recruiterFeedbackId") REFERENCES "RecruiterCoreValueFeedback"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_tasks" ADD CONSTRAINT "feedback_tasks_sixMonthFeedbackId_fkey" FOREIGN KEY ("sixMonthFeedbackId") REFERENCES "SixMonthEVPFeedback"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedback_tasks" ADD CONSTRAINT "feedback_tasks_candidateFeedbackId_fkey" FOREIGN KEY ("candidateFeedbackId") REFERENCES "CandidateEmployerFeedback"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviewer_sessions" ADD CONSTRAINT "reviewer_sessions_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviewer_sessions" ADD CONSTRAINT "reviewer_sessions_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reviewer_sessions" ADD CONSTRAINT "reviewer_sessions_reviewerId_fkey" FOREIGN KEY ("reviewerId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pool_sources" ADD CONSTRAINT "talent_pool_sources_talentPoolId_fkey" FOREIGN KEY ("talentPoolId") REFERENCES "talent_pools"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pool_sources" ADD CONSTRAINT "talent_pool_sources_sourcedById_fkey" FOREIGN KEY ("sourcedById") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recruiter_performance_logs" ADD CONSTRAINT "recruiter_performance_logs_recruiterId_fkey" FOREIGN KEY ("recruiterId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recruiter_performance_logs" ADD CONSTRAINT "recruiter_performance_logs_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recruiter_performance_logs" ADD CONSTRAINT "recruiter_performance_logs_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_actorUserId_fkey" FOREIGN KEY ("actorUserId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pool_entries" ADD CONSTRAINT "talent_pool_entries_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pool_entries" ADD CONSTRAINT "talent_pool_entries_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pool_entries" ADD CONSTRAINT "talent_pool_entries_ownerRecruiterId_fkey" FOREIGN KEY ("ownerRecruiterId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "talent_pool_entries" ADD CONSTRAINT "talent_pool_entries_addedById_fkey" FOREIGN KEY ("addedById") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_post_interview" ADD CONSTRAINT "internal_feedback_post_interview_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_post_interview" ADD CONSTRAINT "internal_feedback_post_interview_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_post_interview" ADD CONSTRAINT "internal_feedback_post_interview_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_post_interview" ADD CONSTRAINT "internal_feedback_post_interview_feedbackTaskId_fkey" FOREIGN KEY ("feedbackTaskId") REFERENCES "feedback_tasks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_post_interview" ADD CONSTRAINT "internal_feedback_post_interview_submittedById_fkey" FOREIGN KEY ("submittedById") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_6_month_client" ADD CONSTRAINT "internal_feedback_6_month_client_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_6_month_client" ADD CONSTRAINT "internal_feedback_6_month_client_placementId_fkey" FOREIGN KEY ("placementId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_6_month_client" ADD CONSTRAINT "internal_feedback_6_month_client_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_6_month_client" ADD CONSTRAINT "internal_feedback_6_month_client_feedbackTaskId_fkey" FOREIGN KEY ("feedbackTaskId") REFERENCES "feedback_tasks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "internal_feedback_6_month_client" ADD CONSTRAINT "internal_feedback_6_month_client_submittedById_fkey" FOREIGN KEY ("submittedById") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_feedback_6_month" ADD CONSTRAINT "candidate_feedback_6_month_candidateProfileId_fkey" FOREIGN KEY ("candidateProfileId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_feedback_6_month" ADD CONSTRAINT "candidate_feedback_6_month_placementId_fkey" FOREIGN KEY ("placementId") REFERENCES "Application"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "candidate_feedback_6_month" ADD CONSTRAINT "candidate_feedback_6_month_feedbackTaskId_fkey" FOREIGN KEY ("feedbackTaskId") REFERENCES "feedback_tasks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recruiter_activity_metrics" ADD CONSTRAINT "recruiter_activity_metrics_recruiterId_fkey" FOREIGN KEY ("recruiterId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "recruiter_activity_metrics" ADD CONSTRAINT "recruiter_activity_metrics_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;
