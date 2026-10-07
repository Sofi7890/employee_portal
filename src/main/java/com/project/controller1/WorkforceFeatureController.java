package com.project.controller1;

import com.project.entity.*;
import com.project.service.ClientService;
import com.project.service.EmployeeService;
import com.project.service.ProjectService;
import com.project.service.AttendanceAiService;
import com.project.dto.AttendanceAiAnalysis;
import org.hibernate.Session; import org.hibernate.SessionFactory; import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired; import org.springframework.stereotype.Controller; import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*; import org.springframework.web.multipart.MultipartFile;
import org.springframework.transaction.annotation.Transactional;
import javax.servlet.http.HttpSession; import javax.servlet.http.HttpServletResponse;
import java.io.*; import java.math.BigDecimal; import java.nio.file.*; import java.time.*; import java.time.temporal.ChronoUnit; import java.util.*; import java.util.stream.Collectors;

@Controller
@Transactional
public class WorkforceFeatureController {
 private final SessionFactory sf; private final EmployeeService employeeService; private final ClientService clientService; private final ProjectService projectService; private final AttendanceAiService attendanceAiService;
 @Autowired public WorkforceFeatureController(SessionFactory sf, EmployeeService e, ClientService c, ProjectService p, AttendanceAiService ai){this.sf=sf;employeeService=e;clientService=c;projectService=p;attendanceAiService=ai;}
 private Session db(){return sf.getCurrentSession();}
 private String role(HttpSession s){return (String)s.getAttribute("role");}
 private String user(HttpSession s){return (String)s.getAttribute("username");}
 private boolean admin(HttpSession s){return "ROLE_ADMIN".equals(role(s));}
 private Employee me(HttpSession s){String email=user(s); return email==null?null:employeeService.findByEmail(email).orElse(null);}
 private void audit(HttpSession s,String action,String type,String id,String details){AuditLog a=new AuditLog();a.setActor(user(s));a.setAction(action);a.setEntityType(type);a.setEntityId(id);a.setDetails(details);a.setCreatedAt(LocalDateTime.now());db().save(a);}
 private void notify(String recipient,String role,String type,String msg){Notification n=new Notification();n.setRecipient(recipient);n.setRole(role);n.setType(type);n.setMessage(msg);n.setCreatedAt(LocalDateTime.now());db().save(n);}
 private LeaveBalance balance(Employee e){Query<LeaveBalance> q=db().createQuery("from LeaveBalance where employee.employeeId=:id",LeaveBalance.class);q.setParameter("id",e.getEmployeeId());LeaveBalance b=q.uniqueResult();if(b==null){b=new LeaveBalance();b.setEmployee(e);db().save(b);}return b;}
 private long count(String hql){return db().createQuery(hql,Long.class).getSingleResult();}

 @GetMapping("/employee/dashboard") public String employeeDashboard(Model m,HttpSession s){Employee e=me(s);if(e==null)return "redirect:/auth/login?error";m.addAttribute("employee",e);m.addAttribute("balance",balance(e));m.addAttribute("today",today(e));m.addAttribute("attendanceCount",countWith("select count(a) from Attendance a where a.employee.employeeId=:id",e.getEmployeeId()));m.addAttribute("pendingLeaves",countWith("select count(l) from LeaveRequest l where l.employee.employeeId=:id and l.status='PENDING'",e.getEmployeeId()));m.addAttribute("pendingExpenses",countWith("select count(x) from ExpenseClaim x where x.employee.employeeId=:id and x.status='PENDING'",e.getEmployeeId()));return "employee-dashboard";}
 private Long countWith(String hql,String id){Query<Long> q=db().createQuery(hql,Long.class);q.setParameter("id",id);return q.getSingleResult();}
 private Attendance today(Employee e){Query<Attendance> q=db().createQuery("from Attendance where employee.employeeId=:id and attendanceDate=:d",Attendance.class);q.setParameter("id",e.getEmployeeId());q.setParameter("d",LocalDate.now());return q.uniqueResult();}

 @GetMapping("/project/detail/{projectId}")
 public String projectDetails(@PathVariable("projectId") String projectId,
                              Model m,
                              HttpSession s) {

     if (!admin(s)) {
         return "redirect:/dashboard";
     }

     Project project = projectService.findById(projectId).orElse(null);

     m.addAttribute("project", project);

     return "project-detail";
 }
 @GetMapping("/employee/details/{employeeId}")
 public String employeeDetails(@PathVariable("employeeId") String employeeId,
                               Model m,
                               HttpSession s) {

     if (!admin(s)) {
         return "redirect:/dashboard";
     }

     Employee employee = employeeService.findById(employeeId).orElse(null);
     if (employee == null) {
         m.addAttribute("employee", null);
         return "employee-details";
     }

     m.addAttribute("employee", employee);
     m.addAttribute("balance", balance(employee));

     Query<Attendance> attendanceQuery = db().createQuery(
             "from Attendance a where a.employee.employeeId=:id order by a.attendanceDate desc",
             Attendance.class);
     attendanceQuery.setParameter("id", employeeId);
     List<Attendance> attendanceAll = attendanceQuery.getResultList();
     List<Attendance> recentAttendance = attendanceAll.size() > 8
             ? attendanceAll.subList(0, 8) : attendanceAll;
     m.addAttribute("attendanceRecords", recentAttendance);
     m.addAttribute("attendanceTotal", attendanceAll.size());
     m.addAttribute("presentDays", attendanceAll.stream().filter(a -> "PRESENT".equalsIgnoreCase(a.getStatus())).count());
     m.addAttribute("lateDays", attendanceAll.stream().filter(Attendance::isLate).count());
     m.addAttribute("officeDays", attendanceAll.stream().filter(a -> "OFFICE".equalsIgnoreCase(a.getAttendanceType())).count());
     m.addAttribute("homeDays", attendanceAll.stream().filter(a -> "HOME".equalsIgnoreCase(a.getAttendanceType())).count());
     m.addAttribute("completedDays", attendanceAll.stream().filter(a -> a.getCheckOut() != null).count());
     m.addAttribute("attendanceAnalysis", attendanceAiService.analyze(attendanceAll));

     Query<LeaveRequest> leaveQuery = db().createQuery(
             "from LeaveRequest l where l.employee.employeeId=:id order by l.appliedDate desc",
             LeaveRequest.class);
     leaveQuery.setParameter("id", employeeId);
     List<LeaveRequest> leaveRequests = leaveQuery.getResultList();
     m.addAttribute("leaveRequests", leaveRequests.size() > 5 ? leaveRequests.subList(0, 5) : leaveRequests);
     m.addAttribute("pendingLeaves", leaveRequests.stream().filter(l -> "PENDING".equalsIgnoreCase(l.getStatus())).count());
     m.addAttribute("approvedLeaves", leaveRequests.stream().filter(l -> "APPROVED".equalsIgnoreCase(l.getStatus())).count());

     Query<ExpenseClaim> expenseQuery = db().createQuery(
             "from ExpenseClaim x where x.employee.employeeId=:id order by x.submittedAt desc",
             ExpenseClaim.class);
     expenseQuery.setParameter("id", employeeId);
     List<ExpenseClaim> expenseClaims = expenseQuery.getResultList();
     m.addAttribute("expenseClaims", expenseClaims.size() > 5 ? expenseClaims.subList(0, 5) : expenseClaims);
     m.addAttribute("pendingExpenses", expenseClaims.stream().filter(x -> "PENDING".equalsIgnoreCase(x.getStatus())).count());
     m.addAttribute("approvedExpenses", expenseClaims.stream().filter(x -> "APPROVED".equalsIgnoreCase(x.getStatus())).count());
     m.addAttribute("totalExpenseAmount", expenseClaims.stream().map(ExpenseClaim::getAmount).filter(Objects::nonNull).reduce(BigDecimal.ZERO, BigDecimal::add));
     m.addAttribute("approvedExpenseAmount", expenseClaims.stream().filter(x -> "APPROVED".equalsIgnoreCase(x.getStatus())).map(ExpenseClaim::getAmount).filter(Objects::nonNull).reduce(BigDecimal.ZERO, BigDecimal::add));

     Query<ResignationRequest> resignationQuery = db().createQuery(
             "from ResignationRequest r where r.employee.employeeId=:id order by r.submittedDate desc",
             ResignationRequest.class);
     resignationQuery.setParameter("id", employeeId);
     List<ResignationRequest> resignations = resignationQuery.getResultList();
     m.addAttribute("latestResignation", resignations.isEmpty() ? null : resignations.get(0));

     Query<AuditLog> auditQuery = db().createQuery(
             "from AuditLog a where a.entityId=:id order by a.createdAt desc",
             AuditLog.class);
     auditQuery.setParameter("id", employeeId);
     List<AuditLog> activities = auditQuery.getResultList();
     m.addAttribute("activities", activities.size() > 8 ? activities.subList(0, 8) : activities);

     return "employee-details";
 }
 @GetMapping("/attendance/my") public String attendanceMy(Model m,HttpSession s){Employee e=me(s);if(e==null)return "redirect:/auth/login";Query<Attendance> q=db().createQuery("from Attendance where employee.employeeId=:id order by attendanceDate desc",Attendance.class);q.setParameter("id",e.getEmployeeId());m.addAttribute("records",q.getResultList());m.addAttribute("today",today(e));return "attendance-my";}
 @PostMapping("/attendance/checkin")
 public String checkIn(@RequestParam(required=false) Double latitude,
                       @RequestParam(required=false) Double longitude,
                       HttpSession s){
     Employee e=me(s);
     if(e==null)return "redirect:/auth/login";
     if(latitude==null || longitude==null || latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180){
         return "redirect:/attendance/my?error=location";
     }
     Attendance a=today(e);
     if(a==null){
         double distance=distanceInMeters(OFFICE_LATITUDE, OFFICE_LONGITUDE, latitude, longitude);
         a=new Attendance();
         a.setEmployee(e);
         a.setAttendanceDate(LocalDate.now());
         a.setStatus("PRESENT");
         a.setCheckIn(LocalDateTime.now());
         a.setLate(LocalTime.now().isAfter(LocalTime.of(9,30)));
         a.setLatitude(latitude);
         a.setLongitude(longitude);
         a.setAttendanceType(distance <= OFFICE_RADIUS_METERS ? "OFFICE" : "HOME");
         db().save(a);
     }
     return "redirect:/attendance/my";
 }

 private static final double OFFICE_LATITUDE = 19.028042;
 private static final double OFFICE_LONGITUDE = 72.845149;
 private static final double OFFICE_RADIUS_METERS = 200.0;

 private double distanceInMeters(double lat1,double lon1,double lat2,double lon2){
     double earthRadius=6371000.0;
     double dLat=Math.toRadians(lat2-lat1);
     double dLon=Math.toRadians(lon2-lon1);
     double a=Math.sin(dLat/2)*Math.sin(dLat/2)
             +Math.cos(Math.toRadians(lat1))*Math.cos(Math.toRadians(lat2))
             *Math.sin(dLon/2)*Math.sin(dLon/2);
     double c=2*Math.atan2(Math.sqrt(a),Math.sqrt(1-a));
     return earthRadius*c;
 }
 @PostMapping("/attendance/checkout") public String checkOut(HttpSession s){Employee e=me(s);if(e!=null){Attendance a=today(e);if(a!=null&&a.getCheckOut()==null){a.setCheckOut(LocalDateTime.now());a.setWorkedMinutes(Math.max(0,ChronoUnit.MINUTES.between(a.getCheckIn(),a.getCheckOut())));db().update(a);}}return "redirect:/attendance/my";}
 //@GetMapping("/attendance/admin") public String attendanceAdmin(@RequestParam(required=false)String employeeId,@RequestParam(required=false)String date,Model m,HttpSession s){if(!admin(s))return "redirect:/dashboard";String hql="from Attendance a where 1=1";if(employeeId!=null&&!employeeId.trim().isEmpty())hql+=" and a.employee.employeeId=:eid";if(date!=null&&!date.isEmpty())hql+=" and a.attendanceDate=:date";hql+=" order by a.attendanceDate desc";Query<Attendance> q=db().createQuery(hql,Attendance.class);if(employeeId!=null&&!employeeId.trim().isEmpty())q.setParameter("eid",employeeId);if(date!=null&&!date.isEmpty())q.setParameter("date",LocalDate.parse(date));m.addAttribute("records",q.getResultList());m.addAttribute("employees",employeeService.findAll());m.addAttribute("employeeId",employeeId);m.addAttribute("date",date);return "attendance-admin";}
 @GetMapping("/attendance/admin")
 public String attendanceAdmin(
         @RequestParam(required = false) String employeeId,
         @RequestParam(required = false) String date,
         Model m,
         HttpSession s) {

     if (!admin(s)) {
         return "redirect:/dashboard";
     }

     String hql = "from Attendance a where 1=1";

     if (employeeId != null && !employeeId.trim().isEmpty()) {
         hql += " and (lower(a.employee.employeeId) like :search " +
                "or lower(a.employee.employeeName) like :search)";
     }

     if (date != null && !date.trim().isEmpty()) {
         hql += " and a.attendanceDate = :date";
     }

     hql += " order by a.attendanceDate desc, a.checkIn desc";

     Query<Attendance> q = db().createQuery(hql, Attendance.class);

     if (employeeId != null && !employeeId.trim().isEmpty()) {
         q.setParameter("search", "%" + employeeId.trim().toLowerCase() + "%");
     }

     if (date != null && !date.trim().isEmpty()) {
         q.setParameter("date", LocalDate.parse(date));
     }

     m.addAttribute("records", q.getResultList());
     m.addAttribute("employees", employeeService.findAll());
     m.addAttribute("employeeId", employeeId);
     m.addAttribute("date", date);

     return "attendance-admin";
 }
 
 @GetMapping("/attendance/ai-analysis")
 public String attendanceAiAnalysis(@RequestParam(required=false) String employeeId,
                                    @RequestParam(defaultValue="30") int days,
                                    Model m,
                                    HttpSession s){
     if(!admin(s)) return "redirect:/dashboard";
     if(days < 7) days = 7;
     if(days > 365) days = 365;

     List<Employee> employees = employeeService.findAll();
     Employee selected = null;
     if(employeeId != null && !employeeId.trim().isEmpty()) {
         selected = employeeService.findById(employeeId.trim()).orElse(null);
     }
     if(selected == null && !employees.isEmpty()) selected = employees.get(0);

     List<Attendance> records = new ArrayList<>();
     if(selected != null){
         LocalDate from = LocalDate.now().minusDays(days - 1L);
         Query<Attendance> q = db().createQuery(
                 "from Attendance a where a.employee.employeeId=:id and a.attendanceDate>=:from order by a.attendanceDate desc",
                 Attendance.class);
         q.setParameter("id", selected.getEmployeeId());
         q.setParameter("from", from);
         records = q.getResultList();
     }

     AttendanceAiAnalysis analysis = attendanceAiService.analyze(records);
     m.addAttribute("employees", employees);
     m.addAttribute("selectedEmployee", selected);
     m.addAttribute("analysis", analysis);
     m.addAttribute("days", days);
     return "attendance-ai";
 }

 @GetMapping("/leave/my") public String leaveMy(Model m,HttpSession s){Employee e=me(s);if(e==null)return "redirect:/auth/login";Query<LeaveRequest> q=db().createQuery("from LeaveRequest where employee.employeeId=:id order by appliedDate desc",LeaveRequest.class);q.setParameter("id",e.getEmployeeId());m.addAttribute("requests",q.getResultList());m.addAttribute("balance",balance(e));return "leave-my";}
 @GetMapping("/leave/apply") public String leaveForm(Model m,HttpSession s){if(me(s)==null)return "redirect:/auth/login";m.addAttribute("leave",new LeaveRequest());return "leave-form";}
 @PostMapping("/leave/apply") public String leaveApply(@ModelAttribute LeaveRequest form,HttpSession s){Employee e=me(s);if(e==null)return "redirect:/auth/login";if(form.getStartDate()==null||form.getEndDate()==null||form.getEndDate().isBefore(form.getStartDate()))return "redirect:/leave/apply?error=dates";LeaveBalance b=balance(e);if(form.getDays()>b.getRemainingDays())return "redirect:/leave/apply?error=balance";form.setEmployee(e);form.setStatus("PENDING");form.setAppliedDate(LocalDate.now());db().save(form);notify("admin","ROLE_ADMIN","LEAVE","Leave request from "+e.getEmployeeName());audit(s,"CREATE","LeaveRequest",String.valueOf(form.getId()),"Employee submitted leave request");return "redirect:/leave/my";}
 @GetMapping("/leave/admin") public String leaveAdmin(Model m,HttpSession s){if(!admin(s))return "redirect:/dashboard";m.addAttribute("requests",db().createQuery("from LeaveRequest order by appliedDate desc",LeaveRequest.class).getResultList());return "leave-admin";}
 @PostMapping("/leave/{id}/approve") public String leaveApprove(@PathVariable Long id,HttpSession s){if(!admin(s))return "redirect:/dashboard";LeaveRequest l=db().get(LeaveRequest.class,id);if(l!=null&&"PENDING".equals(l.getStatus())){LeaveBalance b=balance(l.getEmployee());if(l.getDays()<=b.getRemainingDays()){l.setStatus("APPROVED");b.setUsedDays(b.getUsedDays()+(int)l.getDays());db().update(b);notify(l.getEmployee().getEmployeeEmail(),l.getEmployee().getRole(),"LEAVE","Your leave request was approved.");audit(s,"APPROVE","LeaveRequest",String.valueOf(id),"Leave approved");}else l.setAdminComment("Insufficient leave balance");db().update(l);}return "redirect:/leave/admin";}
 @PostMapping("/leave/{id}/reject") public String leaveReject(@PathVariable Long id,@RequestParam(required=false)String comment,HttpSession s){if(!admin(s))return "redirect:/dashboard";LeaveRequest l=db().get(LeaveRequest.class,id);if(l!=null){l.setStatus("REJECTED");l.setAdminComment(comment);db().update(l);notify(l.getEmployee().getEmployeeEmail(),l.getEmployee().getRole(),"LEAVE","Your leave request was rejected.");audit(s,"REJECT","LeaveRequest",String.valueOf(id),"Leave rejected");}return "redirect:/leave/admin";}

 @GetMapping("/expense/my") public String expenseMy(Model m,HttpSession s){Employee e=me(s);if(e==null)return "redirect:/auth/login";Query<ExpenseClaim> q=db().createQuery("from ExpenseClaim where employee.employeeId=:id order by submittedAt desc",ExpenseClaim.class);q.setParameter("id",e.getEmployeeId());m.addAttribute("claims",q.getResultList());return "expense-my";}
 @GetMapping("/expense/apply") public String expenseForm(Model m,HttpSession s){if(me(s)==null)return "redirect:/auth/login";m.addAttribute("expense",new ExpenseClaim());return "expense-form";}
 @PostMapping("/expense/apply") public String expenseApply(@ModelAttribute ExpenseClaim form,@RequestParam(value="receipt",required=false)MultipartFile receipt,HttpSession s){Employee e=me(s);if(e==null)return "redirect:/auth/login";if(form.getAmount()==null||form.getAmount().signum()<0)return "redirect:/expense/apply?error=amount";form.setEmployee(e);form.setStatus("PENDING");form.setSubmittedAt(LocalDateTime.now());if(receipt!=null&&!receipt.isEmpty()){try{Path dir=Paths.get(System.getProperty("user.home"),"ems-uploads");Files.createDirectories(dir);String safe=UUID.randomUUID()+"-"+Paths.get(receipt.getOriginalFilename()).getFileName();receipt.transferTo(dir.resolve(safe).toFile());form.setReceiptFile(safe);}catch(Exception ex){form.setReceiptFile(receipt.getOriginalFilename());}}db().save(form);notify("admin","ROLE_ADMIN","EXPENSE","Expense claim from "+e.getEmployeeName());audit(s,"CREATE","ExpenseClaim",String.valueOf(form.getId()),"Expense submitted");return "redirect:/expense/my";}
 @GetMapping("/expense/admin") public String expenseAdmin(Model m,HttpSession s){if(!admin(s))return "redirect:/dashboard";m.addAttribute("claims",db().createQuery("from ExpenseClaim order by submittedAt desc",ExpenseClaim.class).getResultList());return "expense-admin";}
 @PostMapping("/expense/{id}/approve") public String expenseApprove(@PathVariable Long id,HttpSession s){if(!admin(s))return "redirect:/dashboard";ExpenseClaim x=db().get(ExpenseClaim.class,id);if(x!=null){x.setStatus("APPROVED");db().update(x);notify(x.getEmployee().getEmployeeEmail(),x.getEmployee().getRole(),"EXPENSE","Your expense claim was approved.");audit(s,"APPROVE","ExpenseClaim",String.valueOf(id),"Expense approved");}return "redirect:/expense/admin";}
 @PostMapping("/expense/{id}/reject") public String expenseReject(@PathVariable Long id,@RequestParam(required=false)String comment,HttpSession s){if(!admin(s))return "redirect:/dashboard";ExpenseClaim x=db().get(ExpenseClaim.class,id);if(x!=null){x.setStatus("REJECTED");x.setAdminComment(comment);db().update(x);notify(x.getEmployee().getEmployeeEmail(),x.getEmployee().getRole(),"EXPENSE","Your expense claim was rejected.");audit(s,"REJECT","ExpenseClaim",String.valueOf(id),"Expense rejected");}return "redirect:/expense/admin";}

 @GetMapping("/resignation/my") public String resignationMy(Model m,HttpSession s){Employee e=me(s);if(e==null)return "redirect:/auth/login";Query<ResignationRequest> q=db().createQuery("from ResignationRequest where employee.employeeId=:id order by submittedDate desc",ResignationRequest.class);q.setParameter("id",e.getEmployeeId());m.addAttribute("requests",q.getResultList());return "resignation-my";}
 @GetMapping("/resignation/apply") public String resignationForm(Model m,HttpSession s){if(me(s)==null)return "redirect:/auth/login";m.addAttribute("resignation",new ResignationRequest());return "resignation-form";}
 @PostMapping("/resignation/apply") public String resignationApply(@ModelAttribute ResignationRequest r,HttpSession s){Employee e=me(s);if(e==null)return "redirect:/auth/login";r.setEmployee(e);r.setStatus("PENDING");r.setSubmittedDate(LocalDate.now());db().save(r);notify("admin","ROLE_ADMIN","RESIGNATION","Resignation request from "+e.getEmployeeName());audit(s,"CREATE","ResignationRequest",String.valueOf(r.getId()),"Resignation submitted");return "redirect:/resignation/my";}
 @GetMapping("/resignation/admin") public String resignationAdmin(Model m,HttpSession s){if(!admin(s))return "redirect:/dashboard";m.addAttribute("requests",db().createQuery("from ResignationRequest order by submittedDate desc",ResignationRequest.class).getResultList());return "resignation-admin";}
 @PostMapping("/resignation/{id}/approve") public String resignationApprove(@PathVariable Long id,@RequestParam(required=false)String lastWorkingDate,HttpSession s){if(!admin(s))return "redirect:/dashboard";ResignationRequest r=db().get(ResignationRequest.class,id);if(r!=null){r.setStatus("APPROVED");r.setLastWorkingDate(lastWorkingDate==null||lastWorkingDate.isEmpty()?LocalDate.now().plusDays(30):LocalDate.parse(lastWorkingDate));r.setProcessedDate(LocalDate.now());r.getEmployee().setEmploymentStatus("RESIGNED");r.getEmployee().setActive(false);db().update(r.getEmployee());db().update(r);notify(r.getEmployee().getEmployeeEmail(),r.getEmployee().getRole(),"RESIGNATION","Your resignation was approved. LWD: "+r.getLastWorkingDate());audit(s,"APPROVE","ResignationRequest",String.valueOf(id),"Resignation approved");}return "redirect:/resignation/admin";}
 @PostMapping("/resignation/{id}/reject") public String resignationReject(@PathVariable Long id,@RequestParam(required=false)String comment,HttpSession s){if(!admin(s))return "redirect:/dashboard";ResignationRequest r=db().get(ResignationRequest.class,id);if(r!=null){r.setStatus("REJECTED");r.setAdminComment(comment);r.setProcessedDate(LocalDate.now());db().update(r);notify(r.getEmployee().getEmployeeEmail(),r.getEmployee().getRole(),"RESIGNATION","Your resignation request was rejected.");audit(s,"REJECT","ResignationRequest",String.valueOf(id),"Resignation rejected");}return "redirect:/resignation/admin";}

 @GetMapping("/notifications") public String notifications(Model m,HttpSession s){String u=user(s);if(u==null)return "redirect:/auth/login";Query<Notification> q=db().createQuery("from Notification where recipient=:u order by createdAt desc",Notification.class);q.setParameter("u",u);m.addAttribute("notifications",q.getResultList());return "notifications";}
 @PostMapping("/notifications/read/{id}") public String readNotification(@PathVariable Long id,HttpSession s){Notification n=db().get(Notification.class,id);if(n!=null&&Objects.equals(n.getRecipient(),user(s))){n.setReadFlag(true);db().update(n);}return "redirect:/notifications";}

 @GetMapping("/audit") public String audit(Model m,HttpSession s){if(!admin(s))return "redirect:/dashboard";m.addAttribute("logs",db().createQuery("from AuditLog order by createdAt desc",AuditLog.class).setMaxResults(300).getResultList());return "audit";}
 @GetMapping("/reports") public String reports(Model m,HttpSession s){if(!admin(s))return "redirect:/dashboard";m.addAttribute("employeeCount",employeeService.findAll().size());m.addAttribute("clientCount",clientService.findAll().size());m.addAttribute("projectCount",projectService.findAll().size());m.addAttribute("benchCount",employeeService.findBenchEmployees().size());m.addAttribute("attendanceCount",count("select count(a) from Attendance a"));m.addAttribute("leaveCount",count("select count(l) from LeaveRequest l"));m.addAttribute("expenseCount",count("select count(x) from ExpenseClaim x"));m.addAttribute("resignationCount",count("select count(r) from ResignationRequest r"));m.addAttribute("notificationCount",count("select count(n) from Notification n"));m.addAttribute("auditCount",count("select count(a) from AuditLog a"));return "reports";}
 @GetMapping("/reports/employees.csv") public void employeesCsv(HttpServletResponse resp,HttpSession s)throws IOException{if(!admin(s)){resp.sendError(403);return;}resp.setContentType("text/csv");resp.setHeader("Content-Disposition","attachment; filename=employees-report.csv");PrintWriter out=resp.getWriter();out.println("Employee ID,Name,Department,Email,Joining Date,Project,Status");for(Employee e:employeeService.findAll())out.printf("%s,%s,%s,%s,%s,%s,%s%n",csv(e.getEmployeeId()),csv(e.getEmployeeName()),csv(e.getEmployeeDept()),csv(e.getEmployeeEmail()),csv(e.getDateOfJoining()==null?"":e.getDateOfJoining().toString()),csv(e.getProject()==null?"BENCH":e.getProject().getProjectName()),csv(e.getEmploymentStatus()));}
 @GetMapping("/reports/attendance.csv") public void attendanceCsv(HttpServletResponse resp,HttpSession s)throws IOException{if(!admin(s)){resp.sendError(403);return;}resp.setContentType("text/csv");resp.setHeader("Content-Disposition","attachment; filename=attendance-report.csv");PrintWriter out=resp.getWriter();out.println("Employee ID,Employee Name,Date,Check In,Check Out,Status,Late,Worked Minutes,Attendance Type,Latitude,Longitude");for(Attendance a:db().createQuery("from Attendance order by attendanceDate desc",Attendance.class).getResultList())out.printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s%n",csv(a.getEmployee().getEmployeeId()),csv(a.getEmployee().getEmployeeName()),csv(a.getAttendanceDate()==null?"":a.getAttendanceDate().toString()),csv(a.getCheckIn()==null?"":a.getCheckIn().toString().replace('T',' ')),csv(a.getCheckOut()==null?"":a.getCheckOut().toString().replace('T',' ')),a.getStatus(),a.isLate(),a.getWorkedMinutes(),csv(a.getAttendanceType()),a.getLatitude(),a.getLongitude());}
 private String csv(String x){return "\""+(x==null?"":x.replace("\"","\"\""))+"\"";}
 @GetMapping("/reports/leave.csv") public void leaveCsv(HttpServletResponse resp,HttpSession s)throws IOException{if(!admin(s)){resp.sendError(403);return;}resp.setContentType("text/csv");resp.setHeader("Content-Disposition","attachment; filename=leave-report.csv");PrintWriter out=resp.getWriter();out.println("Employee ID,Type,Start,End,Days,Status,Reason");for(LeaveRequest l:db().createQuery("from LeaveRequest order by appliedDate desc",LeaveRequest.class).getResultList())out.printf("%s,%s,%s,%s,%s,%s,%s%n",csv(l.getEmployee().getEmployeeId()),csv(l.getLeaveType()),csv(l.getStartDate()==null?"":l.getStartDate().toString()),csv(l.getEndDate()==null?"":l.getEndDate().toString()),l.getDays(),csv(l.getStatus()),csv(l.getReason()));}
 @GetMapping("/reports/expense.csv") public void expenseCsv(HttpServletResponse resp,HttpSession s)throws IOException{if(!admin(s)){resp.sendError(403);return;}resp.setContentType("text/csv");resp.setHeader("Content-Disposition","attachment; filename=expense-report.csv");PrintWriter out=resp.getWriter();out.println("Employee ID,Type,Amount,Status,Submitted,Description");for(ExpenseClaim x:db().createQuery("from ExpenseClaim order by submittedAt desc",ExpenseClaim.class).getResultList())out.printf("%s,%s,%s,%s,%s,%s%n",csv(x.getEmployee().getEmployeeId()),csv(x.getExpenseType()),x.getAmount(),csv(x.getStatus()),csv(x.getSubmittedAt()==null?"":x.getSubmittedAt().toString().replace('T',' ')),csv(x.getDescription()));}
 @GetMapping("/reports/resignation.csv") public void resignationCsv(HttpServletResponse resp,HttpSession s)throws IOException{if(!admin(s)){resp.sendError(403);return;}resp.setContentType("text/csv");resp.setHeader("Content-Disposition","attachment; filename=resignation-report.csv");PrintWriter out=resp.getWriter();out.println("Employee ID,Submitted,Status,Last Working Date,Reason");for(ResignationRequest r:db().createQuery("from ResignationRequest order by submittedDate desc",ResignationRequest.class).getResultList())out.printf("%s,%s,%s,%s,%s%n",csv(r.getEmployee().getEmployeeId()),csv(r.getSubmittedDate()==null?"":r.getSubmittedDate().toString().replace('T',' ')),csv(r.getStatus()),csv(r.getLastWorkingDate()==null?"":r.getLastWorkingDate().toString()),csv(r.getReason()));}


 @GetMapping("/reports/clients.csv") public void clientsCsv(HttpServletResponse resp,HttpSession s)throws IOException{
     if(!admin(s)){resp.sendError(403);return;} resp.setContentType("text/csv;charset=UTF-8"); resp.setHeader("Content-Disposition","attachment; filename=clients-report.csv");
     PrintWriter out=resp.getWriter(); out.println("Client ID,Client Name,Relationship Date,Role,Status");
     for(Client c:clientService.findAll()) out.printf("%s,%s,%s,%s,%s%n",csv(c.getClientId()),csv(c.getClientName()),csv(c.getClientRelationshipDate()==null?"":c.getClientRelationshipDate().toString()),csv(c.getRole()),csv(c.isActive()?"ACTIVE":"INACTIVE"));
 }
 @GetMapping("/reports/projects.csv") public void projectsCsv(HttpServletResponse resp,HttpSession s)throws IOException{
     if(!admin(s)){resp.sendError(403);return;} resp.setContentType("text/csv;charset=UTF-8"); resp.setHeader("Content-Disposition","attachment; filename=projects-report.csv");
     PrintWriter out=resp.getWriter(); out.println("Project ID,Project Name,Start Date,End Date,Client,Status,Employee Count");
     for(Project p:projectService.findAll()) out.printf("%s,%s,%s,%s,%s,%s,%s%n",csv(p.getProjectId()),csv(p.getProjectName()),csv(p.getProjectStartDate()==null?"":p.getProjectStartDate().toString()),csv(p.getProjectEndDate()==null?"":p.getProjectEndDate().toString()),csv(p.getClient()==null?"":p.getClient().getClientName()),csv(p.isActive()?"ACTIVE":"INACTIVE"),p.getEmployees()==null?0:p.getEmployees().size());
 }
 @GetMapping("/reports/audit.csv") public void auditCsv(HttpServletResponse resp,HttpSession s)throws IOException{
     if(!admin(s)){resp.sendError(403);return;} resp.setContentType("text/csv;charset=UTF-8"); resp.setHeader("Content-Disposition","attachment; filename=audit-log-report.csv");
     PrintWriter out=resp.getWriter(); out.println("ID,Actor,Action,Entity Type,Entity ID,Details,Created At");
     for(AuditLog a:db().createQuery("from AuditLog order by createdAt desc",AuditLog.class).getResultList()) out.printf("%s,%s,%s,%s,%s,%s,%s%n",a.getId(),csv(a.getActor()),csv(a.getAction()),csv(a.getEntityType()),csv(a.getEntityId()),csv(a.getDetails()),csv(a.getCreatedAt()==null?"":a.getCreatedAt().toString().replace('T',' ')));
 }
 @GetMapping("/reports/notifications.csv") public void notificationsCsv(HttpServletResponse resp,HttpSession s)throws IOException{
     if(!admin(s)){resp.sendError(403);return;} resp.setContentType("text/csv;charset=UTF-8"); resp.setHeader("Content-Disposition","attachment; filename=notifications-report.csv");
     PrintWriter out=resp.getWriter(); out.println("ID,Recipient,Role,Type,Message,Read,Created At");
     for(Notification n:db().createQuery("from Notification order by createdAt desc",Notification.class).getResultList()) out.printf("%s,%s,%s,%s,%s,%s,%s%n",n.getId(),csv(n.getRecipient()),csv(n.getRole()),csv(n.getType()),csv(n.getMessage()),n.isReadFlag(),csv(n.getCreatedAt()==null?"":n.getCreatedAt().toString().replace('T',' ')));
 }
 @GetMapping("/restore/employees") public String restoreEmployees(Model m,HttpSession s){if(!admin(s))return "redirect:/dashboard";Query<Employee> q=db().createQuery("from Employee where active=false",Employee.class);m.addAttribute("employees",q.getResultList());return "restore-employees";}
 @PostMapping("/restore/employee/{id}") public String restoreEmployee(@PathVariable String id,HttpSession s){if(admin(s)){Employee e=employeeService.findById(id).orElse(null);if(e!=null){e.setActive(true);e.setEmploymentStatus("ACTIVE");db().update(e);audit(s,"RESTORE","Employee",id,"Employee restored");}}return "redirect:/restore/employees";}
 @GetMapping("/search/employees") public String searchEmployees(
         @RequestParam(required=false) String q,
         @RequestParam(required=false) String sort,
         @RequestParam(required=false) String department,
         @RequestParam(required=false) String status,
         @RequestParam(required=false) String roleFilter,
         @RequestParam(required=false) String project,
         Model m,HttpSession s){
     if(!admin(s))return "redirect:/dashboard";
     List<Employee> all=employeeService.findAll();
     List<Employee> list=new ArrayList<>(all);
     if(q!=null&&!q.trim().isEmpty()){
         String x=q.trim().toLowerCase();
         list=list.stream().filter(e->(safe(e.getEmployeeId())+" "+safe(e.getEmployeeName())+" "+safe(e.getEmployeeEmail())+" "+safe(e.getEmployeeDept())).toLowerCase().contains(x)).collect(Collectors.toList());
     }
     if(department!=null&&!department.trim().isEmpty()) list=list.stream().filter(e->department.equalsIgnoreCase(e.getEmployeeDept())).collect(Collectors.toList());
     if(status!=null&&!status.trim().isEmpty()) list=list.stream().filter(e->status.equalsIgnoreCase(e.getEmploymentStatus())).collect(Collectors.toList());
     if(roleFilter!=null&&!roleFilter.trim().isEmpty()) list=list.stream().filter(e->roleFilter.equalsIgnoreCase(e.getRole())).collect(Collectors.toList());
     if(project!=null&&!project.trim().isEmpty()){
         if("BENCH".equalsIgnoreCase(project)) list=list.stream().filter(e->e.getProject()==null).collect(Collectors.toList());
         else list=list.stream().filter(e->e.getProject()!=null && project.equals(e.getProject().getProjectId())).collect(Collectors.toList());
     }
     if("name".equalsIgnoreCase(sort)) list.sort(Comparator.comparing(e->safe(e.getEmployeeName()),String.CASE_INSENSITIVE_ORDER));
     else if("joining".equalsIgnoreCase(sort)) list.sort(Comparator.comparing(Employee::getDateOfJoining,Comparator.nullsLast(Comparator.naturalOrder())).reversed());

     Set<String> departments=all.stream().map(Employee::getEmployeeDept).filter(Objects::nonNull).filter(x->!x.trim().isEmpty()).collect(Collectors.toCollection(TreeSet::new));
     Set<String> roles=all.stream().map(Employee::getRole).filter(Objects::nonNull).filter(x->!x.trim().isEmpty()).collect(Collectors.toCollection(TreeSet::new));
     Set<String> statuses=all.stream().map(Employee::getEmploymentStatus).filter(Objects::nonNull).filter(x->!x.trim().isEmpty()).collect(Collectors.toCollection(TreeSet::new));

     m.addAttribute("employees",list);m.addAttribute("q",q);m.addAttribute("sort",sort);
     m.addAttribute("department",department);m.addAttribute("status",status);m.addAttribute("roleFilter",roleFilter);m.addAttribute("project",project);
     m.addAttribute("departments",departments);m.addAttribute("roles",roles);m.addAttribute("statuses",statuses);
     m.addAttribute("filterCount",list.size());
     return "employee-list";
 }
 private String safe(String v){return v==null?"":v;}
}
