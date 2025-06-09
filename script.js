document.addEventListener("DOMContentLoaded", function () {
    const titleText = "Prihláste sa";
    const headerText = "IQ Securitas 4000";
    const dvereNadpis = "Detailné logy z dverí";
    const oknaNadpis = "Detailné logy z okien";
    const senzorNadpis = "Detailné logy senzora";
    const infoNadpis = "Informácie o systéme";

    let titleIndex = 0;
    let headerIndex = 0;
    let dvereIndex = 0;
    let oknoIndex = 0;
    let senzorIndex = 0;
    let infoIndex= 0;
    
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
    
    function typeDvere() {
        const titleElem = document.getElementById("dvereheader");
        if (!titleElem) return;
        titleElem.textContent = dvereNadpis.slice(0, dvereIndex++);
        if (dvereIndex <= dvereNadpis.length) setTimeout(typeDvere, 250);
    }
    
    function typeOkno() {
        const titleElem = document.getElementById("oknoheader");
        if (!titleElem) return;
        titleElem.textContent = oknaNadpis.slice(0, oknoIndex++);
        if (oknoIndex <= oknaNadpis.length) setTimeout(typeOkno, 250);
    }
    
    function typeSenzor() {
        const titleElem = document.getElementById("senzorheader");
        if (!titleElem) return;
        titleElem.textContent = senzorNadpis.slice(0, senzorIndex++);
        if (senzorIndex <= senzorNadpis.length) setTimeout(typeSenzor, 250);
    }

    // Spustenie animácií
    typeTitle();
    typeHeader();
    typeDvere();
    typeOkno();
    typeSenzor();
    typeInfo();
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