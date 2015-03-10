##Contents at a Glance
###[Contents](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/table_of_contents.md)
###[Readme](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/README.md)
###[Preface](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Preface.md)
###[Chapter 0: Environment Preparing](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_0._Environment_Preparing.md)  
###[Chapter 1: Information Gathering](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_1._Information_Gathering.md)
###[Chapter 2. Traffic Analysis](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_2._Traffic_Analysis.md)
###[Chapter 3. Runtime Analysis](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_3._Runtime_Analysis.md)
###[Chapter 4. Security Enhancement](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/Chapter_4._Security_Enhancement.md)  
----------------------

# 1. Information Gathering
Somethings are different with previous iOS version. Accroding to [iOS Application Security Part 37 - Adapting to iOS 8](http://highaltitudehacks.com/2014/12/21/ios-application-security-part-37-adapting-to-ios-8/), Application's bundle and data are stored in two different paths with different UUID folder names.  
Application bundle path:

	/var/mobile/Containers/Bundle/Application/<xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx>/<Appname.app>
	
Application data path:

	/var/mobile/Containers/Data/Application/<yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy>
	
Other original iOS app and Cydia app path has no change:

	/Applications/
	
And, most today's iOS file system explorers (iExplorer, iTools, iFunbox) can only look into application data folder when you pick apps.

### 1.0. Check List of Gathering Information
####URL Schemes
 
### 1.1. Crack Apps from AppStore
Any app download from AppStore are encrypted. When an iOS application is launched, the loader decrypts it and loads it into memory. Before class-dump, the description is compulsory. There are couple of tools can do this job. But, currently, early 2015, only clutch beta on Cydia can work with iOS 8.
#### 1.1.1. clutch
Open one ssh shell for iOS device with root password.
![image](https://raw.githubusercontent.com/robert-yi-jones/iOS-App-Security-Assessment-Note/master/Screenshots/clutch_0.png)

#####Get a app list from iOS device.

	$ clutch 
![image](https://raw.githubusercontent.com/robert-yi-jones/iOS-App-Security-Assessment-Note/master/Screenshots/clutch_1.png =814x)
#####Crack the app by clutch
	$ clutch eBay
![image](https://raw.githubusercontent.com/robert-yi-jones/iOS-App-Security-Assessment-Note/master/Screenshots/clutch_2.png =814x)
#####It will be saved to the path like this:
![image](https://raw.githubusercontent.com/robert-yi-jones/iOS-App-Security-Assessment-Note/master/Screenshots/clutch_3.png =814x)
#####Use a tool to export to anywhere you want.
![image](https://raw.githubusercontent.com/robert-yi-jones/iOS-App-Security-Assessment-Note/master/Screenshots/clutch_4.png =602x) 

#### 1.1.2. appCrackr
### 1.2. otool
### 1.3. class-dump
### 1.4. iDB	
[idb](https://github.com/dmayer/idb) is a tool to simplify some common tasks for iOS pentesting and research. 
#### 1.4.1 Getting started
Install ruby (1.9.3 and 2.1 are known to work. Don't use 2.0)  

	$ rvm install ruby --enable-shared 
	$ rvm install 2.1.0 --enable-shared 
Shared library support is required!  

	$ gem install bundler  
	$ brew install qt cmake usbmuxd libimobiledevice  
	$ gem install idb
	$ idb
#### 1.4.2. Manual and Walk Through
https://github.com/dmayer/idb/wiki/Manual-and--Walk-Through


### 1.4. iDB	


### 1.5. iDB	
	
