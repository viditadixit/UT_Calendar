package utcalendar;

import java.util.Date;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class Event {

	@Id Long id;
	String title;
	String date, startDate, endDate;
	
	public Event(){
	}
	
	public Event(String title, String date, String start, String end) {
		this.title = title;
		this.date = date;
		this.startDate = start;
		this.endDate = end;
	}
	
	public String getTitle(){
		return this.title;
	}
	
	public Long getId(){
		return this.id;
	}
	
	public void setId(Long id){
		this.id=id;
	}

}
