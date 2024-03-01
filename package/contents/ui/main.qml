import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as P5Support
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: main

    preferredRepresentation: compactRepresentation
    property bool onDesktop: plasmoid.location === PlasmaCore.Types.Floating

    property bool visibilityEnabled: plasmoid.configuration.visibilityEnabled
    property bool heightEnabled: plasmoid.configuration.heightEnabled
    property bool floatingEnabled: plasmoid.configuration.floatingEnabled
    property bool locationEnabled: plasmoid.configuration.locationEnabled
    property bool lengthEnabled: plasmoid.configuration.lengthEnabled
    property bool alignmentEnabled: plasmoid.configuration.alignmentEnabled

    property var visibilityMode1: plasmoid.configuration.visibilityMode1Name
    property var visibilityMode2: plasmoid.configuration.visibilityMode2Name

    property var heightMode1: plasmoid.configuration.heightMode1
    property var heightMode2: plasmoid.configuration.heightMode2

    property bool floatingMode1: plasmoid.configuration.floatingMode1
    property bool floatingMode2: plasmoid.configuration.floatingMode2

    property var locationMode1: plasmoid.configuration.locationMode1Name
    property var locationMode2: plasmoid.configuration.locationMode2Name

    property var lengthMode1: plasmoid.configuration.lengthMode1Name
    property var lengthMode2: plasmoid.configuration.lengthMode2Name

    property var alignmentMode1: plasmoid.configuration.alignmentMode1Name
    property var alignmentMode2: plasmoid.configuration.alignmentMode2Name
    property string qdbusExec: plasmoid.configuration.qdbusExecutable

    property bool mode: plasmoid.configuration.mode
    property string iconName: !onDesktop ? (mode ? "mode1" : "mode2") : "error"
    property string icon: Qt.resolvedUrl("../icons/" + iconName + ".svg").toString().replace("file://", "")

    property var panelPosition: {}

    property int nextProperty: 0
    property bool isLoaded: false

    toolTipSubText: onDesktop ? "<font color='"+Kirigami.Theme.neutralTextColor+"'>Panel not found, this widget must be child of a panel</font>" : Plasmoid.metaData.description
    toolTipTextFormat: Text.RichText

    compactRepresentation: CompactRepresentation {
        icon: main.icon
        onDesktop: main.onDesktop
    }

    fullRepresentation: ColumnLayout {}

    onModeChanged: {
        if (!onDesktop) {
            if (!isLoaded) return
            panelPosition = getPanelPosition()
            setPropertyTimer.start()
            executable.exec(qdbusExec + " org.kde.plasmashell /org/kde/osdService org.kde.osdService.showText swap-panels 'Panel mode "+(mode ? "1" : "2")+"'")
        } else {
            executable.exec(qdbusExec + " org.kde.plasmashell /org/kde/osdService org.kde.osdService.showText error 'Panel not found, this widget must be child of a panel'")
        }
        plasmoid.configuration.mode = mode
    }
    

    P5Support.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: function(source) {
            disconnectSource(source) // cmd finished
        }

        function exec(cmd) {
            executable.connectSource(cmd)
        }
    }
    
    function setPanelMode() {
        var setPanelModeScript = `
for (var id of panelIds) {
    var panel = panelById(id);
    if (panel.screen === ${panelPosition.screen} && panel.location === "${panelPosition.location}" ) {
        if (${nextProperty} === 0 && ${visibilityEnabled})
            panel.hiding = ${mode} ? "${visibilityMode1}" : "${visibilityMode2}"
        if (${nextProperty} === 1 && ${heightEnabled})
            panel.height = ${mode} ? ${heightMode1} : ${heightMode2}
        if (${nextProperty} === 2 && ${lengthEnabled})
            panel.lengthMode = ${mode} ? "${lengthMode1}" : "${lengthMode2}"
        if (${nextProperty} === 3 && ${locationEnabled})
            panel.location = ${mode} ? "${locationMode1}" : "${locationMode2}"
        if (${nextProperty} === 4 && ${floatingEnabled})
            panel.floating = ${mode} ? ${floatingMode1} : ${floatingMode2}
        if (${nextProperty} === 5 && ${alignmentEnabled})
            panel.alignment = ${mode} ? "${alignmentMode1}" : "${alignmentMode2}"
        break
    }
}`
        console.log(setPanelModeScript);
        executable.exec(qdbusExec + " org.kde.plasmashell /PlasmaShell evaluateScript '" + setPanelModeScript + "'")
        if (nextProperty == 5) {
            setPropertyTimer.stop()
        }
        nextProperty = (nextProperty < 5) ? (nextProperty + 1) : 0
    }

    function getPanelPosition()
    {
        var location
        var screen = main.screen

        switch (plasmoid.location) {
            case PlasmaCore.Types.TopEdge:
                location = "top"
                break
            case PlasmaCore.Types.BottomEdge:
                location = "bottom"
                break
            case PlasmaCore.Types.LeftEdge:
                location = "left"
                break
            case PlasmaCore.Types.RightEdge:
                location = "right"
                break
        }

        console.log("location:"+location+" screen:"+screen);
        return {"screen":screen, "location": location}
    }

    Timer {
        interval: 1000;
        running: true;
        repeat: false;
        onTriggered: {
            isLoaded = true
            panelPosition = getPanelPosition()
        }
    }

    Timer {
        id: setPropertyTimer
        interval: 50;
        running: false;
        repeat: true;
        onTriggered: {
            setPanelMode()
        }
    }
}
