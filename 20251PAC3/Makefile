JAVA = java
JAVAC = javac
CLASSPATH = .:/Users/robertclariso/Documents/code/:/Users/robertclariso/Documents/code/CUP/java_cup_v10k

.SUFFIXES: .java .class
.java.class:
	$(JAVAC) -classpath $(CLASSPATH) $*.java

CLASSES = sym.java Lexer.java Eval.java Parser.java

default: evaluate

classes: $(CLASSES:.java=.class)

Lexer.java: Lexer.lex
	$(JAVA) -classpath $(CLASSPATH) JLex.Main Lexer.lex
	mv Lexer.lex.java Lexer.java

Parser.java sym.java: Parser.cup
	$(JAVA) -classpath $(CLASSPATH) java_cup.Main -parser Parser Parser.cup

run: classes
	$(JAVA) -classpath $(CLASSPATH) Eval run TestCases/Program

generate: classes
	$(JAVA) -classpath $(CLASSPATH) Eval generate TestCases/Enemy > TestCases/Enemy.test
	$(JAVA) -classpath $(CLASSPATH) Eval generate TestCases/Variable > TestCases/Variable.test
	$(JAVA) -classpath $(CLASSPATH) Eval generate TestCases/StateAction > TestCases/StateAction.test
	$(JAVA) -classpath $(CLASSPATH) Eval generate TestCases/Boolean > TestCases/Boolean.test
	$(JAVA) -classpath $(CLASSPATH) Eval generate TestCases/Expression > TestCases/Expression.test
	$(JAVA) -classpath $(CLASSPATH) Eval generate TestCases/Everything > TestCases/Everything.test

evaluate: classes
	$(JAVA) -classpath $(CLASSPATH) Eval evaluate TestCases/Enemy 
	$(JAVA) -classpath $(CLASSPATH) Eval evaluate TestCases/Variable
	$(JAVA) -classpath $(CLASSPATH) Eval evaluate TestCases/StateAction
	$(JAVA) -classpath $(CLASSPATH) Eval evaluate TestCases/Boolean
	$(JAVA) -classpath $(CLASSPATH) Eval evaluate TestCases/Expression 
	$(JAVA) -classpath $(CLASSPATH) Eval evaluate TestCases/Everything

clean:
	rm -f *.class Lexer.java Parser.java sym.java
