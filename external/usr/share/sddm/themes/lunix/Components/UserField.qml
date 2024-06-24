import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: userField
  height: inputHeight
  width: inputWidth
  selectByMouse: true
  echoMode: TextInput.Normal 
  selectionColor: config.overlay0
  renderType: Text.NativeRendering
  font {
    family: config.Font
    pointSize: config.FontSize
    capitalization: Font.Capitalize
    bold: true
  }
  horizontalAlignment: Text.AlignHCenter
  color: config.text 
  placeholderText: "Username"
  text: userModel.lastUser
  background: Rectangle {
    id: userFieldBackground
    color: config.surface0
    radius: 3
  }
  states: [
    State {
      name: "focused"
      when: userField.activeFocus
      PropertyChanges {
        target: userFieldBackground
        color: config.surface1
      }
    },
    State {
      name: "hovered"
      when: userField.hovered
      PropertyChanges {
        target: userFieldBackground
        color: config.surface1
      }
    }
  ]
  transitions: Transition {
    PropertyAnimation {
      properties: "color"
      duration: 300
    }
  }
}
