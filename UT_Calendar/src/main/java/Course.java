import java.util.ArrayList;

public class Course extends Schedule {
	
	public String professor;

	public Course (String title, ArrayList<User> students, ArrayList<Event> events, String prof){
		super(title, students, false, events);
		this.professor = prof;
	}
	
}
