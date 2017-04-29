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
import javax.servlet.http.HttpSession;

import com.googlecode.objectify.ObjectifyService;

public class ToDoItem extends HttpServlet {
	
	static {
        ObjectifyService.register(User.class);
    }

	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException {
		
		String item = (String) request.getParameter("add");
		String email = (String) request.getParameter("email");
		//String name = (String) request.getAttribute("name");
		
		List<User> users = ObjectifyService.ofy().load().type(User.class).list();
		User currentUser = new User();
		for (User u : users) {
			if (u.getEmail().equals(email)) {
				currentUser = new User(u.getName(), u.getEmail(), u.getPassword());
				u.addItem(item);
				currentUser.toDoList = u.toDoList;
				currentUser.schedules = u.schedules;
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