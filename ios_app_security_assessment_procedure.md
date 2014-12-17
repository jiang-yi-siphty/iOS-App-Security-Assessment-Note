
# iOS App Security Assessment Procedure (2014)

## 0. Preparing Environment

### 0.1. iOS Device
#### 0.1.1. Jaibreak
#### 0.1.2. Cydia
#### 0.1.3. Add Sources/Repos
#### 0.1.3. Install Tools

### 0.2. Mac
Source: [Setting Up Your Development Environment](https://github.com/makersquare/student-dev-box/wiki/Setting-Up-Your-Development-Environment)
#### 0.2.1. Installing Developer Tools
If you saw command not found when you typed gcc into your terminal prompt, you'll need to run the following command to install the Developer Tools:  

	$ xcode-select --install
	
	$ brew install xctool
	
This should pop up a dialog box and instructions for how to install the developer tools. After installation, we should check gcc version to verify Xcode Command line installation.

	$ gcc --version
	Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
	Apple LLVM version 6.0 (clang-600.0.56) (based on LLVM 3.5svn)
	Target: x86_64-apple-darwin14.0.0
	Thread model: posix  
	
	$ xcode-select -p
	$ xcodebuild -showsdks

#### 0.2.2. homebrew
[homebrew](http://brew.sh/) is a free/open source software package management system that simplifies the installation of software on the Mac OS X operating system. Originally written by Max Howell, the package manager has gained popularity in the Ruby on Rails community and earned praise for its extensibility.

	$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	 
Once that command finishes, run brew doctor and ensure that nothing comes up (if stuff does, don't panic. Google the problem and try to solve it based on Stack Overflow answers or GitHub discussions, if that doesn't work, consult an instructor).

Follow this up by installing the latest versions of Git and Zsh, then adding Zsh to the list of shells:

	$ brew update
	
#### 0.2.3. git
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
	user.email=me@example.com
	
#### 0.2.4. zsh
[Zsh](http://zsh.sourceforge.net/) is a shell designed for interactive use, although it is also a powerful scripting language. Many of the useful features of bash, ksh, and tcsh were incorporated into zsh; many original features were added.   

	$ brew install zsh
	$ echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells
	
#### 0.2.5. Oh-My-Zsh
[Oh-My-Zsh](http://ohmyz.sh/) is a package of themes and plugins for terminal. It is an open source, community-driven framework for managing your ZSH configuration. It comes bundled with a ton of helpful functions, helpers, plugins, themes, and a few things that make you shout...“Oh My ZSH!”  

	$ curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	
Switch shell by:  

	chsh -s /bin/bash  
	
or  

	chsh -s /bin/zsh

#### 0.2.6. Ruby
Use RVM, the Ruby Version Manager, to install Ruby and manage your Rails versions.

RVM will leave your “system Ruby” untouched and use your shell to intercept any calls to Ruby. There’s no need to remove it. The “system Ruby” will remain on your system and the RVM version will take precedence.  

	$ \curl -L https://get.rvm.io | bash -s stable --ruby
	$ gem -v
	2.0.14
Sourse: [Install Ruby on Rails · Mac OS X Yosemite](http://railsapps.github.io/installrubyonrails-mac.html)   
 
#### 0.2.8. theos
#### 0.2.9. otool


## 1. Information Gathering
### 1.1. Crack Apps from AppStore
#### clutch
#### appCrackr
### otool
### class-dump	
## 2. Traffic Analysis

## 3. Runtime Analysis

### 3.1. Disable ASLR 
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

Do **$ bash obfuscate_project** every time when you want to obfuscate your project. It should be done every release. Store the json file containing symbol mapping so you can get the original symbol names in case of a crash. **Rename stored json file with release version number. **

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

##### 4.1.1.4. [More information](https://github.com/Polidea/ios-class-guard/blob/master/README.md)

### 4.2. Data Protection API

### 4.3. Jailbroken Detection
### 4.3. Secure Memory
#### 4.3.0. Theory 

#### 4.3.1. iMAS memory-security
[memory-security](https://github.com/project-imas/memory-security)