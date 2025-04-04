const text = "Prihláste sa";
let index = 0;
function type() {
    document.getElementById("typing-title").textContent = text.slice(0, index++);
    if (index <= text.length) setTimeout(type, 250);
}
document.addEventListener("DOMContentLoaded", type);

{
const text = "IQ Securitas 4000";
let index = 0;
function type() {
    document.getElementById("header").textContent = text.slice(0, index++);
    if (index <= text.length) setTimeout(type, 150);
}
document.addEventListener("DOMContentLoaded", type);
}

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
