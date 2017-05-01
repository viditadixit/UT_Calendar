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
		
		String schedule = (String) request.getParameter("schedules");
		Long id = Long.parseLong(request.getParameter("id"));

		List<User> users = ObjectifyService.ofy().load().type(User.class).list();
		User currentUser = new User();
		for (User u : users) {
			if (u.getId().equals(id)) {
				currentUser = new User(u.getName(), u.getEmail(), u.getPassword());
				currentUser.setId(id);
				if (!schedule.equals("/"))
					u.addSchedule(schedule);
				currentUser.toDoList = u.toDoList;
				currentUser.schedules = u.schedules;
				ofy().delete().entity(u).now();
				break;
			}
		}

		ofy().save().entity(currentUser).now();
		request.setAttribute("id", Long.toString(currentUser.getId()));
		
		if (currentUser != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/addcalendar.jsp");
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