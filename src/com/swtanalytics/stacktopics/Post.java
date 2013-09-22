package com.swtanalytics.stacktopics;

import java.util.Date;

public class Post {
	
	public int id;
	public int typeId;
	public String originalText = "";
	public String preprocessedText = "";
	public Date date;
	
	public Post(int i, int t, String o, String p, Date d){
		this.id = i;
		this.typeId = t;
		this.originalText = o;
		this.preprocessedText = p;
		this.date = d;
	}

}
