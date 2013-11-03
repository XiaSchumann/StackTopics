package com.swtanalytics.stacktopics;

import java.io.IOException;

import org.apache.commons.lang3.StringEscapeUtils;
import org.kohsuke.args4j.Option;

import javax.xml.parsers.*;

import org.xml.sax.*;
import org.xml.sax.helpers.*;

import java.util.*;
import java.io.*;


public class SOHandler extends DefaultHandler {

    static final String JAXP_SCHEMA_LANGUAGE =
        "http://java.sun.com/xml/jaxp/properties/schemaLanguage";
    static final String W3C_XML_SCHEMA =
        "http://www.w3.org/2001/XMLSchema";
    static final String JAXP_SCHEMA_SOURCE =
        "http://java.sun.com/xml/jaxp/properties/schemaSource";
    
    // Maps tag names to their unique ID
    TreeMap<String, Integer> tagTable = new TreeMap<String, Integer>();
    
    public String outPostsFileName = "";
    public String outTagsFileName = "";
    public String outPostsTagsFileName = "";
    
    BufferedWriter bw_Posts = null;
    BufferedWriter bw_Tags = null;
    BufferedWriter bw_PostsTags = null;
    
    int tagCount = 0;

    // Parser calls this once at the beginning of a document
    public void startDocument() throws SAXException {
    	
    	bw_Posts     = makeWriter(outPostsFileName);
    	bw_Tags      = makeWriter(outTagsFileName);
    	bw_PostsTags = makeWriter(outPostsTagsFileName);
    }
    
    public BufferedWriter makeWriter(String fileName){
    
		File file = new File(fileName);
		 
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		FileWriter fw = null;
		try {
			fw = new FileWriter(file.getAbsoluteFile());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new BufferedWriter(fw);
    }

     // Parser calls this for each element in a document
    // Three things will happen when we see the start of an element.
    // 1. We will write a line to posts.csv
    // 2. We will write a line to posts_tags.csv
    // 3. We will write a line to tags.csv
    // 4. We will write a file to the directory containing the "Body" attribute of the element.
    public void startElement(String namespaceURI, String localName, String qName, Attributes atts)
    throws SAXException
    {
        if (qName.equals("row")){
        	
            String ID = atts.getValue("Id") ;
            String PostType = atts.getValue("PostTypeId") ;
            String CreationDate = atts.getValue("CreationDate") ;
            String Body = atts.getValue("Body");
            String Tags = atts.getValue("Tags");
            
            // Create an escaped, one-line version of Body, for the CSV file
            String Body_escapeXML = StringEscapeUtils.escapeXml(Body);
            Body_escapeXML = Body_escapeXML.replaceAll("\n", "&#xA;");
            
            // Remove the  extra fluff, e.g., "2008-07-31T21:42:52.667" => "2008-07-31"
            CreationDate = CreationDate.replaceFirst("T.*", "");
            
            try {
            	
            	// Write the main CSV data
				bw_Posts.write(String.format("%s|%s|%s|%s|\n", ID, PostType, CreationDate, Body_escapeXML));
				
				// Write the post/Tag mapping
				if (Tags != null){
					Tags = Tags.replaceAll("<", "");
					String tags[] = Tags.split(">");
					
					for (int i=0; i<tags.length;++i){
						String tag = tags[i];
						
						if (! tagTable.containsKey(tag)){
							tagTable.put(tag, tagCount++);
						}
						bw_PostsTags.write(String.format("%s|%d\n", ID, tagTable.get(tag) ));
					}
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
    }


    // Parser calls this once after parsing a document
    public void endDocument() throws SAXException {
    	try {
    		// Output the list of tags
    		for (Map.Entry<String, Integer> entry : tagTable.entrySet()) {
    			bw_Tags.write(String.format("%d|%s\n", entry.getValue(), entry.getKey()));
    		}
    		bw_Posts.close();
    		bw_Tags.close();
    		bw_PostsTags.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
}
