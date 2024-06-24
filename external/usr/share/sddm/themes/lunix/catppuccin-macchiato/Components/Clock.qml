import QtQuick 2.15
import SddmComponents 2.0

Clock {
  id: time
  color: config.text
  timeFont.family: config.Font
  timeFont.pointSize: 150
  dateFont.family: config.Font
  dateFont.pointSize: 90
  anchors {
    margins: 20
    top: parent.top
    right: parent.right
  }
}
