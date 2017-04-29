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

public class AddSchedule extends HttpServlet {
	static {
        ObjectifyService.register(User.class);
    }

	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException {
		
		String schedules = request.getParameter("schedules");
		String email = request.getParameter("email");
		
		List<User> users = ObjectifyService.ofy().load().type(User.class).list();
		User currentUser = new User();
		for (User u : users) {
			if (u.getEmail().equals(email)) {
				currentUser = new User(u.getName(), u.getEmail(), u.getPassword());
				u.addSchedule(schedules);
				currentUser.schedules = u.schedules;
				currentUser.toDoList = u.toDoList;
				ofy().delete().entity(u).now();
				break;
			}
		}
		
		ofy().save().entity(currentUser).now();
		request.setAttribute("email", currentUser.getEmail());
		request.setAttribute("name", currentUser.getName());
		request.setAttribute("toDoList", currentUser.toDoList);
		request.setAttribute("schedules", currentUser.schedules);
		
		if (currentUser != null) {
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