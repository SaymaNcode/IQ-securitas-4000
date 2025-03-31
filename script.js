const text = "Prihláste sa";
let index = 0;
function type() {
    document.getElementById("typing-title").textContent = text.slice(0, index++);
    if (index <= text.length) setTimeout(type, 150);
}
document.addEventListener("DOMContentLoaded", type);
