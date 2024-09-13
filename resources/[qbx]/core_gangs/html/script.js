var WarChart;
var audioPlayer;

// DATA
var config;

var Organizations;
var Zones;
var Bounties;
var Criminals;

let UserConfig;

var menuOpen = false;
var continentalOpen = false;
var coords = null;

var Invitations = [];

var ContinentalCart = {};
var ContinentalPrice = 0;

var Organization;
var Nickname;
var Title;
var Identifier;
var Currency = 0;

var CurrentWinners = [];
var CurrentWar;
var CurrentZone;
var CurrentFocus;

var updateChartLock = false;

// HELP FUNCTIONS

function getContrastColor(hexColor) {

    if (hexColor.indexOf('#') === 0) {
        hexColor = hexColor.slice(1);
    }

    let rgb = hexColor.match(/.{2}/g).map((c) => parseInt(c, 16));
    rgb = rgb.map((c) => c / 255.0 <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4);
    let luminance = 0.2126 * rgb[0] + 0.7152 * rgb[1] + 0.0722 * rgb[2];

    return luminance > 0.5 ? '#000000' : '#ffffff';
}

function playSound(file) {
    if (audioPlayer != null) {
        audioPlayer.pause();
    }

    audioPlayer = new Audio("../sounds/" + file + ".mp3");
    audioPlayer.volume = 0.15;

    var didPlayPromise = audioPlayer.play();

    if (didPlayPromise === undefined) {
        audioPlayer = null;
    } else {
        didPlayPromise.then(_ => { }).catch(error => {
            audioPlayer = null;
        })
    }
}

function hexToRgbCssVariable(hex, alpha) {
    if (!/^#([A-Fa-f0-9]{3}){1,2}$/.test(hex)) {
        console.log(new Error("Invalid hex color code"));
        hex = "#919191"
    }

    if (hex.length === 4) {
        hex = hex.replace(/#([A-Fa-f0-9])([A-Fa-f0-9])([A-Fa-f0-9])/, "#$1$1$2$2$3$3");
    }

    const result = /^#([A-Fa-f0-9]{2})([A-Fa-f0-9]{2})([A-Fa-f0-9]{2})$/.exec(hex);

    if (result) {
        const r = parseInt(result[1], 16);
        const g = parseInt(result[2], 16);
        const b = parseInt(result[3], 16);

        return `rgba(${r}, ${g}, ${b}, ${alpha})`;
    } else {
        return null;
    }
}


function formatSeconds(totalSeconds) {
    let minutes = Math.floor(totalSeconds / 60);
    let seconds = totalSeconds % 60;

    minutes = String(minutes).padStart(2, '0');
    seconds = String(seconds).padStart(2, '0');

    return `${minutes}:${seconds}`;
}

//CLOSE
$(document).keyup(function (e) {
    if (e.keyCode === 27) {

        if (menuOpen) closeMenu();
        if (continentalOpen) closeContinental();

    }

});




// MAIN FUNCTIONS

function submitImage() {

    var imageUrl = $('.imagechange-container2').val();
    if (Organizations[Organization].owner == Identifier) {
        $('.gangs-image').attr('src', imageUrl);
    }

    $.post('https://core_gangs/submitImage', JSON.stringify({
        image: imageUrl
    }));

    endFocus();
}


function pushNotification(text) {


    var base = '      <div class="noti-notification scale-down-center">' +
        '        <span class="noti-text">' + text + '</span>' +
        '      </div>';


    var $noti = $(base);

    $('.noti-notificationfield').append($noti);

    setTimeout(function () {
        $noti.removeClass('scale-down-center');
        $noti.addClass('scale-down-reverse');
        setTimeout(function () {
            $noti.remove();
        }, 500);
    }, 10000);



}

function closeContinental() {
    $.post('https://core_gangs/close', JSON.stringify({}));
    $('#main_container').html('');
    continentalOpen = false;

}


function closeMenu() {

    event?.stopPropagation();

    $.post('https://core_gangs/close', JSON.stringify({}));



    if ($('#map').css('display') == 'block') {

        $('#map').removeClass('slide-right');
        $('#map').addClass('slide-left');

        if ($('.zonemenu-container01').length) {
            $('.zonemenu-container01').remove();
        }

        setTimeout(function () {

            $('#map').css('display', 'none');

            $('.gangs-container01').removeClass('slide-right');
            $('.gangs-container01').addClass('slide-left');

            setTimeout(function () {
                $('#main_container').html('');
                menuOpen = false;
            }, 500);


        }, 500);



    } else {

        $('.gangs-container01').removeClass('slide-right');
        $('.gangs-container01').addClass('slide-left');

        setTimeout(function () {
            $('#main_container').html('');
            $('#map').css('display', 'none');
            menuOpen = false;
        }, 500);

    }




    map.eachLayer(function (layer) {
        if (layer instanceof zoneElement) {
            map.removeLayer(layer);
        }
    });

}

function startWar(zone) {

    $.post('https://core_gangs/startWar', JSON.stringify({
        zone: zone
    }));

}

function ChangeWarMenu(edata) {
    $('.war-inprogress').addClass('scale-down-reverse');

    this.setTimeout(function() {
        $('.war-inprogress').remove();
        $('.war-container1').removeClass('slide-right');
        $('.war-container1').addClass('slide-left');
        WarChart = null
        setTimeout(function () {
            $('.war-container1').remove();
            CurrentWar = edata.zone;
            warMenu();
            updateWarMenu(edata.data, edata.timeleft, edata.inwarzone);
            updateChartLock = false;
        }, 250);
    }, 250)
}

function stopWarMenu() {

    var scores = Object.entries(CurrentWinners)
        .sort((a, b) => b[1] - a[1])
        .slice(0, 3)
        .map(entry => entry[0]);

    CurrentWinners = [];

    $('.war-inprogress').addClass('scale-down-reverse');

    setTimeout(function () {
        $('.war-inprogress').remove();
        WarChart = null;

        var base = '       <div class="war-results">' +
            '       <div class="war-over">';

        if (scores[1] && Organizations[scores[1]]) {
            base += '          <div class="war-container03">' +
                '            <img class="war-img1" src="' + Organizations[scores[1]].picture + '"></img>' +
                '            <div class="war-container04" style="background-color: ' + Organizations[scores[1]].color + '"></div>' +
                '          </div>';
        }
        if (scores[0] && Organizations[scores[0]]) {
            base += '          <div class="war-container05">' +
                '            <img class="war-img1" src="' + Organizations[scores[0]].picture + '"></img>' +
                '            <div class="war-container06" style="background-color: ' + Organizations[scores[0]].color + '">' +
                '              <svg viewBox="0 0 1024 1024" class="war-icon2">' +
                '                <path' +
                '                  d="M832 192v-128h-640v128h-192v128c0 106.038 85.958 192 192 192 20.076 0 39.43-3.086 57.62-8.802 46.174 66.008 116.608 113.796 198.38 130.396v198.406h-64c-70.694 0-128 57.306-128 128h512c0-70.694-57.306-128-128-128h-64v-198.406c81.772-16.6 152.206-64.386 198.38-130.396 18.19 5.716 37.544 8.802 57.62 8.802 106.042 0 192-85.962 192-192v-128h-192zM192 436c-63.962 0-116-52.038-116-116v-64h116v64c0 40.186 7.43 78.632 20.954 114.068-6.802 1.246-13.798 1.932-20.954 1.932zM948 320c0 63.962-52.038 116-116 116-7.156 0-14.152-0.686-20.954-1.932 13.524-35.436 20.954-73.882 20.954-114.068v-64h116v64z"' +
                '                ></path>' +
                '              </svg>' +
                '           </div>' +
                '          </div>';
        }
        if (scores[2] && Organizations[scores[2]]) {
            base += '          <div class="war-container07">' +
                '            <img class="war-img1" src="' + Organizations[scores[2]].picture + '"></img>' +
                '            <div class="war-container08" style="background-color: ' + Organizations[scores[2]].color + '"></div>' +
                '          </div>';
        }

        base += '        </div>';

        if (scores[0] == Organization) {
            base += '       <div class="war-overtext scale-down-center"><span class="war-text2 victory">VICTORY</span></div>';
            playSound('win');
            $("html").css("--zone-color", hexToRgbCssVariable("#499615", 1.0));

        } else {
            base += '       <div class="war-overtext scale-down-center"><span class="war-text3">DEFEAT</span></div>';
            playSound('defeat');
            $("html").css("--zone-color", hexToRgbCssVariable("#960f3c", 1.0));
        }
        base += '       </div>';

        $('.war-container2').append(base);

        setTimeout(function () {
            $('.war-container1').removeClass('slide-right');
            $('.war-container1').addClass('slide-left');

            setTimeout(function () {
                $('.war-container1').remove();
            }, 500);
        }, 10000);
    }, 500);
}

function updateWarMenu(data, timeleft, inwarzone) {

    if (WarChart == null) return;

    $('.war-container7').html('');

    var winningSide;
    var winningScore = 0;

    CurrentWinners = data;

    for (const [key, value] of Object.entries(data)) {

        var base = ' <div class="war-container8" style="background-color: ' + Organizations[key].color + '"><img class="war-img" src="' + Organizations[key].picture + '"></img></div>';
        $('.war-container7').append(base);

        if (value > winningScore) {
            winningScore = value;
            winningSide = key;
        }


        var index = WarChart.data.labels.indexOf(key);

        if (index !== -1) {

            WarChart.data.datasets[0].data[index] = value;

        } else {
            WarChart.data.labels.push(key);
            WarChart.data.datasets[0].data.push(value);
            WarChart.data.datasets[0].backgroundColor.push(Organizations[key].color);
        }

    }

    if (inwarzone && winningSide) {
        $("html").css("--zone-color", hexToRgbCssVariable(Organizations[winningSide].color, 1.0));
    } else {
        $("html").css("--zone-color", hexToRgbCssVariable("#969696", 1.0));
    }

    WarChart.update();


    // UPDATE TIME LEFT
    $('.war-time').html(formatSeconds(timeleft));



}

function warMenu(zone) {

    if (WarChart) return;

    var base = '<div class="war-container1 slide-right">' +
        '      <div class="war-container2">' +
        '        <div class="war-inprogress">' +
        '        <div class="war-container3">' +
        '          <canvas class="war-container4" id="war-chart"></canvas>' +
        '          <div class="war-container5">' +
        '            <span class="war-zonetext">' +
        '              <span class="war-text">ZONE</span>' +
        '              <span class="war-text1">#' + CurrentWar + '</span>' +
        '            </span>' +
        '            <div class="war-container6">' +
        '              <svg viewBox="0 0 1024 1024" class="war-icon">' +
        '                <path' +
        '                  d="M981.333 512c0-129.579-52.565-246.997-137.472-331.861s-202.283-137.472-331.861-137.472-246.997 52.565-331.861 137.472-137.472 202.283-137.472 331.861 52.565 246.997 137.472 331.861 202.283 137.472 331.861 137.472 246.997-52.565 331.861-137.472 137.472-202.283 137.472-331.861zM896 512c0 106.069-42.923 201.984-112.469 271.531s-165.461 112.469-271.531 112.469-201.984-42.923-271.531-112.469-112.469-165.461-112.469-271.531 42.923-201.984 112.469-271.531 165.461-112.469 271.531-112.469 201.984 42.923 271.531 112.469 112.469 165.461 112.469 271.531zM469.333 256v256c0 16.597 9.472 31.019 23.595 38.144l170.667 85.333c21.077 10.539 46.72 2.005 57.259-19.072s2.005-46.72-19.072-57.259l-147.115-73.515v-229.632c0-23.552-19.115-42.667-42.667-42.667s-42.667 19.115-42.667 42.667z"' +
        '                ></path>' +
        '              </svg>' +
        '              <span class="war-time">00:34</span>' +
        '            </div>' +
        '          </div>' +
        '        </div>' +

        '        <div class="war-container7">' +
        '        </div>' +

        '      </div>' +

        '      </div>' +
        '    </div>';





    $('#war_container').append(base);


    var data = {
        labels: [],
        datasets: [{
            data: [],
            backgroundColor: [],
            borderWidth: 0
        }]
    };

    var options = {
        responsive: false,
        plugins: {
            legend: {
                display: false
            }
        },
        animation: {
            animateScale: true,
            animateRotate: true
        }
    };


    var ctx = document.getElementById("war-chart").getContext("2d");
    WarChart = new Chart(ctx, {
        type: 'doughnut',
        data: data,
        options: options
    });


}


function toggleMap() {

    if ($('#map').css('display') == 'block') {

        $('#map').removeClass('slide-right');
        $('#map').addClass('slide-left');

        if ($('.zonemenu-container01').length) {
            $('.zonemenu-container01').remove();
        }


        setTimeout(function () {
            $('#map').css('display', 'none');
        }, 500);


        $('.gangs-icon02').removeClass('flipped');
    } else {

        $('#map').removeClass('slide-left');
        $('#map').addClass('slide-right');

        $('#map').css('display', 'block');
        $('.gangs-icon02').addClass('flipped');
    }
    map.invalidateSize();
    playSound('map');
}


function acceptBounty(id) {

    endFocus();

    setTimeout(function () {
        openBounties();
    }, 500);

    $.post('https://core_gangs/acceptBounty', JSON.stringify({
        id: id
    }));
}

function declineBounty(id) {

    endFocus();

    setTimeout(function () {
        openBounties();
    }, 500);

    $.post('https://core_gangs/declineBounty', JSON.stringify({
        id: id
    }));
}

function deleteBounty(id) {

    endFocus();

    setTimeout(function () {
        openBounties();
    }, 500);

    $.post('https://core_gangs/deleteBounty', JSON.stringify({
        id: id
    }));
}

function newBounty(criminal) {

    var bounty = $('.over-container1').val();

    endFocus();

    setTimeout(function () {
        openBounties();
    }, 500);

    $.post('https://core_gangs/newBounty', JSON.stringify({
        criminal: criminal,
        bounty: bounty
    }));


}

function inviteCriminal(criminal) {

    $.post('https://core_gangs/inviteCriminal', JSON.stringify({
        criminal: criminal
    }));

}

function kickCriminal(criminal) {

    endFocus();

    setTimeout(function () {
        if (Organizations[Organization].owner == Identifier) {
            openMembers(Organization);
        }
    }, 500);

    $.post('https://core_gangs/kickCriminal', JSON.stringify({
        criminal: criminal
    }));

}

function focusBounty(t, criminal) {

    $('.over-bounty-overlay').remove();

    var base = '<div class="over-bounty-overlay scale-up-ver-bottom">' +
        '      <div class="over-bounty-container">' +
        '        <svg viewBox="0 0 1024 1024" class="over-icon">' +
        '          <path' +
        '            d="M504 466q44 12 73 24t61 33 49 53 17 76q0 62-41 101t-109 51v92h-128v-92q-66-14-109-56t-47-108h94q8 90 126 90 62 0 89-23t27-53q0-72-128-104-200-46-200-176 0-58 42-99t106-55v-92h128v94q66 16 101 60t37 102h-94q-4-90-108-90-52 0-83 22t-31 58q0 58 128 92z"' +
        '          ></path>' +
        '        </svg>' +
        '        <input type="number" placeholder="' + config.MinimalBounty + '" class="over-container1"></input>' +
        '      </div>' +
        '      <div class="over-container2" onclick="event.stopPropagation(); newBounty(\'' + criminal + '\')">' +
        '        <svg viewBox="0 0 1316.5714285714284 1024" class="over-icon2">' +
        '          <path' +
        '            d="M109.714 658.286c48 0 48-73.143 0-73.143s-48 73.143 0 73.143zM951.429 625.143c-45.143-58.857-89.143-118.857-140.571-172.571l-71.429 80c-62.857 71.429-175.429 69.714-236.571-3.429-43.429-52.571-43.429-128 1.143-180l101.143-117.714c-35.429-18.286-78.286-12-116.571-12-33.714 0-66.286 13.714-90.286 37.714l-90.286 90.286h-88.571v310.857c25.143 0 48-3.429 68 16l169.714 166.857c34.857 33.714 80 63.429 129.714 63.429 25.714 0 53.143-8.571 71.429-26.857 42.857 14.857 92.571-9.143 105.714-53.143 27.429 2.286 52.571-6.286 72.571-25.143 13.143-12 30.286-36 28.571-54.857 5.143 5.143 17.714 5.714 24.571 5.714 68 0 103.429-71.429 61.714-125.143zM1042.286 658.286h54.857v-292.571h-53.143l-89.714-102.857c-24-27.429-60-43.429-96.571-43.429h-95.429c-32 0-62.857 14.286-83.429 38.286l-119.429 138.857c-21.143 25.143-21.143 60.571-0.571 85.714 32.571 38.857 92.571 39.429 126.286 1.714l110.286-124.571c26.286-29.143 74.286-1.714 62.286 35.429 21.714 25.143 45.143 49.714 66.286 74.857 28.571 35.429 56 72.571 84 108.571 17.714 22.857 30.857 50.286 34.286 80zM1206.857 658.286c48 0 48-73.143 0-73.143s-48 73.143 0 73.143zM1316.571 329.143v365.714c0 20-16.571 36.571-36.571 36.571h-248c-20.571 49.714-65.714 82.857-118.286 90.286-24.571 36-62.286 63.429-104.571 72.571-31.429 40-82.286 64-133.143 60.571-94.286 53.143-200.571 6.857-270.857-62.286l-164-161.143h-204.571c-20 0-36.571-16.571-36.571-36.571v-384c0-20 16.571-36.571 36.571-36.571h240.571c66.286-66.286 112-128 211.429-128h66.857c37.143 0 73.143 11.429 103.429 32 30.286-20.571 66.286-32 103.429-32h95.429c108.571 0 153.714 70.857 219.429 146.286h202.857c20 0 36.571 16.571 36.571 36.571z"' +
        '          ></path>' +
        '        </svg>' +
        '      </div>' +
        '    </div>';

    $(t).append(base);

    $('input').focus();



}

function searchCriminals(t, purpose) {

    $('.focus-buttons').html('');
    var text = $(t).val();
    if (!IsNullOrUndefined(text)) { text = text.toLowerCase(); }

    var limit = 0;

    for (const [key, value] of Object.entries(Criminals)) {

        if (!IsNullOrUndefined(value.name) && (value.name.toLowerCase().match(text) != null && limit < 5 && key != Identifier)) {

            var base
            if (purpose == 'members') {
                base = '        <div class="members-container3" onclick="inviteCriminal(\'' + key + '\')" style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(config.CriminalTitles[value.role - 1].Background, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);">';
            } else if (purpose == 'bounties') {
                base = '        <div class="members-container3" onclick="event.stopPropagation(); focusBounty(this, \'' + key + '\')" style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(config.CriminalTitles[value.role - 1].Background, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);">';
            }

            if (value.org) {
                base = base + '          <img class="leaderboard-container2" src="' + Organizations[value.org].picture + '"></img>';
            }
            base = base + '          <div class="members-container4">' +
                '            <span class="members-text2">' + value.name + '</span>' +
                '            <span class="members-text3" style="color: ' + config.CriminalTitles[value.role - 1].Color + '">' + config.CriminalTitles[value.role - 1].Title + '</span>' +
                '          </div>' +
                '        </div>';

            $('.focus-buttons').append(base);

            limit = limit + 1;
        }

    }


}

function endFocus() {

    $('.focus').html('');
    $('.focus').css('display', 'none');


}

function focusElement(element, adding, type) {

    $('.focus').css('display', 'block');

    let offset = $(element).offset();

    let topElement = $(element).clone()
        .css({
            'position': 'absolute',
            'top': offset.top,
            'left': offset.left,
            'z-index': 51
        })
        .appendTo('.focus');

    topElement.find('.bountyprice').remove();


    var base;
    if (adding) {


        var inputField = '<div class="adding-container1">' +
            '      <svg viewBox="0 0 1024 1024" class="adding-icon">' +
            '        <path' +
            '          d="M213.333 554.667h256v256c0 23.552 19.115 42.667 42.667 42.667s42.667-19.115 42.667-42.667v-256h256c23.552 0 42.667-19.115 42.667-42.667s-19.115-42.667-42.667-42.667h-256v-256c0-23.552-19.115-42.667-42.667-42.667s-42.667 19.115-42.667 42.667v256h-256c-23.552 0-42.667 19.115-42.667 42.667s19.115 42.667 42.667 42.667z"' +
            '        ></path>' +
            '      </svg>' +
            '      <input class="adding-container2" oninput="searchCriminals(this, \'' + type + '\')" placeholder="Criminal"></input>' +
            '    </div>';

        topElement.html(inputField)
            .css({
                'position': 'absolute',
                'top': offset.top,
                'left': offset.left,
                'z-index': 51
            });

        $('input').focus();

        base = '<div class="focus-buttons scale-down-center">' +
            '    </div>';

    } else {
        base = '<div class="focus-buttons scale-down-center">';

        if (type == 'members') {
            base = base + '      <div class="focus-button" onclick="kickCriminal(\'' + $(element).attr('id') + '\')">' +
                '        <svg viewBox="0 0 1024 1024" class="focus-icon">' +
                '          <path' +
                '            d="M768 640v-128h-320v-128h320v-128l192 192zM704 576v256h-320v192l-384-192v-832h704v320h-64v-256h-512l256 128v576h256v-192z"' +
                '          ></path>' +
                '        </svg>' +
                '        <span class="focus-text">KICK</span>' +
                '      </div>';
        } else if (type == 'ping') {
            const accepted = Bounties[Number($(element).attr('id'))]
            //accepted.accepted.includes(Identifier)
            
            base = base + '      <div class="focus-button" onclick="declineBounty(' + $(element).attr('id') + ')">' +
                '        <svg viewBox="0 0 1024 1024" class="focus-icon">' +
                '          <path' +
                '            d="M768 640v-128h-320v-128h320v-128l192 192zM704 576v256h-320v192l-384-192v-832h704v320h-64v-256h-512l256 128v576h256v-192z"' +
                '          ></path>' +
                '        </svg>' +
                '        <span class="focus-text">DECLINE</span>' +
                '      </div>';

            // Ping not provide for now, set just decline bounty 
            // base = base + '      <div class="focus-button" onclick="pingCriminal(' + $(element).attr('id') + ')">' +
            //     '        <svg viewBox="0 0 1024 1024" class="focus-icon">' +
            //     '          <path' +
            //     '            d="M768 640v-128h-320v-128h320v-128l192 192zM704 576v256h-320v192l-384-192v-832h704v320h-64v-256h-512l256 128v576h256v-192z"' +
            //     '          ></path>' +
            //     '        </svg>' +
            //     '        <span class="focus-text">PING</span>' +
            //     '      </div>';
        } else if (type == 'image') {

            base = base + '<div class="imagechange-input" onclick="event.stopPropagation();">' +
                '        <svg viewBox="0 0 1024 1024" class="imagechange-icon">' +
                '          <path' +
                '            d="M362 576l-148 192h596l-192-256-148 192zM896 810q0 34-26 60t-60 26h-596q-34 0-60-26t-26-60v-596q0-34 26-60t60-26h596q34 0 60 26t26 60v596z"' +
                '          ></path>' +
                '        </svg>' +
                '        <input class="imagechange-container2" placeholder="Image URL"></input>' +
                '      </div>' +
                '      <div class="focus-button" onclick="event.stopPropagation(); submitImage()">' +
                '        <svg viewBox="0 0 1024 1024" class="focus-icon">' +
                '          <path' +
                '            d="M768 640v-128h-320v-128h320v-128l192 192zM704 576v256h-320v192l-384-192v-832h704v320h-64v-256h-512l256 128v576h256v-192z"' +
                '          ></path>' +
                '        </svg>' +
                '        <span class="focus-text">SUBMIT</span>' +
                '      </div>';
        } else if (type == 'manageBounty') {
            base = base + '      <div class="focus-button" onclick="deleteBounty(' + $(element).attr('id') + ')">' +
                '        <svg viewBox="0 0 1024 1024" class="focus-icon">' +
                '          <path' +
                '            d="M768 640v-128h-320v-128h320v-128l192 192zM704 576v256h-320v192l-384-192v-832h704v320h-64v-256h-512l256 128v576h256v-192z"' +
                '          ></path>' +
                '        </svg>' +
                '        <span class="focus-text">REMOVE</span>' +
                '      </div>';

        } else if (type == 'bounties') {
            const plId = $(element).attr('plIdentifier')
            if (!IsNullOrUndefined(plId) && plId !== Identifier) {
                base = base + '      <div class="focus-button" onclick="acceptBounty(' + $(element).attr('id') + ')">' +
                    '        <svg viewBox="0 0 1024 1024" class="focus-icon">' +
                    '          <path' +
                    '            d="M768 640v-128h-320v-128h320v-128l192 192zM704 576v256h-320v192l-384-192v-832h704v320h-64v-256h-512l256 128v576h256v-192z"' +
                    '          ></path>' +
                    '        </svg>' +
                    '        <span class="focus-text">ACCEPT</span>' +
                    '      </div>';
            } else {
                base = base + '      <div class="members-orgs">' +
                    '        <span class="focus-text">YOU CAN\'T KILL YOURSELF</span>' +
                    '      </div>';

            }

        } else if (type == 'leave') {
            base = base + '      <div class="focus-button" onclick="leaveOrganization()">' +
                '        <svg viewBox="0 0 1024 1024" class="focus-icon">' +
                '          <path' +
                '            d="M768 640v-128h-320v-128h320v-128l192 192zM704 576v256h-320v192l-384-192v-832h704v320h-64v-256h-512l256 128v576h256v-192z"' +
                '          ></path>' +
                '        </svg>' +
                '        <span class="focus-text">LEAVE</span>' +
                '      </div>';
        }


        base = base + '    </div>';
    }

    var $base = $(base);


    var bottomEdge = offset.top + topElement.outerHeight();



    var viewportBottom = $(window).height() * 0.8;

    if ((bottomEdge + $base.outerHeight()) > viewportBottom) {

        $base.css({
            'position': 'absolute',
            'bottom': $(window).height() - offset.top,
            'left': '21px',
            'z-index': 51
        });
    } else {

        $base.css({
            'position': 'absolute',
            'top': bottomEdge,
            'left': '21px',
            'z-index': 51
        });
    }

    $('.focus').append($base);


}

function setWaypoint(zone) {

    $.post('https://core_gangs/setWaypoint', JSON.stringify({ zone: zone }));

}

function increaseProtection(zone) {

    $.post('https://core_gangs/increaseProtection', JSON.stringify({ zone: zone }));

}

function increaseNPCS(zone) {

    $.post('https://core_gangs/increaseNPCS', JSON.stringify({ zone: zone }));

}

function acceptInvite(org) {

    $.post('https://core_gangs/acceptInvite', JSON.stringify({ org: org }));
    closeMenu();

}

function leaveOrganization() {

    $.post('https://core_gangs/leaveOrg', JSON.stringify({}));
    closeMenu();

}

function completeRegistration() {
    const name = $('.register-name').val();
    const color = $('.register-color').val();
    const picture = $('.register-label').val();
    $.post('https://core_gangs/completeRegistration', JSON.stringify({
        name: name,
        color: color,
        picture: picture
    }));

    $('.register-container2').removeClass('scale-down-center');
    $('.register-container2').addClass('scale-down-reverse');
    setTimeout(function () {
        closeMenu();
    }, 1500);
}

function registerOrganization(first) {


    var base = '<div class="register-container1">' +
        '      <div class="register-container2 scale-down-center">' +
        '        <svg viewBox="0 0 1024 1024" class="register-icon">' +
        '          <path' +
        '            d="M554 598v-172h-84v172h84zM554 768v-86h-84v86h84zM42 896l470-810 470 810h-940z"' +
        '          ></path>' +
        '        </svg>' +
        '        <span class="register-text">YOU DONT BELONG TO ANY</span>' +
        '        <span class="register-text1">ORGANIZATION</span>';

    if (!first) {

        base = base + '        <div class="register-container3">' +
            '          <div class="register-container4">' +
            '            <svg viewBox="0 0 1024 1024" class="register-icon02">' +
            '              <path' +
            '                d="M470 854l170-172h256v172h-426zM264 768l370-370-52-52-368 370v52h50zM786 248q26 26 26 60t-26 60l-486 486h-172v-174q480-478 486-484 26-26 60-26t60 26z"' +
            '              ></path>' +
            '            </svg>' +
            '            <input type="text" placeholder="name" class="register-name input" />' +
            '          </div>' +
            '          <div class="register-container5">' +
            '            <svg viewBox="0 0 1024 1024" class="register-icon04">' +
            '              <path' +
            '                d="M278 726h362l150-214-150-214h-362l148 214zM640 810h-512l192-298-192-298h512q44 0 70 36l186 262-186 262q-26 36-70 36z"' +
            '              ></path>' +
            '            </svg>' +
            '            <input' +
            '              type="text"' +
            '              placeholder="picture"' +
            '              class="register-label input"' +
            '            />' +
            '          </div>' +
            '          <div class="register-container6">' +
            '            <svg viewBox="0 0 1024 1024" class="register-icon06">' +
            '              <path' +
            '                d="M746 512q26 0 45-18t19-46-19-46-45-18-45 18-19 46 19 46 45 18zM618 342q26 0 45-19t19-45-19-45-45-19-45 19-19 45 19 45 45 19zM406 342q26 0 45-19t19-45-19-45-45-19-45 19-19 45 19 45 45 19zM278 512q26 0 45-18t19-46-19-46-45-18-45 18-19 46 19 46 45 18zM512 128q158 0 271 100t113 242q0 88-63 150t-151 62h-74q-28 0-46 19t-18 45q0 22 16 42t16 44q0 28-18 46t-46 18q-160 0-272-112t-112-272 112-272 272-112z"' +
            '              ></path>' +
            '            </svg>' +
            '            <input' +
            '              type="color"' +
            '              value="#6603fc"' +
            '              class="register-color input"' +
            '            />' +
            '          </div>' +
            '        </div>' +
            '        <div class="register-container7" onclick="completeRegistration()">' +
            '          <svg viewBox="0 0 1024 1024" class="register-icon08">' +
            '            <path' +
            '              d="M810 554h-256v256h-84v-256h-256v-84h256v-256h84v256h256v84z"' +
            '            ></path>' +
            '          </svg>' +
            '          <span class="register-text2">' + (config.OrganizationCreationPrice != null && config.OrganizationCreationPrice !== false && config.OrganizationCreationPrice > 0 ? ('CREATE FOR ' + config.OrganizationCreationPrice + ' ' + config.CurrencyName.toUpperCase()) : 'CREATE') + '</span>' +
            '        </div>';

    } else if (config.CanCreateOrganizations) {

        base = base + '<div class="invites-container">';

        for (const [key, value] of Object.entries(Invitations)) {

            base = base + '<div class="invites-container1">' +
                '      <img class="invites-container2" src="' + Organizations[value].picture + '"></img>' +
                '      <div class="invites-container3" onclick="acceptInvite(\'' + value + '\')">' +
                '        <svg viewBox="0 0 1024 1024" class="invites-icon">' +
                '          <path' +
                '            d="M384 512h-320v-128h320v-128l192 192-192 192zM1024 0v832l-384 192v-192h-384v-256h64v192h320v-576l256-128h-576v256h-64v-320z"' +
                '          ></path>' +
                '        </svg>' +
                '      </div>' +
                '    </div>';

        }


        base = base + '</div>' +
            '        <div class="register-container7" onclick="registerOrganization(false)">' +
            '          <svg viewBox="0 0 1024 1024" class="register-icon08">' +
            '            <path' +
            '              d="M810 554h-256v256h-84v-256h-256v-84h256v-256h84v256h256v84z"' +
            '            ></path>' +
            '          </svg>' +
            '          <span class="register-text2">CREATE</span>' +
            '        </div>';

    } else {
        base = base + '<div class="invites-container">';

        for (const [key, value] of Object.entries(Invitations)) {

            base = base
                + '  <div class="invites-container1">' +
                '      <img class="invites-container2" src="' + Organizations[value].picture + '"></img>' +
                '      <div class="invites-container3" onclick="acceptInvite(\'' + value + '\')">' +
                '        <svg viewBox="0 0 1024 1024" class="invites-icon">' +
                '          <path' +
                '            d="M384 512h-320v-128h320v-128l192 192-192 192zM1024 0v832l-384 192v-192h-384v-256h64v192h320v-576l256-128h-576v256h-64v-320z">' +
                '          </path>' +
                '        </svg>' +
                '      </div>' +
                '    </div>';
        }
        base = base + '</div>';
    }



    base = base + '      </div>' +
        '    </div>';

    if (first) {
        $('.gangs-container01').html(base);
    } else {
        $('.register-container2').removeClass('scale-down-center');
        $('.register-container2').addClass('scale-down-reverse');
        setTimeout(function () {
            $('.gangs-container01').html(base);
        }, 500);
    }


    userInfo(true)
}

function moveSlide(t, step) {

    var parentContainer = $(t).parent();
    var totalSlides = parentContainer.find('.shop-within').children().length;
    if (totalSlides > 0 && totalSlides > 2) { totalSlides = totalSlides - 2; }
    var slideWidth = parentContainer.find('.shop-within .shop:first').width();

    parentContainer.data('currentSlide', parentContainer.data('currentSlide') || 0);
    var currentSlide = parentContainer.data('currentSlide') + step;
    currentSlide = Math.max(0, Math.min(currentSlide, totalSlides - 1));

    var newTransformValue = (-currentSlide * slideWidth);

    parentContainer.find('.shop-within').css('transform', 'translateX(' + newTransformValue + 'px)');

    parentContainer.data('currentSlide', currentSlide);
}

function checkoutContinental() {



    if (ContinentalPrice > 0) {

        $('.shop-checkout').removeClass('slide-top');
        $('.shop-checkout').addClass('slide-bottom');

        setTimeout(function () {
            $.post('https://core_gangs/checkoutContinental', JSON.stringify({
                cart: ContinentalCart,
                price: ContinentalPrice
            }));

            closeContinental();
        }, 200);


    }

}

function selectProduct(t) {

    var $el = $(t);

    var price = $el.attr('price');
    price = parseInt(price);
    var name = $el.attr('item');





    if ($el.css("border") === "" || $el.css("border") === "none" || $el.css("border") === "0px none rgb(0, 0, 0)") {
        ContinentalPrice = ContinentalPrice + price;
        ContinentalCart[name] = price;
        $el.css({
            "border": "3px solid #efbb24",
            "box-sizing": "border-box"
        });
    } else {
        ContinentalPrice = ContinentalPrice - price;
        ContinentalCart[name] = null;
        $el.css("border", "none");
    }


    $('.shop-currency').text(ContinentalPrice);
}

function openContinental(zone) {

    ContinentalCart = {};
    ContinentalPrice = 0;

    continentalOpen = true;

    var base = '<div class="shop-checkout-container">' +
        '      <div class="shop-checkout slide-top" onclick="checkoutContinental()">' +
        '        <span class="shop-text">CHECKOUT</span>' +
        '        <span class="shop-currency">0</span>' +
        '      </div>' +
        '    </div>' +
        '    <div class="shop-gradient slide-left-zone">' +
        '      <span class="shop-title">' + config.Continentals[zone].Title + '</span>' +
        '      <div class="shop-vehicles">' +
        '        <div class="shop-left1" onclick="moveSlide(this, -1)">' +
        '          <svg viewBox="0 0 1024 1024" class="shop-icon">' +
        '            <path' +
        '              d="M854 470v84h-520l238 240-60 60-342-342 342-342 60 60-238 240h520z"' +
        '            ></path>' +
        '          </svg>' +
        '        </div>' +
        '        <div class="shop-items-container">' +
        '        <div class="shop-within">' +
        '          <div class="shop shop-vehicle" onclick="selectProduct(this)">' +
        '            <div class="shop-img"></div>' +
        '            <span class="shop-text1">100</span>' +
        '          </div>' +
        '        </div>' +
        '        </div>' +
        '        <div class="shop-right2" onclick="moveSlide(this, 1)">' +
        '          <svg viewBox="0 0 1024 1024" class="shop-icon02">' +
        '            <path' +
        '              d="M512 170l342 342-342 342-60-60 238-240h-520v-84h520l-238-240z"' +
        '            ></path>' +
        '          </svg>' +
        '        </div>' +
        '      </div>' +
        '      <div class="shop-weapons">' +
        '        <div class="shop-left1" onclick="moveSlide(this, -1)">' +
        '          <svg viewBox="0 0 1024 1024" class="shop-icon04">' +
        '            <path' +
        '              d="M854 470v84h-520l238 240-60 60-342-342 342-342 60 60-238 240h520z"' +
        '            ></path>' +
        '          </svg>' +
        '        </div>' +
        '        <div class="shop-items-container">' +
        '        <div class="shop-within">';
    for (const [key, value] of Object.entries(config.Continentals[zone].Shop['weapons'])) {
        base = base + '          <div class="shop shop-weapon" price="' + value + '" item="' + key + '" onclick="selectProduct(this)">' +
            '            <img class="shop-img1" src="img/items/' + key + '.png"></img>' +
            '            <span class="shop-text2">' + value + '</span>' +
            '          </div>';
    }
    base = base + '        </div>' +
        '        </div>' +
        '        <div class="shop-right2" onclick="moveSlide(this, 1)">' +
        '          <svg viewBox="0 0 1024 1024" class="shop-icon06">' +
        '            <path' +
        '              d="M512 170l342 342-342 342-60-60 238-240h-520v-84h520l-238-240z"' +
        '            ></path>' +
        '          </svg>' +
        '        </div>' +
        '      </div>' +
        '      <div class="shop-items">' +
        '        <div class="shop-left1" onclick="moveSlide(this, -1)">' +
        '          <svg viewBox="0 0 1024 1024" class="shop-icon08">' +
        '            <path' +
        '              d="M854 470v84h-520l238 240-60 60-342-342 342-342 60 60-238 240h520z"' +
        '            ></path>' +
        '          </svg>' +
        '        </div>' +
        '        <div class="shop-items-container">' +
        '        <div class="shop-within">';
    for (const [key, value] of Object.entries(config.Continentals[zone].Shop['items'])) {
        base = base + '          <div class="shop shop-item" price="' + value + '" item="' + key + '" onclick="selectProduct(this)">' +
            '            <img class="shop-img2" src="img/items/' + key + '.png"></img>' +
            '            <span class="shop-price">' + value + '</span>' +
            '          </div>';
    }
    base = base + '         </div>' +
        '        </div>' +
        '        <div class="shop-right2" onclick="moveSlide(this, 1)">' +
        '          <svg viewBox="0 0 1024 1024" class="shop-icon10">' +
        '            <path' +
        '              d="M512 170l342 342-342 342-60-60 238-240h-520v-84h520l-238-240z"' +
        '            ></path>' +
        '          </svg>' +
        '        </div>' +
        '      </div>' +
        '    </div>';

    $('#main_container').html(base);



}



function openMembers(org) {

    $('.gangs-buttons').removeClass(' scale-down-center');
    $('.gangs-buttons').addClass(' scale-down-reverse');

    var owner = Organizations[org].owner;
    var ownerData = Criminals[owner];

    var base = '    <div class="controls-container1">' +
        '      <div class="controls-container2" onclick="openButtons()">' +
        '        <svg viewBox="0 0 1024 1024" class="controls-icon">' +
        '          <path' +
        '            d="M854 470v84h-520l238 240-60 60-342-342 342-342 60 60-238 240h520z"' +
        '          ></path>' +
        '        </svg>' +
        '      </div>' +
        '      <div class="controls-container2" onclick="focusElement(this, true, \'members\')">' +
        '        <svg viewBox="0 0 1024 1024" class="controls-icon2">' +
        '          <path' +
        '            d="M213.333 554.667h256v256c0 23.552 19.115 42.667 42.667 42.667s42.667-19.115 42.667-42.667v-256h256c23.552 0 42.667-19.115 42.667-42.667s-19.115-42.667-42.667-42.667h-256v-256c0-23.552-19.115-42.667-42.667-42.667s-42.667 19.115-42.667 42.667v256h-256c-23.552 0-42.667 19.115-42.667 42.667s19.115 42.667 42.667 42.667z"' +
        '          ></path>' +
        '        </svg>' +
        '      </div>' +
        '    </div>' +
        '<div class="members-members scale-down-center">';
    if (IsNullOrUndefined(ownerData)) {
        ownerData = {}
        ownerData.role = config.CriminalTitles.length - 1;
        base += '<span class="members-orgs">OWNER</span>' +
            '      <div class="members-ownerlist">' +
            '        <div class="members-container3" style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(config.CriminalTitles[ownerData.role - 1].Background, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);">' +
            // '          <img class="leaderboard-container2" src="' + Organizations[org].picture + '"></img>' +
            '          <div class="members-container2">' +
            '            <span class="members-text">Owner not set</span>' +
            '            <span class="members-text1" style="color: ' + config.CriminalTitles[ownerData.role - 1].Color + '">' + config.CriminalTitles[ownerData.role - 1].Title + '</span>' +
            '          </div>' +
            '        </div>' +
            '      </div>' +
            '      <span class="members-orgs1">MEMBERS</span>' +
            '      <div class="members-memberslist">';
    } else {
        base += '<span class="members-orgs">OWNER</span>' +
            '      <div class="members-ownerlist">' +
            '        <div class="members-container3" style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(config.CriminalTitles[ownerData.role - 1].Background, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);">' +
            '          <img class="leaderboard-container2" src="' + Organizations[org].picture + '"></img>' +
            '          <div class="members-container2">' +
            '            <span class="members-text">' + ownerData.name + '</span>' +
            '            <span class="members-text1" style="color: ' + config.CriminalTitles[ownerData.role - 1].Color + '">' + config.CriminalTitles[ownerData.role - 1].Title + '</span>' +
            '          </div>' +
            '        </div>' +
            '      </div>' +
            '      <span class="members-orgs1">MEMBERS</span>' +
            '      <div class="members-memberslist">';
    }

    for (const [key, value] of Object.entries(Criminals)) {
        if (value.org == org && owner != key) {

            var click = '';

            if (org == Organization) {
                click = 'onclick="focusElement(this, false, \'members\')"';
            }


            base = base + '        <div class="members-container3" id="' + key + '" ' + click + ' style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(config.CriminalTitles[value.role - 1].Background, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);">' +
                '          <img class="leaderboard-container2" src="' + Organizations[org].picture + '"></img>' +
                '          <div class="members-container4">' +
                '            <span class="members-text2">' + value.name + '</span>' +
                '            <span class="members-text3" style="color: ' + config.CriminalTitles[value.role - 1].Color + '">' + config.CriminalTitles[value.role - 1].Title + '</span>' +
                '          </div>' +
                '        </div>';

        }
    }
    base = base + '      </div>' +
        '    </div>';


    setTimeout(function () {
        $('.gangs-container02').html(base);
    }, 200);

}


function openBounties() {

    $('.gangs-buttons').removeClass(' scale-down-center');
    $('.gangs-buttons').addClass(' scale-down-reverse');

    var usedBounties = [];

    var base = '    <div class="controls-container1">' +
        '      <div class="controls-container2" onclick="openButtons()">' +
        '        <svg viewBox="0 0 1024 1024" class="controls-icon">' +
        '          <path' +
        '            d="M854 470v84h-520l238 240-60 60-342-342 342-342 60 60-238 240h520z"' +
        '          ></path>' +
        '        </svg>' +
        '      </div>' +
        '      <div class="controls-container2" onclick="focusElement(this, true, \'bounties\')">' +
        '        <svg viewBox="0 0 1024 1024" class="controls-icon2">' +
        '          <path' +
        '            d="M213.333 554.667h256v256c0 23.552 19.115 42.667 42.667 42.667s42.667-19.115 42.667-42.667v-256h256c23.552 0 42.667-19.115 42.667-42.667s-19.115-42.667-42.667-42.667h-256v-256c0-23.552-19.115-42.667-42.667-42.667s-42.667 19.115-42.667 42.667v256h-256c-23.552 0-42.667 19.115-42.667 42.667s19.115 42.667 42.667 42.667z"' +
        '          ></path>' +
        '        </svg>' +
        '      </div>' +
        '    </div>' +
        '<div class="members-members scale-down-center">' +
        '      <span class="members-orgs">YOUR BOUNTIES</span>' +
        '      <div class="members-memberslist">';

    for (const [key, value] of Object.entries(Bounties)) {

        if (!value) continue;
        if (value.setby == Identifier && !usedBounties.includes(key)) {

            let criminal = Criminals[value.identifier];

            let bountyImage = IsNullOrUndefined(criminal)
                && IsNullOrUndefined(criminal.org)
                && Organizations[criminal.org]
                && Organizations[criminal.org].picture ? Organizations[criminal.org].picture : 'img/user.png'

            base = base + '        <div class="members-container3" id="' + value.id + '" onclick="focusElement(this, false, \'manageBounty\')" style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(config.CriminalTitles[criminal.role - 1].Background, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);">' +
                '          <div class="bountyprice scale-up-ver-bottom"><div class="bountytext">' + value.bounty + '</div></div>' +
                '          <img class="leaderboard-container2" src="' + bountyImage + '"></img>' +
                '          <div class="members-container4">' +
                '            <span class="members-text2">' + criminal.name + '</span>' +
                '            <span class="members-text3" style="color: ' + config.CriminalTitles[criminal.role - 1].Color + '">' + config.CriminalTitles[criminal.role - 1].Title + '</span>' +
                '          </div>' +
                '        </div>';

            usedBounties.push(key);

        }

    }

    base = base + '      </div>' +
        '      <span class="members-orgs">ACTIVE BOUNTIES</span>' +
        '      <div class="members-memberslist">';

    for (const [key, value] of Object.entries(Bounties)) {

        if (!value) continue;

        if (value.accepted.includes(Identifier) && !usedBounties.includes(key)) {

            let criminal = Criminals[value.identifier];

            let bountyImage = IsNullOrUndefined(criminal)
                && IsNullOrUndefined(criminal.org)
                && Organizations[criminal.org]
                && Organizations[criminal.org].picture ? Organizations[criminal.org].picture : 'img/user.png'

            base = base + '        <div class="members-container3" id="' + value.id + '" onclick="focusElement(this, false, \'ping\')" style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(config.CriminalTitles[criminal.role - 1].Background, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);">' +
                '          <img class="leaderboard-container2" src="' + bountyImage + '"></img>' +
                '          <div class="members-container4">' +
                '            <span class="members-text2">' + criminal.name + '</span>' +
                '            <span class="members-text3" style="color: ' + config.CriminalTitles[criminal.role - 1].Color + '">' + config.CriminalTitles[criminal.role - 1].Title + '</span>' +
                '          </div>' +
                '        </div>';

            usedBounties.push(key);

        }

    }

    base = base + '      </div>' +
        '      <span class="members-orgs1">BOUNTIES</span>' +
        '      <div class="members-memberslist">';
    for (const [key, value] of Object.entries(Bounties)) {

        if (!value) continue;

        if (!usedBounties.includes(key)) {

            let criminal = Criminals[value.identifier];

            let bountyImage = IsNullOrUndefined(criminal)
                && IsNullOrUndefined(criminal.org)
                && Organizations[criminal.org]
                && Organizations[criminal.org].picture ? Organizations[criminal.org].picture : 'img/user.png'

            base = base + '        <div class="members-container3" id="' + value.id + '" plIdentifier="' + value.identifier + '" onclick="focusElement(this, false, \'bounties\')" style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(config.CriminalTitles[criminal.role - 1].Background, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);">' +
                '          <img class="leaderboard-container2" src="' + bountyImage + '"></img>' +
                '          <div class="members-container4">' +
                '            <span class="members-text2">' + criminal.name + '</span>' +
                '            <span class="members-text3" style="color: ' + config.CriminalTitles[criminal.role - 1].Color + '">' + config.CriminalTitles[criminal.role - 1].Title + '</span>' +
                '          </div>' +
                '        </div>';

        }

    }
    base = base + '      </div>' +
        '    </div>';


    setTimeout(function () {
        $('.gangs-container02').html(base);
    }, 200);


}

function openLeaderboard() {

    $('.gangs-buttons').removeClass(' scale-down-center');
    $('.gangs-buttons').addClass(' scale-down-reverse');

    var base = '    <div class="controls-container1">' +
        '      <div class="controls-container2" onclick="openButtons()">' +
        '        <svg viewBox="0 0 1024 1024" class="controls-icon">' +
        '          <path' +
        '            d="M854 470v84h-520l238 240-60 60-342-342 342-342 60 60-238 240h520z"' +
        '          ></path>' +
        '        </svg>' +
        '      </div>' +
        '    </div>' +
        '    <div class="leaderboard-leaderboard scale-down-center">' +
        '      <span class="leaderboard-orgs">ORGANIZATIONS</span>' +
        '      <div class="leaderboard-container1">';

    var orgArray = Object.entries(Organizations).map(([key, value]) => {
        var allocation = value.zoneNumber / Object.keys(Zones).length * 100;
        allocation = Math.round(allocation * 100) / 100;
        return { key, value, allocation };
    });


    orgArray.sort((a, b) => b.allocation - a.allocation);

    var orgs = 0;

    for (const org of orgArray) {
        base = base + '        <div class="leaderboard-org" onclick="openMembers(\'' + org.key + '\')" style="background: linear-gradient(180deg, ' + hexToRgbCssVariable(org.value.color, 0.4) + ' 0.00%, rgba(0, 0, 0, 0.58) 100.00%);">' +
            '          <img class="leaderboard-container2" src="' + org.value.picture + '"></img>' +
            '          <span class="leaderboard-text">%' + org.allocation + '</span>' +
            '        </div>';

        orgs++;
        if (orgs >= 20) {
            break;
        }
    }

    base = base + '      </div>' +
        '      <span class="leaderboard-crims">CRIMINALS</span>' +
        '      <div class="leaderboard-crim">';


    var criminalsArray = Object.entries(Criminals).map(([key, value]) => {
        return { key, value };
    });


    criminalsArray.sort((a, b) => b.value.role - a.value.role);

    var criminals = 0;

    for (const criminal of criminalsArray) {
        if (criminal.value.org) {

            base = base + '        <div class="members-container3" style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(config.CriminalTitles[criminal.value.role - 1].Background, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);">' +
                '          <img class="leaderboard-container2" src="' + Organizations[criminal.value.org].picture + '"></img>' +
                '          <div class="members-container4">' +
                '            <span class="members-text2">' + criminal.value.name + '</span>' +
                '            <span class="members-text3" style="color: ' + config.CriminalTitles[criminal.value.role - 1].Color + '">' + config.CriminalTitles[criminal.value.role - 1].Title + '</span>' +
                '          </div>' +
                '        </div>';

            criminals++;
            if (criminals >= 20) {
                break;
            }
        }
    }

    base = base + '      </div>' +
        '    </div>';

    setTimeout(function () {
        $('.gangs-container02').html(base);
    }, 200);
}

function openButtons() {
    var base = '        <div class="gangs-buttons  scale-down-center">' +
        '          <div class="gangs-leaderboard" onclick="openLeaderboard()">' +
        '            <svg viewBox="0 0 1024 1024" class="gangs-icon04">' +
        '              <path' +
        '                d="M692 554h118v256h-118v-256zM452 214h120v596h-120v-596zM214 392h128v418h-128v-418z"' +
        '              ></path>' +
        '            </svg>' +
        '          </div>' +
        '          <div class="gangs-bounties" onclick="openBounties()">' +
        '            <svg viewBox="0 0 948.0045714285714 1024" class="gangs-icon06">' +
        '              <path' +
        '                d="M474.857 384.571c12 0 23.429 3.429 33.714 10.286l126.857 84.571c23.429 15.429 44.571 34.286 62.857 55.429l83.429 97.143c14.286 16.571 20.571 38.857 16.571 60.571l-41.143 236c-4.571 24-24 42.286-48.571 45.143l-301.143 32-201.143 18.286h-5.143c-29.714 0-54.857-24-54.857-54.857 0-28.571 24-51.429 52.571-54.857l148.571-18.286h-256c-31.429 0-56.571-26.286-54.857-57.714 1.714-29.714 28-52 57.714-52l252.571-0.571-297.714-36.571c-30.857-3.429-53.143-31.429-48.571-62.857 4.571-27.429 29.714-45.714 57.143-45.714h5.714l274.857 34.286-200.571-53.714c-28.571-7.429-50.286-33.714-45.714-62.857 4.571-27.429 28-46.286 54.286-46.286 4 0 7.429 0.571 11.429 1.143l256 54.857 124 21.143c1.143 0 2.286 0.571 3.429 0.571 17.143 0 25.714-23.429 10.286-33.714l-106.286-71.429c-26.286-17.714-32.571-53.143-13.714-78.286 10.286-14.286 26.857-21.714 43.429-21.714zM434.857 500l106.286 71.429-124.571-21.143-2.857-1.143-20.571-21.714-136-149.714c-1.143-1.143-1.714-2.857-2.857-4-17.714-23.429-13.714-57.714 10.857-76.571 22.857-17.714 55.429-12 75.429 9.143l81.143 84c-1.714 1.714-3.429 2.857-5.143 4.571-12 16.571-16.571 36.571-13.143 56.571 3.429 19.429 14.857 37.143 31.429 48.571zM941.714 240.571l8.571 152c1.714 28-0.571 56.571-6.286 84l-27.429 125.143c-4.571 21.714-18.286 39.429-38.286 49.714l-60.571 30.857c0.571-22.857-6.857-44.571-22.286-62.286l-83.429-97.143c-19.429-22.286-41.714-42.286-66.857-58.857l-126.857-84.571c-12.571-8.571-27.429-13.143-43.429-13.143-19.429 0-37.143 8-50.286 21.143l-134.286-178.286c-18.857-25.143-13.143-60.571 13.143-78.286 24.571-17.143 58.286-9.143 76.571 14.857l152 201.143-149.714-260c-16-26.857-6.857-61.714 21.143-76.571 26.286-13.714 59.429-2.857 74.286 22.857l137.714 240-77.714-192.571c-10.857-27.429-3.429-60.571 22.857-74.286 28-14.857 62.286-2.857 75.429 25.714l110.286 237.143 57.714 112c9.143 17.714 36 10.286 34.857-9.143l-6.857-128c-1.714-31.429 22.857-57.714 54.286-58.286 29.714 0 53.714 25.143 55.429 54.857z"' +
        '              ></path>' +
        '            </svg>' +
        '          </div>' +
        '          <div class="gangs-members" onclick="openMembers(\'' + Organization + '\')">' +
        '            <svg viewBox="0 0 1024 1024" class="gangs-icon08">' +
        '              <path' +
        '                d="M682 554q56 0 122 16t122 52 56 82v106h-256v-106q0-88-84-148 14-2 40-2zM342 554q56 0 122 16t121 52 55 82v106h-598v-106q0-46 56-82t122-52 122-16zM342 470q-52 0-90-38t-38-90 38-90 90-38 89 38 37 90-37 90-89 38zM682 470q-52 0-90-38t-38-90 38-90 90-38 90 38 38 90-38 90-90 38z"' +
        '              ></path>' +
        '            </svg>' +
        '          </div>' +
        '          <div class="gangs-exit" onclick="focusElement(this, false, \'leave\')">' +
        '<svg viewBox="0 0 1024 1024" class="gangs-icon10">' +
        '      <path' +
        '        d="M810 128q34 0 60 26t26 60v596q0 34-26 60t-60 26h-596q-36 0-61-25t-25-61v-170h86v170h596v-596h-596v170h-86v-170q0-36 25-61t61-25h596zM430 666l110-112h-412v-84h412l-110-112 60-60 214 214-214 214z"' +
        '      ></path>' +
        '    </svg>' +
        '          </div>' +
        '        </div>';

    $('.gangs-container02').html(base);
}

function refreshZonesMenu() {

    map.eachLayer(function (layer) {
        if (layer instanceof zoneElement || layer instanceof PlayerLocation) {
            map.removeLayer(layer);
        }
    });

    let playerLocation = new PlayerLocation([coords['y'], coords['x']]);
    playerLocation.addTo(map);

    for (const [key, value] of Object.entries(Zones)) {
        if (value !== null && value !== undefined) {
            var color;
            if (!IsNullOrUndefined(value.org) && !IsNullOrUndefined(Organizations[value.org])) {
                color = Organizations[value.org].color || '#6e6d6d';
            } else {
                switch (value.type) {
                    case 'value':
                        color = '#eb2f61';
                        break;
                    case 'multiplier':
                        color = '#0e1424';
                        break;
                    case 'house':
                        color = '#0000ff';
                        break;
                    case 'continental':
                        color = '#ebc334';
                        break;
                    default:
                        color = '#6e6d6d';
                }
            }
            var zone = new zoneElement(value.type, key, color, key, value.zoneType);
            map.addLayer(zone);
        }
    }

    $(".fight-zone").mouseenter(function () {
        playSound('zone');
    });
}

function openMenu(mapUnfold = false) {

    refreshZonesMenu();
    playSound('open');

    var allocation = 0;
    var picture = null;

    menuOpen = true;

    if (Organizations[Organization]) {
        allocation = Organizations[Organization].zoneNumber / Object.keys(Zones).length * 100;
        allocation = Math.round(allocation * 100) / 100;
        picture = Organizations[Organization].picture;
    }



    var base = '<div class="gangs-container01 slide-right">' +

        // NOTIFICATIONS
        '<div class="noti-notificationfield"></div>' +

        // FOCUS
        '        <div class="focus" onclick="endFocus()"></div>' +

        // OVERLAY
        '      <div class="gangs-overlay"></div>' +

        //MAP BUTTON
        '        <div class="gangs-container04" onclick="toggleMap()">' +
        '          <svg viewBox="0 0 1024 1024" class="gangs-icon02">' +
        '            <path' +
        '              d="M854 470v84h-520l238 240-60 60-342-342 342-342 60 60-238 240h520z"' +
        '            ></path>' +
        '          </svg>' +
        '        </div>' +

        // HEADER
        '        <span class="gangs-type">ORGANIZATION</span>';

    base = base + '        <div class="gangs-logo" onclick="focusElement(this, false, \'image\')" ><img class="gangs-image" src="' + picture + '" /></div>';
    // POWER AND CURRENCY
    base = base + '        <div class="gangs-container05">' +
        '          <div class="gangs-powercontainer">' +
        '            <span class="gangs-text">POWER</span>' +
        '            <span class="gangs-text1">' + allocation + '%</span>' +
        '          </div>' +
        '          <div class="gangs-shillingcontainer">' +
        '            <span class="gangs-text2">' + config.CurrencyName.toUpperCase() + '</span>' +
        '            <span class="gangs-text3">' + Currency + '</span>' +
        '          </div>' +
        '        </div>' +

        // MAIN MENU
        '      <div class="gangs-container02">' +
        '      </div>' +


        '    </div>' +
        '    </div>';


    $('#main_container').append(base);

    if (!Organizations[Organization]) {

        registerOrganization(true);

    } else {

        openButtons();
        userInfo(false);

    }


    $('.gangs-logo').on('mousemove', function (e) {
        var x = (e.pageX - $(this).offset().left - $(this).width() / 2) / 10;
        var y = (e.pageY - $(this).offset().top - $(this).height() / 2) / -10;

        var lightX = e.pageX - $(this).offset().left;
        var lightY = e.pageY - $(this).offset().top;



        $('.gangs-image').css('transform', 'rotateX(' + y + 'deg) rotateY(' + x + 'deg)');
    });

    $('.gangs-logo').on('mouseleave', function () {
        $('.gangs-image').css('transform', 'rotateX(0deg) rotateY(0deg)');

    });

    if (!IsNullOrUndefined(mapUnfold) && mapUnfold && Organizations[Organization]) {
        setTimeout(() => { toggleMap(); refreshZonesMenu() }, 500)
    }
}

function confirmUserInfo() {

    var alias = $('.gangs-alias').val();

    if (alias.length > 20 || alias.match(/^[a-zA-Z0-9]+$/)) {

        $.post('https://core_gangs/confirmUserInfo', JSON.stringify({
            identifier: Identifier,
            alias: alias
        }));


        $('.userinfo-container2').removeClass('scale-down-center');
        $('.userinfo-container2').addClass('scale-down-reverse');

        setTimeout(function () {
            closeMenu();
        }, 500);

    }

}

let userPreferenceDisplay = false;
function openUserPreference() {
    if (userPreferenceDisplay === false) {
        $('#user-preference').css('transition', '0.0s').slideDown(500, () => {
            $('#user-preference').css('transition', '0.3s');
        });
        userPreferenceDisplay = true;
    } else {
        $('#user-preference').slideUp();
        $('#user-preference').css('transition', '0.0s').slideUp(500, () => {
            $('#user-preference').css('transition', '0.3s');
        });

        userPreferenceDisplay = false;
    }
}

function updatePreference(preferenceName) {
    let preference = !IsNullOrUndefined(UserConfig) ? UserConfig : {};
    if (preferenceName === 'mapIsUnfold') {
        preference.mapIsUnfold = $('#pinMap').prop('checked')
    }
    $.post(`https://${GetParentResourceName()}/updatePreference`, JSON.stringify({
        preference : preference.mapIsUnfold
    }));
}


function userInfo(register) {

    var banner = "#616161";
    if (Criminals[Identifier]) {
        banner = config.CriminalTitles[Criminals[Identifier].role - 1].Background
    }

    // USER INFO
    var base = '        <div class="gangs-userinfo" onclick="openUserPreference()">' +
        '          <img class="gangs-img" src="img/user.png"></img>' +
        '          <div class="gangs-rolebanner" style="background: linear-gradient(90deg, ' + hexToRgbCssVariable(banner, 0.5) + ' 0.00%, rgba(0, 0, 0, 0.88) 100.00%);"></div>' +
        '          <div class="gangs-container03" >';
    if (Criminals[Identifier]) {

        var criminal = Criminals[Identifier];

        base = base + '            <span class="gangs-alias">' + criminal.name + '</span>' +
            '            <span class="gangs-role" style="color: ' + config.CriminalTitles[criminal.role - 1].Color + '">' + config.CriminalTitles[criminal.role - 1].Title + '</span>' +
            '          </div>' +
            '      <div class="gangs-iconbox" onclick="closeMenu()">' +
            '          <svg viewBox="0 0 1024 1024" class="gangs-icon">' +
            '            <path' +
            '              d="M981.333 512c0-129.579-52.565-246.997-137.472-331.861s-202.283-137.472-331.861-137.472-246.997 52.565-331.861 137.472-137.472 202.283-137.472 331.861 52.565 246.997 137.472 331.861 202.283 137.472 331.861 137.472 246.997-52.565 331.861-137.472 137.472-202.283 137.472-331.861zM896 512c0 106.069-42.923 201.984-112.469 271.531s-165.461 112.469-271.531 112.469-201.984-42.923-271.531-112.469-112.469-165.461-112.469-271.531 42.923-201.984 112.469-271.531 165.461-112.469 271.531-112.469 201.984 42.923 271.531 112.469 112.469 165.461 112.469 271.531zM353.835 414.165l97.835 97.835-97.835 97.835c-16.683 16.683-16.683 43.691 0 60.331s43.691 16.683 60.331 0l97.835-97.835 97.835 97.835c16.683 16.683 43.691 16.683 60.331 0s16.683-43.691 0-60.331l-97.835-97.835 97.835-97.835c16.683-16.683 16.683-43.691 0-60.331s-43.691-16.683-60.331 0l-97.835 97.835-97.835-97.835c-16.683-16.683-43.691-16.683-60.331 0s-16.683 43.691 0 60.331z"' +
            '            ></path>' +
            '          </svg>' +
            '        </div>' +
            '        </div>';

        // USER PREFERENCE

        base = base +
            '<div id="user-preference" class="user-preference-container" style="display:none"> ' +
            '<div onclick="openUserPreference()" class="user-preference-close-btn">' +
            '   <svg viewBox="0 0 1024 1024" class="user-preference-close-icon">' +
            '      <path' +
            '        d="M961.714 461.714l-424 423.429c-14.286 14.286-37.143 14.286-51.429 0l-424-423.429c-14.286-14.286-14.286-37.714 0-52l94.857-94.286c14.286-14.286 37.143-14.286 51.429 0l303.429 303.429 303.429-303.429c14.286-14.286 37.143-14.286 51.429 0l94.857 94.286c14.286 14.286 14.286 37.714 0 52z"' +
            '      ></path>' +
            '    </svg>' +
            '</div>' +
            '<div class="user-preference-text"> PREFERENCES </div>' +
            '<div class="user-preference-options">' +
            '<div class="user-preference-text-low">' +
            '<label class="user-preferance-text-label" for="pinMap">UNFOLD MAP BY DEFAULT</label>' +
            '<input type="checkbox" id="pinMap" name="pinMap" onclick="updatePreference(\'mapIsUnfold\')" ' + (!IsNullOrUndefined(UserConfig) && UserConfig.mapIsUnfold ? 'checked' : '') + '/> ' +
            '</div>' +
            '</div>' +
            '</div>';


    } else {

        base = base + '            <input class="gangs-alias input" placeholder="nickname"></input>' +
            '          </div>' +
            '<div class="gangs-iconbox" onclick="confirmUserInfo()">' +
            '<svg viewBox="0 0 1024 1024" class="gangs-icon">' +
            '      <path' +
            '        d="M512 854q140 0 241-101t101-241-101-241-241-101-241 101-101 241 101 241 241 101zM512 86q176 0 301 125t125 301-125 301-301 125-301-125-125-301 125-301 301-125zM708 324l60 60-342 342-212-214 60-60 152 152z"' +
            '      ></path>' +
            '    </svg>' +
            '</div>' +

            '      </div>' +

            '    <div class="userinfo-container1">' +
            '      <div class="userinfo-container2 scale-down-center">' +
            '        <svg viewBox="0 0 804.5714285714286 1024" class="userinfo-icon">' +
            '          <path' +
            '            d="M329.143 877.714l54.857-256-54.857-73.143-73.143-36.571zM475.429 877.714l73.143-365.714-73.143 36.571-54.857 73.143zM566.857 300.571c-0.571-1.143-1.143-2.286-2.286-3.429-5.143-4-46.286-4.571-54.857-4.571-32.571 0-63.429 4.571-95.429 10.857-4 1.143-8 1.143-12 1.143s-8 0-12-1.143c-32-6.286-62.857-10.857-95.429-10.857-8.571 0-49.714 0.571-54.857 4.571-1.143 1.143-1.714 2.286-2.286 3.429 0.571 5.143 1.143 10.286 2.286 15.429 3.429 4.571 6.286 2.857 8.571 9.714 14.857 40.571 21.714 72 73.143 72 73.714 0 53.143-68 77.143-68h6.857c24 0 3.429 68 77.143 68 51.429 0 58.286-31.429 73.143-72 2.286-6.857 5.143-5.143 8.571-9.714 1.143-5.143 1.714-10.286 2.286-15.429zM804.571 802.857c0 93.143-61.143 148-152.571 148h-499.429c-91.429 0-152.571-54.857-152.571-148 0-103.429 18.286-260 124.571-311.429l-51.429-125.714h122.286c-8-23.429-12.571-48-12.571-73.143 0-6.286 0.571-12.571 1.143-18.286-22.286-4.571-110.857-22.857-110.857-54.857 0-33.714 97.143-52 120-56.571 12-42.857 40.571-108 69.714-141.714 11.429-13.143 25.714-21.143 43.429-21.143 34.286 0 61.714 35.429 96 35.429s61.714-35.429 96-35.429c17.714 0 32 8 43.429 21.143 29.143 33.714 57.714 98.857 69.714 141.714 22.857 4.571 120 22.857 120 56.571 0 32-88.571 50.286-110.857 54.857 2.857 30.857-1.143 61.714-11.429 91.429h122.286l-46.857 128.571c102.286 53.143 120 206.857 120 308.571z"' +
            '          ></path>' +
            '        </svg>' +
            '        <span class="userinfo-text">YOU ARE NOT YET A CRIMINAL</span>' +
            '        <span class="userinfo-text1">REGISTRATION</span>' +
            '      </div>' +
            '    </div>';

    }

    if (register) {
        $('.register-container1').append(base);
    } else {
        $('.gangs-container01').append(base);
    }

}

function warIcon(zone, timeleft) {

    let zoneDiv = $('div[zone="' + zone + '"]');

    if (zoneDiv.find('.fight-war').length > 0) {

        if (timeleft == 1) {
            zoneDiv.find('.fight-war').remove();
        } else {
            zoneDiv.find('.fight-wartime').text(formatSeconds(timeleft));
        }

    } else {


        var base = '<div class="fight-war">' +
            '        <svg viewBox="0 0 1024 1024" class="fight-waricon">' +
            '          <path' +
            '            d="M500 810q86 0 145-59t59-145q0-88-24-172-62 82-198 110-120 26-120 132 0 56 40 95t98 39zM576 28q128 104 203 253t75 317q0 140-100 240t-242 100-242-100-100-240q0-216 138-380v16q0 66 44 112t110 46q64 0 105-45t41-113q0-40-8-92t-16-82z"' +
            '          ></path>' +
            '        </svg>' +
            '        <span class="fight-wartime">' + formatSeconds(timeleft) + '</span>' +
            '      </div>';

        zoneDiv.prepend(base);

    }


}

function openZoneMenu(zone) {

    CurrentZone = zone;

    var org;

    if (Zones[zone].org) {

        org = Zones[zone].org;
        $("html").css("--selected-color", Organizations[org].color);
        $("html").css("--selected-rgb", hexToRgbCssVariable(Organizations[org].color, 0.7));

    } else {

        $("html").css("--selected-color", "#595959");
        $("html").css("--selected-rgb", hexToRgbCssVariable("#595959", 0.7));

    }


    var base = '<div class="zonemenu-container01">' +
        '      <div class="zonemenu-info slide-left-zone">' +
        '        <img class="zonemenu-container02" src="' + (Zones[zone].picture || 'img/zone.png') + '"></img>' +
        '        <span class="zonemenu-text">' + (Zones[zone].title || '#' + zone) + '</span>' +
        '        <div class="zonemenu-container03">';
    if (org) {


        base = base + '          <div class="zonemenu-occupied">' +
            '            <span class="zonemenu-orgs">OCCUPIED</span>' +
            '            <div class="zonemenu-container04">' +
            '              <img class="zonemenu-container05" src="' + Organizations[org].picture + '"></img>' +
            '              <span class="zonemenu-text1">' + org.toUpperCase() + '</span>' +
            '            </div>' +
            '          </div>';

    }

    if (config.Zones[zone] && config.Zones[zone].Description != null) {

        base = base + '          <div class="zonemenu-upgrade">' +
            '            <span class="zonemenu-orgs1">DESCRIPTION</span>' +
            '            <div class="zonemenu-description">';

        for (const [key, value] of Object.entries(config.Zones[zone].Description)) {
            base = base + '<div class="desc">' + value + '</div>';
        }

        base = base + '</div>' +
            '</div>';

    }




    if (!config.Continentals[zone]) {

        base = base + '          <div class="zonemenu-upgrade">' +
            '            <span class="zonemenu-orgs1">UPGRADE</span>' +
            '            <div class="zonemenu-container06">';

    }

    if (Zones[zone].protection != null) {
        base = base + '              <div class="zonemenu-container07">' +
            '                <div class="zonemenu-container08">' +
            '                  <span class="zonemenu-text2">' + Zones[zone].protection + '</span>' +
            '                  <svg viewBox="0 0 1024 1024" class="zonemenu-icon">' +
            '                    <path' +
            '                      d="M384 85.333h-213.333c-47.061 0-85.333 38.229-85.333 85.333v213.333c0 47.104 38.272 85.333 85.333 85.333h213.333c47.061 0 85.333-38.229 85.333-85.333v-213.333c0-47.104-38.272-85.333-85.333-85.333zM384 384h-213.333v-213.333h213.333v213.333z"' +
            '                    ></path>' +
            '                    <path' +
            '                      d="M853.333 85.333h-213.333c-47.104 0-85.333 38.229-85.333 85.333v213.333c0 47.104 38.229 85.333 85.333 85.333h213.333c47.104 0 85.333-38.229 85.333-85.333v-213.333c0-47.104-38.229-85.333-85.333-85.333zM853.333 384h-213.333v-213.333h213.333v213.333z"' +
            '                    ></path>' +
            '                    <path' +
            '                      d="M384 554.667h-213.333c-47.061 0-85.333 38.229-85.333 85.333v213.333c0 47.104 38.272 85.333 85.333 85.333h213.333c47.061 0 85.333-38.229 85.333-85.333v-213.333c0-47.104-38.272-85.333-85.333-85.333zM384 853.333h-213.333v-213.333h213.333v213.333z"' +
            '                    ></path>' +
            '                    <path' +
            '                      d="M853.333 554.667h-213.333c-47.104 0-85.333 38.229-85.333 85.333v213.333c0 47.104 38.229 85.333 85.333 85.333h213.333c47.104 0 85.333-38.229 85.333-85.333v-213.333c0-47.104-38.229-85.333-85.333-85.333zM853.333 853.333h-213.333v-213.333h213.333v213.333z"' +
            '                    ></path>' +
            '                  </svg>' +
            '                </div>' +
            '                <div class="zonemenu-container09" onclick="increaseProtection(' + zone + ')">' +
            '                  <span class="zonemenu-text3">UPGRADE</span>' +
            '                  <span class="zonemenu-text4">' + ((Zones[zone].protection + 1) * config.ProtectionValuePrice) + ' ' + config.CurrencyName.toUpperCase() + '</span>' +
            '                </div>' +
            '              </div>';
    }

    if (Zones[zone].npcs != null) {

        base = base + '             <div class="zonemenu-container10">' +
            '                <div class="zonemenu-container11">' +
            '                  <span class="zonemenu-text5">' + Zones[zone].npcs + '</span>' +
            '                  <svg viewBox="0 0 1024 1024" class="zonemenu-icon5">' +
            '                    <path' +
            '                      d="M512 890.112c-50.517-28.672-188.587-114.987-258.133-236.757-3.371-5.888-6.528-11.776-9.515-17.792-19.456-38.869-31.019-80.128-31.019-123.563v-269.099l298.667-112 298.667 112v269.099c0 43.435-11.563 84.693-30.976 123.605-2.987 5.973-6.187 11.904-9.515 17.792-69.589 121.771-207.659 208.043-258.133 236.757zM531.072 976.811c0 0 212.864-105.6 313.173-281.131 4.096-7.168 8.021-14.507 11.776-21.973 24.235-48.427 39.979-102.741 39.979-161.707v-298.667c0-18.176-11.392-33.707-27.691-39.936l-341.333-128c-10.069-3.797-20.693-3.499-29.952 0l-341.333 128c-17.024 6.357-27.563 22.485-27.691 39.936v298.667c0 58.965 15.744 113.28 40.021 161.749 3.712 7.467 7.637 14.763 11.776 21.973 100.309 175.531 313.173 281.131 313.173 281.131 12.459 6.229 26.453 5.803 38.144 0z"' +
            '                    ></path>' +
            '                  </svg>' +
            '                </div>' +
            '                <div class="zonemenu-container12" onclick="increaseNPCS(' + zone + ')">' +
            '                  <span class="zonemenu-text6">UPGRADE</span>' +
            '                  <span class="zonemenu-text7">' + ((Zones[zone].npcs + 1) * config.NPCValuePrice) + ' ' + config.CurrencyName.toUpperCase() + '</span>' +
            '                </div>' +
            '              </div>';

    }

    if (!config.Continentals[zone]) {

        base = base + '            </div>' +
            '          </div>';

    }

    base = base + '<div class="waypoint-options">' +
        '      <span class="waypoint-org">OPTIONS</span>' +
        '      <div class="waypoint-set" onclick="setWaypoint(\'' + zone + '\')">' +
        '        <svg viewBox="0 0 1024 1024" class="waypoint-icon">' +
        '          <path' +
        '            d="M512 0c-282.77 0-512 229.23-512 512s229.23 512 512 512 512-229.23 512-512-229.23-512-512-512zM96 512c0-229.75 186.25-416 416-416 109.574 0 209.232 42.386 283.534 111.628l-411.534 176.372-176.372 411.534c-69.242-74.302-111.628-173.96-111.628-283.534zM585.166 585.166l-256.082 109.75 109.75-256.082 146.332 146.332zM512 928c-109.574 0-209.234-42.386-283.532-111.628l411.532-176.372 176.372-411.532c69.242 74.298 111.628 173.958 111.628 283.532 0 229.75-186.25 416-416 416z"' +
        '          ></path>' +
        '        </svg>' +
        '        <span class="waypoint-text">SET WAYPOINT</span>' +
        '      </div>' +
        '    </div>' +


        '        </div>';
    if (!config.Continentals[zone]) {
        base = base + '        <div class="zonemenu-container13" onclick="startWar(' + zone + ')">' +
            '          <div class="zonemenu-container14"></div>' +
            '          <svg viewBox="0 0 1024 1024" class="zonemenu-icon7">' +
            '            <path' +
            '              d="M426 704l256-192-256-192v384zM512 86q176 0 301 125t125 301-125 301-301 125-301-125-125-301 125-301 301-125z"' +
            '            ></path>' +
            '          </svg>' +
            '          <span class="zonemenu-text8">START WAR</span>' +
            '        </div>' +
            '      </div>' +
            '    </div>';

    }

    if ($('.zonemenu-container01').length) {
        $('.zonemenu-info').removeClass('slide-left-zone');
        $('.zonemenu-info').addClass('slide-right-zone');
        setTimeout(function () {
            $('.zonemenu-container01').remove();
            $('#main_container').prepend(base);
        }, 200);
    } else {
        $('#main_container').prepend(base);
    }
}

function IsNullOrUndefined(data) {
    return data === undefined || data === null;
}

window.addEventListener('message', function (event) {
    var edata = event.data;

    if (edata.type == 'open') {

        Organizations = edata.orgs;
        Zones = edata.zones;
        Bounties = edata.bounties;
        Criminals = edata.criminals;
        config = edata.config;
        Organization = edata.org;
        Identifier = edata.cid;
        coords = edata.coords;
        UserConfig = edata.userConfig

        // SETUP COLORS
        if (Organizations[Organization]) {
            $("html").css("--main-color", Organizations[Organization].color);
            $("html").css("--rgb-color", hexToRgbCssVariable(Organizations[Organization].color, 0.3));
        }

        openMenu(UserConfig?.mapIsUnfold);

    }
    if (edata.type == 'update') {

        Organizations = edata.orgs;
        Zones = edata.zones;
        Bounties = edata.bounties;
        Criminals = edata.criminals;
        config = edata.config;
        Organization = edata.org;
        UserConfig = edata.userConfig
    }
    if (edata.type == 'currency') {

        Currency = edata.currency;
        $('.gangs-text3').text(Currency);


    }
    if (edata.type == 'invite') {

        Invitations.push(edata.org);

    }
    if (edata.type == 'notification') {

        pushNotification(edata.text);

    }
    if (edata.type == 'stopWarChart') {
        stopWarMenu();
    }
    if (edata.type == 'updateWars') {
        warIcon(edata.zone, edata.timeleft)
    }

    if (edata.type == 'updateWarChart') {
        if (updateChartLock) { return; }

        if ((CurrentWar != edata.zone) && WarChart) {
            updateChartLock = true;
            ChangeWarMenu(edata)
        } else {
            CurrentWar = edata.zone;
            warMenu();
            updateWarMenu(edata.data, edata.timeleft, edata.inwarzone);
        }
    }

    if (edata.type == 'refreshZones') {

        Zones = edata.zones;

        refreshZonesMenu();
        if (CurrentZone) openZoneMenu(CurrentZone);


    }
    if (edata.type == 'continental') {
        config = edata.config;
        openContinental(edata.zone);
    }
});