package testBoard;

import java.sql.Date;

public class ArticleVO {
	private int bno;
	private String title;
	private String content;
	private String id;
	Date date;
	
	public ArticleVO() {
		
	}
	
	
	
	public ArticleVO(int bno, String title, String content, String id) {
		super();
		this.bno = bno;
		this.title = title;
		this.content = content;
		this.id = id;
	}



	public int getBno() {
		return bno;
	}



	public void setBno(int bno) {
		this.bno = bno;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getContent() {
		return content;
	}



	public void setContent(String content) {
		this.content = content;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public Date getDate() {
		return date;
	}



	public void setDate(Date date) {
		this.date = date;
	}
	
	
}
