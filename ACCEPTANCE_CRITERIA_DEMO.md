# How to Show All Acceptance Criteria (Milestone 0 & 1) to the Client

**This is the README section “How to test Milestone 1”** (and Milestone 0). It maps each deliverable and acceptance criterion to concrete steps you can run in front of the client. Use it for demos and sign-off.

**Replace `http://localhost:3000` and `http://localhost:4000` with your frontend/backend URLs if different.**

---

## Prerequisites (before the demo)

1. **Backend** running (e.g. port 4000), **frontend** running (e.g. port 3000).
2. **Backend DB** migrated and seeded:
   ```bash
   cd backend
   npm install
   npx prisma migrate reset   # or: npx prisma migrate deploy
   npm run db:seed
   npm run start:dev
   ```
3. **Frontend** running (e.g. `npm run dev` in the frontend repo).
4. **Seeded user**: `user1@example.com` / password **`dev12345`** (8+ chars; frontend rejects shorter). User is in **Org A** (Admin) and **Org B** (Viewer).

---

## Milestone 0 — Authorization

### Deliverable: Auth provider with session/JWT containing userId

| What to show | How to show | Verify |
|--------------|-------------|--------|
| Session/JWT contains userId | 1. Open **http://localhost:3000/auth/log-in**.<br>2. Sign in with **user1@example.com** / **dev12345**.<br>3. You are redirected to **http://localhost:3000/client/dashboard**. | User lands on dashboard (no redirect back to login). Session is established with userId (used server-side for org resolution). |

### Deliverable: Server-side session validation in Nest (guard/middleware)

| What to show | How to show | Verify |
|--------------|-------------|--------|
| Protected routes require valid session | 1. **Log out** (sidebar → Logout).<br>2. In browser DevTools → Console run: `fetch('http://localhost:4000/orgs').then(r => console.log(r.status))`.<br>3. Or in a new incognito window, call the same (no cookies). | Response status **401** (Unauthorized). Server rejects unauthenticated calls. |
| Valid session is accepted | 1. Log in again at **http://localhost:3000/auth/log-in** (**user1@example.com** / **dev12345**).<br>2. Open **Settings → Backend RBAC test (M0 & M1)** (or **http://localhost:3000/client/backend-rbac-test**).<br>3. Page shows **Current org ID** and list of orgs. | No “No backend session” error. Backend accepts the session and returns org data. |

### Deliverable: Membership lookup — userId → org memberships + roles, no trust in client-sent orgId

| What to show | How to show | Verify |
|--------------|-------------|--------|
| userId → org memberships + roles | On the **Backend RBAC test** page, you see **2 orgs** (e.g. Org A, Org B) with roles (e.g. admin, viewer). | List comes from backend **GET /orgs**, which resolves memberships and roles from DB using **userId from the JWT** — not from any client-sent orgId. |
| No trust in client-sent orgId | currentOrgId is shown at the top. It is **not** sent by the client; it is loaded from **UserCurrentOrg** or from the user’s memberships on the server. | Server resolves currentOrgId from session/JWT + membership table only (see backend `OrgContextService`). |

### Acceptance: Log in/out, session expires, server rejects unauthenticated

| Criterion | How to show | Verify |
|-----------|-------------|--------|
| Log in | Go to **http://localhost:3000/auth/log-in**, sign in with **user1@example.com** / **dev12345**. | Redirect to client dashboard. |
| Log out | Click **Logout** in the sidebar. | Redirect to login; visiting **/client/dashboard** again redirects to login. |
| Session expires | (Optional) Wait for JWT expiry or delete the `backend_access_token` cookie, then open **/client/dashboard**. | Redirect to login. |
| Server rejects unauthenticated | Without logging in, call **GET http://localhost:4000/orgs** (e.g. from DevTools or curl). | **401** response. |

### Acceptance: User in 2 orgs resolved server-side

| Criterion | How to show | Verify |
|-----------|-------------|--------|
| User in 2 orgs resolved server-side | 1. Log in (**user1@example.com** / **dev12345**).<br>2. Open **Backend RBAC test** page (**Settings → Backend RBAC test (M0 & M1)**). | Page shows **Current org ID** and a list of **2 orgs** (Org A, Org B). All resolved server-side from userId. |

---

## Milestone 1 — Organization Context + Permissions

### Deliverable: Current Organization Context — server-side currentOrgId

| What to show | How to show | Verify |
|--------------|-------------|--------|
| currentOrgId resolved server-side | On the **Backend RBAC test** page, note **Current org ID** at the top. | Loaded from authenticated session/JWT + **membership table** (UserCurrentOrg or default membership). Not from client input. |
| Available in route handlers | Backend **GET /orgs** and **POST /orgs/:id/switch** use `@AuthCtx()` and `currentOrgId` from the resolved context. | Same page calls these endpoints and displays currentOrgId and org list. |
| Available in service layer | Backend `OrgContextService.resolveAuthContext()` is used by guards and returns `currentOrgId`; jobs controller uses `@CurrentOrgId()`. | Demonstrated by switching org and calling **POST /jobs/publish** (see below). |

### Deliverable: Permission model — hasPermission / requirePermission, role → permission server-side

| What to show | How to show | Verify |
|--------------|-------------|--------|
| Permission helper / requirePermission | Backend uses `@RequirePermission('job:create')` and `@RequirePermission('job:publish')` on **POST /jobs** and **POST /jobs/publish**; guard checks `authContext.permissions`. | On **Backend RBAC test** page, click **Call POST /jobs/publish**. In Org A (Admin) → **200**; in Org B (Viewer) → **403**. |
| Role → permission server-side | Permissions come from **RolePermissionMapping** (e.g. Admin → all job:*; Viewer → job:read only). No UI logic. | Same as above: different HTTP status per org/role proves role→permission is resolved on the server. |

### Deliverable: Seed data — permissions, default roles, role-permission mappings, idempotent

| What to show | How to show | Verify |
|--------------|-------------|--------|
| Canonical permissions seeded | Run `npm run db:seed` in backend. | DB table `access_permissions` contains e.g. job:create, job:read, job:update, job:delete, job:publish. |
| Default roles seeded | Same seed. | Roles (Admin, Recruiter, Viewer) represented via **AccessRole** and **MembershipRole**; seed assigns user to Org A (ORG_ADMIN) and Org B (VIEWER). |
| Role-permission mappings seeded | Same seed. | Table `role_permission_mappings` (or equivalent) links roles to permissions (e.g. ORG_ADMIN → all, VIEWER → job:read). |
| Seed is idempotent | Run `npm run db:seed` a second time. | No errors; same data (upsert/merge behavior). |

### Acceptance: Start app, log in with user in 2 orgs

| Criterion | How to show | Verify |
|-----------|-------------|--------|
| Start app locally | Start backend and frontend (see Prerequisites). | Both respond (e.g. frontend at :3000, backend at :4000). |
| Log in with user who belongs to 2 orgs | Open **http://localhost:3000/auth/log-in**, sign in **user1@example.com** / **dev12345**. | User lands on client dashboard; Backend RBAC test page shows 2 orgs. |

### Acceptance: Switching org changes currentOrgId

| Criterion | How to show | Verify |
|-----------|-------------|--------|
| Switching org changes currentOrgId | 1. On **Backend RBAC test** page, note **Current org ID** (e.g. Org A).<br>2. Click **Switch here** for the other org (e.g. Org B).<br>3. Page refetches org list. | **Current org ID** and the list update to the new org (e.g. Org B marked as current). |

### Acceptance: Permissions differ per org

| Criterion | How to show | Verify |
|-----------|-------------|--------|
| Permissions differ per org | 1. On **Backend RBAC test**, ensure you’re in **Org A** (Admin). Click **Call POST /jobs/publish**.<br>2. Click **Switch here** for **Org B** (Viewer). Click **Call POST /jobs/publish** again. | First call → **200** (Admin has job:publish). Second call → **403** (Viewer does not). |

### Acceptance: DB contains seeded roles & permissions

| Criterion | How to show | Verify |
|-----------|-------------|--------|
| DB contains seeded roles & permissions | After `npm run db:seed`, open DB (e.g. TablePlus, pgAdmin, or `psql`). | Tables `access_permissions`, `role_permission_mappings`, `membership_roles`, `user_current_org` (or equivalent) contain the expected rows (permissions, role–permission links, user’s memberships and current org). |

---

## Quick demo script (for client meeting)

1. **Prerequisites**: Backend + frontend running; DB migrated and seeded.
2. **Login**: Open login page → **user1@example.com** / **dev12345** → land on client dashboard. *(M0: session/JWT with userId; server-side validation.)*
3. **Unauthenticated rejected**: In DevTools Console, `fetch('http://localhost:4000/orgs').then(r => console.log(r.status))` → show **401**. *(M0: server rejects unauthenticated.)*
4. **2 orgs resolved server-side**: Open **Settings → Backend RBAC test** → show **Current org ID** and list of **2 orgs**. *(M0: membership lookup; M1: currentOrgId from session/membership.)*
5. **Switch org**: Click **Switch here** for the other org → show **Current org ID** and list updating. *(M1: switching org changes currentOrgId.)*
6. **Permissions per org**: In Org A, click **Call POST /jobs/publish** → **200**. Switch to Org B, click again → **403**. *(M1: permissions differ per org; role→permission server-side.)*
7. **Logout**: Click Logout → try opening dashboard → redirect to login. *(M0: log out; session cleared.)*
8. **(Optional) DB**: Show `access_permissions` and `role_permission_mappings` (or equivalent) in DB. *(M1: seeded roles & permissions.)*

---

## Optional: API verification (curl)

Useful if the client wants to see API-level proof without the UI.

1. Get token: log in on frontend, then DevTools → Application → Cookies → copy **backend_access_token** (or get JWT via backend signin: `curl -s -X POST "http://localhost:4000/auth/signin" -H "Content-Type: application/json" -d '{"email":"user1@example.com","password":"dev12345"}'` and use the returned `jwt`).
2. Set `TOKEN="<paste>"`.
3. **GET /orgs**: `curl -s "http://localhost:4000/orgs" -H "Authorization: Bearer $TOKEN"` → JSON with currentOrgId and list of orgs.
4. **POST /orgs/:id/switch**: `curl -s -X POST "http://localhost:4000/orgs/<ORG_B_ID>/switch" -H "Authorization: Bearer $TOKEN"`.
5. **GET /orgs** again → currentOrgId changed.
6. **POST /jobs/publish**: `curl -s -o /dev/null -w "%{http_code}" -X POST "http://localhost:4000/jobs/publish" -H "Authorization: Bearer $TOKEN"` — in Org A (Admin) → 200; after switch to Org B (Viewer) → 403.

---

## Example: how to show Milestones 0–1 (5 min)

1. **Start** backend (`npm run start:dev`) and frontend (`npm run dev`). Ensure DB is migrated and seeded (`npm run db:seed`). Seeded demo user: **user1@example.com** / **dev12345** (8+ chars; frontend will reject e.g. `dev`).
2. **Log in** at http://localhost:3000/auth/log-in with that user → you land on the client dashboard. *(M0: session/JWT with userId.)*
3. **Reject unauthenticated**: Open DevTools → Console → run `fetch('http://localhost:4000/orgs').then(r => console.log(r.status))` → **401**. *(M0: server rejects unauthenticated.)*
4. **2 orgs from server**: Go to **Settings → Backend RBAC test** (or `/client/backend-rbac-test`) → see **Current org ID** and **2 orgs** (Org A, Org B). *(M0: membership lookup; M1: currentOrgId from session/membership.)*
5. **Switch org**: Click **Switch here** on Org B → **Current org ID** and list update. *(M1: switching org changes currentOrgId.)*
6. **Permissions per org**: With **Org A** current, click **Call POST /jobs/publish** → **200**. Switch to **Org B**, click again → **403**. *(M1: permissions differ per org.)*
7. **Log out**: Sidebar → Logout → open `/client/dashboard` → redirect to login. *(M0: session cleared.)*

---

## Checklist for sign-off

- [ ] **M0** — Log in with userId in session; log out; session cleared.
- [ ] **M0** — Unauthenticated request to protected endpoint returns 401.
- [ ] **M0** — User in 2 orgs: backend returns list of orgs + currentOrgId (no client-sent orgId).
- [ ] **M1** — currentOrgId shown and loaded from session/membership only.
- [ ] **M1** — Switching org updates currentOrgId (visible on Backend RBAC test page).
- [ ] **M1** — POST /jobs/publish returns 200 in Org A (Admin) and 403 in Org B (Viewer).
- [ ] **M1** — DB contains seeded permissions, roles, and role-permission mappings; seed is idempotent.
