document.addEventListener("DOMContentLoaded", function () {
    const titleText = "Prihláste sa";
    const headerText = "IQ Securitas 4000";
    const dvereNadpis = "Detailné logy z dverí";
    const oknaNadpis = "Detailné logy z okien";
    const senzorNadpis = "Detailné logy senzora";
<<<<<<< HEAD

=======
    const infoNadpis = "Informácie o systéme";
    
>>>>>>> 1c51c871243e266e48b8c784336acf723fb40470
    let titleIndex = 0;
    let headerIndex = 0;
    let dvereIndex = 0;
    let oknoIndex = 0;
    let senzorIndex = 0;
    let infoIndex = 0;
    
    function typeTitle() {
        const titleElem = document.getElementById("typing-title");
        if (!titleElem) return;
<<<<<<< HEAD
        titleElem.textContent = titleText.slice(0, titleIndex++);
        if (titleIndex <= titleText.length) setTimeout(typeTitle, 250);
=======
        titleElem.textContent = titleText.slice(0, titleIndex);
        titleIndex++;
        if (titleIndex <= titleText.length) setTimeout(typeTitle, 150);
>>>>>>> 1c51c871243e266e48b8c784336acf723fb40470
    }
    
    function typeHeader() {
        const headerElem = document.getElementById("header");
        if (!headerElem) return;
<<<<<<< HEAD
        headerElem.textContent = headerText.slice(0, headerIndex++);
=======
        headerElem.textContent = headerText.slice(0, headerIndex);
        headerIndex++;
>>>>>>> 1c51c871243e266e48b8c784336acf723fb40470
        if (headerIndex <= headerText.length) setTimeout(typeHeader, 150);
    }
    
    function typeDvere() {
        const titleElem = document.getElementById("dvereheader");
        if (!titleElem) return;
<<<<<<< HEAD
        titleElem.textContent = dvereNadpis.slice(0, dvereIndex++);
        if (dvereIndex <= dvereNadpis.length) setTimeout(typeDvere, 250);
=======
        titleElem.textContent = dvereNadpis.slice(0, dvereIndex);
        dvereIndex++;
        if (dvereIndex <= dvereNadpis.length) setTimeout(typeDvere, 150);
>>>>>>> 1c51c871243e266e48b8c784336acf723fb40470
    }
    
    function typeOkno() {
        const titleElem = document.getElementById("oknoheader");
        if (!titleElem) return;
<<<<<<< HEAD
        titleElem.textContent = oknaNadpis.slice(0, oknoIndex++);
        if (oknoIndex <= oknaNadpis.length) setTimeout(typeOkno, 250);
=======
        titleElem.textContent = oknaNadpis.slice(0, oknoIndex);
        oknoIndex++;
        if (oknoIndex <= oknaNadpis.length) setTimeout(typeOkno, 150);
>>>>>>> 1c51c871243e266e48b8c784336acf723fb40470
    }
    
    function typeSenzor() {
        const titleElem = document.getElementById("senzorheader");
        if (!titleElem) return;
<<<<<<< HEAD
        titleElem.textContent = senzorNadpis.slice(0, senzorIndex++);
        if (senzorIndex <= senzorNadpis.length) setTimeout(typeSenzor, 250);
=======
        titleElem.textContent = senzorNadpis.slice(0, senzorIndex);
        senzorIndex++;
        if (senzorIndex <= senzorNadpis.length) setTimeout(typeSenzor, 150);
    }
    
    function typeInfo() {
        const titleElem = document.getElementById("infoheader");
        if (!titleElem) return;
        titleElem.textContent = infoNadpis.slice(0, infoIndex);
        infoIndex++;
        if (infoIndex <= infoNadpis.length) setTimeout(typeInfo, 150);
>>>>>>> 1c51c871243e266e48b8c784336acf723fb40470
    }

    // Spustenie animácií
    typeTitle();
    typeHeader();
    typeDvere();
    typeOkno();
    typeSenzor();
    typeInfo();
}); 


// jQuery ready blok
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

function viacinfo() {
    window.location.href = 'viac-info.php';
}

function spatdom() {
    window.location.href = 'index.php';
}