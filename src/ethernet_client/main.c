#include <stdio.h>
#include <stdlib.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include "lodepng.h"

#define SMALL_REPLY 100
#define SMALL_MSG 50
#define BUF_SIZE 1400
#define CHANNELS 4
#define MAX_FILENAME 100

#define FILE_SIZE 3686400
#define MAX_MESSAGE_SIZE 4000000

#define MIN(X, Y) (((X) < (Y)) ? (X) : (Y))

int EthernetConnect(SOCKET*);
int loadpng(char**, unsigned*, unsigned*, const char*);
int dumppng(char*, unsigned, unsigned, const char*);
int write_image(SOCKET, char*, unsigned);
int read_image(SOCKET, char*, unsigned);
int open_image(SOCKET, char);
int open_message(SOCKET, char);
int begin_encode(SOCKET, char, char, char);
int begin_decode(SOCKET, char, char);
int check_done_encoding(SOCKET);
int check_done_decoding(SOCKET);
//unsigned format_message(unsigned char*,unsigned);

char stego_image[FILE_SIZE];
char blank_image[FILE_SIZE];
 char message[MAX_MESSAGE_SIZE];
int main(int argc, char** argv)
{
    char* cover_image = 0;


    int i;
    unsigned width = 0, height = 0, message_size = 0;
    char input_filename[MAX_FILENAME] = "./in_incrementing.png";
    char output_filename[MAX_FILENAME] = "./out_incrementing.png";
    char in_message_filename[MAX_FILENAME] = "./in_message.txt";
    char out_message_filename[MAX_FILENAME] = "./out_message.txt";

 /*   FILE* message_file = fopen(out_message_filename, "r");
    message_size = fread(message,sizeof(char), MAX_MESSAGE_SIZE - 1, message_file);
    message_size = format_message(message, message_size);
/**/
    SOCKET s;

    memset(blank_image,0,FILE_SIZE);

    if(EthernetConnect(&s) != 0) return -1;

    for(i = 1; i < argc; i++){  //read instructions from command line arguments
        if(strncmp(argv[i], "write_png:", 10) == 0){
             if(loadpng(&cover_image,&width,&height,input_filename) != 0) return -1;
             if(open_image(s, argv[i][10]) != 0) return -1;
             if(write_image(s, cover_image,FILE_SIZE) != 0) return -1;

        }
        else if(strncmp(argv[i], "read_png:", 9) == 0){
            if(open_image(s, argv[i][9]) != 0) return -1;
            if(read_image(s, stego_image, FILE_SIZE) != 0) return -1;
            if(dumppng(stego_image,width,height,output_filename)) return -1;
        }
        else if(strncmp(argv[i], "clear_png:",10) == 0){
             if(open_image(s, argv[i][10]) != 0) return -1;
             if(write_image(s, blank_image,FILE_SIZE) != 0) return -1;
        }
        else if(strncmp(argv[i], "write_txt:", 10) == 0){
             FILE* message_file = fopen(in_message_filename, "r");
             if(!message_file){
                printf("Could not open message input file\n");
                return -1;
             }
             message_size = fread(message,sizeof(char), MAX_MESSAGE_SIZE, message_file);

             printf("%d bytes of message file were read\n",message_size);
             if(open_message(s, argv[i][10]) != 0) return -1;
             if(write_image(s, message,message_size) != 0) return -1;
             fclose(message_file);
        }
        else if(strncmp(argv[i], "read_txt:", 9) == 0){
             FILE* message_file = fopen(out_message_filename, "w");
             if(!message_file){
                printf("Could not open message output file\n");
                return -1;
             }
             if(open_message(s, argv[i][9]) != 0) return -1;
             if(read_image(s, message, message_size) != 0) return -1;
             //message_size = format_message((unsigned char*) message, message_size);
             if(fwrite(message,sizeof(char), message_size, message_file) != message_size){
                printf("Error: could not write whole message to file\n");
             }
             fclose(message_file);
        }
        else if(strncmp(argv[i], "set_msg_size:", 13) == 0){
            message_size = strtol(&argv[i][13], NULL, 10);
            if(message_size == 0) {
                printf("Error: Invalid message size\n");
            }
        }
        else if(strncmp(argv[i], "begin_encode:", 13) == 0){
            if(begin_encode(s,argv[i][14],argv[i][15],argv[i][13]) != 0){
                printf("Error: Could not begin encoding\n");
                return -1;
            }
        }
        else if(strncmp(argv[i], "begin_decode:", 13) == 0){
            if(begin_decode(s,argv[i][14],argv[i][13]) != 0){
                printf("Error: Could not begin encoding\n");
                return -1;
            }
        }
        else if(strncmp(argv[i], "check_encode", 11) == 0){
            if(check_done_encoding(s) != 0){
                printf("Error: Could not check done encoding bit\n");
                return -1;
            }
        }
        else if(strncmp(argv[i], "check_decode", 11) == 0){
            if(check_done_decoding(s) != 0){
                printf("Error: Could not check done decoding bit\n");
                return -1;
            }
        }
        else if(strncmp(argv[i], "set_input:", 10) == 0){
            strcpy(input_filename, &argv[i][10]);
            printf("Input file is now: %s\n", input_filename);
        }
        else if(strncmp(argv[i], "set_output:", 11) == 0){
            strcpy(output_filename, &argv[i][11]);
            printf("Output file is now: %s\n", output_filename);
        }
        else if(strncmp(argv[i], "set_in_message:", 15) == 0){
            strcpy(in_message_filename, &argv[i][15]);
            printf("Input message file is now: %s\n", in_message_filename);
        }
        else if(strncmp(argv[i], "set_out_message:", 16) == 0){
            strcpy(out_message_filename, &argv[i][16]);
            printf("Output message file is now: %s\n", out_message_filename);
        }
        else if(strncmp(argv[i], "wait", 4) == 0){
            system("pause");
        }
        else{
            printf("Invalid Argument\n");
        }
    }

    closesocket(s);
    WSACleanup();/**/
    return 0;
}

int EthernetConnect(SOCKET* s)
{
    WSADATA wsa;
    struct sockaddr_in server;

    printf("\nInitialising Winsock...");
    if (WSAStartup(MAKEWORD(2,2),&wsa) != 0)
    {
        printf("Failed. Error Code : %d",WSAGetLastError());
        return -1;
    }

    printf("Initialised.\n");

    //Create a socket
    if((*s = socket(AF_INET , SOCK_STREAM , 0 )) == INVALID_SOCKET)
    {
        printf("Could not create socket : %d" , WSAGetLastError());
        return -1;
    }

    printf("Socket created.\n");


    server.sin_addr.s_addr = inet_addr("192.168.1.10");
    server.sin_family = AF_INET;
    server.sin_port = htons(7);

    //Connect to remote server
    if (connect(*s , (struct sockaddr *)&server , sizeof(server)) < 0)
    {
        printf("connect error");
        return -1;
    }

    printf("Connected\n\n");

    return 0;
}
int loadpng(char** image, unsigned* width, unsigned* height, const char* filename){
    unsigned error = lodepng_decode32_file((unsigned char**) image, width, height,filename);
    if(error) {
        printf("error %u: %s\n", error, lodepng_error_text(error));
        return -1;
    }
    return 0;
}
int dumppng(char* image, unsigned width, unsigned height, const char* filename){
    unsigned error = lodepng_encode32_file(filename, (unsigned char*) image, width, height);
    if(error) {
        printf("error %u: %s\n", error, lodepng_error_text(error));
        return -1;
    }
    return 0;
}
int write_image(SOCKET s, char* image, unsigned file_size){
    char reply[SMALL_REPLY];
    unsigned send_len, recv_size, total_sent = 0;

    while(total_sent < file_size){
        if((send_len = send(s , &image[total_sent] , MIN(file_size - total_sent, BUF_SIZE)  , 0)) < 0)
        {
            printf("Send failed");
            return -1;
        }
        total_sent += send_len;

        if((recv_size = recv(s , reply , SMALL_REPLY , 0)) == SOCKET_ERROR)
        {
            printf("recv failed\n");
            return -1;
        }
    }
    printf("%d bytes written\n", total_sent);
    return 0;

}
int read_image(SOCKET s, char* image, unsigned file_size){
    unsigned recv_size, total_recvd = 0;

    char buffer[BUF_SIZE];
    while (total_recvd < file_size){

        if(send(s , "ReadFile\x0" , SMALL_MSG, 0) < 0)
        {
            printf("Send failed");
            return -1;
        }

        if((recv_size = recv(s , buffer ,  BUF_SIZE , 0)) == SOCKET_ERROR)
        {
            printf("recv failed\n");
        }
        memcpy(&image[total_recvd],buffer,MIN(file_size - total_recvd, recv_size));
        total_recvd += recv_size;
    }
    printf("%d bytes read\n", total_recvd);

    return 0;

}

int open_image(SOCKET s, char location)
{
    char open_msg[SMALL_MSG] = "Open Image ";
    char reply[SMALL_REPLY];
    int recv_size, len = strlen(open_msg);

    open_msg[len] = location;
    open_msg[len+1] = 0;

    if(send(s,open_msg, SMALL_MSG, 0) <= 0)
    {
        printf("Opening Send failed");
        return -1;
    }
    if((recv_size = recv(s , reply , SMALL_REPLY , 0)) == SOCKET_ERROR)
    {
        printf("Opening recv failed\n");
        return -1;
    }
    reply[recv_size] = 0;
    printf("%s\n", reply);
    return 0;
}
int open_message(SOCKET s, char location)
{
    char open_msg[SMALL_MSG] = "Open Message ";
    char reply[SMALL_REPLY];
    int recv_size, len = strlen(open_msg);

    open_msg[len] = location;
    open_msg[len+1] = 0;

    if(send(s,open_msg, SMALL_MSG, 0) <= 0)
    {
        printf("Opening Send failed");
        return -1;
    }
    if((recv_size = recv(s , reply , SMALL_REPLY , 0)) == SOCKET_ERROR)
    {
        printf("Opening recv failed\n");
        return -1;
    }
    reply[recv_size] = 0;
    printf("%s\n", reply);
    return 0;
}
int begin_encode(SOCKET s, char cover_location, char stego_location, char message_location)
{
    #define N_MSG 4
    char reply[SMALL_REPLY];
    char msgs[N_MSG][SMALL_MSG] = {"set_cover X", "set_stego X", "set_message X", "begin encoding\x0"};
    int i, recv_size;

    msgs[0][10] = cover_location;
    msgs[1][10] = stego_location;
    msgs[2][12] = message_location;

    for(i = 0; i < N_MSG; i++){
        if(send(s,msgs[i], SMALL_MSG, 0) <= 0)
        {
            printf("Begin Send failed\n");
            return -1;
        }
        if((recv_size = recv(s , reply , SMALL_REPLY , 0)) == SOCKET_ERROR)
        {
            printf("Begin recv failed\n");
            return -1;
        }
        reply[recv_size] = 0;
        printf("%s\n", reply);
    }
    return 0;
    #undef N_MSG

}
int begin_decode(SOCKET s, char stego_location, char message_location)
{
    char reply[SMALL_REPLY];
    char msgs[3][SMALL_MSG] = {"set_decoder_stego X", "set_decoder_message X", "begin decoding\x0"};
    int i, recv_size;

    msgs[0][18] = stego_location;
    msgs[1][20] = message_location;

    for(i = 0; i < 3; i++){
        if(send(s,msgs[i], SMALL_MSG, 0) <= 0)
        {
            printf("Begin Send failed\n");
            return -1;
        }
        if((recv_size = recv(s , reply , SMALL_REPLY , 0)) == SOCKET_ERROR)
        {
            printf("Begin recv failed\n");
            return -1;
        }
        reply[recv_size] = 0;
        printf("%s\n", reply);
    }
    return 0;

}
int check_done_encoding(SOCKET s)
{
    char reply[SMALL_REPLY];
    int recv_size;

    if(send(s,"check done encoding", SMALL_MSG, 0) <= 0)
    {
        printf("Check done send failed\n");
        return -1;
    }
    if((recv_size = recv(s , reply , SMALL_REPLY , 0)) == SOCKET_ERROR)
    {
        printf("Check done recv failed\n");
        return -1;
    }
    reply[recv_size] = 0;
    printf("%s\n", reply);
    return 0;
}
int check_done_decoding(SOCKET s)
{
    char reply[SMALL_REPLY];
    int recv_size;

    if(send(s,"check done decoding", SMALL_MSG, 0) <= 0)
    {
        printf("Check done send failed\n");
        return -1;
    }
    if((recv_size = recv(s , reply , SMALL_REPLY , 0)) == SOCKET_ERROR)
    {
        printf("Check done recv failed\n");
        return -1;
    }
    reply[recv_size] = 0;
    printf("%s\n", reply);
    return 0;
}
/*unsigned format_message(unsigned char* message, unsigned message_size)
{
    #define NUM_BYTES_SKIP 0
    #define NUM_BITS_SHIFT 1
    message_size -= NUM_BYTES_SKIP;
    memmove(message, &message[NUM_BYTES_SKIP], message_size);

    //static unsigned char flip_table[256] = {0};
   // static int table_filled = 0;
    //int c;
//    int i;

    if(!table_filled){
        for(c = 0; c < 256; c++){
            for(i = 0; i < 8; i++){
                flip_table[c] += (7 - 2*i) > 0 ? (c & (1 << i)) << (7 - 2*i) : (c & (1 << i)) >> (2*i - 7);
            }
        }
        table_filled = 1;
    }
    for(i = 0; i < message_size; i++)
        message[i] = flip_table[(unsigned) message[i]];

   // for(i = 0; i < message_size - 1; i++)
     //   message[i] = (message[i] >> NUM_BITS_SHIFT) + ((message[i+1] & ((1 << NUM_BITS_SHIFT) - 1)) << (8 - NUM_BITS_SHIFT));

 //   message[message_size] = message[message_size] >> NUM_BITS_SHIFT;

    return message_size;

    #undef NUM_BYTES_SKIP
    #undef NUM_BITS_SHIFT

}*/
