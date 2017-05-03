package utcalendar;

import java.util.Date;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class Event implements Comparable<Event>{

	@Id Long id;
	String title;
	String date, startTime, endTime;
	String color;
	
	public Event(){
	}
	
	public Event(String title, String date, String start, String end) {
		this.title = title;
		this.date = date;
		this.startTime = start;
		this.endTime = end;
		this.color = "blue";
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
	
	public String getDate(){
		return date;
	}
	
	public String getStartTime(){
		return startTime;
	}
	
	public String getEndTime(){
		return endTime;
	}
	
	public int getDifference(){
		String[] start = startTime.split(":");
		String[] end = endTime.split(":");
		int startHour = Integer.parseInt(start[0]);
		int endHour = Integer.parseInt(end[0]);
		int startMin = Integer.parseInt(start[1].substring(0,2));
		int endMin = Integer.parseInt(end[1].substring(0, 2));
		int hoursDiff = endHour-startHour;
		int numRows = hoursDiff*2;
		if(endMin==30)
			numRows++;
		if(startMin==30)
			numRows--;
		return numRows;
	}
	
	public int getDay(){
		return Integer.parseInt(date.substring(8));
	}
	
	public int compareTo(Event other){
		int i = this.getStartTime().compareTo(other.getStartTime());
		if(i!=0)
			return i;
		else{
			return this.getDate().compareTo(other.getDate());
		}
	}
	
	public String getColor(){
		return color;
	}
	
	public void setColor(String color){
		this.color = color;
	}
}
