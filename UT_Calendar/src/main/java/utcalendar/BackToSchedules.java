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

public class BackToSchedules extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException {
		
		Long id = Long.parseLong(request.getParameter("id"));
		
		request.setAttribute("id", id);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/addcalendar.jsp");
		try {
			dispatcher.forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}