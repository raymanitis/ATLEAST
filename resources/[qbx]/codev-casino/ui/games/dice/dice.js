$(function () {
    window.addEventListener('message', function (event) {
        if (event.data.type == "rollDice") {
            if ($(".dice-bet-button").hasClass("disabled")) {
                setTimeout(function () {rollDice(event.data.number)}, 500);
                return;
            }
            rollDice(event.data.number);
        }
    });


    $(".dice-button-half").click(function () {
        let val = Number($("#dice-bet-amount-input").val());
        if (val > 0) {
            $("#dice-bet-amount-input").val(Number(Number(val) / 2).toFixed(2))
            $("#dice-profit-to-win").text(Number($("#dice-bet-amount-input").val()) * Number(calculateMultiplier(Number($("#dice-range").val()))).toFixed(4));
        } 1
    });

    $(".dice-button-double").click(function () {
        let val = Number($("#dice-bet-amount-input").val());
        if (val > 0) {
            $("#dice-bet-amount-input").val(Number(Number(val) * 2).toFixed(2))
            $("#dice-profit-to-win").text(Number($("#dice-bet-amount-input").val()) * Number(calculateMultiplier(Number($("#dice-range").val()))).toFixed(4));
        }
    });

    function rollDice(value){
        $(".dice-bet-button").addClass("disabled");
        $(".dice-image").css("height", "90%");
        $(".dice-image").fadeIn();
        $(".dice-image").animate({
            marginLeft: value + "%",
        }, 350, "linear");
        $(".dice-text").text(Number(value).toFixed(2));
        $(".dice-image").animate({
            height: "100%",
        }, 100, "linear");
        let rollOver = value > Number($("#dice-range").val());
        if (rollOver) {
            $(".dice-text").css("color", "#00ff00");
        } else {
            $(".dice-text").css("color", "#ff0000");
        }

        let historyLength = $(".dice-history-item").length;
        if (historyLength >= 5) {
            $(".dice-history-item").first().remove();
        }
        let historyItem = $("<div class='dice-history-item'></div>");
        historyItem.text(Number(value).toFixed(2));
        if (rollOver) {
            historyItem.addClass("win");
        }
        $(".dice-history").append(historyItem);
        lastValue = value;
        setTimeout(function () {
            $(".dice-bet-button").removeClass("disabled");
        }, 500);
    }

    let lastValue = 40;
    $(".dice-bet-button").click(function () {
        let val = Number($("#dice-bet-amount-input").val());
       $.post('https://'+GetParentResourceName()+'/diceBet', JSON.stringify({
            amount: val,
            rollOver: Number($("#dice-range").val()),
       }));
    });

    $("#dice-bet-amount-input").on("change", function () {
        let val = $(this).val();
        if(val >= 1) {
            $("#dice-profit-to-win").text(Number(val) * Number(calculateMultiplier(Number($("#dice-range").val()))).toFixed(4));
        }
    });

    $("#dice-range").on("change", function () {
        let val = $(this).val();
        if(val >= 10 && val <= 98) {
            $("#roll-over-text").text(Number(val).toFixed(2));
            $("#win-chance-text").text(Number(100 - val).toFixed(2));
            $("#multiplier-text").text(Number(calculateMultiplier(val)).toFixed(4));
            $("#dice-profit-to-win").text(Number($("#dice-bet-amount-input").val()) * Number(calculateMultiplier(val)).toFixed(4));
        } else if(val <= 10){
            $("#dice-range").val(10);
            $("#dice-range").trigger("change");
            $("#dice-profit-to-win").text(Number($("#dice-bet-amount-input").val()) * Number(calculateMultiplier(10)).toFixed(4));
        } else if(val >= 98) {
            $("#dice-range").val(98);
            $("#dice-range").trigger("change");
            $("#dice-profit-to-win").text(Number($("#dice-bet-amount-input").val()) * Number(calculateMultiplier(98)).toFixed(4));
        }
    });

    function calculateMultiplier(zarDegeri) {
        let carpmaSonucu = ((zarDegeri / (100 - zarDegeri) + zarDegeri / 1000 ) + 1) - (zarDegeri / 350) 
        return carpmaSonucu;
    }
})