package utcalendar;
import java.util.ArrayList;
import java.util.Date;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Week {

	@Id Long id;
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public int weekNo;
	public Date startTime, endTime;
	
	public Week() {
		this.weekNo = 0;
		startTime = new Date();
		endTime = new Date();
	}
	
	public Week(int weekNo, Date startTime, Date endTime) {
		this.weekNo = weekNo;
		this.startTime = startTime;
		this.endTime = endTime;
	}
	
	public Long getId(){
		return this.id;
	}
	
	public void setId(Long id){
		this.id=id;
	}
	
	public Date getStartTime() {
		return startTime;
	}
	
	public Date getEndTime() {
		return endTime;
	}
}
