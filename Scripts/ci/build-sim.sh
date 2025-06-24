#!/bin/bash

xcodebuild clean build-for-testing \
  -project WebDriverAgent.xcodeproj \
  -derivedDataPath $DERIVED_DATA_PATH \
  -scheme $SCHEME \
  -destination "$DESTINATION" \
  CODE_SIGNING_ALLOWED=NO ARCHS=$ARCHS

pushd $WD

# Simulators might have an issue to lauch if we drop frameworks even we don't use them.
zip -r $ZIP_PKG_NAME $SCHEME-Runner.app
popd
mv $WD/$ZIP_PKG_NAME ./
