package com.project.controller1;
import com.project.entity.*; import com.project.service.*; import org.hibernate.SessionFactory; import org.hibernate.query.Query; import org.springframework.beans.factory.annotation.Autowired; import org.springframework.stereotype.Controller; import org.springframework.ui.Model; import org.springframework.web.bind.annotation.GetMapping; import org.springframework.transaction.annotation.Transactional; import javax.servlet.http.HttpSession; import java.util.*;
@Controller @Transactional(readOnly=true) public class DashboardMvcController {
 private final EmployeeService employees; private final ClientService clients; private final ProjectService projects; private final SessionFactory sf;
 @Autowired public DashboardMvcController(EmployeeService e,ClientService c,ProjectService p,SessionFactory sf){employees=e;clients=c;projects=p;this.sf=sf;}
 @GetMapping("/dashboard") public String dashboard(Model m,HttpSession s){String role=(String)s.getAttribute("role");if(role==null)return "redirect:/auth/login?error";if("ROLE_ADMIN".equals(role)){m.addAttribute("employeeCount",employees.findAll().size());m.addAttribute("clientCount",clients.findAll().size());m.addAttribute("projectCount",projects.findAll().size());m.addAttribute("benchCount",employees.findBenchEmployees().size());m.addAttribute("attendanceCount",sf.getCurrentSession().createQuery("select count(a) from Attendance a",Long.class).getSingleResult());m.addAttribute("pendingLeaves",sf.getCurrentSession().createQuery("select count(l) from LeaveRequest l where l.status='PENDING'",Long.class).getSingleResult());m.addAttribute("pendingExpenses",sf.getCurrentSession().createQuery("select count(x) from ExpenseClaim x where x.status='PENDING'",Long.class).getSingleResult());
            try {
                m.addAttribute("salaryCount",sf.getCurrentSession().createQuery("select count(x) from SalaryStructure x",Long.class).getSingleResult());
                m.addAttribute("payrollCount",sf.getCurrentSession().createQuery("select count(x) from PayrollRecord x",Long.class).getSingleResult());
                m.addAttribute("pendingApprovals",sf.getCurrentSession().createQuery("select count(x) from ApprovalRequest x where x.status='PENDING'",Long.class).getSingleResult());
                m.addAttribute("openGoals",sf.getCurrentSession().createQuery("select count(x) from PerformanceGoal x where x.status='OPEN'",Long.class).getSingleResult());
            } catch(Exception ignored) {
                m.addAttribute("salaryCount",0L); m.addAttribute("payrollCount",0L); m.addAttribute("pendingApprovals",0L); m.addAttribute("openGoals",0L);
            }
            return "admin-dashboard";}if("ROLE_EMPLOYEE".equals(role))return "redirect:/employee/dashboard";if("ROLE_CLIENT".equals(role))return "redirect:/client/dashboard";return "redirect:/auth/login?error";}
}
