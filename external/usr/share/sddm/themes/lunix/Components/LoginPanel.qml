import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Item {
  property var user: userField.text.toLowerCase()
  property var password: passwordField.text
  property var session: sessionPanel.session
  property var inputHeight: 150
  property var inputWidth: 1000
  Rectangle {
    id: loginBackground
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    height: inputHeight * 5.3
    width: inputWidth * 1.2
    radius: 10
    visible: config.LoginBackground == "true" ? true : false
    color: config.mantle
  }
  Column {
    spacing:20
    anchors {
      bottom: parent.bottom
      left: parent.left
    }
    PowerButton {
      id: powerButton
    }
    RebootButton {
      id: rebootButton
    }
    SleepButton {
      id: sleepButton
    }
    z: 5
  }
  Column {
    spacing: 20
    anchors {
      bottom: parent.bottom
      right: parent.right
    }
    SessionPanel {
      id: sessionPanel
    }
    z: 5
  }
  Column {
    spacing: 50
    z: 5
    width: inputWidth
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    UserField {
      id: userField
      height: inputHeight
      width: parent.width
    }
    PasswordField {
      id: passwordField
      height: inputHeight
      width: parent.width
      onAccepted: loginButton.clicked()
    }
    Button {
      id: loginButton
      height: inputHeight * 0.8
      width: parent.width * 0.8
      enabled: user != "" && password != "" ? true : false
      hoverEnabled: true
      anchors {
        horizontalCenter: parent.horizontalCenter
      }
      contentItem: Text {
        id: buttonText
        renderType: Text.NativeRendering
        font {
          family: config.Font
          pointSize: config.FontSize * 0.6
          bold: true
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.crust
        text: "Login"
      }
      background: Rectangle {
        id: buttonBackground
        color: config.sapphire
        radius: 3
      }
      states: [
        State {
          name: "pressed"
          when: loginButton.down
          PropertyChanges {
            target: buttonBackground
            color: config.teal
          }
          PropertyChanges {
            target: buttonText
          }
        },
        State {
          name: "hovered"
          when: loginButton.hovered
          PropertyChanges {
            target: buttonBackground
            color: config.teal
          }
          PropertyChanges {
            target: buttonText
          }
        },
        State {
          name: "enabled"
          when: loginButton.enabled
          PropertyChanges {
            target: buttonBackground
          }
          PropertyChanges {
            target: buttonText
          }
        }
      ]
      transitions: Transition {
        PropertyAnimation {
          properties: "color"
          duration: 300
        }
      }
      onClicked: {
        sddm.login(user, password, session)
      }
    }
  }
  Connections {
    target: sddm

    function onLoginFailed() {
      passwordField.text = ""
      passwordField.focus = true
    }
  }
}
