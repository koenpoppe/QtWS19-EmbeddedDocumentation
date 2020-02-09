# QtWS19-EmbeddedDocumentation

## Introduction
This repository illustrates the concepts of embedding documentation into QML as was presented on the Qt World Summit 2019 in Berlin ([Abstract][abstract], [Video][video]).

By using attached properties and introspection into the QML view hierarchy, basic instructions can be integrated into the QML code itself and displayed in an interactive manner with only minor code changes.

[abstract]: https://www.qtworldsummit.com/2019/sessions/embedded-documentation-qml/ "Qt World Summit 2019 abstract"
[video]: https://resources.qt.io/qt-world-summit-2019/74-embedded-documentation-with-qml-koen-poppe-vandewiele "Qt World Summit 2019 video"

## Demo application

![Demo application][normal]

If a user is unsure about the functionality behind a control, pressing the '?' in the shows an overlay and highlights all controls or groups of controls with documentation embedded:

![Demo application with overlay activated][overlay]

Selecting one of them shows the brief documentation that was added:

![Demo application with the popover for the media controls][popover]
 
Pressing anywhere else exits the documentation mode and returns to normal operations.

[normal]: /screenshots/normal.png?raw=true "Demo application"
[overlay]: /screenshots/overlay.png?raw=true "Overlay highlighting the controls with documentation"
[popover]: /screenshots/popover.png?raw=true "After selecting the highlighted area, brief documentation is shown"
