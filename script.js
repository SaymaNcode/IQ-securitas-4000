document.addEventListener("DOMContentLoaded", function () {
    const titleText = "Prihláste sa";
    const headerText = "IQ Securitas 4000";

    let titleIndex = 0;
    let headerIndex = 0;

    function typeTitle() {
        const titleElem = document.getElementById("typing-title");
        if (!titleElem) return;
        titleElem.textContent = titleText.slice(0, titleIndex++);
        if (titleIndex <= titleText.length) setTimeout(typeTitle, 250);
    }

    function typeHeader() {
        const headerElem = document.getElementById("header");
        if (!headerElem) return;
        headerElem.textContent = headerText.slice(0, headerIndex++);
        if (headerIndex <= headerText.length) setTimeout(typeHeader, 150);
    }

    typeTitle();
    typeHeader();
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

