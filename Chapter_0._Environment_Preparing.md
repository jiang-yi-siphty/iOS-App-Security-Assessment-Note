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
# 0. Environment Preparing  
  
## 0.1. iOS Device
### 0.1.1. Jailbreak
For iOS 8.x.x, [Taig](http://www.taig.com/) is the best freeware to jailbreak, currently. (Dec 2014)
### 0.1.2. Add Sources/Repos
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
	
### 0.1.3. Install Tools
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


## 0.2. Mac
Source: [Setting Up Your Development Environment](https://github.com/makersquare/student-dev-box/wiki/Setting-Up-Your-Development-Environment)
### 0.2.1. Installing Developer Tools
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

### 0.2.2. iTools/iFunBox
Both of two application are file manager. Pick your favourite one to install.
[iTools](http://pro.itools.cn/mac/english)  or [iFunBox](http://www.i-funbox.com/ifunboxmac/)

### 0.2.3. Ruby
Use RVM, the Ruby Version Manager, to install Ruby and manage your Rails versions.

RVM will leave your “system Ruby” untouched and use your shell to intercept any calls to Ruby. There’s no need to remove it. The “system Ruby” will remain on your system and the RVM version will take precedence.  

	$ \curl -L https://get.rvm.io | bash -s stable --ruby
	$ gem -v
	2.0.14
	rvm install ruby --enable-shared 
Sourse: [Install Ruby on Rails · Mac OS X Yosemite](http://railsapps.github.io/installrubyonrails-mac.html)   	

### 0.2.4. homebrew
[homebrew](http://brew.sh/) is a free/open source software package management system that simplifies the installation of software on the Mac OS X operating system. Originally written by Max Howell, the package manager has gained popularity in the Ruby on Rails community and earned praise for its extensibility.

	$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	 
Once that command finishes, run brew doctor and ensure that nothing comes up (if stuff does, don't panic. Google the problem and try to solve it based on Stack Overflow answers or GitHub discussions, if that doesn't work, consult an instructor).

Follow this up by installing the latest versions of Git and Zsh, then adding Zsh to the list of shells:

	$ brew update

	user.email=me@example.com
	
### 0.2.5. zsh
[Zsh](http://zsh.sourceforge.net/) is a shell designed for interactive use, although it is also a powerful scripting language. Many of the useful features of bash, ksh, and tcsh were incorporated into zsh; many original features were added.   

	$ brew install zsh
	$ echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells
	
### 0.2.6. Oh-My-Zsh
[Oh-My-Zsh](http://ohmyz.sh/) is a package of themes and plugins for terminal. It is an open source, community-driven framework for managing your ZSH configuration. It comes bundled with a ton of helpful functions, helpers, plugins, themes, and a few things that make you shout...“Oh My ZSH!”  

	$ curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	
Switch shell by:  

	chsh -s /bin/bash  
	
or  

	chsh -s /bin/zsh

### 0.2.7. git
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

### 0.2.8. theos
Set environment  

	$ export THEOS=/opt/theos

Fetch Theos  

	$ sudo git clone git://github.com/DHowett/theos.git $THEOS
	

### 0.2.9. ldid
ldid is a tool for sign iOS app.
Download packet from following url:  
<https://github.com/downloads/rpetrich/ldid/ldid.zip> 
 
Unzip it to 
 
	/opt/theos/bin
	

### 0.2.10. MobilSubstrate
Configure MobileSubstrate environment in Terminal  

	$ sudo $THEOS/bin.bootstrap.sh substrate
Copy libsubstrate.dylib from iOS device /Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate to local mac's $THEOS/lib/libsubstrate.dylib

	$ sudo mv -f /the/path/to/CydiaSubstrate $THEOS/lib/libsubstrate.dylib
 
### 0.2.11. dpkg
Download and install MacPorts from <https://www.macports.org/install.php>
Than, setup environment and update

	$ export port=/opt/bin/port
	$ sudo port selfupdate
	
Install dpkg

	$ sudo port install dpkg
	

### 0.2.12. theos NIC templates
There are 5 Theos project templates in NIC templates packet. Download and decompress it from  
<https://github.com/DHowett/theos-nic-templates/archive/master.zip>  
to  

	$THEOS/templates/iphone

### class-dump
[class-dump](http://stevenygard.com/projects/class-dump/) is a command-line utility for examining the Objective-C runtime information stored in Mach-O files. It generates declarations for the classes, categories and protocols. This is the same information provided by using ‘otool -ov’, but presented as normal Objective-C declarations, so it is much more compact and readable.

	$ brew install class-dump

### class-dump-z
download the excellent little command line utility called class-dump-z that will display all the Objective-C declaration information found in the executable.

Unzip the downloaded bundle and in Terminal, navigate inside the unzipped directory to class-dump-z_0.2a/mac_x86. Here you’ll find a file called class-dump-z. Install this however you might like. I personally like to copy it to my /usr/bin directory:

	$ sudo cp class-dump-z /usr/bin/
	
	
### xctool	

	$ brew install xctool
	
	
**Source:** [iOS App Security and Analysis: Part 1/2](http://www.raywenderlich.com/45645/ios-app-security-analysis-part-1)

### 0.2.13. otool