import QtQuick 2.0
import QtQml 2.2

import org.kde.plasma.configuration 2.0
import org.kde.plasma.calendar 2.0 as PlasmaCalendar

ConfigModel {
    id: configModel

    ConfigCategory {
        name: i18n("General")
        icon: "configure"
        source: "configGeneral.qml"
    }
    ConfigCategory {
        name: i18nd("plasma_applet_org.kde.plasma.digitalclock", "Calendar")
        icon: "office-calendar"
        source: "configCalendar.qml"
    }

    property Instantiator __eventPlugins: Instantiator {
        model: PlasmaCalendar.EventPluginsManager.model
        delegate: ConfigCategory {
            name: model.display
            icon: model.decoration
            source: model.configUi
            visible: plasmoid.configuration.enabledCalendarPlugins.indexOf(model.pluginPath) > -1
        }

        onObjectAdded: configModel.appendCategory(object)
        onObjectRemoved: configModel.removeCategory(object)
    }
}
