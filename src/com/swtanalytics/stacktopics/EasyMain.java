package com.swtanalytics.stacktopics;

import java.io.IOException;


import org.kohsuke.args4j.Option;
import org.kohsuke.args4j.CmdLineParser;
import org.kohsuke.args4j.CmdLineException;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;



public class EasyMain {

    //@Option(name="-n", usage="The number of functions to generate.")
    //public int numMathFunctions = NUM_MATH_FUNCTIONS_DEFAULT;

    //@Option(name="-d", usage="Print differentials too.")
    //public boolean isPrintDifferential = false;

    //@Option(name="-f", usage="Experiment with Fractions.")
    //public boolean isFractions = false;

    protected void parse_input(String[] args) {

        CmdLineParser parser = new CmdLineParser(this);
        try {
            parser.parseArgument(args);
            if (1 <= 0) {
                //throw new CmdLineException("Option -n requires a positive integer");
            	}

        } catch (CmdLineException e) {
            System.out.print(e.getMessage());
            System.out.print("\n");
            parser.printUsage(System.err);
            System.exit(1);
        }
    }


    // The main logic loop
    public void run() {
    	AnalysisPackage a = new AnalysisPackage();
    	
    	try{	       
	    	SAXParserFactory factory = SAXParserFactory.newInstance();
	    	SAXParser saxParser = factory.newSAXParser();
	    	XMLHandler handler = new XMLHandler();
	    	saxParser.parse("../SO/June2010/"
	    			+ "tmp.xml", handler);
	    	a.posts = handler.posts;
    	} catch (Exception e){
    		e.printStackTrace();
    		System.exit(1);
    	}
    	
    	// TODO: Persist to disk somehow
    	
    	// For now, see if we can run LDA using MALLET
    	a.buildInstanceList();
    	a.runLDA();
    }

    public static void main(String[] args) throws IOException {
        EasyMain main = new EasyMain();
        main.parse_input(args);
        main.run();
    }

}
