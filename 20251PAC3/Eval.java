import java.io.*;
import java.lang.*;
import java.util.List;
import java.util.LinkedList;

// /* DSLab */
// import edu.uoc.dpcs.lsim.logger.LoggerManager.Level;
// import lsim.library.api.LSimLogger;

public class Eval {

    public enum Type { BOOLEAN, INT, FLOAT, STRING };

	public static final String LANGUAGE_EXTENSION = "q";
	public static final String TESTCASE_EXTENSION = "test";
	public static final Eval eval = new Eval();

	private boolean generateTestCase = false; 
    private List<String> buffer;

    // /* DSLab */
    // public static String result_summary = "";
    // public static String result = "";
    public static boolean success = false;

    public Eval() {
        generateTestCase = false;
        buffer = new LinkedList<String>();
    }

    // /* DSLab */
    public static boolean isSuccess(){
        return success;
    }

	public static void main(String argv[]) throws Exception {

        // /* DSLab */
        // // LSimLogger.setLoggerAsLocalLogger("compiladors--PAC1", "./logs/", true);
        // LSimLogger.log(Level.INFO, "main -- inici");

        if (argv.length != 2) {
            System.err.println("[Arguments Error] Incorrect arguments. Usage:");
            System.err.println("                      Eval <MODE> <TESTCASE>");
            System.err.println("                  MODE = \"run\" or \"evaluate\".");
            System.err.println("                  TESTCASE = input filename without file extension");
            // /* DSLab */
            // LSimLogger.log(Level.ERROR, "[Arguments Error] Incorrect arguments");
            System.exit(1);
        }
        String mode = argv[0];
        if (!mode.equals("run") && !mode.equals("evaluate") && !mode.equals("generate")) {
            String error = "[Arguments Error] The first parameter must be either \"run\" or \"evaluate\".";
            System.err.println(error);
            // /* DSLab */
            // LSimLogger.log(Level.ERROR, error);
            System.exit(1);
        } else {
            String caseName = argv[1];
            String filePath = caseName + "." + LANGUAGE_EXTENSION;
            FileInputStream sourceCodeInputStream = null; // input file
            try {
                sourceCodeInputStream = new FileInputStream(filePath);
            } catch (FileNotFoundException e) {
                System.out.println(filePath + ": Unable to open file");
                // /* DSLab */
                // LSimLogger.log(Level.ERROR, filePath + ": Unable to open file");
                return;
            }

            if (mode.equals("generate")) {
                eval.generateTestCase = true;
            }

            // Read input file
            Lexer lex = new Lexer(sourceCodeInputStream);
            Parser analyzer = new Parser(lex);
            analyzer.initParser();
            try {
              analyzer.parse();
            } catch (Exception e) {
                // /* DSLab */
                // LSimLogger.log(Level.ERROR, "[Parse error]: line " + lex.getLine() + ": token '" + lex.lastToken() );
                throw new RuntimeException("Line " + lex.getLine() + ": token '" + lex.lastToken() + "' - " + e.toString());
            }
            analyzer.endParser();


            if (mode.equals("evaluate")) {
                success = evaluateTestCase(caseName + "." + TESTCASE_EXTENSION);
            }
        }
	}

    private static List<String> parseTestCase(String path) throws java.io.IOException {
        BufferedReader reader;
        List<String> testCaseResult = new LinkedList<String>();
        try {
            // Read test case results from file
            reader = new BufferedReader(new FileReader(path));
            String line = reader.readLine();
            while (line != null) {
                if (!line.isEmpty()) {
                    testCaseResult.add(line);
                }
                line = reader.readLine();
            }
            reader.close();
        } catch (IOException e) {
            System.err.println("There was an unexpected error when reading the test case at " + path);
            System.err.println("--------------------------------\n");
            // /* DSLab */
            // LSimLogger.log(Level.ERROR, path + ": Error reading test case");
            throw e;
        }
        return testCaseResult;
    }

    private static boolean evaluateTestCase(String path) throws java.io.IOException {
        
        List<String> testCaseResult = parseTestCase(path);

        String expectedResult = testCaseResult.toString();
        String actualResult = eval.buffer.toString();
        
        if (expectedResult.equals(actualResult)) {
            System.out.println("[Evaluation] Success!");
            return true;
        } else {
            System.out.println("[Evaluation] Your analyzer does not match the expected output. ");
            System.out.println("[Evaluation] ... your analyzer reported the following declaration sequence: " +
                            actualResult);
            System.out.println("[Evaluation] ... but it was expected to encounter the following declarations: " +
                            expectedResult);
            return false;
        }
        
    }

	private static void emit(String str) {
		if (eval.generateTestCase) {
			System.out.println(str);
		}
        eval.buffer.add(str);
	}

    public static void emitDuplicateEnemyError(String name) {
        emit("DUPL_ENEMY$" + name);
    }

    public static void emitDuplicateVarError(String name) {
        emit("DUPL_VAR$" + name);
    }

    public static void emitDuplicateStateError(String name) {
        emit("DUPL_STATE$" + name);
    }

    public static void emitDuplicateActionError(String name) {
        emit("DUPL_ACTION$" + name);
    }

    public static void emitUndeclaredVarError(String name) {
        emit("UNDECLARED_VAR$" + name);
    }

    public static void emitUndeclaredStateError(String name) {
        emit("UNDECLARED_STATE$" + name);
    }

    public static void emitUndeclaredActionError(String name) {
        emit("UNDECLARED_ACTION$" + name);
    }

    public static void emitForbiddenNameError(String name) {
        emit("FORBIDDEN$" + name);
    }
    
    public static void emitTypeError(Eval.Type expected, Eval.Type found) {
        emit("TYPE_ERROR$" + expected + "--" + found);
    }

}