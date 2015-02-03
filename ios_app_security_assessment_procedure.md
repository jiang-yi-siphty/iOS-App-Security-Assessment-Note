
# iOS 8 App Security Assessment Procedure (2014)


## 0. Environment Preparing

### 0.1. iOS Device
#### 0.1.1. Jailbreak
For iOS 8.x.x, [Taig](http://www.taig.com/) is the best freeware to jailbreak, currently. (Dec 2014)
#### 0.1.2. Add Sources/Repos
After jailbreak, we need add sources in Cydia. 

	http://repo.biteyourapple.net/
	http://coolstar.org/publicrepo/
	http://repo.insanelyi.com/
	http://apt.modmyi.com/
	http://nix.howett.net/theos/
	http://cydia.xsellize.com/
	http://apt.weiphone.com/
	http://Apt.178.com/
	http://AppAddict.org/repo
	
#### 0.1.3. Install Tools
**afc2add**  
**AppList**  
**Appsync for iOS8**  
**Clutch Beta**  
**Darwin CC Tools**  
**iFile**  
**insanelyi App - iOS8 **  
**iOS Toolchain**  
**iWep PRO 8**  
**ldone**
**LLVM+Clang**  
**MobileTerminal(iOS7)**  
**OpenSSH** (Must change root password after install)  
**Pod2g's ASLR Tools**  
**theos8**  


### 0.2. Mac
Source: [Setting Up Your Development Environment](https://github.com/makersquare/student-dev-box/wiki/Setting-Up-Your-Development-Environment)
#### 0.2.1. Installing Developer Tools
If you saw command not found when you typed gcc into your terminal prompt, you'll need to run the following command to install the Developer Tools:  

	$ xcode-select --install
	
This should pop up a dialog box and instructions for how to install the developer tools. After installation, we should check gcc version to verify Xcode Command line installation.

	$ gcc --version
	Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
	Apple LLVM version 6.0 (clang-600.0.56) (based on LLVM 3.5svn)
	Target: x86_64-apple-darwin14.0.0
	Thread model: posix  
	
	$ xcode-select -p
	$ xcodebuild -showsdks

#### 0.2.2. iTools/iFunBox
Both of two application are file manager. Pick your favourite one to install.
[iTools](http://pro.itools.cn/mac/english)  or [iFunBox](http://www.i-funbox.com/ifunboxmac/)

#### 0.2.3. Ruby
Use RVM, the Ruby Version Manager, to install Ruby and manage your Rails versions.

RVM will leave your “system Ruby” untouched and use your shell to intercept any calls to Ruby. There’s no need to remove it. The “system Ruby” will remain on your system and the RVM version will take precedence.  

	$ \curl -L https://get.rvm.io | bash -s stable --ruby
	$ gem -v
	2.0.14
	rvm install ruby --enable-shared 
Sourse: [Install Ruby on Rails · Mac OS X Yosemite](http://railsapps.github.io/installrubyonrails-mac.html)   	

#### 0.2.4. homebrew
[homebrew](http://brew.sh/) is a free/open source software package management system that simplifies the installation of software on the Mac OS X operating system. Originally written by Max Howell, the package manager has gained popularity in the Ruby on Rails community and earned praise for its extensibility.

	$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	 
Once that command finishes, run brew doctor and ensure that nothing comes up (if stuff does, don't panic. Google the problem and try to solve it based on Stack Overflow answers or GitHub discussions, if that doesn't work, consult an instructor).

Follow this up by installing the latest versions of Git and Zsh, then adding Zsh to the list of shells:

	$ brew update

	user.email=me@example.com
	
#### 0.2.5. zsh
[Zsh](http://zsh.sourceforge.net/) is a shell designed for interactive use, although it is also a powerful scripting language. Many of the useful features of bash, ksh, and tcsh were incorporated into zsh; many original features were added.   

	$ brew install zsh
	$ echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells
	
#### 0.2.6. Oh-My-Zsh
[Oh-My-Zsh](http://ohmyz.sh/) is a package of themes and plugins for terminal. It is an open source, community-driven framework for managing your ZSH configuration. It comes bundled with a ton of helpful functions, helpers, plugins, themes, and a few things that make you shout...“Oh My ZSH!”  

	$ curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	
Switch shell by:  

	chsh -s /bin/bash  
	
or  

	chsh -s /bin/zsh

#### 0.2.7. git
[Git](http://git-scm.com/) is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

	$ brew install git
	$ git version
	git version 1.9.3 (Apple Git-50)
Configure Git if you haven’t used it before. First, list the current settings with the git config -l --global command. Then set user.name and user.email if necessary:

	$ git config -l --global
	fatal: unable to read config file '/Users/.../.gitconfig': No such file or directory
	$ git config --global user.name "Your Real Name"
	$ git config --global user.email me@example.com
	$ git config -l --global
	user.name=Your Real Name

#### 0.2.8. theos
Set environment  

	$ export THEOS=/opt/theos

Fetch Theos  

	$ sudo git clone git://github.com/DHowett/theos.git $THEOS
	

#### 0.2.9. ldid
ldid is a tool for sign iOS app.
Download packet from following url:  
<https://github.com/downloads/rpetrich/ldid/ldid.zip> 
 
Unzip it to 
 
	/opt/theos/bin
	

#### 0.2.10. MobilSubstrate
Configure MobileSubstrate environment in Terminal  

	$ sudo $THEOS/bin.bootstrap.sh substrate
Copy libsubstrate.dylib from iOS device /Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate to local mac's $THEOS/lib/libsubstrate.dylib

	$ sudo mv -f /the/path/to/CydiaSubstrate $THEOS/lib/libsubstrate.dylib
 
#### 0.2.11. dpkg
Download and install MacPorts from <https://www.macports.org/install.php>
Than, setup environment and update

	$ export port=/opt/bin/port
	$ sudo port selfupdate
	
Install dpkg

	$ sudo port install dpkg
	

#### 0.2.12. theos NIC templates
There are 5 Theos project templates in NIC templates packet. Download and decompress it from  
<https://github.com/DHowett/theos-nic-templates/archive/master.zip>  
to  

	$THEOS/templates/iphone

#### class-dump
[class-dump](http://stevenygard.com/projects/class-dump/) is a command-line utility for examining the Objective-C runtime information stored in Mach-O files. It generates declarations for the classes, categories and protocols. This is the same information provided by using ‘otool -ov’, but presented as normal Objective-C declarations, so it is much more compact and readable.

	$ brew install class-dump

#### class-dump-z
download the excellent little command line utility called class-dump-z that will display all the Objective-C declaration information found in the executable.

Unzip the downloaded bundle and in Terminal, navigate inside the unzipped directory to class-dump-z_0.2a/mac_x86. Here you’ll find a file called class-dump-z. Install this however you might like. I personally like to copy it to my /usr/bin directory:

	$ sudo cp class-dump-z /usr/bin/
	
	
#### xctool	

	$ brew install xctool
	
	
**Source:** [iOS App Security and Analysis: Part 1/2](http://www.raywenderlich.com/45645/ios-app-security-analysis-part-1)

#### 0.2.13. otool


## 1. Information Gathering
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
	
## 2. Traffic Analysis

## 3. Runtime Analysis

### 3.1. Disable ASLR (Address Space Layout Randomization) 
Source:   
[Disable ASLR on iOS applications (May 23 2014)](http://www.securitylearn.net/tag/remove-pie-flag-of-ios-app/)  
[废除应用程序的ASLR特性](http://blog.csdn.net/yiyaaixuexi/article/details/20391001)   

PIE Flag is Position Independent Enable. The binary file with PIE flag will cause ASLR in runtime.  

ASLR – Address Space Layout Randomization is an important exploit mitigation technique introduced in iOS 4.3. ASLR makes the remote exploitation of memory corruption vulnerabilities significantly more difficult by randomizing the application objects location in the memory. By default iOS applications uses limited ASLR and only randomizes part of the objects in the memory. The image compares the different memory sections for partial and full ASLR applications.   
#### Check PIE Flag
	$ otool -hv theIosApp
	theIosApp:
	Mach header
      magic      cputype   cpusubtype  caps    filetype  ncmds  sizeofcmds      flags
	  MH_MAGIC       ARM           V7  0x00     EXECUTE     33        3712   NOUNDEFS DYLDLINK TWOLEVEL PIE
#### Remove PIE Flag 
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


## 4. Security Enhancement
All following security enhancements are coding solutions in the project. 
### 4.0. Checklist of Potential Vulnerabilities
#### Third Party Library 
**Risk:** ★★★★☆
#### Jailbreak 
**Risk:** ★★★☆☆
#### Piracy 
**Risk:** ★★★☆☆
#### URL Scheme abusing
**Risk:** ★☆☆☆☆ 
### 4.1. Obfuscation

#### 4.1.1. iOS Class Guard
[iOS-Class-Guard](https://github.com/Polidea/ios-class-guard) is a command-line utility for obfuscating Objective-C class, protocol, property and method names. It was made as an extension for [class-dump](https://github.com/nygard/class-dump). The utility generates a symbol table which is then included during compilation. It effectively hides most of class, protocol, method, property and i-var names.

iOS Class Guard itself is not the silver bullet for security of your application. However, it will definitiely make your application harder to read by an attacker.

Read the official announcement at [Polidea Blog](http://www.polidea.com/#!heartbeat/blog/Protecting_iOS_Applications)   

##### 4.1.1.1. Installation
	
Execute this simple bash script in Terminal. When asked for the password, enter your account. It's needed, because the utility is installed in /usr/local/bin.

	$ brew install https://raw.githubusercontent.com/Polidea/homebrew/ios-class-guard/Library/Formula/ios-class-guard.rb
	
To install bleeding edge version:

	$ brew install --HEAD https://raw.githubusercontent.com/Polidea/homebrew/ios-class-guard/Library/Formula/ios-class-guard.rb
	
##### 4.1.1.2. How to use it?

A few steps are required to integrate iOS Class Guard in a project.

Download [obfuscate_project](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/SourceCode/Obfuscating/obfuscate_project.sh) in to your project root path. 

	$ chmod +x obfuscate_project

Update the project file, scheme and configuration name in shell script obfuscate_project.sh .

Do 

	$ ./obfuscate_project 
every time when you want to obfuscate your project. It should be done every release. Store the json file containing symbol mapping so you can get the original symbol names in case of a crash. **Rename stored json file with release version number. **

Build, test and archive your project using Xcode or other tools.

The presented way is the simplest one. You can also add additional target that will automatically regenerate the symbols map during compilation.

**ios-class-guard will be called by shell script obfuscate_project.**

##### 4.1.1.3. Example

You can take a look what changes are required and how it works in some example projects.

	$ git clone https://github.com/Polidea/ios-class-guard-example ios-class-guard-example
	$ cd ios-class-guard-example
	$ make compile
Here is class-dump for [non-obfuscated sources](https://github.com/Polidea/ios-class-guard-example/tree/master/SWTableViewCell-no-obfuscated.xcarchive/Headers)

What it will look like when you [use iOS Class Guard](https://github.com/Polidea/ios-class-guard-example/tree/master/SWTableViewCell-obfuscated.xcarchive/Headers)

##### 4.1.1.3. Experience
In the shell script obfuscate_project, we need add an ignore list as command ios-class-guard 's parameters. Many controls can cause trouble, but they are not that important. Thus, the simple solution is ignore them.

Like:  

	ios-class-guard \
	--sdk-root "$SDK_DIR" \
	-i 'machine*' \
	-i 'AL*' \
	-i '*Flurry*' \
	-i '*TestFlight*' \
	-O symbols.h \
	build/$CONFIGURATION-$OBFUSCATION_SDK/$TARGET.app/$TARGET


##### 4.1.1.4. [More information](https://github.com/Polidea/ios-class-guard/blob/master/README.md)

### 4.2. Data Protection API

### 4.3. Jailbreak Detection
There are couple of ways can detect jailbreak. The following code is a combination of checking the path and URL scheme of Cydia, checking Non-AppStore apps installation, writing file outside of application bundle. It was introduced by Prateek Gianchandani's article, in Dec 17th, 2013.  
	
	
    +(BOOL)isJailbroken{
  
    #if !(TARGET_IPHONE_SIMULATOR)
  
       if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
          return YES;
        }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]){
          return YES;
        }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]){
          return YES;
        }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]){
          return YES;
        }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]){
          return YES;
        }
  
      NSError *error;
        NSString *stringToBeWritten = @"This is a test.";
        [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES
              encoding:NSUTF8StringEncoding error:&error];
        if(error==nil){
        //Device is jailbroken
        return YES;
      } else {
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
      }
 
      if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        //Device is jailbroken
        return YES;
      }
    #endif
  
      //All checks have failed. Most probably, the device is not jailbroken
      return NO;
    }    
    
And, attacker also has way to [bypass above jailbreak detection](http://highaltitudehacks.com/2013/12/17/ios-application-security-part-24-jailbreak-detection-and-evasion/) by using Cycript and Class-dump-z. Developer can change the +(BOOL)isJailbroken method name to something that doesn’t look quite appealing to the hacker. Or developer can use **obfuscation** to slow-down attacker's analysis significantly....   
This war never ends...  
### 4.4. Secure Memory
#### 4.4.0. Theory 

#### 4.4.1. iMAS memory-security
[memory-security](https://github.com/project-imas/memory-security)

### 4.5. Secure URL schemes
An URL scheme invoking looks like this:

	XXX://parameters
	
Accroding to Prateek Gianchandani's Mar 7th, 2014 article, [iOS Application Security Part 30 - Attacking URL Schemes](http://highaltitudehacks.com/2014/03/07/ios-application-security-part-30-attacking-url-schemes/), the unvalidated url scheme invoking can be abused by other app or web page accessed by safari.  Skype iOS app was a bad example. The old version Skype can be invoke and make phone call without user validation. 

	skype://0433092885?cal  
To invoke native iOS telephone application, safari will prompt a authorisationzation alert. 

	tel://1123456789
However, in iOS 8, the safari will prompt a alert to ask user's permission about the Skype phone call.
 
**Suggestion :**  
**1.**  Validate the parameter **sourceApplication** in delegate method:
	
	– (BOOL)application:(UIApplication )application openURL:(NSURL )url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
Prepare a whitelist of the applications which is allowed to invoke URL scheme. If the calling app is not on the list, app will ignore parameter in the URL scheme.    
**2.**  Prompt conformation alert to user at the begining. Let user decide to process or abort any action based on the URL scheme parameters. 
### 4.6. Third Party Security Libraries  
According to [iOS Application Security Part 31 - the Problem With Using Third Party Libraries for Securing Your Apps](http://highaltitudehacks.com/2014/03/18/ios-application-security-part-31-the-problem-with-using-third-party-libraries-for-securing-your-apps/), some third party libraries provide security enhancement. It can help us to detect jailbroken and piracy etc. It makes complicate things simple.  Like [Shmoopi Anti-Piracy Library](https://github.com/Shmoopi/AntiPiracy). 

However, it might introduces common or known vulnerabilities into the project. It will be various. It depends on which library is involved in project. The class name can be the library's signature.

**Suggestion :**
**1.** Manually change the class name and the method name can add extremely workload for attacker.
**2.** Use obfuscation procedure to parsing classes, methods, properties in the project.
**3.** Create honeypot with attractive name for attacker. It can waste their life little bit. 



