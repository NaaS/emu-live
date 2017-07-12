# emu


## Install  
#### SUME
The installation process will create a project named **reference_emu** under the `NetFPGA-SUME-live/projects/` directory.   

1. ```git clone https://github.com/NetFPGA/NetFPGA-SUME-live.git```  
2. ```git clone https://github.com/NaaS/emu.git```
3. ```source [path_to]/NetFPGA-SUME-live/tools/settings.sh```  
4. ```cd [path_to]/emu/kiwi_src/```   
5. ```make install_sume```  

The `source NetFPGA-SUME-live/tools/settings.sh`(step 3) will export the enviroment variables for the `NetFPGA-SUME-live/` directory.   
Make sure that you have modify the **settings.sh** with the correct paths to that directory.   
ex. `$SUME_FOLDER = [path_to]/NetFPGA-SUME-live`   
To make sure that all the variables have been set up correctly, try:   
`source [path_to]/NetFPGA-SUME-live/tools/settings.sh`    
`echo $SUME_FOLDER`    
`echo $NF_DESIGN_DIR`   

The `make install_sume`(step 5) command will copy the `emu/netfpga_src/NetFPGA-SUME/lib/` and `emu/netfpga_src/NetFPGA-SUME/project/` into the 
`NetFPGA-SUME-live` directory. This step will create all the dependencies needed for the project.  
    
    
#### 1G-CML
The installation process will create a project named **reference_emu_nf1_cml** under the `NetFPGA-1G-CML-live/projects/` directory.   
   
1. ```git clone https://github.com/NetFPGA/NetFPGA-1G-CML-live.git```  
2. ```git clone https://github.com/NaaS/emu.git```
3. ```source [path_to]/NetFPGA-1G-CML-live/bashrc_addon_NetFPGA_10G```  
4. ```cd [path_to]/emu/kiwi_src/```   
5. ```make install_cml```  

The `[path_to]/NetFPGA-1G-CML-live/bashrc_addon_NetFPGA_10G`(step 3) will export the enviroment variables for the `NetFPGA-1G-CML-live/` directory.   
Make sure that you have modify the **bashrc_addon_NetFPGA_10G** with the correct paths to that directory.   
ex. `$NF_ROOT = [path_to]/NetFPGA-1G-CML-live`   
To make sure that all the variables have been set up correctly, try:    
`source [path_to]/NetFPGA-1G-CML-live/bashrc_addon_NetFPGA_10G`   
`echo $NF_ROOT`    
`echo $NF_DESIGN_DIR`   

The `make install_cml`(step 5) command will copy the `emu/netfpga_src/NetFPGA-1G-CML/lib/` and `emu/netfpga_src/NetFPGA-1G-CML/project/` into the 
`NetFPGA-1G-CML-live` directory. This step will create all the dependencies needed for the project.  
    
    
## Kiwi
### Dependancies
The Kiwi compiler depends on the following:
- `apt-get install fsharp`
- `apt-get install mono-complete`
- `apt-get install verilator`      
and the following environment variables need to be set:     
- `export HPRLS=[path to Kiwi's "bitbucket-hprls2" directory]` **(or)** `export KIWIDLL = Kiwi.dll`, `export KIWIC	= $(MONO) kiwic.exe`    
(it's simplest to set the first).
### Source code
The source code can be found [here](http://koo.corpus.cam.ac.uk/kiwic-download/)
### Documentation
The Kiwi documentation is located [here](http://www.cl.cam.ac.uk/~djg11/kiwi/)

## NetFPGA driver   

Running the hardware tests necessitates having the driver installed. Having the
driver installed also allows you to peek at registers, even if the program is
standalone (e.g., a switch).    
#### SUME    
To install the driver run:
- `cd $DRIVER_FOLDER`
- `make`
- `insmod sume_riffa.ko`
Then bring up the interfaces:
- `ifconfig nf0 up && ifconfig nf1 up && ifconfig nf2 up && ifconfig nf3 up`
    
#### 1G-CML   
To install the driver run:
- `cd $NF_ROOT/projects/reference_nic_nf1_cml/sw/host/driver/`
- `make`
- `insmod nf10.ko`
Then bring up the interfaces:
- `ifconfig nf0 up && ifconfig nf1 up && ifconfig nf2 up && ifconfig nf3 up`


## Project   
The basic infrastructure has been set up.   
We will continue with the example of the *emu_reference_switch_lite.cs*.  
    
#### SUME    
1. ```cd emu/kiwi_src/```  
2. ```make emu_reference_switch_lite_sume```   
3. ```source [path_to]/NetFPGA-SUME-live/tools/settings.sh```
4. ```cd [path_to]NetFPGA-SUME-live/``` **(or)** ```cd $SUME_FOLDER```
5. ```make```
   
The `make emu_reference_switch_lite_sume`(step 2) command will create the verilog file from the C# code.  
Currently the `make` command in step 2 supports:   
- emu_reference_switch_lite_sume  
- emu_reference_switch_lite_v2_sume   
- emu_reference_switch_sume   
- emu_reference_switch_threads_sume    
- emu_memcached_binary_sume   
- emu_memcached_binary_v2_sume   
- emu_memcached_ascii_sume
- emu_memcached_ascii_v2_sume
- emu_DNS_server_sume  
- emu_DNS_DBG_sume  
- emu_TCP_pingRA_sume
- emu_ICMP_echo_sume
    
Then the generated verilog file and the opl_wrapper will be copied into the `NetFPGA-SUME-live/projects/reference_emu/` directory.   
The command `make` in step 5 will generate all the IP cores that are needed for every project (including the reference_emu).           
#### 1G-CML   
1. ```cd emu/kiwi_src/```  
2. ```make emu_reference_switch_lite_cml```   
3. ```source ../../NetFPGA-1G-CML-live/bashrc_addon_NetFPGA_10G```
4. ```cd ../../NetFPGA-1G-CML-live/``` **(or)** ```cd $NF_ROOT```
5. ```make cores```

The `make emu_reference_switch_lite_cml`(step 2) command will create the verilog file from the C# code.  
Currently the `make` command in step 2 supports:   
- emu_reference_switch_lite_cml
- emu_memcached_binary_cml    
- emu_memcached_ascii_cml   

Then the generated verilog file and the opl_wrapper will be copied into the `NetFPGA-1G-CML-live/projects/reference_emu_nf1_cml/` directory.   
The command `make cores` in step 5 will generate all the IP cores that are needed for every project (including the reference_emu).   



## Tests
All the tests that are associated with the __*reference_emu*__ project are located under 
the:    
`NetFPGA-SUME-live/projects/reference_emu/test/` directory    
`NetFPGA-1G-CML-live/projects/reference_emu_nf1_cml/test/` directory    

The associated tests, to verify the functionality of the:  
####1G-CML
- *emu_reference_switch_lite.cs* are:  
	- both_simple_broadcast
	- both_learning_sw
- *emu_memcached_binary.cs* are:   
	- both_memcached_binary  
- *emu_memcached_ascii.cs* are:   
	- both_memcached_ascii  
    
    
####SUME
- *emu_reference_switch_lite.cs, emu_reference_switch_lite_v2.cs, emu_reference_switch.cs, emu_reference_switch_threads.cs* are:  
	- both_simple_broadcast
	- both_learning_sw
- *emu_memcached_binary.cs, emu_memcached_binary_v2.cs* are:   
	- both_memcached_binary  
- *emu_memcached_ascii.cs, emu_memcached_ascii_2.cs* are:   
	- both_memcached_ascii  
- *emu_ICMP_echo.cs* are:   
	- both_icmp_echo  
- *emu_DNS_server.cs* are:   
	- both_dns_server
- *emu_DNS_DBG.cs* are:   
	- both_dns_debug
- *emu_TCP_pingRA.cs* are:   
	- both_tcp_pingRA  

*Note:* In order to perform both sim/hw tests, you need to have created the IP cores. See the [Project](#project) section, step 4-5.

### SIM Test
*__Note:__ Remember to source the settings.sh(SUME) or bashrc_addon_NetFPGA_10G(1G-CML)*   

#### SUME
1. `cd NetFPGA-SUME-live/tools/scripts/`
2. `./nf_test.py sim --major simple --minor broadcast` **(or)** `./nf_test.py sim --major learning --minor sw`    
    
#### 1G-CML
1. `cd NetFPGA-1G-CML-live/tools/bin/`
2. `./nf_test.py sim --major simple --minor broadcast` **(or)** `./nf_test.py sim --major learning --minor sw`    


### HW Test
*__Note:__ Remember to source the settings.sh(SUME) or bashrc_addon_NetFPGA_10G(1G-CML)*    

#### SUME
1. `cd NetFPGA-SUME-live/projects/reference_emu/` **(or)** `cd $NF_DESIGN_DIR`
2. `make`
3. `xmd`
4. `fpga -f bitfiles/reference_emu.bit`
5. `cd ../../tools/scripts/`
6. `./nf_test.py hw --major simple --minor broadcast` **(or)** `./nf_test.py hw --major learning --minor sw`    
    
#### 1G-CML
1. `cd NetFPGA-1G-CML-live/projects/reference_emu_nf1_cml/` **(or)** `cd $NF_ROOT`
2. `make`
3. `make download`
5. `cd ../../tools/bin/`
6. `./nf_test.py hw --major simple --minor broadcast` **(or)** `./nf_test.py hw --major learning --minor sw` 

_Note:_ Before running step 6, ensure that the cables are connected properly -- the test
involves sending packets to the NetFPGA via some other network interfaces on
your workstation. The configuration can be found in the file
`$SUME_FOLDER/projects/reference_emu/test/connections/conn`,
as described in the SUME [wiki](https://github.com/NetFPGA/NetFPGA-SUME-public/wiki/Hardware-Tests#section-2---test-directory-file-structure).


## Directory File Structure
```
emu/
├── kiwi_src/
│   ├── Makefile
│   ├── emu_reference_switch_lite.cs
│   ├── emu_reference_switch_lite_v2.cs
│   ├── emu_reference_switch.cs
│   ├── emu_reference_switch_threads.cs
│   ├── emu_ICMP_echo.cs
│   ├── emu_memcached_ascii.cs
│   ├── emu_memcached_binary.cs
│   ├── emu_memcached_ascii_v2.cs
│   ├── emu_memcached_binary_v2.cs
│   ├── emu_DNS_server.cs
│   ├── emu_DNS_DBG.cs
│   └── emu_TCP_pingRA.cs
│
└── netfpga_src/
    │
    ├── NetFPGA-SUME
    │		├── lib/
    │		│   └── emu_output_port_lookup_v1_0_0/
    │		│       │
    │		│       ├── Makefile
    │		│       ├── emu_output_port_lookup.tcl
    │		│       │
    │		│       ├── hdl/
    │		│       │   ├── output_port_lookup_cpu_regs.v
    │		│       │   └── output_port_lookup_cpu_regs_define.v
    │		│       │
    │		│       └── data/
    │		│	    └── output_port_lookup_regs_define(.txt .h .tcl)
    │		│
    │		├── opl_wrapper/
    │		│   ├── emu_output_port_lookup_AXIS256.v
    │		│   ├── emu_output_port_lookup_AXIS256_CAM.v   
    │		│   ├── emu_output_port_lookup_AXIS256_CAM_THREADS.v
    │		│   ├── emu_output_port_lookup_AXIS64.v
    │		│   └── emu_output_port_lookup_AXIS64_CAM.v
    │		│
    │		└── project/
    │	    	└── reference_emu/
    │	        	├── bitfiles
    │	        	├── hw_bd/
    │	        	├── sw_bd/
    │	        	├── hw_vb/
    │	        	├── sw_vb/
    │	        	└── test/
    │
    └── NetFPGA-1G-CML
    	├── NetFPGA-1G-CML-Makefile
      	│
    	├── lib/
    	│   └── nf10_emu_output_port_lookup_v1_00_a/
    	│       ├── Makefile
    	│       └── data/
    	│
    	├── opl_wrapper/
    	│   └── nf10_emu_output_port_lookup_AXIS64_CAM.v
    	│
    	└── project/
        └── reference_emu_nf1_cml/
    	        ├── bitfiles
    	        ├── hw/
    	        ├── sw/
    	        ├── lib/
      	        ├── nf1_cml/
    	        ├── Makefile
    	        └── test/
```
