import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../Themes" as Theme
import "."

Rectangle {
    id: root
    property string username: Theme.Config.githubUsername
    property var contributionData: []
    property var gridData: []

    readonly property int tileWidth:  Dimensions.tileWidth
    readonly property int tileHeight: Dimensions.tileHeight
    readonly property int squareSpacing: Dimensions.tileGap
    readonly property int maxWeeks: 45

    color: Theme.Colors.color0
    radius: Dimensions.radius
    border.width: Dimensions.border
    border.color: Theme.Colors.color9

    implicitWidth: {
        const weeks = Math.max(1, Math.ceil(gridData.length / 7));
        return weeks * (tileWidth + squareSpacing) + Dimensions.graphMargin * 2;
    }
    implicitHeight: Dimensions.minGraphHeight

    Process {
        id: githubFetch
        command: []
        running: false
        Component.onCompleted: {
            if (!username) return;
            const url = `https://github-contributions-api.jogruber.de/v4/${username}`;
            console.log("Requesting:", url);
            command = ["curl", "-s", "-L", url];
            running = true;
        }
        stdout: SplitParser {
            onRead: data => {
                console.log("RAW reply:", data);
                try {
                    const rsp = JSON.parse(data);
                    let today = new Date();
                    today.setHours(0, 0, 0, 0);
                    let yearStart = new Date(today.getFullYear(), 0, 1);
                    contributionData = rsp.contributions.filter(
                        d => {
                            const dd = new Date(d.date);
                            return dd >= yearStart && dd <= today;
                        }
                    );
                    console.log(`Loaded ${contributionData.length} days`);
                    organiseGridData();
                } catch (e) {
                    console.error("Failed to parse GitHub data:", e);
                }
            }
        }
    }

    Timer {
        interval: 3600000
        running: true
        repeat: true
        onTriggered: githubFetch.running = true
    }

    function organiseGridData() {
        const MAX_WEEKS = maxWeeks;
        gridData = [];
        if (!contributionData.length) return;

        const firstDate = new Date(contributionData[0].date);
        const lastDate = new Date(contributionData[contributionData.length - 1].date);

        let firstWeekStart = new Date(firstDate);
        firstWeekStart.setDate(firstDate.getDate() - firstDate.getDay());
        let lastWeekStart = new Date(lastDate);
        lastWeekStart.setDate(lastDate.getDate() - lastDate.getDay());

        const totalWeeks = Math.ceil((lastWeekStart - firstWeekStart) / (7 * 24 * 60 * 60 * 1000)) + 1;

        let weekGrid = [];
        for (let w = 0; w < totalWeeks; ++w) {
            weekGrid[w] = [];
            for (let d = 0; d < 7; ++d)
                weekGrid[w][d] = {level: 0, count: 0, date: ""};
        }

        contributionData.forEach(day => {
            const date = new Date(day.date);
            const weekIndex = Math.floor((date - firstWeekStart) / (7 * 24 * 60 * 60 * 1000));
            const dayIndex = date.getDay();
            if (weekIndex >= 0 && weekIndex < totalWeeks)
                weekGrid[weekIndex][dayIndex] = day;
        });

        if (totalWeeks > MAX_WEEKS)
            weekGrid = weekGrid.slice(totalWeeks - MAX_WEEKS);

        let columnFirst = [];
        for (let w = 0; w < weekGrid.length; ++w)
            for (let d = 0; d < 7; ++d)
                columnFirst.push(weekGrid[w][d]);
        gridData = columnFirst;
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Dimensions.graphMargin
        spacing: Dimensions.spacing

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: Dimensions.headerHeight
            spacing: 0

            Text {
                text: username ? `@${username}'s Contributions` : "Loading…"
                color: Theme.Colors.color15
                font.pixelSize: Dimensions.graphUsernameFontSize
                font.bold: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }

            Item { Layout.fillWidth: true }

            Text {
                text: contributionData.length
                      ? `${contributionData.reduce((sum, d) => sum + d.count, 0)} total`
                      : ""
                color: Theme.Colors.color15
                font.pixelSize: Dimensions.graphTotalFontSize
                font.bold: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Grid {
                id: contributionGrid
                anchors.centerIn: parent
                columns: Math.max(1, Math.ceil(gridData.length / 7))
                rows: 7
                columnSpacing: squareSpacing
                rowSpacing: squareSpacing
                flow: Grid.TopToBottom

                Repeater {
                    model: gridData.length

                    Rectangle {
                        id: rect
                        width: tileWidth
                        height: tileHeight
                        radius: 2

                        property var day: gridData[index] || {level: 0, count: 0, date: ""}

                        color: {
                            switch (day.level) {
                                case 0: return Theme.Colors.conlevel1
                                case 1: return Theme.Colors.conlevel2
                                case 2: return Theme.Colors.conlevel3
                                case 3: return Theme.Colors.conlevel4
                                case 4: return Theme.Colors.conlevel5
                                default: return Theme.Colors.conlevel1
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }
                }
            }
        }
    }
}