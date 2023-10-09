# Q & A

## Xcode version

Different versions of Xcode need to be installed under specific Mac OS versions and can develop specific iOS versions. For more details, refer to [Wikipedia](https://en.wikipedia.org/wiki/Xcode).

![versions](/Introduction/versions.png "versions")

High version Xcode can't be installed on macOS with a lower version. 
If you try to install Xcode by downloading Xcode.zip, you could then see errors like `cpio read error:Undefined error:0` when decompressing.

![version_not_match](/Introduction/version_not_match2.png "version_not_match")



## iOS Developer Account
Apple Developer Certificate is required to deploy iOS-Tagent. Fortunately, Apple now allows us to register with Apple ID without payment.


## Login to Xcode
Select `Xcode` -> `Preferences` -> `Accounts` -> `Manage Certificates` -> below the left column `+` -> `iOS Development` to login Xcode.

<img src="login.png" alt="login" tittle="login" width="50%"  height="50%">


## Manage developer certificate
After login, you need set up the developer certificate. `WebDriverAgent` -> `WebDriverAgent-Runner` -> `General` -> `Signing` select your certificate

<img src="signing.png" alt="signing" tittle="signing" width="70%"  height="70%">


## bundle identifier
If you are using a free developer certificate, you may see the error `Xcode failed to create provisioning profile` 

<img src="FailID.png" alt="FailID" tittle="FailID" width="50%"  height="50%">

This error can be fixed by changing the Bundle Identifier `Build Settings` -> `Product Bundle Identifier`. This should be a unique identifier, you can set up your own.Here's an example 'com.xxx.webDriverAgent-test123'. 

![bundleId](/Introduction/bundleId.png "set up bundleId")


## Trusting certificates
The first time you install iOS-Tangent to your iPhone, you will get a pop up as shown below.  Select Settings
The first time you installed iOS-Tagent to your iPhone, you will get a pop up as shown below. Select `Settings ` -> `General ` -> `Device Management`  ->  to trust the developer certificate on your iPhone. Then retry "test" in Xcode, it should work. See [Apple documentation](https://support.apple.com/en-us/HT204460)


![untrusted](/Introduction/untrusted.jpg "untrusted")

![trust_dev](/Introduction/trust_dev2.png "trust_dev")
