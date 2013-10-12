
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

%%
%class Scanner 
%unicode
%standalone
%type String 

%init{
      this.tokensList = new ArrayList();   
%init}


%{

private ArrayList tokensList; 

private void writeOutputFile() throws IOException {/* metodo usado para guardar los tokens correctos*/
	String filename = "salida.out";
	BufferedWriter out = new BufferedWriter(new FileWriter(filename));
	for (Object s:this.tokensList) {
		System.out.println(s);
		out.write(s + "\n");
	}
	out.close();
}

%}
/*Aca definimos las macros que corresponderan a los tokens validos identificados*/ 

Identifier= [a-zA-Z][a-zA-Z0-9_"",()]* /* Macro para definiciones */


%%
{Identifier}+"("{Identifier}*+")"+"."    {this.tokensList.add(yytext());}
{Identifier}+{Identifier}*":""-"{Identifier}+{Identifier}*","*"."   {this.tokensList.add(yytext());}
"write"+"("{Identifier}+")"   {this.tokensList.add(yytext());}
"nl" {this.tokensList.add(yytext());}
"fail" {this.tokensList.add(yytext());}
/* validando tokens*/


\r|\n|\r\n|\u2028|\u2029|\u000B|\u000C|\u0085 {}           
<<EOF>>       {this.writeOutputFile(); System.exit(0);}  

      
