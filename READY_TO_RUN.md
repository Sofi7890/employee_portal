# Employee & Workforce System - Ready Build

This build keeps the existing Spring MVC + JSP + Hibernate architecture and adds the practical proposal modules without OTP/email setup.

## Added
- Employee self-service dashboard
- Attendance check-in/check-out/history/admin search
- Leave balance, apply, history, admin approve/reject
- Expense claims, receipt upload, admin approve/reject
- Resignation/exit workflow with last working date
- In-app notifications
- Audit logs
- Workforce reports and CSV exports
- Employee search/sort
- Soft-delete behavior for employees/clients/projects (employee restore screen)
- Dashboard metrics and light JSP styling

## Intentionally excluded
- OTP authentication
- SMTP/email setup
- Full PDF/Excel binary report generation (CSV exports are included)

## Database
The existing five tables are preserved. Hibernate `update` automatically creates the new feature tables and adds the small status/active columns when the application starts.

## Run
1. Use Java 17 and Tomcat 9.
2. Ensure MySQL database `ems_system_db` is available.
3. Verify the DB connection in `src/main/java/com/project/config/HibernateConfig.java` if your local MySQL credentials differ.
4. Deploy the generated `ems-system.war` or run from Eclipse.
5. Open `/ems-system/` and it redirects to `/auth/login`.
6. Existing admin/employee/client BCrypt passwords remain untouched.

## Important
Because the source uses JSP + Spring MVC rather than the Thymeleaf/Spring Boot stack written in the proposal, this build deliberately extends the working architecture instead of rewriting it.
