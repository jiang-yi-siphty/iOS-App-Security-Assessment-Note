
# iOS App Security Assessment Procedure (2014)
## Preparing Environment
### iOS Device
#### Jaibreak
#### Cydia
#### Add Sources/Repos
#### Install Tools
### Mac
#### class-dump
#### theos

## Information Gathering
### Crack Apps from AppStore
### Class-Dump
### Disable ASLR 
PIE Flag is Position Independent Enable. The binary file with PIE flag will cause ASLR in runtime.  

ASLR – Address Space Layout Randomization is an important exploit mitigation technique introduced in iOS 4.3. ASLR makes the remote exploitation of memory corruption vulnerabilities significantly more difficult by randomizing the application objects location in the memory. By default iOS applications uses limited ASLR and only randomizes part of the objects in the memory. The image compares the different memory sections for partial and full ASLR applications.  
#### Check PIE Flag
	otool -hv theIosApp
	theIosApp:
	Mach header
      magic      cputype   cpusubtype  caps    filetype  ncmds  sizeofcmds      flags
	  MH_MAGIC       ARM           V7  0x00     EXECUTE     33        3712   NOUNDEFS DYLDLINK TWOLEVEL PIE
#### Remove PIE Flag 
Download https://github.com/CarinaTT/MyRemovePIE

	sudo chmod 777 /usr/bin/MyRemovePIE
	sudo /usr/bin/MyRemovePIE theIosApp
	loading header

	backing up application binary...

	binary backed up to:	iFob.

	mach_header:	cefaedfe0c000000090000000200000021000000800e000085002000
	original flags:	85002000
	Disabling ASLR/PIE ...
	new flags:	85000000
	ASLR has been disabled for iFob
	
