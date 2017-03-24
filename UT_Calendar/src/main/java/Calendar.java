import java.util.ArrayList;
import java.util.Date;

public class Calendar {
	
	Date currentDate;
	ArrayList<Schedule> schedules;
	
	public Calendar() {
		this.currentDate = new Date();
	}
	
	public void addSchedule(Schedule schedule) {
		schedules.add(schedule);
	}
	
	public void updateSchedule(Schedule schedule) {
		for (int i = 0; i < schedules.size(); i++) {
			if (schedules.get(i).getTitle().equals(schedule.getTitle())) {
				schedules.remove(i);
				schedules.add(schedule);
				break;
			}
		}
	}
	
	public void deleteSchedule(Schedule schedule) {
		schedules.remove(schedule);
	}
	
}
