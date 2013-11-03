package com.swtanalytics.stacktopics;

import java.io.File;
import java.io.IOException;

import org.kohsuke.args4j.Option;
import org.kohsuke.args4j.CmdLineParser;
import org.kohsuke.args4j.CmdLineException;

import javax.xml.parsers.*;

import org.xml.sax.*;
import org.xml.sax.helpers.*;

import java.util.*;
import java.io.*;


public class ParsePosts extends DefaultHandler {

    @Option(name="-f", usage="The Stack Overflow XML file to parse.")
    public String xmlFileName = "";
    
    @Option(name="-p", usage="The name of the output posts file (csv).")
    public String outPostsFileName = "";
    
    @Option(name="-t", usage="The name of the output tag file (csv).")
    public String outTagsFileName = "";
    
    @Option(name="-m", usage="The name of the output posts_tags mapping file (csv).")
    public String outPostsTagsFileName = "";
    

    protected void parse_input(String[] args) {

        CmdLineParser parser = new CmdLineParser(this);
        try {
            parser.parseArgument(args);
        } catch (CmdLineException e) {
            System.out.print(e.getMessage());
            System.out.print("\n");
            parser.printUsage(System.err);
            System.exit(1);
        }
    }


    // The main logic loop
    public void run() throws Exception {
    	
    	SOHandler so = new SOHandler();
    	so.outPostsFileName     = outPostsFileName;
    	so.outTagsFileName      = outTagsFileName;
    	so.outPostsTagsFileName = outPostsTagsFileName;
    	
        
        SAXParserFactory spf = SAXParserFactory.newInstance();
        SAXParser saxParser = spf.newSAXParser();
        XMLReader xmlReader = saxParser.getXMLReader();
        xmlReader.setContentHandler(so);
        xmlReader.setErrorHandler(new MyErrorHandler(System.err));
        xmlReader.parse(convertToFileURL(xmlFileName));
    }


    
    /**
     * Convert from a filename to a file URL.
     */
    private static String convertToFileURL(String filename) {
        // On JDK 1.2 and later, simplify this to:
        // "path = file.toURL().toString()".
        String path = new File(filename).getAbsolutePath();
        if (File.separatorChar != '/') {
            path = path.replace(File.separatorChar, '/');
        }
        if (!path.startsWith("/")) {
            path = "/" + path;
        }
        return "file:" + path;
    }


    public static void main(String[] args) throws Exception {
        ParsePosts main = new ParsePosts();
        main.parse_input(args);
        main.run();
    }




    // Error handler to report errors and warnings
    private static class MyErrorHandler implements ErrorHandler {
        /** Error handler output goes here */
        private PrintStream out;

        MyErrorHandler(PrintStream out) {
            this.out = out;
        }

        /**
         * Returns a string describing parse exception details
         */
        private String getParseExceptionInfo(SAXParseException spe) {
            String systemId = spe.getSystemId();
            if (systemId == null) {
                systemId = "null";
            }
            String info = "URI=" + systemId +
                " Line=" + spe.getLineNumber() +
                ": " + spe.getMessage();
            return info;
        }

        // The following methods are standard SAX ErrorHandler methods.
        // See SAX documentation for more info.

        public void warning(SAXParseException spe) throws SAXException {
            out.println("Warning: " + getParseExceptionInfo(spe));
        }

        public void error(SAXParseException spe) throws SAXException {
            String message = "Error: " + getParseExceptionInfo(spe);
            throw new SAXException(message);
        }

        public void fatalError(SAXParseException spe) throws SAXException {
            String message = "Fatal Error: " + getParseExceptionInfo(spe);
            throw new SAXException(message);
        }
    }


}
