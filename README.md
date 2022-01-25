# FPGA_intership_code


开发环境：Modelsim， 时钟为5ps  
开发语言：VHDL  


-----------------------------------------answer code ---------------------------------------------  
pipeline1.vhd : 1) 实现上述总线同步握手场景，不考虑异步场景；  
pipeline2.vhd : 2) 假定master的valid信号不满足时序要求，要对valid信号用寄存器打一拍，实现该总线握手场景；  
pipeline3.vhd : 3) 假定slave的ready信号不满足时序要求，要对ready信号用寄存器打一拍，实现该总线握手场景；  
pipeline4.vhd : 4) 假定valid和ready信号都不满足时序要求，都需要用寄存器打一拍，实现该总线握手场景;   

-----------------------------------------test bench ------------------------------------------  
pipeline1.vhd : pip1_tb.vhd  
pipeline2.vhd : pip2_tb.vhd  
pipeline3.vhd : pip3_tb.vhd  
pipeline4.vhd : pip4_tb.vhd  


----------------------------------------------wave image-------------------------------------------  
pip1_tb_wave.png  
pip2_tb_wave.png  
pip3_tb_wave.png  
pip4_tb_wave.png  


------------------------------------- 对于仿真要求的一些解释----------------------------------------------
5) 仿真要求体现高性能传输无气泡、逐级反压、传输不丢数据。  
高性能传输气泡：在master发送数据后，数据可以在pipeline的寄存器中保存，而不是master的数据输出端口一直保持数据不变  
逐级反压：在master的valid信号拉高，准备发送data值时，如果slave的ready信号保持低位，则需要master持续拉高valid信号并保持数据输出端口数据不变  



