let Organizations;
let dataAreLoad = false;
let config = { };

function changeColor(newHexColor, duration) {

    const currentHexColor = getComputedStyle(document.documentElement).getPropertyValue('--main-color').trim();
    const steps = 150;
    const intervalTime = duration / steps;
    let currentStep = 0;

    const currentColorValues = hexToRgb(currentHexColor);
    const newColorValues = hexToRgb(newHexColor);

    if (!currentColorValues || !newColorValues) {
        console.error('Invalid hex color');
        return;
    }

    const colorInterval = setInterval(() => {
        const newStepColor = currentColorValues.map((c, i) => {
            return Math.round(c + ((newColorValues[i] - c) * currentStep / steps));
        });


        $("html").css("--main-color", rgbToHex(newStepColor[0], newStepColor[1], newStepColor[2]));

        currentStep++;
        if (currentStep > steps) {
            clearInterval(colorInterval);
        }
    }, intervalTime);
}

function rgbToHex(r, g, b) {
    return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
}

function hexToRgb(hex) {
    let shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
    hex = hex.replace(shorthandRegex, function (m, r, g, b) {
        return r + r + g + g + b + b;
    });

    let result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? [
        parseInt(result[1], 16),
        parseInt(result[2], 16),
        parseInt(result[3], 16)
    ] : null;
}

function populateGangs(data) {
    if (!dataAreLoad) {
        return;
    }

    const totalScore = Object.values(data).reduce((total, score) => total + score, 0);
    let lead = 0;
    let winning;

    for (const [key, value] of Object.entries(data)) {
        if (value <= 0 || totalScore <= 0) {
            continue
        }
        var percentage = ((value / totalScore) * 100).toFixed(0);

        if (percentage > lead) {
            winning = key;
            lead = percentage;
        }

        if ($('#' + key).length) {
            $('#' + key).find('.border-percent').text(percentage + '%');
        } else {
            if (!IsNullOrUndefined(Organizations[key]) && !IsNullOrUndefined(Organizations[key].picture)) {
                var base = `<div class="border-gang" id="` + key + `">
                      <div class="border-image" style="background-image: url(`+ Organizations[key].picture + `)"></div>
                      <div class="border-container1"></div>
                      <div class="border-container2">
                        <span class="border-percent">` + percentage + `%</span>
                      </div>
                    </div>`;

                $('.border-gangs').append(base);
            }
        }
    }

    if (winning != null) {
        changeColor(Organizations[winning].color, 2000)
    }
}

function enableEffect() {
    if (config.EnableBackgroundWallEffect) {
        $('#backgroundEffect').addClass('animation-effect');
    } 
    if (config.EnableSlidingTextWallEffect) {
        $('#slideEffect').addClass('sliding-content');
    } 
    if (config.EnablePulseTextWallEffect) {
        $('#pulseEffect').addClass('border-text1-animation');
    } 
}

window.addEventListener("message", function (e) {
    const edata = e.data;
    if (edata.type == 'updateWarBorder') {
        if (!dataAreLoad) {
            config.EnableBackgroundWallEffect = edata.EnableBackgroundWallEffect
            config.EnableSlidingTextWallEffect = edata.EnableSlidingTextWallEffect
            config.EnablePulseTextWallEffect = edata.EnablePulseTextWallEffect
            enableEffect()
            Organizations = edata.orgs;
        }
        dataAreLoad = true;
        populateGangs(edata.data);
        $('.border-text').text('#' + edata.zone)
    }
    if (edata.type == 'load') {
        Organizations = edata.orgs;
        dataAreLoad = true;
        config = edata.config;
        enableEffect()
    }
});


fetch(`https://${document.location.host}/duiIsReady`, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify({ ok: true })
})

function IsNullOrUndefined(data) {
    return data === undefined || data === null;
}
