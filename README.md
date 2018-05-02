# WebDriverAgent-Evo Introduction

![ios-airtestIDE](/IntroductionPhoto/ios-airtestIDE.gif "ios-airtestIDE")

WebDriverAgent-Evo is a project based on facebook [WebDriverAgent](https://github.com/facebook/WebDriverAgent), and intend to fit [AirtestProject](http://airtest.netease.com/).

To use airtest and airtestIDE on ios, this project is required

This Project is worked well in xcode 9 + ios 11, other version of xcode and ios version is not fully tested

    this project is open beta status now, if you have problem with this project please goto Issues

## Getting Started

### prerequisite
    1. iOS Provisioning Profile(Certificate) (free or paid)
    2. basic experience with xcode

You can simply open `WebDriverAgent.xcodeproj` and start `WebDriverAgentRunner` test

and start do what you want with [Airtest](http://airtest.netease.com/)
(with ios http url)

## Start manual

### 1. run the agent
1. set up an signing in WebDriverAgent -> WebDriverAgent-Runner-> General -> signing.
![set up signing](/IntroductionPhoto/signing.png "set up signing")


2. if a free personal certificate used

    This will manifest as something like an error that Xcode failed to create provisioning profile:

![FailID](/IntroductionPhoto/FailID.png "set up id Fail")

 please change 'Build Settings' ->"Product Bundle Identifier" into somethings else

![bundleId](/IntroductionPhoto/bundleId.png "set up bundleId")

3. perform test in a selected device

#### choose device first

![chooseDevice](/IntroductionPhoto/chooseDevice.png "chooseDevice")

#### choose schema next

![chooseScheme](/IntroductionPhoto/chooseScheme.png "chooseScheme")

#### finally: Product -> Test
![runTest](/IntroductionPhoto/runTest.png "runTest")

or

![ProductTest](/IntroductionPhoto/ProductTest.jpg "ProductTest")


4. also you need trust the application. You can go to Settings => General => Device Management on the device to trust the developer and allow the app to be run (see [Apple documentation for more information](https://support.apple.com/en-us/HT204460)). after that run 'test' again

![untrustedDev](/IntroductionPhoto/untrustedDev.png "untrustedDev")

5. start Success

    when something like this show in log, it means webDricerAgent start success

        Test Suite 'All tests' started at 2017-01-23 15:49:12.585
        Test Suite 'WebDriverAgentRunner.xctest' started at 2017-01-23 15:49:12.586
        Test Suite 'UITestingUITests' started at 2017-01-23 15:49:12.587
        Test Case '-[UITestingUITests testRunner]' started.
        t =     0.00s     Start Test at 2017-01-23 15:49:12.588
        t =     0.00s     Set Up


More about how to start WebDriverAgent [here](https://github.com/facebook/WebDriverAgent/wiki/Starting-WebDriverAgent).
and [here](https://github.com/appium/appium/blob/master/docs/en/drivers/ios-xcuitest-real-devices.md)

### 2. set up proxy
you need to set up proxy to forward request to real device via usb-forwarding
as this may have something wrong, known [Issues](https://github.com/facebook/WebDriverAgent/wiki/Common-Issues) and [detail](https://github.com/facebook/WebDriverAgent/issues/288)

you can use [iproxy](https://github.com/libimobiledevice/libimobiledevice)

    $ brew install libimobiledevice
    $ iproxy 8100 8100

then try to access http://127.0.0.1:8100/status in mac browser, is a json string shown, mean all start success

### 3. Finally
you can use ios device in airtest with http://127.0.0.1:8100

## Known Issues
???

## License
This project is based on [WebDriverAgent](https://github.com/facebook/WebDriverAgent) :


[`WebDriverAgent` is BSD-licensed](LICENSE). We also provide an additional [patent grant](PATENTS).


Have fun with Airtest!
