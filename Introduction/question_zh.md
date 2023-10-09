# Q & A

## Xcode版本
不同版本的Xcode需要在指定版本的mac os系统下安装，能开发指定版本的iOS，具体可参考[维基百科](https://en.wikipedia.org/wiki/Xcode)

![versions](/Introduction/versions.png "versions")

高版本 Xcode 不能在低版本 macOS 下安装，强行下载 xip 安装包进行安装，在解压的时候也会出现如下问题。如出现如`cpio read error:Undefined error:0` 、  `应用程序Xcode的这个版本不能与此版本的OS X配合使用`等问题，最好还是更新 os 系统或者更换低版本Xcode

![version_not_match](/Introduction/version_not_match.png "version_not_match")



## 开发者证书
部署iOS测试平台需要苹果开发者证书，现在使用个人Apple ID登陆即可，不需要另外注册付费开发者账号


## 登陆开发者账号
开发者账号登陆过程为 `Xcode` -> `Preferences` -> `Accounts` -> `Manage Certificates` -> 左栏下方 `+` -> `iOS Development`，如有遇到其他问题，可自行百度

<img src="login.png" alt="login" tittle="login" width="50%"  height="50%">


## 设置开发者证书
登陆后，需在项目设置开发者证书，具体步骤为`WebDriverAgent` -> `WebDriverAgent-Runner` -> `General` -> `Signing` 选择自己的开发者证书

<img src="signing.png" alt="signing" tittle="signing" width="70%"  height="70%">


## buddle identifier
使用了免费开发者证书的用户，可能会遇到问题 `Xcode failed to create provisioning profile` 

<img src="FailID.png" alt="FailID" tittle="FailID" width="50%"  height="50%">

可以通过修改 `Build Settings` -> `Product Bundle Identifier`解决。Xcode会联网检查Product Bundle Identifier，此字段要求唯一标志，多试几个，总有可以的。如 ('com.xxx.webDriverAgent-test123')

![bundleId](/Introduction/bundleId.png "set up bundleId")


## 信任设备
第一次安装 iOS-Tagent 的时候，你会遇到下面的错误提示框。这时候需要信任应用程序才可以进行启动，在手机上 `设置` -> `通用` -> `设备管理` 从而对应用程序进行信任，才可以进行运行 (可以查看 [Apple documentation](https://support.apple.com/en-us/HT204460))。之后 Xcode 重新启动`test`即可，会黑屏一下接着正常执行。

![untrusted](/Introduction/untrusted.jpg "untrusted")

![trust_dev](/Introduction/trust_dev.png "trust_dev")
