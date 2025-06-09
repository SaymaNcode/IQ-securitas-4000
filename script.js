document.addEventListener("DOMContentLoaded", function () {
    fetch('get_uptime.php')
        .then(response => response.json())
        .then(data => {
            startApp(data.uptime || 0);
        })
        .catch(() => {
            startApp(0);
        });
});

function startApp(initialUptime) {
    // Typing efekty
    const texts = {
        "typing-title": "Prihláste sa",
        "header": "IQ Securitas 4000",
        "dvereheader": "Detailné logy z dverí",
        "oknoheader": "Detailné logy z okien",
        "senzorheader": "Detailné logy senzora",
        "infoheader": "Informácie o systéme"
    };

    Object.keys(texts).forEach(id => {
        let index = 0;
        const elem = document.getElementById(id);
        if (!elem) return;
        
        function type() {
            elem.textContent = texts[id].slice(0, index++);
            if (index <= texts[id].length) setTimeout(type, id === "header" ? 150 : 250);
        }
        type();
    });

    // Uptime counter
    let uptimeSeconds = initialUptime;
    const uptimeDisplay = document.getElementById('uptime-display');

    function sklonuj(cislo, jednotka) {
        if (cislo === 1) return jednotka[0];
        if (cislo >= 2 && cislo <= 4) return jednotka[1];
        return jednotka[2];
    }

    function updateUptime() {
        uptimeSeconds++;
        const minutes = Math.floor(uptimeSeconds / 60);
        const hours = Math.floor(minutes / 60);
        const days = Math.floor(hours / 24);
        
        let displayText;
        if (days > 0) {
            const remainingHours = hours % 24;
            displayText = `${days} ${sklonuj(days, ['deň', 'dni', 'dní'])}`;
            if (remainingHours > 0) {
                displayText += `, ${remainingHours} ${sklonuj(remainingHours, ['hodina', 'hodiny', 'hodín'])}`;
            }
        } else if (hours > 0) {
            const remainingMinutes = minutes % 60;
            displayText = `${hours} ${sklonuj(hours, ['hodina', 'hodiny', 'hodín'])}`;
            if (remainingMinutes > 0) {
                displayText += `, ${remainingMinutes} ${sklonuj(remainingMinutes, ['minúta', 'minúty', 'minút'])}`;
            }
        } else {
            displayText = `${minutes} ${sklonuj(minutes, ['minúta', 'minúty', 'minút'])}`;
        }
        
        if (uptimeDisplay) uptimeDisplay.textContent = displayText;
    }

    function saveUptime() {
        fetch('update_uptime.php', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: `uptime=${uptimeSeconds}`
        }).catch(console.error);
    }

    function updateStatus() {
        fetch('status_update.php')
            .then(response => response.json())
            .then(data => {
                document.querySelectorAll('.log-box').forEach(box => {
                    const type = box.textContent.includes('senzora') ? 'senzor' : 
                                box.textContent.includes('okien') ? 'okna' : 'dvere';
                    const p = box.querySelector('p');
                    if (p && data.logs?.[type]) {
                        p.textContent = `${data.logs[type].message} o ${data.logs[type].timestamp}`;
                    }
                });
            }).catch(console.error);
    }

    if (uptimeDisplay) setInterval(updateUptime, 1000);
    setInterval(saveUptime, 60000);
    setInterval(updateStatus, 5000);
    window.addEventListener('beforeunload', saveUptime);
}

// Pomocné funkcie
function showHistory(type) {
    alert("Zobrazenie histórie: " + type);
}

function viacinfo() {
    window.location.href = 'viac-info.php';
}

function spatdom() {
    window.location.href = 'index.php';
}
