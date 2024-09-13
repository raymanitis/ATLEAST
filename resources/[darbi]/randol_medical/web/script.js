window.addEventListener('message', function (event) {
    const { type, time, count, level, isDead, msg, emsCount } = event.data;
    switch (type) {
        case 'showDeathScreen': showDeathScreen(time, isDead, msg); updateEMSCount(emsCount); break;
        case 'updateTimer': updateTimer(time, isDead, msg); updateEMSCount(emsCount); break;
        case 'hideDeathScreen': hideDeathScreen(); break;
        case 'bloodSplat': bloodSplats(count); break;
        case 'updateBleedingLevel': updateBleedingLevel(level); break;
        default: console.warn(`tf is this event type bro??: ${type}`); break;
    }
});

function showDeathScreen(time, isDead, msg) {
    const deathOverlay = document.getElementById('death-overlay');
    const redOverlay = document.getElementById('red-overlay');
    deathOverlay.classList.remove('hidden');
    redOverlay.classList.remove('hidden');
    updateTimer(time, isDead, msg);
}

function updateTimer(time, isDead, msg) {
    const timerElement = document.getElementById('timer');

    if (isDead && time <= 0) {
        timerElement.textContent = 'TAGAD TU VARI PĀRCELTIES';
    } else {
        const minutes = Math.floor(time / 60);
        const seconds = time % 60;
        timerElement.textContent = `${msg} ${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
    }
}

function hideDeathScreen() { 
    document.getElementById('death-overlay').classList.add('hidden');
    document.getElementById('red-overlay').classList.add('hidden');
}

function updateBleedingLevel(level) {
    const container = document.getElementById('bleeding-level-container');
    const bleedingLevelElement = document.getElementById('bleeding-level');

    if (level > 0) {
        container.style.display = 'block';
        bleedingLevelElement.value = level;
        container.style.opacity = '1';
    } else {
        container.style.opacity = '0';
        container.addEventListener('transitionend', () => {
        container.style.display = 'none';
        }, { once: true });
    }
}

function bloodSplats(count) {
    const bloodSplatsContainer = document.getElementById('blood-splats');
    const dimOverlay = document.getElementById('dim-overlay');

    dimOverlay.classList.remove('hidden');
    dimOverlay.style.opacity = '0.5';

    for (let i = 0; i < count; i++) {
        const x = Math.random() * window.innerWidth;
        const y = Math.random() * window.innerHeight;
        const bloodSplat = document.createElement('div');

        bloodSplat.classList.add('blood-splat');
        bloodSplat.style.left = `${x}px`;
        bloodSplat.style.top = `${y}px`;

        bloodSplatsContainer.appendChild(bloodSplat);

        setTimeout(() => { bloodSplat.style.opacity = '1'; bloodSplat.style.transform = 'scale(0.5)'; }, 2000);

        setTimeout(() => { bloodSplat.remove(); }, 3000);
    }

    setTimeout(() => { dimOverlay.style.opacity = '0'; setTimeout(() => { dimOverlay.classList.add('hidden'); }, 1000); }, 1000);
}

function updateEMSCount(emsCount) { if (emsCount !== undefined) { document.getElementById('ems-count').textContent = emsCount; } }