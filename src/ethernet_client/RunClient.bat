EthernetClient2.exe set_input:./images/pier.png set_output:./images/pier_out.png set_out_message:./messages/out_pier.txt set_in_message:./verne.txt  write_txt:A write_png:B begin_encode:ABC check_encode check_encode wait set_msg_size:10000 begin_decode:DC check_decode check_decode read_txt:D