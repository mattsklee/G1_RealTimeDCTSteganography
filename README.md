# G1_RealTimeDCTSteganography

Implementation of fast steganographic encoder and decoder in Nexys4 DDR and Nexys Video Boards. Design includes PC to DRAM interface through Ethernet and DRAM to encoder/decoder communication through AXI interface logic. A sample video implementation is also included to illustrate the real time capability of the encoder.

How to use?
-----------
Once the product is running on an FPGA, it can be controlled by sending commands to it via Ethernet. Any permutation of the following commands can be sent to the product by including them in as command line argument given to the Ethernet Client executable.  

- set_input:<path>
Set the path for any PNG image file that will be sent to the server
- set_output:<path>
Set the path for any PNG image that will be received from the server
- set_in_message:<path>
Set the path for any text that will be sent to the server
- set_out_message:<path>
Set the path for any PNG image that will be received from the server
- write_png:<location>
Load a PNG image from the specified path on the local machine
Tell the server to open the file at location <location> as an image
Write the loaded PNG file to the server
- read_png:<location>
Tell the server to open the file at <location> as an image
Send Read commands to the server until enough data is received to fill a 720p 32-bit colour depth image
- clear_png:<location>
Tell the server to open the file at <location> as an image
Overwrite this entire file with zeros
- write_txt:<location>
Load a text image from the specified path on the local machine
Tell the server to open the file at <location> as a message
Write the entire text file to the server
Store the size of this file
- set_msg_size:<number>
Set the size of the message file
- read_txt:<location>
Tell the server to open the file at <location> as a message
Send Read commands to the server until the whole message is received
The size of the message file must be known in advance through  either a previous write_txt or  set_msg_size command.
- begin_encode:<location 1><location 2><location 3>
Tell the encoder block to use the file at location 1 as its message
Tell the encoder block to use the file at location 2 as its cover image
Tell the encoder block to write its stego image at location 3
Tell the encoder block to begin encoding
- begin_decode:<location 1><location 2>
Tell the decoder write the message it finds at location 1
Tell the decoder block to use the file at location 2 as its stego image
Tell the decoder block to begin encoding
- check_encode
Check if the encoder has finished parsing an image
- check_decode
Check if the encoder has finished parsing an image
- wait
Wait for the user to press a key before proceeding to the next argument
For example, an image can be encoded and then decoded with the following sequence of command line arguments.
 EthernetClient2.exe set_input:./images/pier.png set_output:./images/pier_out.png set_out_message:./messages/out_pier.txt set_in_message:./verne.txt  write_txt:A write_png:B begin_encode:ABC check_encode check_encode wait set_msg_size:10000 begin_decode:DC check_decode check_decode read_txt:D

Repository Structure
--------------------
Root:.
¦   README.md
¦   
+---docs
¦       presentation.pptx
¦       report.pdf
¦       
+---src
    +---ips
    ¦   +---decoder_ip_prj
    ¦   +---encdec_sim_prj
    ¦   +---encoder_ip_prj
    ¦   +---stream_encoder_ip_prj
    ¦
    +---ethernet_client
    ¦       
    +---project_archives
            nexys4_ddr_encdec_prj.xpr.zip
            nexys_video_stream_enc_prj.xpr.zip

Authors
-------
Matthew Lee, Thomas Sattolo, George Shehata 


Acknowledgements
----------------
The authors would like to thank Michal Krepa and Emrah Yuce for the use of their DCT core provided through OpenCores. The core can be found at http://opencores.org/project,mdct . Additionally, we would like to thank Digilent for the use of their example designs including hdmi and echoserver. 