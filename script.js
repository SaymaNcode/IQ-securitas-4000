document.addEventListener("DOMContentLoaded", function () {
    const titleText = "Prihláste sa";
    const headerText = "IQ Securitas 4000";
    const dvereNadpis = "Detailné logy z dverí";
    const oknaNadpis = "Detailné logy z okien";
    const senzorNadpis = "Detailné logy senzora";

    let titleIndex = 0;
    let headerIndex = 0;
    let dvereIndex = 0;
    let oknoIndex = 0;
    let senzorIndex = 0;

    function typeTitle() {
        const titleElem = document.getElementById("typing-title");
        if (!titleElem) return;
        titleElem.textContent = titleText.slice(0, titleIndex++);
        if (titleIndex < titleText.length) setTimeout(typeTitle, 250);
    }

    function typeHeader() {
        const headerElem = document.getElementById("header");
        if (!headerElem) return;
        headerElem.textContent = headerText.slice(0, headerIndex++);
        if (headerIndex < headerText.length) setTimeout(typeHeader, 150);
    }

    function typeDvere() {
        const titleElem = document.getElementById("dvereheader");
        if (!titleElem) return;
        titleElem.textContent = dvereNadpis.slice(0, dvereIndex++);
        if (dvereIndex < dvereNadpis.length) setTimeout(typeDvere, 250);
    }

    function typeOkno() {
        const titleElem = document.getElementById("oknoheader");
        if (!titleElem) return;
        titleElem.textContent = oknaNadpis.slice(0, oknoIndex++);
        if (oknoIndex < oknaNadpis.length) setTimeout(typeOkno, 250);
    }

    function typeSenzor() {
        const titleElem = document.getElementById("senzorheader");
        if (!titleElem) return;
        titleElem.textContent = senzorNadpis.slice(0, senzorIndex++);
        if (senzorIndex < senzorNadpis.length) setTimeout(typeSenzor, 250);
    }

    typeTitle();
    typeHeader();
    typeDvere();
    typeOkno();
    typeSenzor();
});


$(document).ready(function() {
    function updateAlarmStatus() {
        $.get("alarm_status.php", function(data) {
            $("#alarm-status").text(data == "1" ? "Zapnutý" : "Vypnutý");
            $("#toggle-alarm").text(data == "1" ? "Vypnúť alarm" : "Zapnúť alarm");
        });
    }

    function updateLogs() {
        $.getJSON("latest_logs.php", function(logs) {
            $(".log-entry").each(function(index) {
                $(this).find("p").text(logs[index].message);
                $(this).find("small").text(logs[index].timestamp);
            });
        });
    }

    function updateUptime() {
        $.get("uptime.php", function(data) {
            $("#uptime").text(data);
        });
    }

    $("#toggle-alarm").click(function() {
        $.post("toggle_alarm.php", function() {
            updateAlarmStatus();
        });
    });

    setInterval(updateAlarmStatus, 5000);
    setInterval(updateLogs, 10000);
    setInterval(updateUptime, 1000);
});

function showHistory(type) {
    alert("Zobrazenie histórie: " + type);
}

