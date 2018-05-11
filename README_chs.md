# WebDriverAgent-Evo 介绍

![ios-airtestIDE](/IntroductionPhoto/ios-airtestIDE.gif "ios-airtestIDE")

WebDriverAgent-Evo 是基于 facebook 的 [WebDriverAgent](https://github.com/facebook/WebDriverAgent) 项目上进行开发的 , 目的是为了对 [AirtestProject](http://airtest.netease.com/) 提供iOS平台的测试支持，在原项目的基础上进行了定制化的优化和功能调整。

如果需要使用airtest项目对iOS平台进行测试，需要部署此项目来完成对iOS手机的操作

这个项目基于Xcode9 + iOS 11 平台进行开发和测试，其他版本的xcode和iOS未经完整测试，可能会出现非预期的错误情况。


>现在这个项目在公开测试状态，会存在一些问题，如果对于这个项目有问题和反馈建议，可以到 [Issues](https://github.com/AirtestProject/iOS-Tagent/issues)里进行提出.


## 开始部署

### 前置要求
    1. 需要iOS的开发者证书，付费的免费的均可。
    2. 需要了解xcode的基础操作和用法

总体上，可以就直接打开`WebDriverAgent.xcodeproj`，并且使用 'test' 模式在设备上启动`WebDriverAgentRunner` 即可。

之后可以利用[Airtest](http://airtest.netease.com/)项目对iOS平台的应用程序进行测试(使用iOS对应的url方式)。


## 部署教程

### 1. 启动客户端

1. 需要设置开发者证书，可以通过  WebDriverAgent -> WebDriverAgent-Runner-> General -> signing 选择自己的开发者证书
![set up signing](/IntroductionPhoto/signing.png "set up signing")


2. 如果使用了免费的开发者证书

    可能会出现，比如 'Xcode failed to create provisioning profile' 这样的错误

![FailID](/IntroductionPhoto/FailID.png "set up id Fail")

可以通过修改 'Build Settings' ->"Product Bundle Identifier" , 将Product Bundle Identifier修改成xcode可以接受的名字即可如('com.xxx.webDriverAgent-test123')

![bundleId](/IntroductionPhoto/bundleId.png "set up bundleId")

3. 在选定设备上启动项目

#### 首先选择需要启动的设备

![chooseDevice](/IntroductionPhoto/chooseDevice.png "chooseDevice")

#### 选择启动的Scheme，选择WebDriverAgentRunner

![chooseScheme](/IntroductionPhoto/chooseScheme.png "chooseScheme")

#### 最后，选择Product->Test 启动项目
![runTest](/IntroductionPhoto/runTest.png "runTest")

点击启动或从菜单里选择启动

![ProductTest](/IntroductionPhoto/ProductTest.jpg "ProductTest")


4. 第一次安装的时候，你需要信任应用程序才可以进行启动，可以选择 Settings -> General -> Device Management 从而对应用程序进行信任，才可以进行运行 (可以查看 [Apple documentation](https://support.apple.com/en-us/HT204460)). 之后重新启动'test'即可，会黑屏一下接着返回。

![untrustedDev](/IntroductionPhoto/untrustedDev.png "untrustedDev")

5. 启动成功

    当你看到这样的日志的时候代表项目已经启动成功了

        Test Suite 'All tests' started at 2017-01-23 15:49:12.585
        Test Suite 'WebDriverAgentRunner.xctest' started at 2017-01-23 15:49:12.586
        Test Suite 'UITestingUITests' started at 2017-01-23 15:49:12.587
        Test Case '-[UITestingUITests testRunner]' started.
        t =     0.00s     Start Test at 2017-01-23 15:49:12.588
        t =     0.00s     Set Up


可以从以下了解更多的关于如何成功启动这个项目的方法 [here](https://github.com/facebook/WebDriverAgent/wiki/Starting-WebDriverAgent).
和 [here](https://github.com/appium/appium/blob/master/docs/en/drivers/ios-xcuitest-real-devices.md)

### 2. 设置代理
一般情况下，需要通过设置usb代理的方式访问手机上的Agent，直接通过wifi对手机进行访问可能会出现问题，具体的原因可以参考 [Issues](https://github.com/facebook/WebDriverAgent/wiki/Common-Issues) 和 [detail](https://github.com/facebook/WebDriverAgent/issues/288)

可以使用 [iproxy](https://github.com/libimobiledevice/libimobiledevice) 进行usb代理

    $ brew install libimobiledevice
    $ iproxy 8100 8100

启动成功后，可以试着访问http://127.0.0.1:8100/status 在mac电脑的xcode上，如果访问成功并且可以看到一些json格式的手机信息，即表示启动成功。


### 3. 最后，使用
在启动成功之后可以通过 http://127.0.0.1:8100 这个地址， 填入Airtest或者Airtest-ide栏目中的方式，使用 Airtest 或者 Airtest-ide 对iOS设备上的应用程序进行测试

## Known Issues

https://github.com/AirtestProject/iOS-Tagent/issues

## License
这个项目基于[WebDriverAgent](https://github.com/facebook/WebDriverAgent) 进行了定制化的开发和优化:


[`WebDriverAgent` is BSD-licensed](LICENSE). We also provide an additional [patent grant](PATENTS).


Have fun with Airtest!
