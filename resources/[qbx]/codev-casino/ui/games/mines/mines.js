$(document).ready(function () {
    play_button_enabled = true;
    cashout_button_enabled = false;
    num_of_bombs = 1;
    game_in_progress = false;
    bomb_locations = [];
    selected_tiles = [];
    winnings = 0;


    window.addEventListener('message', function (event) {
        if(event.data.type == "minesBet"){
            if (play_button_enabled) {
                newGame();
            }
        }
    });

    $(".mines-button-half").click(function () {
        let val = Number($("#mines-bet-amount-input").val());
        if (val > 0) {
            $("#mines-bet-amount-input").val(Number(Number(val) / 2).toFixed(2))
        }
    });

    $(".mines-button-double").click(function () {
        let val = Number($("#mines-bet-amount-input").val());
        if (val > 0) {
            $("#mines-bet-amount-input").val(Number(Number(val) * 2).toFixed(2))
        }
    });

    // Options List
    $('.options li').click(function () {
        $('.options li').each(function () {
            $(this).removeClass('selected');
        });
        $(this).addClass('selected');
        num_of_bombs = parseInt($(this).attr("id"));
    });

    // When play button is clicked
    $('.mines-bet-button').click(function () {
        bet = parseFloat($('#mines-bet-amount-input').val());
        $.post('https://'+GetParentResourceName()+'/minesBet', JSON.stringify({
            amount: bet
        }));
    });

    // Game function
    function newGame() {
        if (!game_in_progress) {
            num_of_bombs = $(".mines-mine-select select").val();
            game_in_progress = true;
            winnings = bet;
            updateWinnings();
            togglePlayButton();
            toggleCashoutButton();
            setBombLocations(num_of_bombs, 1, 25);
        }
    }



    // When tile is clicked
    $('#tiles li').click(function () {
        if (game_in_progress) {
            var index = $(this).index() + 1;
            if (selected_tiles.indexOf(index) == -1) {
                selected_tiles.push(index);
                if (bomb_locations.indexOf(index) == -1) {
                    // Did NOT select a bomb
                    $(this).addClass('good');
                    var odds = 1 - (num_of_bombs / (26 - selected_tiles.length));
                    var multiplier = 1 / odds;
                    var new_winnings = +(((bet * multiplier) - bet).toFixed(2));
                    winnings = +((winnings + new_winnings).toFixed(2));
                    updateWinnings();
                } else {
                    // Did select a bomb
                    $(this).addClass('bad');
                    toggleCashoutButton();
                    game_in_progress = false;
                    setTimeout(function () {
                        togglePlayButton();
                        winnings = 0;

                        updateWinnings();
                        bomb_locations = [];
                        selected_tiles = [];
                        $('#tiles li').each(function () {
                            $(this).removeClass();
                        });
                    }, 500);
                }
            }
        }
    });

    $('.mines-cashout-button').click(function () {
        if (cashout_button_enabled) {
            // End game
            toggleCashoutButton();
            togglePlayButton();
            $.post('https://'+GetParentResourceName()+'/minesCashout', JSON.stringify({
                amount: winnings
            }));
            winnings = 0;
            updateWinnings();
            game_in_progress = false;
            bomb_locations = [];
            selected_tiles = [];
            $('#tiles li').each(function () {
                $(this).removeClass();
            });
        }
    });

    function updateWinnings() {
        winnings = +(winnings).toFixed(2); $('.mines-cashout-button').html("Cashout ($" + winnings + ")");
    }

    function togglePlayButton() {
        $('.mines-bet-button').toggleClass('disabled');
        if (play_button_enabled) {
            play_button_enabled = false;
        } else {
            play_button_enabled = true;
        }
    }

    function toggleCashoutButton() {
        $('.mines-cashout-button').toggleClass('disabled');
        if (cashout_button_enabled) {
            cashout_button_enabled = false;
        } else {
            cashout_button_enabled = true;
        }
    }

    function setBombLocations(amount, min, max) {
        for (i = 0; i < amount; i++) {
            var num = Math.floor(Math.random() * max) + min;
            while (bomb_locations.indexOf(num) != -1) {
                num = Math.floor(Math.random() * max) + min;
            }
            bomb_locations.push(num);
        }
    }
});