import java.io.*;
import java.lang.*;
import java_cup.runtime.Symbol;


%%

%{
   public int getLine() {
      return yyline;
   }
  
   public String lastToken() {
      return yytext();
   }
%}

%{
    // --- COMPILERS -- UNIVERSITAT OBERTA DE CATALUNYA
    // --- Activity 1 - Lexical analysis
    //
    // STUDENT FULL NAME:
    // UOC USERNAME:
    // COURSE INSTRUCTOR:

    // Add any attributes to the lexer (if you need them) here


    // Add any code that you would like to execute before the lexer begins
    // Here you can initialize any variables you require
    // There is no need to modify this funcion if you don't need it!
    public static void initLex() {

    }

    // Add any code that you would like to execute after the lexer ends
    // There is no need to modify this function if you don't need it!
    public static void endLex() {
    

    }

%}

%class Lexer
%full
%line
%cup

COMMENT            = \#.*

IDENTIFIER         = [a-zA-Z_][0-9a-zA-Z_]*

INT_LITERAL        = [0-9][0-9]*
FLOAT_LITERAL      = [0-9][0-9]*\.[0-9]*
WRONG_FLOAT        = \.[0-9]+
STRING_LITERAL     = \"[^\"]*\"
PERCENT_LITERAL    = ("100"|[0-9]|[1-9][0-9])\%

EOL                = [\r\n]
SPACE              = [ \t]

%%

{COMMENT}          { /* Ignore comments */ }

BOSS               { return new Symbol( sym.BOSS ); }
DATA               { return new Symbol( sym.DATA ); }
STATE              { return new Symbol( sym.STATE ); }
ACTION             { return new Symbol( sym.ACTION ); }
GOTO               { return new Symbol( sym.GOTO ); }
CHANCE             { return new Symbol( sym.CHANCE ); }
IF                 { return new Symbol( sym.IF ); }

true               { return new Symbol( sym.TRUE ); }
false              { return new Symbol( sym.FALSE ); }

"="                { return new Symbol( sym.EQUALS ); }
"!="               { return new Symbol( sym.NOT_EQUALS ); }
"<"                { return new Symbol( sym.LESS_THAN ); }
">"                { return new Symbol( sym.MORE_THAN ); }
"<="               { return new Symbol( sym.LESS_EQ_THAN ); }
">="               { return new Symbol( sym.MORE_EQ_THAN ); }
"+"                { return new Symbol( sym.SUM ); }
"-"                { return new Symbol( sym.MINUS ); }
"*"                { return new Symbol( sym.TIMES ); }
"/"                { return new Symbol( sym.DIV ); }
"AND"              { return new Symbol( sym.AND ); }
"OR"               { return new Symbol( sym.OR ); }
"NOT"              { return new Symbol( sym.NOT ); }

{IDENTIFIER}       { return new Symbol( sym.IDENT, yytext() ); }

"{"                { return new Symbol( sym.OPEN_KEY ); }
"}"                { return new Symbol( sym.CLOSE_KEY ); }
"("                { return new Symbol( sym.OPEN_PAREN ); }
")"                { return new Symbol( sym.CLOSE_PAREN ); }
","                { return new Symbol( sym.COMMA ); } 
";"                { return new Symbol( sym.SEMICOLON ); }
"->"               { return new Symbol( sym.ARROW ); }

{INT_LITERAL}      { int value = 0;
                     try {
                       value = Integer.parseInt( yytext() );
                     } catch (Exception e) {
                       throw new RuntimeException("Error parsing integer constant: " + e.toString());
                     }
                     return new Symbol( sym.INT_LITERAL, Integer.valueOf(value) ); }

{PERCENT_LITERAL}  { int value = 0;
                     try {
                       String aux = yytext(); 
                       String str = aux.substring( 0, aux.length() - 1);
                       value = Integer.parseInt( str );
                     } catch (Exception e) {
                       throw new RuntimeException("Error parsing percent constant: " + e.toString());
                     }
                     return new Symbol( sym.PERCENT_LITERAL, Integer.valueOf(value) ); }

{FLOAT_LITERAL}    { double value = 0.0;
                     try {
                       value = Double.parseDouble( yytext() );
                     } catch (Exception e) {
                       throw new RuntimeException("Error parsing float constant: " + e.toString());
                     }
                     return new Symbol( sym.FLOAT_LITERAL, Double.valueOf(value) ); }

{WRONG_FLOAT}      { /* Do nothing */ }

{STRING_LITERAL}   { return new Symbol( sym.STRING_LITERAL, yytext() ); }

{EOL}              { /* Ignore new lines */ }
{SPACE}            { /* Ignore spaces */ }

.                  { throw new RuntimeException("Lexical error: "+ yytext() ); }
