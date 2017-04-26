package utcalendar;
import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Schedule {
	
	@Id Long id;

	String title;
	boolean access; //public = true, private = false
	private ArrayList<User> subscriberList;
	private ArrayList<User> studentList;
	ArrayList<Event> events;
	
	public Schedule(String title, ArrayList<User> students, boolean access, ArrayList<Event> events) {
		this.title = title;
		if (access) {
			this.studentList = new ArrayList<User>();
		} else {
			this.studentList = students;
		}
		this.events = events;
		this.subscriberList = new ArrayList<User>();
	}
	
	public String getTitle() {
		return this.title;
	}
	
	public void addStudent(User user) {
		this.studentList.add(user);
	}
	
	public void deleteStudent(User user) {
		this.studentList.remove(user);
	}
	
	public void subscribe(User user) {
		this.subscriberList.add(user);
	}
	
	public void unsubscribe(User user) {
		this.subscriberList.remove(user);
	}
	
	public void addEvent(Event event) {
		this.events.add(event);
	}
	
	public void deleteEvent(Event event) {
		this.events.remove(event);
	}
	
	public void updateStudents() {
		for (int i = 0; i < subscriberList.size(); i++) {
			subscriberList.get(i).updateCalendar(this);
		}
	}
}
