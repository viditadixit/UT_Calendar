package utcalendar;
import java.util.ArrayList;
import java.util.Date;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Event {

	@Id Long id;
	String title;
	String location;
	Date startDate, endDate;
	
	public Event(String title, String location, Date start, Date end) {
		this.title = title;
		this.location = location;
		this.startDate = start;
		this.endDate = end;
	}
	
	public void editLocation(Schedule s, String newLoc) {
		this.location = newLoc;
		updateSchedule(s);
	}
	
	public void editStartDate(Schedule s, Date newStart) {
		this.startDate = newStart;
		updateSchedule(s);
	}
	
	public void editEndDate(Schedule s, Date newEnd) {
		this.endDate = newEnd;
		updateSchedule(s);
	}
	
	public void updateSchedule(Schedule s) {
		s.updateStudents();
	}
}
