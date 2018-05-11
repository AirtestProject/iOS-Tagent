iOS-Tagent Introduction
====================================

.. image:: ./IntroductionPhoto/ios-airtestIDE.gif

iOS-Tagent is a project based on facebook `WebDriverAgent <https://github.com/facebook/WebDriverAgent>`_ .
and intend to fit `AirtestProject <http://airtest.netease.com/>`_.

`中文文档 <./README_chs.rst>`_

To use airtest and airtestIDE on iOS, this project is required

This Project is worked well in **xcode 9** + **iOS 11**, other version of xcode and iOS version is not fully tested

::

    this project is open beta status now
    if you have problem with this project please goto `Issues <https://github.com/AirtestProject/iOS-Tagent/issues>`_

Api status
------------------------------------
This project intend to work with `airtest-ide <http://airtest.netease.com/>`_ and `Airtest Framework <https://github.com/AirtestProject/Airtest>`_

Common Api in airtest is supported

    - start_app: OK
    - stop_app: OK
    - snapshot: OK
    - home:     OK
    - touch:    OK
    - swipe:    OK
    - text:     OK
    - wait:     OK
    - exists:   OK
    - find_all: OK
    - assert_exists: OK
    - assert_not_exists: OK


except:

    - wake: Now supported now (may use 'home' instead)
    - keyevent: Only support 'home' event
    - clear_app:  Not supported now
    - install:  Not supported now
    - uninstall: Not supported now


Getting Started
------------------------------------

prerequisite
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    | 1. iOS Provisioning Profile(Certificate) (free or paid)
    | 2. basic experience with xcode

You can simply open `WebDriverAgent.xcodeproj` and start `WebDriverAgentRunner` test

and start do what you want with `Airtest <http://airtest.netease.com/>`_
(with iOS http url)

Start manual
------------------------------------

1. run the agent
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


1. set up an signing in WebDriverAgent -> WebDriverAgent-Runner-> General -> signing.
    .. image: ./IntroductionPhoto/signing.png

2. if a free personal certificate used

    This will manifest as something like an error that Xcode failed to create provisioning profile:

    .. image:: ./IntroductionPhoto/FailID.png

    please change 'Build Settings' ->"Product Bundle Identifier" into somethings else. like 'com.xxx.webDriverAgent-test123'


    .. image:: ./IntroductionPhoto/bundleId.png

3. perform test in a selected device

choose device first
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    .. image:: ./IntroductionPhoto/chooseDevice.png

choose schema next
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    .. image:: ./IntroductionPhoto/chooseScheme.png

finally: Product -> Test
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    .. image:: ./IntroductionPhoto/runTest.png

    or

    .. image:: ./IntroductionPhoto/ProductTest.jpg


4. | also you need trust the application. You can go to Settings => General => Device Management on the device
   | to trust the developer and allow the app to be run
   | (see `Apple documentation for more information <https://support.apple.com/en-us/HT204460>`_ ).
   | after that run 'test' again


    .. image :: ./IntroductionPhoto/untrustedDev.png

5. start Success

    when something like this show in log, it means webDricerAgent start success
    ::

        Test Suite 'All tests' started at 2017-01-23 15:49:12.585
        Test Suite 'WebDriverAgentRunner.xctest' started at 2017-01-23 15:49:12.586
        Test Suite 'UITestingUITests' started at 2017-01-23 15:49:12.587
        Test Case '-[UITestingUITests testRunner]' started.
        t =     0.00s     Start Test at 2017-01-23 15:49:12.588
        t =     0.00s     Set Up


More about how to start WebDriverAgent  `here <https://github.com/facebook/WebDriverAgent/wiki/Starting-WebDriverAgent>`_.
and `another <https://github.com/appium/appium/blob/master/docs/en/drivers/ios-xcuitest-real-devices.md>`_

2. set up proxy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

you need to set up proxy to forward request to real device via usb-forwarding
as this may have something wrong, known `Issues <https://github.com/facebook/WebDriverAgent/wiki/Common-Issues>`_
and `detail <https://github.com/facebook/WebDriverAgent/issues/288>`_

you can use `iproxy <https://github.com/libimobiledevice/libimobiledevice>`_

::

    $ brew install libimobiledevice
    $ iproxy 8100 8100

then try to access http://127.0.0.1:8100/status in mac browser, is a json string shown, mean all start success

3. Finally
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
you can use iOS device in airtest with http://127.0.0.1:8100

Known Issues
-----------------------------------
https://github.com/AirtestProject/iOS-Tagent/issues

License
-----------------------------------

This project is based on `WebDriverAgent <https://github.com/facebook/WebDriverAgent>`_ :


`**WebDriverAgent** is BSD-licensed <./LICENSE>`_ . We also provide an additional `patent grant <./PATENTS>`_.


Have fun with Airtest!
