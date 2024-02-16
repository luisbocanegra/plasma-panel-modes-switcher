import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.settings
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasma5support as P5Support
import org.kde.plasma.plasmoid
import "components" as Components

KCM.SimpleKCM {
    id:root
    property var textAreaPadding: 10
    property var controlWidth: 48
    signal configurationChanged

    property alias cfg_visibilityEnabled: visibilityEnabled.checked
    property alias cfg_heightEnabled: heightEnabled.checked
    property alias cfg_floatingEnabled: floatingEnabled.checked
    property alias cfg_locationEnabled: locationEnabled.checked
    property alias cfg_lengthEnabled: lengthEnabled.checked
    property alias cfg_alignmentEnabled: alignmentEnabled.checked

    property int cfg_visibilityMode1: plasmoid.configuration.visibilityMode1
    property var cfg_visibilityMode1Name: plasmoid.configuration.visibilityMode1Name
    property int cfg_visibilityMode2: plasmoid.configuration.visibilityMode2
    property var cfg_visibilityMode2Name: plasmoid.configuration.visibilityMode2Name

    property alias cfg_heightMode1: heightMode1.value //plasmoid.configuration.heightMode1
    property alias cfg_heightMode2: heightMode2.value //plasmoid.configuration.heightMode2

    property alias cfg_floatingMode1: floatingMode1.checked
    property alias cfg_floatingMode2: floatingMode2.checked

    property int cfg_locationMode1: plasmoid.configuration.locationMode1
    property var cfg_locationMode1Name: plasmoid.configuration.locationMode1Name
    property int cfg_locationMode2: plasmoid.configuration.locationMode2
    property var cfg_locationMode2Name: plasmoid.configuration.locationMode2Name

    property int cfg_lengthMode1: plasmoid.configuration.lengthMode1
    property var cfg_lengthMode1Name: plasmoid.configuration.lengthMode1Name
    property int cfg_lengthMode2: plasmoid.configuration.lengthMode2
    property var cfg_lengthMode2Name: plasmoid.configuration.lengthMode2Name

    property int cfg_alignmentMode1: plasmoid.configuration.alignmentMode1
    property var cfg_alignmentMode1Name: plasmoid.configuration.alignmentMode1Name

    property int cfg_alignmentMode2: plasmoid.configuration.alignmentMode2
    property var cfg_alignmentMode2Name: plasmoid.configuration.alignmentMode2Name


    Kirigami.FormLayout {
        id: generalPage
        Layout.alignment: Qt.AlignTop

        // Label {
        //     text: i18n("Show engine icon when utilization is above the specified thresholds.\nThe priority is the order in which they appear here (descending)")
        //     font: Kirigami.Theme.smallFont
        //     opacity: 0.7
        // }


        // Visibility ----------------------------------------------------------
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Visibility"
        }
        CheckBox {
            Kirigami.FormData.label: i18n("Enabled:")
            id: visibilityEnabled
        }

        // --- Mode 1
        RadioButton {
            Kirigami.FormData.label: i18n("Mode 1:")
            text: i18n("Always visible")
            ButtonGroup.group: visibilityMode1Group
            property string visibilityName: "none"
            property int index: 0
            checked: Plasmoid.configuration.visibilityMode1 === index
            enabled: cfg_visibilityEnabled
        }

        RadioButton {
            text: i18n("Auto hide")
            ButtonGroup.group: visibilityMode1Group
            property string visibilityName: "autohide"
            property int index: 1
            checked: Plasmoid.configuration.visibilityMode1 === index
            enabled: cfg_visibilityEnabled
        }

        RadioButton {
            text: i18n("Dodge windows")
            ButtonGroup.group: visibilityMode1Group
            property string visibilityName: "dodgewindows"
            property int index: 2
            checked: Plasmoid.configuration.visibilityMode1 === index
            enabled: cfg_visibilityEnabled
        }

        RadioButton {
            text: i18n("Windows go below")
            ButtonGroup.group: visibilityMode1Group
            property string visibilityName: "windowsgobelow"
            property int index: 3
            checked: Plasmoid.configuration.visibilityMode1 === index
            enabled: cfg_visibilityEnabled
        }

        ButtonGroup {
            id: visibilityMode1Group
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_visibilityMode1 = checkedButton.index
                    cfg_visibilityMode1Name = checkedButton.visibilityName
                }
            }
        }

        // --- Mode 2
        RadioButton {
            Kirigami.FormData.label: i18n("Mode 2:")
            text: i18n("Always visible")
            ButtonGroup.group: visibilityMode2Group
            property string visibilityName: "none"
            property int index: 0
            checked: Plasmoid.configuration.visibilityMode2 === index
            enabled: cfg_visibilityEnabled
        }

        RadioButton {
            text: i18n("Auto hide")
            ButtonGroup.group: visibilityMode2Group
            property string visibilityName: "autohide"
            property int index: 1
            checked: Plasmoid.configuration.visibilityMode2 === index
            enabled: cfg_visibilityEnabled
        }

        RadioButton {
            text: i18n("Dodge windows")
            ButtonGroup.group: visibilityMode2Group
            property string visibilityName: "dodgewindows"
            property int index: 2
            checked: Plasmoid.configuration.visibilityMode2 === index
            enabled: cfg_visibilityEnabled
        }

        RadioButton {
            text: i18n("Windows go below")
            ButtonGroup.group: visibilityMode2Group
            property string visibilityName: "windowsgobelow"
            property int index: 3
            checked: Plasmoid.configuration.visibilityMode2 === index
            enabled: cfg_visibilityEnabled
        }

        ButtonGroup {
            id: visibilityMode2Group
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_visibilityMode2 = checkedButton.index
                    cfg_visibilityMode2Name = checkedButton.visibilityName
                }
            }
        }

        // Height --------------------------------------------------------------
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Height"
        }
        CheckBox {
            Kirigami.FormData.label: i18n("Enabled:")
            id: heightEnabled
        }

        // --- Mode 1
        SpinBox {
            Kirigami.FormData.label: i18n("Mode 1:")
            id: heightMode1
            enabled: cfg_heightEnabled
            // text: i18n("Always visible")
            // ButtonGroup.group: visibilityMode1Group
            // property string visibilityName: "none"
            // property int index: 0
            // checked: Plasmoid.configuration.visibilityMode1 === index
            from: 32
            // onValueModified: {
            //     cfg_heightMode1 = value
            // }
        }

        // --- Mode 2
        SpinBox {
            Kirigami.FormData.label: i18n("Mode 2:")
            id: heightMode2
            enabled: cfg_heightEnabled
            // text: i18n("Always visible")
            // ButtonGroup.group: visibilityMode1Group
            // property string visibilityName: "none"
            // property int index: 0
            // checked: Plasmoid.configuration.visibilityMode1 === index
            from: 32
            // onValueModified: {
            //     cfg_heightMode2 = value
            // }
        }

        // Floating --------------------------------------------------------------
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Floating"
        }
        CheckBox {
            Kirigami.FormData.label: i18n("Enabled:")
            id: floatingEnabled
        }

        // --- Mode 1
        CheckBox {
            Kirigami.FormData.label: i18n("Mode 1:")
            id: floatingMode1
            enabled: cfg_floatingEnabled
        }

        // --- Mode 2
        CheckBox {
            Kirigami.FormData.label: i18n("Mode 2:")
            id: floatingMode2
            enabled: cfg_floatingEnabled
        }

        // Location ------------------------------------------------------------
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Location"
        }
        CheckBox {
            Kirigami.FormData.label: i18n("Enabled:")
            id: locationEnabled
        }

        // --- Mode 1
        RadioButton {
            Kirigami.FormData.label: i18n("Mode 1:")
            text: i18n("Top")
            ButtonGroup.group: locationMode1Group
            property string locationName: "top"
            property int index: 0
            checked: Plasmoid.configuration.locationMode1 === index
            enabled: cfg_locationEnabled
        }

        RadioButton {
            text: i18n("Bottom")
            ButtonGroup.group: locationMode1Group
            property string locationName: "bottom"
            property int index: 1
            checked: Plasmoid.configuration.locationMode1 === index
            enabled: cfg_locationEnabled
        }

        RadioButton {
            text: i18n("Left")
            ButtonGroup.group: locationMode1Group
            property string locationName: "left"
            property int index: 2
            checked: Plasmoid.configuration.locationMode1 === index
            enabled: cfg_locationEnabled
        }

        RadioButton {
            text: i18n("Right")
            ButtonGroup.group: locationMode1Group
            property string locationName: "right"
            property int index: 3
            checked: Plasmoid.configuration.locationMode1 === index
            enabled: cfg_locationEnabled
        }

        ButtonGroup {
            id: locationMode1Group
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_locationMode1 = checkedButton.index
                    cfg_locationMode1Name = checkedButton.locationName
                }
            }
        }

        // --- Mode 2
        RadioButton {
            Kirigami.FormData.label: i18n("Mode 2:")
            text: i18n("Top")
            ButtonGroup.group: locationMode2Group
            property string locationName: "top"
            property int index: 0
            checked: Plasmoid.configuration.locationMode2 === index
            enabled: cfg_locationEnabled
        }

        RadioButton {
            text: i18n("Bottom")
            ButtonGroup.group: locationMode2Group
            property string locationName: "bottom"
            property int index: 1
            checked: Plasmoid.configuration.locationMode2 === index
            enabled: cfg_locationEnabled
        }

        RadioButton {
            text: i18n("Left")
            ButtonGroup.group: locationMode2Group
            property string locationName: "left"
            property int index: 2
            checked: Plasmoid.configuration.locationMode2 === index
            enabled: cfg_locationEnabled
        }

        RadioButton {
            text: i18n("Right")
            ButtonGroup.group: locationMode2Group
            property string locationName: "right"
            property int index: 3
            checked: Plasmoid.configuration.locationMode2 === index
            enabled: cfg_locationEnabled
        }

        ButtonGroup {
            id: locationMode2Group
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_locationMode2 = checkedButton.index
                    cfg_locationMode2Name = checkedButton.locationName
                }
            }
        }


        // Length --------------------------------------------------------------
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Length mode"
        }
        CheckBox {
            Kirigami.FormData.label: i18n("Enabled:")
            id: lengthEnabled
        }

        // --- Mode 1
        RadioButton {
            Kirigami.FormData.label: i18n("Mode 1:")
            text: i18n("Fill")
            ButtonGroup.group: lengthMode1Group
            property string lengthName: "fill"
            property int index: 0
            checked: Plasmoid.configuration.lengthMode1 === index
            enabled: cfg_lengthEnabled
        }

        RadioButton {
            text: i18n("Fit")
            ButtonGroup.group: lengthMode1Group
            property string lengthName: "fit"
            property int index: 1
            checked: Plasmoid.configuration.lengthMode1 === index
            enabled: cfg_lengthEnabled
        }

        ButtonGroup {
            id: lengthMode1Group
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_lengthMode1 = checkedButton.index
                    cfg_lengthMode1Name = checkedButton.lengthName
                }
            }
        }

        // --- Mode 2
        RadioButton {
            Kirigami.FormData.label: i18n("Mode 2:")
            text: i18n("Fill")
            ButtonGroup.group: lengthMode2Group
            property string lengthName: "fill"
            property int index: 0
            checked: Plasmoid.configuration.lengthMode2 === index
            enabled: cfg_lengthEnabled
        }

        RadioButton {
            text: i18n("Fit")
            ButtonGroup.group: lengthMode2Group
            property string lengthName: "fit"
            property int index: 1
            checked: Plasmoid.configuration.lengthMode2 === index
            enabled: cfg_lengthEnabled
        }

        ButtonGroup {
            id: lengthMode2Group
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_lengthMode2 = checkedButton.index
                    cfg_lengthMode2Name = checkedButton.lengthName
                }
            }
        }


        // Alignment ------------------------------------------------------------
        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: "Alignment"
        }
        CheckBox {
            Kirigami.FormData.label: i18n("Enabled:")
            id: alignmentEnabled
        }

        // --- Mode 1
        RadioButton {
            Kirigami.FormData.label: i18n("Mode 1:")
            text: i18n("Left")
            ButtonGroup.group: alignmentMode1Group
            property string alignmentName: "left"
            property int index: 0
            checked: Plasmoid.configuration.alignmentMode1 === index
            enabled: cfg_alignmentEnabled
        }

        RadioButton {
            text: i18n("Center")
            ButtonGroup.group: alignmentMode1Group
            property string alignmentName: "center"
            property int index: 1
            checked: Plasmoid.configuration.alignmentMode1 === index
            enabled: cfg_alignmentEnabled
        }

        RadioButton {
            text: i18n("Right")
            ButtonGroup.group: alignmentMode1Group
            property string alignmentName: "right"
            property int index: 2
            checked: Plasmoid.configuration.alignmentMode1 === index
            enabled: cfg_alignmentEnabled
        }

        ButtonGroup {
            id: alignmentMode1Group
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_alignmentMode1 = checkedButton.index
                    cfg_alignmentMode1Name = checkedButton.alignmentName
                }
            }
        }

        // --- Mode 2
        RadioButton {
            Kirigami.FormData.label: i18n("Mode 2:")
            text: i18n("Left")
            ButtonGroup.group: alignmentMode2Group
            property string alignmentName: "fill"
            property int index: 0
            checked: Plasmoid.configuration.alignmentMode2 === index
            enabled: cfg_alignmentEnabled
        }

        RadioButton {
            text: i18n("Center")
            ButtonGroup.group: alignmentMode2Group
            property string alignmentName: "center"
            property int index: 1
            checked: Plasmoid.configuration.alignmentMode2 === index
            enabled: cfg_alignmentEnabled
        }

        RadioButton {
            text: i18n("Right")
            ButtonGroup.group: alignmentMode2Group
            property string alignmentName: "right"
            property int index: 2
            checked: Plasmoid.configuration.alignmentMode2 === index
            enabled: cfg_alignmentEnabled
        }

        ButtonGroup {
            id: alignmentMode2Group
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_alignmentMode2 = checkedButton.index
                    cfg_alignmentMode2Name = checkedButton.alignmentName
                }
            }
        }
    }
}
