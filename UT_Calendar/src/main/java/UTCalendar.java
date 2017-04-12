import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

public class UTCalendar extends HttpServlet {
	
	/*static {
        ObjectifyService.register(User.class);
        ObjectifyService.register(Schedule.class);
    }*/

	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException {
		
		User kirtana = new User("Kirtana Moorthy", "km@utexas.edu", "km");
		User vidita = new User("Vidita Dixit", "vd@utexas.edu", "vd");
		User katelyn = new User("Katelyn Ge", "kg@utexas.edu", "kg");
		User rebecca = new User("Rebecca Jiang", "rj@utexas.edu", "rj");
		
		ArrayList<User> users = new ArrayList<User>();
		users.add(kirtana);
		users.add(vidita);
		users.add(katelyn);
		users.add(rebecca);
		
		System.out.println(users);
		
		response.sendRedirect("calendar.jsp");
		
		/*ofy().save().entity(kirtana).now();
		ofy().save().entity(vidita).now();
		ofy().save().entity(katelyn).now();
		ofy().save().entity(rebecca).now();*/
	}
}