# Table of Contents

##Contents at a Glance
###Contents
###[Readme](https://github.com/robert-yi-jones/iOS-App-Security-Assessment-Note/blob/master/README.md)
###Preface
###Chapter 0: Environment Preparing  
###Chapter 1: Information Gathering
###Chapter 2. Traffic Analysis
###Chapter 3. Runtime Analysis 
###Chapter 4. Security Enhancement  
-----------------------

  
  
  

  
#Chapter 4. Security Enhancement  
All following security enhancements are coding solutions in the project. 
## 4.0. Checklist of Potential Vulnerabilities
### Un-protected CoreData or Files
**Risk:** ★★★★★
Once a iPhone trusted a pc/mac, the pc/mac will be able to download app's data forever. Until iPhone be reseted by choose the "Reset Location & Privacy" option in Settings -> General -> Reset. Malicious access might happened even the iPhone is in screen lock mode. If we don't use Data Protection API, the app's data will be exposed by a pc/mac it used to trusted. 

### Third Party Library Vulnerability  
**Risk:** ★★★★☆
Third party library might involve un-expected well-known vulnerabilities. The security related third party library might lose protection by hackers.

### Jailbreak 
**Risk:** ★★★☆☆
The threat of jailbreak is come from end user. Reverse-Engineering iOS app requires a jailbreak iOS device. User can decrypt App Store binary and analysis it. If it is necessary, the app can detect iOS jailbreak status to do some preventions like abort app, use honeypot method, notice remote server. 

### Piracy 
**Risk:** ★★★☆☆

### URL Scheme abusing
**Risk:** ★☆☆☆☆ 
The abusing of URL scheme doesn't really hurt anyone in most scenarios. But it can annoy app user by other app's un-expected invoke. So, before your app does anything as URL Scheme told, please authenticate invoker or prompt to app user. 


## 4.1. Obfuscation

### 4.1.1. iOS Class Guard
[iOS-Class-Guard](https://github.com/Polidea/ios-class-guard) is a command-line utility for obfuscating Objective-C class, protocol, property and method names. It was made as an extension for [class-dump](https://github.com/nygard/class-dump). The utility generates a symbol table which is then included during compilation. It effectively hides most of class, protocol, method, property and i-var names.

iOS Class Guard itself is not the silver bullet for security of your application. However, it will definitiely make your application harder to read by an attacker.

Read the official announcement at [Polidea Blog](http://www.polidea.com/#!heartbeat/blog/Protecting_iOS_Applications)   

#### 4.1.1.1. Installation
	
Execute this simple bash script in Terminal. When asked for the password, enter your account. It's needed, because the utility is installed in /usr/local/bin.

	$ brew install https://raw.githubusercontent.com/Polidea/homebrew/ios-class-guard/Library/Formula/ios-class-guard.rb
	
To install bleeding edge version:

	$ brew install --HEAD https://raw.githubusercontent.com/Polidea/homebrew/ios-class-guard/Library/Formula/ios-class-guard.rb
	
#### 4.1.1.2. How to use it?

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

#### 4.1.1.3. Example

You can take a look what changes are required and how it works in some example projects.

	$ git clone https://github.com/Polidea/ios-class-guard-example ios-class-guard-example
	$ cd ios-class-guard-example
	$ make compile
Here is class-dump for [non-obfuscated sources](https://github.com/Polidea/ios-class-guard-example/tree/master/SWTableViewCell-no-obfuscated.xcarchive/Headers)

What it will look like when you [use iOS Class Guard](https://github.com/Polidea/ios-class-guard-example/tree/master/SWTableViewCell-obfuscated.xcarchive/Headers)

#### 4.1.1.3. Experience
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


#### 4.1.1.4. [More information](https://github.com/Polidea/ios-class-guard/blob/master/README.md)

## 4.2. Data Protection API

## 4.3. Jailbreak Detection
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
### 4.3.1 Bypassing Jailbreak Detection Using Xcon  
Downloading Xcon in your project is very straightforward. Make sure http://apt.modmyi.com is added as a source in Cydia and search for Xcon. Install in on your device and restart your device.   
Once you run any app, you will notice that the library will inject into the process as can be seen from the following 
### 4.3.2 Bypassing Jailbreak Detection Using Xcon  
## 4.4. Secure Memory
### 4.4.0. Theory 

### 4.4.1. iMAS memory-security
[memory-security](https://github.com/project-imas/memory-security)

## 4.5. Secure URL schemes
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
## 4.6. Third Party Security Libraries  
According to [iOS Application Security Part 31 - the Problem With Using Third Party Libraries for Securing Your Apps](http://highaltitudehacks.com/2014/03/18/ios-application-security-part-31-the-problem-with-using-third-party-libraries-for-securing-your-apps/), some third party libraries provide security enhancement. It can help us to detect jailbroken and piracy etc. It makes complicate things simple.  Like [Shmoopi Anti-Piracy Library](https://github.com/Shmoopi/AntiPiracy). 

However, it might introduces common or known vulnerabilities into the project. It will be various. It depends on which library is involved in project. The class name can be the library's signature.

**Suggestion :**
**1.** Manually change the class name and the method name can add extremely workload for attacker.
**2.** Use obfuscation procedure to parsing classes, methods, properties in the project.
**3.** Create honeypot with attractive name for attacker. It can waste their life little bit. 
**4.** Keep updating third party libraries in the project. 

## 4.7. Apple Data Protection API
### 4.7.3. Data Read/Write Protection
### 4.7.3. File Protection
### 4.7.3. CoreData Protection

Configure fileAttributes **NSFileProtectionComplete** or others depends on scenario.

	

	- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
	{
	    if (_persistentStoreCoordinator != nil) {
	        return _persistentStoreCoordinator;
	    }
	    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
	    NSError *error = nil;
	    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    NSDictionary *fileAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
    if (![[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:storeURL.path error:&error]) {
        // Handle error
        }
    return _persistentStoreCoordinator;
}
 

 

