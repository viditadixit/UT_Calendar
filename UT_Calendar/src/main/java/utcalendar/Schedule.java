package utcalendar;

import java.util.ArrayList;
import java.lang.String;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Parent;


@Entity
public class Schedule {

	@Id Long id;
	String title;
	boolean access; //public = true, private = false
	Long authorId;
	private ArrayList<String> studentList;
	public ArrayList<Long> events;
	String color;
	
	public Schedule(){
		this.studentList=new ArrayList<String>();
		this.events= new ArrayList<Long>();
	}
	
	public Schedule(String title, ArrayList<String> students, boolean access, ArrayList<Long> events) {
		this.title = title;
		this.studentList=new ArrayList<String>();
		this.events = events;
	}
	
	public String getTitle() {
		return this.title;
	}
	
	public void setTitle(String title){
		this.title= title;
	}
	
	public Long getID() {
		return this.id;
	}
	
	public Long getAuthor() {
		return this.authorId;
	}
	
	public void setAuthor(Long id){
		this.authorId=id;
	}
	public void setAccess(String access){
		if(access.equals("public")){
			this.access=true;
		}
		else if(access.equals("private")){
			this.access=false;
		}
	}
	
	public void addStudent(String user) {
		this.studentList.add(user);
	}
	
	public void deleteStudent(String user) {
		this.studentList.remove(user);
	}
	
	public void addEvent(Long event) {
		this.events.add(event);
	}
	
	public void deleteEvent(Long event) {
		this.events.remove(event);
	}
	
	public String getColor() {
		return this.color;
	}
	
	public void setColor(String color) {
		this.color = color;
	}
}
