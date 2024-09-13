window.addEventListener('message', function(event) {
    if(event.data.action == "veniatorWaiting"){
        waitForGame()
    } else if(event.data.action == "veniatorUpdate"){
        updateCoeff(event.data.coeff)
    } else if(event.data.action == "veniatorStarted"){
        restartGame()
    } else if(event.data.action == "veniatorFinished"){
        stopAnimation()
        $('.veniator-run-gif').attr('src', './imgs/fall.gif')
        $('.veniator-run-gif').css('top', '-5.4vh')
        $(".fellDown-text").show();
        $('.veniator-run-gif').css('filter', 'hue-rotate(0deg)')
        $('.veniator-run-gif').css('top', 'hue-rotate(0deg)')

        placedBet1 = false;
        placedBet2 = false;
        let val1 = Number($("#bet-amount-first").val());
        let val2 = Number($("#bet-amount-second").val());
        $("#bet-button-first").css("background-color", "#28a909");
        $("#bet-button-first").css("border", "solid 1px #b2f2a3");
        $("#bet-button-first").html("BET<br>"+Number(val1).toFixed(2)+" USD")
        $("#bet-button-second").css("background-color", "#28a909");
        $("#bet-button-second").css("border", "solid 1px #b2f2a3");
        $("#bet-button-second").html("BET<br>"+Number(val2).toFixed(2)+" USD")
    } else if(event.data.action == "veniatorHistory"){
        veniatorHistory(event.data.history)
    } else if(event.data.action == "veniatorBet"){
        if(event.data.result){
            if(event.data.bet == 1){
                let val = Number($("#bet-amount-first").val());
                placedBet1 = val;
                $("#bet-button-first").css("background-color", "#cb011a");
                $("#bet-button-first").css("border", "solid 1px #ff7171");
                $("#bet-button-first").html("CANCEL")
            } else {
                let val = Number($("#bet-amount-second").val());
                placedBet2 = val;
                $("#bet-button-second").css("background-color", "#cb011a");
                $("#bet-button-second").css("border", "solid 1px #ff7171");
                $("#bet-button-second").html("CANCEL")
            }
        }
    } else if(event.data.action == "veniatorCancelBet"){
        if(event.data.result){
            if(event.data.bet == 1){
                let val = Number($("#bet-amount-first").val());
                placedBet1 = false;
                $("#bet-button-first").css("background-color", "#28a909");
                $("#bet-button-first").css("border", "solid 1px #b2f2a3");
                $("#bet-button-first").html("BET<br>"+Number(val).toFixed(2)+" USD")
            } else {
                let val = Number($("#bet-amount-second").val());
                placedBet2 = false;
                $("#bet-button-second").css("background-color", "#28a909");
                $("#bet-button-second").css("border", "solid 1px #b2f2a3");
                $("#bet-button-second").html("BET<br>"+Number(val).toFixed(2)+" USD")
            }
        }
    }
});

//interavls
let rotateInterval, animationInterval;

//numbers
let rotateNum, widthNum, gifPositionNum;

let coeff = 1

let placedBet1 = false;
let placedBet2 = false;

$(function(){
    $("#bet-button-first").click(function(){
        let val = Number($("#bet-amount-first").val());
        if(!placedBet1){
            $.post('http://'+GetParentResourceName()+'/placeBet', JSON.stringify({
                bet: val,
                index: 1,
            }));
        } else {
            $.post('http://'+GetParentResourceName()+'/cancelBet', JSON.stringify({
                index: 1,
            }));
        }
    });

    $("#bet-button-second").click(function(){
        let val = Number($("#bet-amount-second").val());
        if(!placedBet2){
            $.post('http://'+GetParentResourceName()+'/placeBet', JSON.stringify({
                bet: val,
                index: 2,
            }));
        } else {
            $.post('http://'+GetParentResourceName()+'/cancelBet', JSON.stringify({
                index: 2,
            }));
        }
    });

    $("#bet-amount-first").on('keyup', function(e){
        if(!placedBet1){
            let val = $(this).val();
            if(val > 1){
                $("#bet-button-first").html("BET<br>"+val+" USD")
            }
        } else {
            $.post('http://'+GetParentResourceName()+'/cancelBet', JSON.stringify({
                index: 1,
            }));
        }
    });

    $("#bet-amount-second").on('keyup', function(e){
        if(!placedBet2){
            let val = $(this).val();
            if(val > 1){
                $("#bet-button-second").html("BET<br>"+Number(val).toFixed(2)+" USD")
            }
        } else {
            $.post('http://'+GetParentResourceName()+'/cancelBet', JSON.stringify({
                index: 2,
            }));
        }
    });
})

function veniatorHistory(history) {
    $(".history-box").empty();
    $.each(history, function(index, value) {
        let classText = "";
        if(value > 2){
            classText = " m2x";
        }
        if(value > 10){
            classText = " m10x";
        }
        let html = `<div class="history-item${classText}">${value.toFixed(2)}x</div>`;
        $(".history-box").prepend(html);
    });
}

function updateCoeff(newCoeff) {
    coeff = newCoeff
    $(".veniator-coeff-duration").text(`${coeff.toFixed(2)}x`)
    if(coeff > 2){
        $('.veniator-game-container').removeClass('veniator-container-backgroundBlue')
        $('.veniator-game-container').addClass('veniator-container-backgroundRed')
        $('.veniator-square1').css('background', 'rgb(189, 8, 50)')
        $('.veniator-coeff-duration').css('text-shadow', '0px 0px 100px rgba(189, 8, 50, 1)')
        $('.veniator-game-container').css('border-color', 'rgb(189, 8, 50)')
        $('.veniator-run-gif').css('filter', 'hue-rotate(150deg)')
        $(".veniator-coeff-duration").css("color", 'rgb(189, 8, 50)')
    } else if (coeff > 10){
        // make it purple
        $('.veniator-game-container').removeClass('veniator-container-backgroundRed')
        $('.veniator-game-container').addClass('veniator-container-backgroundPurple')
        $('.veniator-square1').css('background', 'rgb(189, 8, 50)')
        $('.veniator-coeff-duration').css('text-shadow', '0px 0px 100px rgba(189, 8, 50, 1)')
        $('.veniator-game-container').css('border-color', 'rgb(189, 8, 50)')
        $('.veniator-run-gif').css('filter', 'hue-rotate(150deg)')
        $(".veniator-coeff-duration").css("color", 'rgb(189, 8, 50)')
    } else {
        $('.veniator-game-container').removeClass('veniator-container-backgroundRed')
        $('.veniator-game-container').removeClass('veniator-container-backgroundPurple')
        $('.veniator-game-container').addClass('veniator-container-backgroundBlue')
        $('.veniator-coeff-duration').css('text-shadow', '0px 0px 100px rgba(255, 255, 255, 1)')
        $('.veniator-game-container').css('border-color', 'rgb(106,200,242)')
        $(".veniator-coeff-duration").css("color", 'rgb(255, 255, 255)')
        $('.veniator-run-gif').css('filter', 'hue-rotate(0deg)')
    }
}

function startGame() {
    rotateNum = 0;
    widthNum = 0;
    $(".veniator-starting").hide();
    $(".veniator-square1").show();
    $(".veniator-game-container").show();
    $(".veniator-coeff-duration").show();
    $('.veniator-game-container').removeClass('veniator-container-backgroundTransparent')
    $('.veniator-game-container').addClass('veniator-container-backgroundBlue')
    //rotate animation
    rotateInterval = setInterval(() => {
        widthNum += 0.040;
        rotateNum += 0.005;
        let stopLimit = 12;
        let widthLimit = 102;
        if(placedBet1){
            $("#bet-button-first").css("background-color", "#d07206");
            $("#bet-button-first").css("border", "solid 1px #ffbd71");
            $("#bet-button-first").html("CASH OUT<br>"+Number(placedBet1 * coeff).toFixed(2)+" USD")
        }
        if(placedBet2){
            $("#bet-button-second").css("background-color", "#d07206");
            $("#bet-button-second").css("border", "solid 1px #ffbd71");
            $("#bet-button-second").html("CASH OUT<br>"+Number(placedBet2 * coeff).toFixed(2)+" USD")
        }
        if(coeff > 2){
            rotateNum += 0.01;
        }
        if(coeff > 5){
            widthNum += 0.020;
        }
        if(widthNum < widthLimit) {
            $(".veniator-game-container").css("width", widthNum + "%")
        }
        
        if (Number(rotateNum).toFixed(0) < stopLimit) {
            $('.veniator-game-container').css(`transform`, `rotate(-${rotateNum}deg)`)
        }
    }, 10);
}

function runAnimation() {
    gifPositionNum = 0;
    
    $('.veniator-run-gif').attr('src', './imgs/run.gif')
    $('.veniator-run-gif').css({
        'top': '-6.4vh',
        'left': '0',
    })
    animationInterval = setInterval(() => {
        let containerWidth = $('.veniator-game-container').css('width').slice(0, -2);
        let animationLeftPosition = $('.veniator-run-gif').css('left').slice(0, -2);
        
        if (animationLeftPosition < containerWidth - 47) {
            gifPositionNum += 0.07;
            $('.veniator-run-gif').css('left', `${gifPositionNum}vh`)
        }

    }, 10);
}

// startGame();
// runAnimation();

// waitForGame()
function waitForGame() {
    $(".veniator-game-container").hide();
    $(".veniator-coeff-duration").hide();
    $(".veniator-square1").hide();
    $(".veniator-starting").fadeIn();
    $(".fellDown-text").hide();
    // in 10 seconds make veniator-loading-inner width 100% to 0%
    $(".veniator-loading-inner").css("width", "100%");
    $(".veniator-loading-inner").animate({
        width: "0%"
    }, 10000, function() {
    });
}


function restartGame() {
    stopAnimation();
    runAnimation();
    startGame();
}

function stopAnimation() {
    clearInterval(rotateInterval)
    clearInterval(animationInterval)
}