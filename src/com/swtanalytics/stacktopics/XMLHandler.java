package com.swtanalytics.stacktopics;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class XMLHandler extends DefaultHandler {
	
		public ArrayList<Post> posts = new ArrayList<Post>();
	 
		public void startElement(String uri, String localName,String qName, Attributes attributes) throws SAXException {
			if (qName.equalsIgnoreCase("row")) {
				
				int id = Integer.parseInt(attributes.getValue("Id"));
				int t = Integer.parseInt(attributes.getValue("PostTypeId"));
				String o = attributes.getValue("Body");
				String p = attributes.getValue("BodyPre");
				String d = attributes.getValue("CreationDate").substring(0,10); // e.g., "2008-08-01T07:25:22.443"
				
				Date date = null;
				try {
					date = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(d);
				} catch (Exception e){
					System.out.print(e.getMessage());
		            System.out.print("\n");
		            System.exit(1);
				}

				Post post = new Post(id, t, o, p, date);
				posts.add(post);
			}
		}
	 
		public void endElement(String uri, String localName, String qName) throws SAXException {}
		public void characters(char ch[], int start, int length) throws SAXException {}
}
