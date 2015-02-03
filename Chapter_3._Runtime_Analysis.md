# Table of Contents

##Contents at a Glance
###[Contents](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/table_of_contents.md)
###[Readme](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/README.md)
###[Preface](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Preface.md)
###[Chapter 0: Environment Preparing](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_0._Environment_Preparing.md)  
###[Chapter 1: Information Gathering](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_1._Information_Gathering.md)
###[Chapter 2. Traffic Analysis](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_2._Traffic_Analysis.md)
###[Chapter 3. Runtime Analysis](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_3._Runtime_Analysis.md)
###[Chapter 4. Security Enhancement](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_4._Security_Enhancement.md)  
----------------------------
 
  
  

  
#Chapter 3. Runtime Analysis
## 3.1. Disable ASLR
Source:   
[Disable ASLR on iOS applications (May 23 2014)](http://www.securitylearn.net/tag/remove-pie-flag-of-ios-app/)  
[废除应用程序的ASLR特性](http://blog.csdn.net/yiyaaixuexi/article/details/20391001)   

PIE Flag is Position Independent Enable. The binary file with PIE flag will cause ASLR in runtime.  

ASLR – Address Space Layout Randomization is an important exploit mitigation technique introduced in iOS 4.3. ASLR makes the remote exploitation of memory corruption vulnerabilities significantly more difficult by randomizing the application objects location in the memory. By default iOS applications uses limited ASLR and only randomizes part of the objects in the memory. The image compares the different memory sections for partial and full ASLR applications.   
### Check PIE Flag
	$ otool -hv theIosApp
	theIosApp:
	Mach header
      magic      cputype   cpusubtype  caps    filetype  ncmds  sizeofcmds      flags
	  MH_MAGIC       ARM           V7  0x00     EXECUTE     33        3712   NOUNDEFS DYLDLINK TWOLEVEL PIE
### Remove PIE Flag 
Download <https://github.com/CarinaTT/MyRemovePIE>

	$ sudo chmod 777 /usr/bin/MyRemovePIE
	$ sudo /usr/bin/MyRemovePIE theIosApp		
	loading header

	backing up application binary...

	binary backed up to:	theIosApp.

	mach_header:	cefaedfe0c000000090000000200000021000000800e000085002000
	original flags:	85002000
	Disabling ASLR/PIE ...
	new flags:	85000000
	ASLR has been disabled for theIosApp


