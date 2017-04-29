package utcalendar;
import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

public class UTCalendar extends HttpServlet {
	static {
        ObjectifyService.register(User.class);
    }

	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = "";
		
		List<User> users = ObjectifyService.ofy().load().type(User.class).list();

		boolean user = false;
		
		for (User u : users) {
			System.out.println(u.getEmail());
			System.out.println(u.getPassword());
			if (u.getEmail().equals(username)) {
				if (u.getPassword().equals(password)) {
					request.setAttribute("email", u.getEmail());
					request.setAttribute("name", u.getName());
					request.setAttribute("toDoList", u.toDoList);
					request.setAttribute("schedules", u.schedules);
					user = true;
					break;
				}
			}
		}
		
		if (user) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/calendar.jsp");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//response.sendRedirect("/calendar.jsp?user=" + name);
		} else {
			response.sendRedirect("/login.jsp");
		}
	}
}