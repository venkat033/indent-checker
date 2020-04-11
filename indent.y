%{

#include<stdio.h>
#include<stdlib.h>
int stack[100];	// stack for each new indent tab space
int tab[100];
int arr[100];
int i=1;
int top=-1;
int flower_flag=0;
int if_flag=0;	
int flower[100]; // stack for bracket 
int ftop=-1;	// flower top



//int block[100];
//int btop=-1;

void A1();
void A2();
void A3();
int yylex();
int yyerror();
%}

%token FOR PRINT NUM ID RANGE TAB START END IF ELSEIF ELSE

%%


S	: START ST END { printf("valid"); }
	;


ST	: ST ST
	| TAB { A2(); } SEMI
	| ST2
	| ST3
	;

		
ST2	: TAB FOR '(' E ';' E ';' E ')' '{'{ flower_flag=1; A1(); } BODY 				// for loop
	| TAB FOR ' ' ID ' ' RANGE '(' E ')' ':'{ flower_flag=0; A1(); } BODY 	
	;

ST3	: TAB IF ' ' E ':' { flower_flag=0;A1();} BODY							// if 
	| TAB IF '(' E ')' '{'{ flower_flag=1; A1(); } BODY 
	;


												

BODY	: BODY BODY
	| ST2
	| ST3
	| TAB { A2(); } SEMI
	| TAB{ A3(); } '}'
	;



SEMI	: E ';'
	| E
	;


E	: E '=''=' E 
	| E '=' E
	| E '+' E
	| E '-' E
	| E '*' E
	| E '/' E
	| E '<' E
	| E '>' E
	| E '<''=' E
	| E '>''=' E
	| E '-''-' 
	| E '+''+'
	| ID
	| NUM
	;

%%
//#include "lex.yy.c"
//#include "y.tab.h"

void A1(){
		arr[i]=2;	// 2 -> for
		int val=yylval;
		tab[i]=val;

		
		
		
		
		if(i==1){  // add && !flower_flag
			stack[++top]=val;
			if(flower_flag){
				flower[++ftop]=val;
			}		// python for when line = 1
		}
			
			// push if tab is greater than previous tab value
		if(i!=1){
			if(val>stack[top]){
				// if prev is E -> cannot push
				if(arr[i-1]==2){
						stack[++top]=val;
						if(flower_flag)
							flower[++ftop]=val;				
				}
				else{
					printf("invalid indent 1");
				}
			}
			else if(val<stack[top]){
				// pop the stack till top of stack matches with current tab value
				int k,found=0;
				for(k=0;k<=ftop;k++){
					if(val==flower[k])
						found=1;
				}
				if(found==1){
					printf("invalid indent 2");
				}
				else{
				while(val != stack[top]){
					if(stack[top]>val){
							top--;		
					}
					if(stack[top]<val){
						printf("invalid indent 3\n");
						exit(0);	// the indent must match with previous indent 
					}
								
				}
				if(flower_flag){
					flower[++ftop]=val;
				}
				}
			}
			else{
				
					if(arr[i-1]==2){ 
						printf("invalid indent 4");
					}
					else{
						
						if(flower_flag){
							flower[++ftop]=val;
						}
					}
			}

			
			
		}
		
		i++;

}
void A2(){
		arr[i]=1;	// 1 -> E
		
		int val=yylval;
		tab[i]=val;
	
		if(val>stack[top]){
			// check  prev statement. if prev is for -> then push . if prev is E we cannot push	
			if(arr[i-1]==2 || i==1){
				stack[++top]=val;
			}
			else{
				printf("invalid indent 5");  
			}
			
		}
		else if(val<stack[top]){
			// pop the stack till top of stack matches with current tab value
				if(arr[i-1]==2){
					printf("invalid indent");
					
				}
				
			int k,found=0;
			for(k=0;k<=ftop;k++){
				if(val==flower[k])
					found=1;			
			}
			if(found==1){
				printf("invalid indent 6");
			}
			else{
		
				while(val != stack[top]){
					if(stack[top]>val){
						top--;		
					}
					if(stack[top]<val){
						printf("invalid indent 7\n");
						exit(0);	// the indent must always match with previous indentation
					}
									
				}
			}
			
		}
		else {

				if(arr[i-1]==2){
					printf("invalid indent 8");
					
				}
		}
		
		
		i++;

}

void A3(){
	arr[i]=3;

	int val=yylval;
	tab[i]=val;
	
	// closing bracket must match with for's indent value
	if(val==stack[top]){
		printf("invalid indent 9");
	}
	else if(val>stack[top]){
		printf("invalid indent 10");
	}
	else{
		
		
		int temp=flower[ftop];
			
		if(val != temp){
			printf("invalid indent 11");
		}
		if(val==temp){
			ftop--;
			while(stack[top]!=temp){
				top--;
			}
		}
		
	}
	
	i++;
	

}



int main(){

stack[++top]=0;
printf("input :\n");
yyparse();

//printing the stack values and tab values of each line
/*
int k;
for(k=1;k<i;k++){
	printf("\n%d ->  %d , %d",k,arr[k],tab[k]);
}


printf("\nstack :");
for(k=0;k<=top;k++){
	printf("%d\t",stack[k]);
}
printf("\nflower stack:");
for(k=0;k<=ftop;k++){
	printf("%d\t",flower[k]);
}
*/
/*
printf("\nblock stack:");
for(k=0;k<=btop;k++){
	printf("%d\t",block[k]);
}
*/
return 0;
}
int yyerror(){

printf("invalid from yyerror");
}
