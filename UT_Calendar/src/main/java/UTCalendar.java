import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

public class UTCalendar extends HttpServlet {
	
	/*static {
        ObjectifyService.register(User.class);
    }*/

	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException {
		
		User kirtana = new User("Kirtana Moorthy", "km@utexas.edu", "km");
		User vidita = new User("Vidita Dixit", "vd", "vd");
		User katelyn = new User("Katelyn Ge", "kg@utexas.edu", "kg");
		User rebecca = new User("Rebecca Jiang", "rj@utexas.edu", "rj");
		
		/*ofy().save().entity(kirtana).now();
		ofy().save().entity(vidita).now();
		ofy().save().entity(katelyn).now();
		ofy().save().entity(rebecca).now();*/
		
		vidita.addItem("study");
		
		ArrayList<User> users = new ArrayList<User>();
		users.add(kirtana);
		users.add(vidita);
		users.add(katelyn);
		users.add(rebecca);
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = "";
		
		boolean user = false;
		
		for (User u : users) {
			if (u.getEmail().equals(username)) {
				if (u.getPassword().equals(password)) {
					name = u.getName();
					request.setAttribute("user", u);
					request.setAttribute("name", u.getName());
					request.setAttribute("toDoList", u.toDoList);
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