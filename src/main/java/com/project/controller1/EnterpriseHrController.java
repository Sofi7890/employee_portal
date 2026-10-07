package com.project.controller1;

import com.project.entity.*;
import com.project.entity.enterprise.*;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;

import java.io.File;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.time.*;
import java.util.*;

@Controller
@Transactional
public class EnterpriseHrController {

    private final SessionFactory sf;

    @Autowired
    public EnterpriseHrController(SessionFactory sf) {
        this.sf = sf;
    }

    private Session db() {
        return sf.getCurrentSession();
    }

    private String role(HttpSession s) {
        return (String) s.getAttribute("role");
    }

    private String user(HttpSession s) {
        return (String) s.getAttribute("username");
    }

    private boolean admin(HttpSession s) {
        return "ROLE_ADMIN".equals(role(s));
    }

    private Employee find(String id) {
        return db().get(Employee.class, id);
    }

    private Employee me(HttpSession s) {

        String email = user(s);

        if (email == null) {
            return null;
        }

        Query<Employee> q =
                db().createQuery(
                        "from Employee where employeeEmail=:e",
                        Employee.class
                );

        q.setParameter("e", email);

        return q.uniqueResult();
    }

    private List<Employee> employees() {

        return db().createQuery(
                "from Employee order by employeeName",
                Employee.class
        ).getResultList();
    }


    /* ============================================================
       ENTERPRISE CENTER
       ============================================================ */

    @GetMapping("/enterprise")
    public String home(Model m, HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        seedSalaries();

        m.addAttribute("employees", employees());

        m.addAttribute(
                "salaryCount",
                db().createQuery(
                        "select count(x) from SalaryStructure x",
                        Long.class
                ).getSingleResult()
        );

        m.addAttribute(
                "payrollCount",
                db().createQuery(
                        "select count(x) from PayrollRecord x",
                        Long.class
                ).getSingleResult()
        );

        m.addAttribute(
                "pendingApprovals",
                db().createQuery(
                        "select count(x) from ApprovalRequest x " +
                        "where x.status='PENDING'",
                        Long.class
                ).getSingleResult()
        );

        m.addAttribute(
                "openGoals",
                db().createQuery(
                        "select count(x) from PerformanceGoal x " +
                        "where x.status='OPEN'",
                        Long.class
                ).getSingleResult()
        );

        return "enterprise-dashboard";
    }


    private void seedSalaries() {

        List<Employee> es = employees();

        for (Employee e : es) {

            Query<Long> q =
                    db().createQuery(
                            "select count(x) from SalaryStructure x " +
                            "where x.employee.employeeId=:id",
                            Long.class
                    );

            q.setParameter("id", e.getEmployeeId());

            if (q.getSingleResult() == 0) {

                SalaryStructure x =
                        new SalaryStructure();

                x.setEmployee(e);

                BigDecimal basic =
                        new BigDecimal("30000");

                if ("ROLE_ADMIN".equals(e.getRole())) {

                    basic =
                            new BigDecimal("55000");

                } else if (
                        e.getRole() != null &&
                        e.getRole().contains("MANAGER")
                ) {

                    basic =
                            new BigDecimal("45000");
                }

                x.setBasicSalary(basic);

                x.setHra(
                        basic.multiply(
                                new BigDecimal("0.40")
                        )
                );

                x.setAllowances(
                        basic.multiply(
                                new BigDecimal("0.10")
                        )
                );

                x.setPf(
                        basic.multiply(
                                new BigDecimal("0.12")
                        )
                );

                x.setTax(
                        basic.multiply(
                                new BigDecimal("0.05")
                        )
                );

                x.setEffectiveFrom(
                        e.getDateOfJoining() == null
                                ? LocalDate.now()
                                : e.getDateOfJoining()
                );

                db().save(x);
            }
        }
    }


    /* ============================================================
       SALARY
       ============================================================ */

    @GetMapping("/enterprise/salary")
    public String salary(Model m, HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        seedSalaries();

        m.addAttribute(
                "salaries",
                db().createQuery(
                        "from SalaryStructure " +
                        "order by employee.employeeName",
                        SalaryStructure.class
                ).getResultList()
        );

        m.addAttribute(
                "employees",
                employees()
        );

        return "enterprise-salary";
    }


    @PostMapping("/enterprise/salary/save")
    public String salarySave(
            @RequestParam String employeeId,
            @RequestParam BigDecimal basic,
            @RequestParam BigDecimal hra,
            @RequestParam BigDecimal allowances,
            @RequestParam BigDecimal pf,
            @RequestParam BigDecimal tax,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        Employee e = find(employeeId);

        if (e != null) {

            Query<SalaryStructure> q =
                    db().createQuery(
                            "from SalaryStructure " +
                            "where employee.employeeId=:id",
                            SalaryStructure.class
                    );

            q.setParameter("id", employeeId);

            SalaryStructure x =
                    q.uniqueResult();

            if (x == null) {

                x = new SalaryStructure();

                x.setEmployee(e);
            }

            x.setBasicSalary(basic);
            x.setHra(hra);
            x.setAllowances(allowances);
            x.setPf(pf);
            x.setTax(tax);

            x.setEffectiveFrom(
                    LocalDate.now()
            );

            db().saveOrUpdate(x);
        }

        return "redirect:/enterprise/salary";
    }


    /* ============================================================
       PAYROLL
       ============================================================ */

    @PostMapping("/enterprise/payroll/process")
    public String processPayroll(
            @RequestParam int month,
            @RequestParam int year,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        seedSalaries();

        List<SalaryStructure> salaryStructures =
                db().createQuery(
                        "from SalaryStructure",
                        SalaryStructure.class
                ).getResultList();

        for (SalaryStructure x : salaryStructures) {

            Query<PayrollRecord> q =
                    db().createQuery(
                            "from PayrollRecord " +
                            "where employee.employeeId=:id " +
                            "and payrollMonth=:m " +
                            "and payrollYear=:y",
                            PayrollRecord.class
                    );

            q.setParameter(
                    "id",
                    x.getEmployee().getEmployeeId()
            );

            q.setParameter("m", month);
            q.setParameter("y", year);

            PayrollRecord p =
                    q.uniqueResult();

            if (p == null) {

                p = new PayrollRecord();

                p.setEmployee(
                        x.getEmployee()
                );

                p.setPayrollMonth(month);
                p.setPayrollYear(year);

                p.setGross(
                        x.getGross()
                );

                p.setDeductions(
                        x.getTotalDeductions()
                );

                p.setNet(
                        x.getNetSalary()
                );

                p.setStatus(
                        "PROCESSED"
                );

                p.setProcessedAt(
                        LocalDateTime.now()
                );

                db().save(p);

            } else {

                if (!"ON HOLD".equalsIgnoreCase(
                        p.getStatus()
                )) {

                    p.setGross(
                            x.getGross()
                    );

                    p.setDeductions(
                            x.getTotalDeductions()
                    );

                    p.setNet(
                            x.getNetSalary()
                    );

                    p.setStatus(
                            "PROCESSED"
                    );

                    p.setProcessedAt(
                            LocalDateTime.now()
                    );

                    db().update(p);
                }
            }
        }

        return "redirect:/enterprise/payroll";
    }


    @GetMapping("/enterprise/payroll")
    public String payroll(
            Model m,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        m.addAttribute(
                "payroll",
                db().createQuery(
                        "from PayrollRecord " +
                        "order by payrollYear desc, " +
                        "payrollMonth desc, " +
                        "employee.employeeName",
                        PayrollRecord.class
                ).getResultList()
        );

        m.addAttribute(
                "now",
                LocalDate.now()
        );

        return "enterprise-payroll";
    }


    @PostMapping("/enterprise/payroll/{id}/hold")
    public String holdPayroll(
            @PathVariable Long id,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        PayrollRecord p =
                db().get(
                        PayrollRecord.class,
                        id
                );

        if (p != null &&
                "PROCESSED".equalsIgnoreCase(
                        p.getStatus()
                )) {

            p.setStatus("ON HOLD");

            db().update(p);
        }

        return "redirect:/enterprise/payroll";
    }


    @PostMapping("/enterprise/payroll/{id}/release")
    public String releasePayroll(
            @PathVariable Long id,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        PayrollRecord p =
                db().get(
                        PayrollRecord.class,
                        id
                );

        if (p != null &&
                "ON HOLD".equalsIgnoreCase(
                        p.getStatus()
                )) {

            p.setStatus("APPROVED");

            db().update(p);
        }

        return "redirect:/enterprise/payroll";
    }


    /* ============================================================
       DOCUMENTS
       ============================================================ */

    @GetMapping("/enterprise/documents")
    public String documents(
            Model m,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        m.addAttribute(
                "documents",
                db().createQuery(
                        "from EmployeeDocument " +
                        "order by expiryDate",
                        EmployeeDocument.class
                ).getResultList()
        );

        m.addAttribute(
                "employees",
                employees()
        );

        return "enterprise-documents";
    }


    @PostMapping("/enterprise/documents/save")
    public String docSave(
            @RequestParam String employeeId,
            @RequestParam String type,
            @RequestParam String name,
            @RequestParam(required = false) String issueDate,
            @RequestParam(required = false) String expiryDate,
            @RequestParam("documentFile") MultipartFile documentFile,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        Employee employee =
                find(employeeId);

        if (employee == null) {
            return "redirect:/enterprise/documents";
        }

        EmployeeDocument d =
                new EmployeeDocument();

        d.setEmployee(employee);
        d.setDocumentType(type);
        d.setDocumentName(name);

        if (issueDate != null &&
                !issueDate.isEmpty()) {

            d.setIssueDate(
                    LocalDate.parse(issueDate)
            );
        }

        if (expiryDate != null &&
                !expiryDate.isEmpty()) {

            d.setExpiryDate(
                    LocalDate.parse(expiryDate)
            );
        }

        if (documentFile != null &&
                !documentFile.isEmpty()) {

            try {

                String uploadDirectory =
                        System.getProperty("user.home")
                        + File.separator
                        + "ems-system-documents";

                File directory =
                        new File(uploadDirectory);

                if (!directory.exists()) {
                    directory.mkdirs();
                }

                String originalName =
                        documentFile.getOriginalFilename();

                if (originalName == null ||
                        originalName.trim().isEmpty()) {

                    return "redirect:/enterprise/documents";
                }

                originalName =
                        new File(originalName)
                                .getName();

                String extension = "";

                int dot =
                        originalName.lastIndexOf('.');

                if (dot >= 0) {

                    extension =
                            originalName.substring(dot);
                }

                String storedName =
                        employeeId
                        + "_"
                        + System.currentTimeMillis()
                        + extension;

                File destination =
                        new File(
                                directory,
                                storedName
                        );

                documentFile.transferTo(
                        destination
                );

                d.setFilePath(
                        destination.getAbsolutePath()
                );

            } catch (Exception ex) {

                ex.printStackTrace();

                return "redirect:/enterprise/documents";
            }
        }

        d.setStatus("ACTIVE");

        db().save(d);

        return "redirect:/enterprise/documents";
    }


    @GetMapping("/enterprise/documents/{id}/view")
    public ResponseEntity<Resource> viewDocument(
            @PathVariable Long id,
            HttpSession s) {

        if (!admin(s)) {

            return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .build();
        }

        EmployeeDocument d =
                db().get(
                        EmployeeDocument.class,
                        id
                );

        if (d == null ||
                d.getFilePath() == null ||
                d.getFilePath().trim().isEmpty()) {

            return ResponseEntity
                    .notFound()
                    .build();
        }

        try {

            File file =
                    new File(
                            d.getFilePath()
                    );

            if (!file.exists() ||
                    !file.isFile()) {

                return ResponseEntity
                        .notFound()
                        .build();
            }

            Resource resource =
                    new FileSystemResource(file);

            String contentType =
                    Files.probeContentType(
                            file.toPath()
                    );

            if (contentType == null) {
                contentType =
                        "application/octet-stream";
            }

            return ResponseEntity
                    .ok()
                    .header(
                            HttpHeaders.CONTENT_DISPOSITION,
                            "inline; filename=\""
                            + file.getName()
                            + "\""
                    )
                    .header(
                            HttpHeaders.CONTENT_TYPE,
                            contentType
                    )
                    .contentLength(
                            file.length()
                    )
                    .body(resource);

        } catch (Exception ex) {

            ex.printStackTrace();

            return ResponseEntity
                    .status(
                            HttpStatus.INTERNAL_SERVER_ERROR
                    )
                    .build();
        }
    }


    /* ============================================================
       PERFORMANCE
       ============================================================ */

    @GetMapping("/enterprise/performance")
    public String performance(
            Model m,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        m.addAttribute(
                "goals",
                db().createQuery(
                        "from PerformanceGoal order by dueDate",
                        PerformanceGoal.class
                ).getResultList()
        );

        m.addAttribute(
                "employees",
                employees()
        );

        return "enterprise-performance";
    }


    @PostMapping("/enterprise/performance/save")
    public String goalSave(
            @RequestParam String employeeId,
            @RequestParam String goalType,
            @RequestParam String title,
            @RequestParam(required = false) String description,
            @RequestParam int target,
            @RequestParam(required = false) String dueDate,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        PerformanceGoal g =
                new PerformanceGoal();

        g.setEmployee(
                find(employeeId)
        );

        g.setGoalType(goalType);
        g.setTitle(title);
        g.setDescription(description);
        g.setTargetPercent(target);

        if (dueDate != null &&
                !dueDate.isEmpty()) {

            g.setDueDate(
                    LocalDate.parse(dueDate)
            );
        }

        db().save(g);

        return "redirect:/enterprise/performance";
    }


    @PostMapping("/enterprise/performance/{id}/progress")
    public String goalProgress(
            @PathVariable Long id,
            @RequestParam int progress,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        PerformanceGoal g =
                db().get(
                        PerformanceGoal.class,
                        id
                );

        if (g != null) {

            g.setProgressPercent(
                    Math.max(
                            0,
                            Math.min(
                                    100,
                                    progress
                            )
                    )
            );

            if (g.getProgressPercent() >=
                    g.getTargetPercent()) {

                g.setStatus("COMPLETED");
            }

            db().update(g);
        }

        return "redirect:/enterprise/performance";
    }


    /* ============================================================
       ONBOARDING
       ============================================================ */

    @GetMapping("/enterprise/onboarding")
    public String onboarding(
            Model m,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        m.addAttribute(
                "tasks",
                db().createQuery(
                        "from OnboardingTask order by dueDate",
                        OnboardingTask.class
                ).getResultList()
        );

        m.addAttribute(
                "employees",
                employees()
        );

        return "enterprise-onboarding";
    }


    @PostMapping("/enterprise/onboarding/generate")
    public String onboardingGenerate(
            @RequestParam String employeeId,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        Employee e =
                find(employeeId);

        if (e != null) {

            String[] names = {
                    "Collect identity documents",
                    "Complete HR orientation",
                    "Assign project and team",
                    "Configure system access",
                    "Complete joining checklist"
            };

            for (String n : names) {

                OnboardingTask t =
                        new OnboardingTask();

                t.setEmployee(e);
                t.setTaskName(n);
                t.setOwner("HR / Admin");

                t.setDueDate(
                        LocalDate.now()
                                .plusDays(7)
                );

                db().save(t);
            }
        }

        return "redirect:/enterprise/onboarding";
    }


    @PostMapping("/enterprise/onboarding/{id}/complete")
    public String onboardingComplete(
            @PathVariable Long id,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        OnboardingTask t =
                db().get(
                        OnboardingTask.class,
                        id
                );

        if (t != null) {

            t.setStatus("COMPLETED");

            db().update(t);
        }

        return "redirect:/enterprise/onboarding";
    }


    /* ============================================================
       OFFBOARDING
       ============================================================ */

    @GetMapping("/enterprise/offboarding")
    public String offboarding(
            Model m,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        m.addAttribute(
                "tasks",
                db().createQuery(
                        "from OffboardingTask order by dueDate",
                        OffboardingTask.class
                ).getResultList()
        );

        m.addAttribute(
                "employees",
                employees()
        );

        return "enterprise-offboarding";
    }


    @PostMapping("/enterprise/offboarding/generate")
    public String offboardingGenerate(
            @RequestParam String employeeId,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        Employee e =
                find(employeeId);

        if (e != null) {

            String[] names = {
                    "HR clearance",
                    "Project handover",
                    "Asset return",
                    "Knowledge transfer",
                    "Experience certificate"
            };

            for (String n : names) {

                OffboardingTask t =
                        new OffboardingTask();

                t.setEmployee(e);
                t.setTaskName(n);
                t.setOwner("HR / Admin");

                t.setDueDate(
                        LocalDate.now()
                                .plusDays(15)
                );

                db().save(t);
            }
        }

        return "redirect:/enterprise/offboarding";
    }


    @PostMapping("/enterprise/offboarding/{id}/complete")
    public String offboardingComplete(
            @PathVariable Long id,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        OffboardingTask t =
                db().get(
                        OffboardingTask.class,
                        id
                );

        if (t != null) {

            t.setStatus("COMPLETED");

            db().update(t);
        }

        return "redirect:/enterprise/offboarding";
    }


    /* ============================================================
       CENTRAL APPROVAL CENTER
       ============================================================ */

    @GetMapping("/enterprise/approvals")
    public String approvals(
            Model m,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        m.addAttribute(
                "approvals",
                db().createQuery(
                        "from ApprovalRequest " +
                        "order by createdAt desc",
                        ApprovalRequest.class
                ).getResultList()
        );

        /*
         * IMPORTANT:
         * This populates the Employee dropdown.
         */
        m.addAttribute(
                "employees",
                employees()
        );

        /*
         * Existing Leave requests.
         */
        m.addAttribute(
                "leaveRequests",
                db().createQuery(
                        "from LeaveRequest",
                        LeaveRequest.class
                ).getResultList()
        );

        /*
         * Existing Expense requests.
         */
        m.addAttribute(
                "expenseRequests",
                db().createQuery(
                        "from ExpenseClaim",
                        ExpenseClaim.class
                ).getResultList()
        );

        /*
         * Existing Payroll records.
         */
        m.addAttribute(
                "payrollRequests",
                db().createQuery(
                        "from PayrollRecord " +
                        "order by payrollYear desc, " +
                        "payrollMonth desc",
                        PayrollRecord.class
                ).getResultList()
        );

        /*
         * Existing Offboarding records.
         */
        m.addAttribute(
                "offboardingRequests",
                db().createQuery(
                        "from OffboardingTask " +
                        "order by dueDate",
                        OffboardingTask.class
                ).getResultList()
        );

        return "enterprise-approvals";
    }


    @PostMapping("/enterprise/approvals/create")
    public String approvalCreate(
            @RequestParam String employeeId,
            @RequestParam String type,
            @RequestParam String referenceId,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        Employee employee =
                find(employeeId);

        if (employee == null) {
            return "redirect:/enterprise/approvals";
        }

        if (referenceId == null ||
                referenceId.trim().isEmpty()) {

            return "redirect:/enterprise/approvals";
        }

        boolean validReference = false;

        try {

            Long refId =
                    Long.parseLong(
                            referenceId
                    );

            if ("LEAVE".equalsIgnoreCase(type)) {

                LeaveRequest request =
                        db().get(
                                LeaveRequest.class,
                                refId
                        );

                if (request != null &&
                        request.getEmployee() != null &&
                        employeeId.equals(
                                request.getEmployee()
                                        .getEmployeeId()
                        )) {

                    validReference = true;
                }

            } else if (
                    "EXPENSE".equalsIgnoreCase(type)
            ) {

                ExpenseClaim request =
                        db().get(
                                ExpenseClaim.class,
                                refId
                        );

                if (request != null &&
                        request.getEmployee() != null &&
                        employeeId.equals(
                                request.getEmployee()
                                        .getEmployeeId()
                        )) {

                    validReference = true;
                }

            } else if (
                    "PAYROLL".equalsIgnoreCase(type)
            ) {

                PayrollRecord request =
                        db().get(
                                PayrollRecord.class,
                                refId
                        );

                if (request != null &&
                        request.getEmployee() != null &&
                        employeeId.equals(
                                request.getEmployee()
                                        .getEmployeeId()
                        )) {

                    validReference = true;
                }

            } else if (
                    "OFFBOARDING".equalsIgnoreCase(type)
            ) {

                OffboardingTask request =
                        db().get(
                                OffboardingTask.class,
                                refId
                        );

                if (request != null &&
                        request.getEmployee() != null &&
                        employeeId.equals(
                                request.getEmployee()
                                        .getEmployeeId()
                        )) {

                    validReference = true;
                }
            }

        } catch (NumberFormatException ex) {

            return "redirect:/enterprise/approvals";
        }

        if (!validReference) {

            return "redirect:/enterprise/approvals";
        }

        ApprovalRequest a =
                new ApprovalRequest();

        a.setEmployee(employee);
        a.setRequestType(type);
        a.setReferenceId(referenceId);
        a.setCurrentLevel("MANAGER");

        db().save(a);

        return "redirect:/enterprise/approvals";
    }


    @PostMapping("/enterprise/approvals/{id}/action")
    public String approvalAction(
            @PathVariable Long id,
            @RequestParam String action,
            @RequestParam(required = false) String comments,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        ApprovalRequest a =
                db().get(
                        ApprovalRequest.class,
                        id
                );

        if (a != null) {

            a.setComments(comments);

            if ("APPROVE".equals(action)) {

                if ("MANAGER".equals(
                        a.getCurrentLevel()
                )) {

                    a.setCurrentLevel("HR");

                } else {

                    a.setStatus("APPROVED");
                }

            } else {

                a.setStatus("REJECTED");
            }

            db().update(a);
        }

        return "redirect:/enterprise/approvals";
    }


    /* ============================================================
       TIME TRACKING
       ============================================================ */

    @GetMapping("/enterprise/time")
    public String time(
            Model m,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        List<Attendance> as =
                db().createQuery(
                        "from Attendance " +
                        "order by attendanceDate desc",
                        Attendance.class
                ).getResultList();

        for (Attendance a : as) {

            if (a.getCheckIn() != null &&
                    a.getCheckOut() != null) {

                long mins =
                        Duration.between(
                                a.getCheckIn(),
                                a.getCheckOut()
                        ).toMinutes();

                Query<TimesheetEntry> q =
                        db().createQuery(
                                "from TimesheetEntry " +
                                "where employee.employeeId=:id " +
                                "and workDate=:d",
                                TimesheetEntry.class
                        );

                q.setParameter(
                        "id",
                        a.getEmployee()
                                .getEmployeeId()
                );

                q.setParameter(
                        "d",
                        a.getAttendanceDate()
                );

                TimesheetEntry t =
                        q.uniqueResult();

                if (t == null) {

                    t = new TimesheetEntry();

                    t.setEmployee(
                            a.getEmployee()
                    );

                    t.setWorkDate(
                            a.getAttendanceDate()
                    );
                }

                t.setRegularMinutes(
                        Math.min(
                                mins,
                                480
                        )
                );

                t.setOvertimeMinutes(
                        Math.max(
                                0,
                                mins - 480
                        )
                );

                t.setStatus(
                        "CALCULATED"
                );

                db().saveOrUpdate(t);
            }
        }

        m.addAttribute(
                "timesheets",
                db().createQuery(
                        "from TimesheetEntry " +
                        "order by workDate desc",
                        TimesheetEntry.class
                ).getResultList()
        );

        return "enterprise-time";
    }


    /* ============================================================
       ANALYTICS
       ============================================================ */

    @GetMapping("/enterprise/analytics")
    public String analytics(
            Model m,
            HttpSession s) {

        if (!admin(s)) {
            return "redirect:/dashboard";
        }

        long total =
                employees().size();

        long active =
                db().createQuery(
                        "select count(e) from Employee e " +
                        "where e.active=true",
                        Long.class
                ).getSingleResult();

        long office =
                db().createQuery(
                        "select count(a) from Attendance a " +
                        "where a.attendanceType='OFFICE'",
                        Long.class
                ).getSingleResult();

        long home =
                db().createQuery(
                        "select count(a) from Attendance a " +
                        "where a.attendanceType='HOME'",
                        Long.class
                ).getSingleResult();

        long resigned =
                db().createQuery(
                        "select count(e) from Employee e " +
                        "where e.employmentStatus='RESIGNED'",
                        Long.class
                ).getSingleResult();

        m.addAttribute("total", total);
        m.addAttribute("active", active);
        m.addAttribute("office", office);
        m.addAttribute("home", home);
        m.addAttribute("resigned", resigned);

        m.addAttribute(
                "payrollTotal",
                db().createQuery(
                        "select coalesce(sum(p.net),0) " +
                        "from PayrollRecord p",
                        BigDecimal.class
                ).getSingleResult()
        );

        return "enterprise-analytics";
    }


    /* ============================================================
       PAYSLIP
       ============================================================ */

    @GetMapping("/enterprise/payslip/{id}")
    public String payslip(
            @PathVariable Long id,
            Model m,
            HttpSession s) {

        Employee e = me(s);

        if (e == null) {
            return "redirect:/auth/login";
        }

        PayrollRecord p =
                db().get(
                        PayrollRecord.class,
                        id
                );

        if (p == null ||
                (!admin(s) &&
                        !p.getEmployee()
                                .getEmployeeId()
                                .equals(
                                        e.getEmployeeId()
                                ))) {

            return "redirect:/enterprise/my";
        }

        m.addAttribute("p", p);

        return "enterprise-payslip";
    }


    /* ============================================================
       EMPLOYEE SELF SERVICE
       ============================================================ */

    @GetMapping("/enterprise/my")
    public String my(
            Model m,
            HttpSession s) {

        Employee e =
                me(s);

        if (e == null) {
            return "redirect:/auth/login";
        }

        Query<SalaryStructure> sq =
                db().createQuery(
                        "from SalaryStructure " +
                        "where employee.employeeId=:id",
                        SalaryStructure.class
                );

        sq.setParameter(
                "id",
                e.getEmployeeId()
        );

        m.addAttribute(
                "salary",
                sq.uniqueResult()
        );

        Query<PayrollRecord> pq =
                db().createQuery(
                        "from PayrollRecord " +
                        "where employee.employeeId=:id " +
                        "order by payrollYear desc," +
                        "payrollMonth desc",
                        PayrollRecord.class
                );

        pq.setParameter(
                "id",
                e.getEmployeeId()
        );

        m.addAttribute(
                "payroll",
                pq.getResultList()
        );

        Query<PerformanceGoal> gq =
                db().createQuery(
                        "from PerformanceGoal " +
                        "where employee.employeeId=:id " +
                        "order by dueDate",
                        PerformanceGoal.class
                );

        gq.setParameter(
                "id",
                e.getEmployeeId()
        );

        m.addAttribute(
                "goals",
                gq.getResultList()
        );

        Query<EmployeeDocument> dq =
                db().createQuery(
                        "from EmployeeDocument " +
                        "where employee.employeeId=:id " +
                        "order by expiryDate",
                        EmployeeDocument.class
                );

        dq.setParameter(
                "id",
                e.getEmployeeId()
        );

        m.addAttribute(
                "documents",
                dq.getResultList()
        );

        return "enterprise-my";
    }
}