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
		String name = (String) request.getParameter("name");
		
		/*String myObjectId = request.getParameter("user");
		User user = (User)request.getSession().getAttribute(myObjectId);
		request.getSession().removeAttribute(myObjectId);*/
		
		//String userID = request.getParameter("user");
		//HttpSession session = request.getSession();
		//User user = (User)request.getAttribute("user");
		//request.getSession().removeAttribute(userID);
		
		//System.out.println(item);
		//System.out.println(user);
		
		List<User> users = ObjectifyService.ofy().load().type(User.class).list();
		User currentUser = new User();
		for (User u : users) {
			if (u.getName().equals(name)) {
				currentUser = u;
				ofy().delete().entity(u).now();
				break;
			}
		}
	
		currentUser.addItem(item);
		ofy().save().entity(currentUser).now();
		request.setAttribute("name", name);
		request.setAttribute("toDoList", currentUser.toDoList);
		
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
		
		/*if (user != null) {
			System.out.println(item);
			//System.out.println(user.getName());
			user.addItem(item);
			//String id = UUID.randomUUID().toString();
			//request.getSession().setAttribute(id, user);
			request.setAttribute("name", user.getName());
			request.setAttribute("user", user);
			//request.setAttribute("user", u);
			request.setAttribute("toDoList", user.toDoList);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/calendar.jsp");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		} else {
			System.out.println("ERROR");
		}*/
	}
}