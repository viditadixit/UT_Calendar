package utcalendar;
import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Schedule {
	
	@Id Long id;

	String title;
	boolean access; //public = true, private = false
	private ArrayList<String> subscriberList;
	private ArrayList<String> studentList;
	ArrayList<String> events;
	
	public Schedule(String title) {
		this.title = title;
	}
	
	public Schedule(String title, ArrayList<String> students, boolean access, ArrayList<String> events) {
		this.title = title;
		if (access) {
			this.studentList = new ArrayList<String>();
		} else {
			this.studentList = students;
		}
		this.events = events;
		this.subscriberList = new ArrayList<String>();
	}
	
	public String getTitle() {
		return this.title;
	}
	
	public void addStudent(String user) {
		this.studentList.add(user);
	}
	
	public void deleteStudent(String user) {
		this.studentList.remove(user);
	}
	
	public void subscribe(String user) {
		this.subscriberList.add(user);
	}
	
	public void unsubscribe(String user) {
		this.subscriberList.remove(user);
	}
	
	public void addEvent(String event) {
		this.events.add(event);
	}
	
	public void deleteEvent(String event) {
		this.events.remove(event);
	}
	
	/*public void updateStudents() {
		for (int i = 0; i < subscriberList.size(); i++) {
			subscriberList.get(i).updateCalendar(this);
		}
	}*/
}
