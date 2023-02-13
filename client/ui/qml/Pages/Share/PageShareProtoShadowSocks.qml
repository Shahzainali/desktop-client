import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ProtocolEnum 1.0
import "../"
import "../../Controls"
import "../../Config"

PageShareProtocolBase {
    id: root
    protocol: ProtocolEnum.ShadowSocks

    BackButton {
        id: back
    }
    Caption {
        id: caption
        text: qsTr("Share ShadowSocks Settings")
    }

    FlickableType {
        id: fl
        anchors.top: caption.bottom
        contentHeight: content.height

        ColumnLayout {
            id: content
            enabled: logic.pageEnabled
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 15

            LabelType {
                id: lb_desc
                Layout.fillWidth: true
                Layout.topMargin: 10

                horizontalAlignment: Text.AlignHCenter

                wrapMode: Text.Wrap
                text: qsTr("Note: ShadowSocks protocol using same password for all connections")
            }

            ShareConnectionButtonType {
                Layout.topMargin: 10
                Layout.fillWidth: true
                Layout.preferredHeight: 40

                text: genConfigProcess ? generatingConfigText : generateConfigText
                onClicked: {
                    enabled = false
                    genConfigProcess = true
                    ShareConnectionLogic.onPushButtonShareShadowSocksGenerateClicked()
                    enabled = true
                    genConfigProcess = false
                }
            }

            TextAreaType {
                id: tfShareCode

                Layout.topMargin: 20
                Layout.preferredHeight: 200
                Layout.fillWidth: true

                textArea.readOnly: true
                textArea.wrapMode: TextEdit.WrapAnywhere
                textArea.verticalAlignment: Text.AlignTop
                textArea.text: ShareConnectionLogic.textEditShareShadowSocksText

                visible: tfShareCode.textArea.length > 0
            }
            ShareConnectionButtonCopyType {
                Layout.preferredHeight: 40
                Layout.fillWidth: true
                Layout.bottomMargin: 20

                start_text: qsTr("Copy config")
                copyText: tfShareCode.textArea.text
            }

            LabelType {
                height: 20
                visible: tfConnString.length > 0
                text: qsTr("Connection string")
            }
            TextFieldType {
                id: tfConnString
                height: 100
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                text: ShareConnectionLogic.lineEditShareShadowSocksStringText
                visible: tfConnString.length > 0

                readOnly: true
            }
            ShareConnectionButtonCopyType {
                Layout.preferredHeight: 40
                Layout.fillWidth: true
                start_text: qsTr("Copy string")
                copyText: tfConnString.text
            }

            Image {
                id: label_share_ss_qr_code
                Layout.topMargin: 20
                Layout.fillWidth: true
                Layout.preferredHeight: width
                smooth: false
                source: ShareConnectionLogic.shareShadowSocksQrCodeText
            }
        }
    }
}
