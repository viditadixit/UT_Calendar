package utcalendar;
import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

public class NewSchedule extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException {
		
		List<User> users = ObjectifyService.ofy().load().type(User.class).list();
		Long id = Long.parseLong(request.getParameter("id"));
		User u = ObjectifyService.ofy().load().type(User.class).filter("id", id).first().get();
		
		//need to parse parameters so events are together in table
		//scheduleName, access, timeto#, timefrom#, validemail, date#, name#,
		Enumeration parameters = request.getParameterNames();
		ArrayList<String> ScheduleList = new ArrayList<String>(100);
		for(int i=0; i< 100; i++){
			ScheduleList.add("empty");
		}
		System.out.println(ScheduleList.size());
		while(parameters.hasMoreElements()){
			String parameterName = (String)parameters.nextElement();
			System.out.println(parameterName);
			String parameterValue = (String) request.getParameter(parameterName);
			if(parameterName.equals("scheduleName")){
				ScheduleList.set(0,parameterValue);
			}
			else if(parameterName.equals("access")){
				ScheduleList.set(1,parameterValue);
			}
			else if(parameterName.equals("validemail")){
				ScheduleList.set(2,parameterValue);
			}
			else if(parameterName.equals("id")) {
				continue;
			}
			else{ //events
				int arrayIndex=0;
				int eventnum= Integer.parseInt(parameterName.substring(parameterName.length()-1));
				String parameter=parameterName.substring(0,parameterName.length()-1);
				if(parameter.equals("name")){
					arrayIndex=(eventnum*4)-1;
				}
				else if(parameter.equals("date")){
					arrayIndex=eventnum*4;
				}
				else if(parameter.equals("timefrom")){
					arrayIndex=(eventnum*4)+1;
				}
				else if(parameter.equals("timeto")){
					arrayIndex=(eventnum*4)+2;
				}
				ScheduleList.set(arrayIndex,parameterValue);
			}	
		}
		int endOfList=ScheduleList.indexOf("empty");
		ArrayList<String> newScheduleData = new ArrayList<String>();
		newScheduleData.addAll(ScheduleList.subList(0, endOfList));
		System.out.println(newScheduleData.toString());
		Schedule newSchedule = new Schedule();
		newSchedule.setTitle(newScheduleData.get(0)); //set name
		newSchedule.setAccess(newScheduleData.get(1)); //set access*/
		
		String emailString=newScheduleData.get(2);
		String[] emails=emailString.split("\\s+"); //set emails
		System.out.println(Arrays.asList(emails));
		for(int i=0; i<emails.length;i++){
			System.out.println(emails[i]);
			newSchedule.addStudent(emails[i].toString());
		}
		for(int i=3; i<newScheduleData.size();i=i+4){ //set events
			Event newEvent = new Event(newScheduleData.get(i), newScheduleData.get(i+1), newScheduleData.get(i+2), newScheduleData.get(i+3));
			ObjectifyService.ofy().save().entity(newEvent).now();
			newSchedule.addEvent(newEvent.getId());
		}
		newSchedule.setAuthor(id);
		
	    ObjectifyService.ofy().save().entity(newSchedule).now(); //create new schedule in objectify
	    
		request.setAttribute("id", u.getId());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/addcalendar.jsp");
		try {
			dispatcher.forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}