const BucketMultipliers = {
    "high": {
        8: [29, 4, 1.5, 0.3, 0.2, 0.3, 1.5, 4, 29],
        9: [43, 7, 2, 0.6, 0.2, 0.2, 0.6, 2, 7, 43],
        10: [76, 10, 3, 0.9, 0.3, 0.2, 0.3, 0.9, 3, 10, 76],
        11: [120, 14, 5.2, 1.4, 0.4, 0.2, 0.2, 0.4, 1.4, 5.2, 14, 120],
        12: [170, 24, 8.1, 2, 0.7, 0.2, 0.2, 0.2, 0.7, 2, 8.1, 24, 170],
        13: [260, 37, 11, 4, 1, 0.2, 0.2, 0.2, 0.2, 1, 4, 11, 37, 260],
        14: [420, 56, 18, 5, 1.9, 0.3, 0.2, 0.2, 0.2, 0.3, 1.9, 5, 18, 56, 420],
        15: [620, 83, 27, 8, 3, 0.5, 0.2, 0.2, 0.2, 0.2, 0.5, 3, 8, 27, 83, 620],
        16: [1000, 130, 26, 9, 4, 2, 0.2, 0.2, 0.2, 0.2, 0.2, 2, 4, 9, 26, 130, 1000],
    },
    "medium": {
        8: [13, 3, 1.3, 0.7, 0.4, 0.7, 1.3, 3, 13],
        9: [18, 4, 1.7, 0.9, 0.5, 0.5, 0.9, 1.7, 4, 18],
        10: [22, 5, 2, 1.4, 0.6, 0.4, 0.6, 1.4, 2, 5, 22],
        11: [24, 6, 3, 1.8, 0.7, 0.5, 0.5, 0.7, 1.8, 3, 6, 24],
        12: [33, 11, 4, 2, 1.1, 0.6, 0.3, 0.6, 1.1, 2, 4, 11, 33],
        13: [43, 13, 6, 3, 1.3, 0.7, 0.4, 0.4, 0.7, 1.3, 3, 6, 13, 43],
        14: [58, 15, 7, 4, 1.9, 1, 0.5, 0.2, 0.5, 1, 1.9, 4, 7, 15, 58],
        15: [88, 18, 11, 5, 3, 1.3, 0.5, 0.3, 0.3, 0.5, 1.3, 3, 5, 11, 18, 88],
        16: [110, 41, 10, 5, 3, 1.5, 1, 0.5, 0.3, 0.5, 1, 1.5, 3, 5, 10, 41, 110],
    },
    "low": {
        8: [5.6, 2.1, 1.1, 1, 0.5, 1, 1.1, 2.1, 5.6],
        9: [5.6, 2, 1.6, 1, 0.7, 0.7, 1, 1.6, 2, 5.6],
        10: [8.9, 3, 1.4, 1.1, 1, 0.5, 1, 1.1, 1.4, 3, 8.9],
        11: [8.4, 3, 1.9, 1.3, 1, 0.7, 0.7, 1, 1.3, 1.9, 3, 8.4],
        12: [10, 3, 1.6, 1.4, 1.1, 1, 0.5, 1, 1.1, 1.4, 1.6, 3, 10],
        13: [8.1, 4, 3, 1.9, 1.2, 0.9, 0.7, 0.7, 0.9, 1.2, 1.9, 3, 4, 8.1],
        14: [7.1, 4, 1.9, 1.4, 1.3, 1.1, 1, 0.5, 1, 1.1, 1.3, 1.4, 1.9, 4, 7.1],
        15: [15, 8, 3, 2, 1.5, 1.1, 1, 0.7, 0.7, 1, 1.1, 1.5, 2, 3, 8, 15],
        16: [16, 9, 2, 1.4, 1.4, 1.2, 1.1, 1, 0.5, 1, 1.1, 1.2, 1.4, 1.4, 2, 9, 16],
    }
}

const Chances = {
    8: [0.3906, 3.1250, 10.9375, 21.8750, 27.3438, 21.8750, 10.9375, 3.1250, 0.3906],
    9: [0.1953, 1.7578, 7.0313, 16.4063, 24.6094, 24.6094, 16.4063, 7.0313, 1.7578, 0.1953],
    10: [0.0977, 1.0742, 4.3945, 11.8164, 20.0195, 24.9023, 20.0195, 11.8164, 4.3945, 1.0742, 0.0977],
    11: [0.0488, 0.5371, 2.4414, 7.3242, 15.6250, 22.9492, 22.9492, 15.6250, 7.3242, 2.4414, 0.5371, 0.0488],
    12: [0.0244, 0.2686, 1.2207, 4.3945, 10.2539, 18.2617, 23.7305, 18.2617, 10.2539, 4.3945, 1.2207, 0.2686, 0.0244],
    13: [0.0122, 0.1348, 0.6104, 2.1973, 6.3477, 13.9648, 21.4844, 21.4844, 13.9648, 6.3477, 2.1973, 0.6104, 0.1348, 0.0122],
    14: [0.0061, 0.0674, 0.3052, 1.0986, 4.1504, 10.0586, 17.5781, 22.2656, 17.5781, 10.0586, 4.1504, 1.0986, 0.3052, 0.0674, 0.0061],
    15: [0.0031, 0.0337, 0.1526, 0.5493, 2.6855, 7.8125, 14.3555, 20.0195, 20.0195, 14.3555, 7.8125, 2.6855, 0.5493, 0.1526, 0.0337, 0.0031],
    16: [0.0015, 0.0168, 0.0763, 0.2747, 1.3428, 4.8828, 11.7188, 17.0898, 21.4844, 17.0898, 11.7188, 4.8828, 1.3428, 0.2747, 0.0763, 0.0168, 0.0015],
}

$(function () {
    window.addEventListener('message', function (event) {
        if (event.data.type == "dropBall") {
            dropBall(event.data.index);
        }
    });

    $(".plinko-button-half").click(function () {
        let val = Number($("#plinko-bet-amount-input").val());
        if (val > 0) {
            $("#plinko-bet-amount-input").val(Number(Number(val) / 2).toFixed(2))
        } 1
    });

    $(".plinko-button-double").click(function () {
        let val = Number($("#plinko-bet-amount-input").val());
        if (val > 0) {
            $("#plinko-bet-amount-input").val(Number(Number(val) * 2).toFixed(2))
        }
    });

    $(".plinko-row-select select").change(function () {
        let val = $(this).val();
        createBoard(Number(val));
    });

    $(".plinko-risk-select select").change(function () {
        let val = $(".plinko-row-select select").val();
        createBoard(Number(val));
    });

    $(".plinko-bet-button").click(function () {
        // dropBall(selectedIndex);
        $.post("https://"+GetParentResourceName()+"/plinkoBet", JSON.stringify({
            amount: Number($("#plinko-bet-amount-input").val()),
            risk: $(".plinko-risk-select select").val(),
            row: Number($(".plinko-row-select select").val()),
        }));
    });
})

let maxPos = 0;
var board = $('#plinko-screen');
function createBoard(n) {
    maxPos = n;
    board.empty();
    board.attr('size', n);
    for (var i = 0; i <= n; i++) {
        for (var j = 0; j <= i; j++) {
            var x = 0.5 + (j - (i / 2)) / (n + 2);
            var y = (i + 1) / (n + 2);
            var s = 1 / (i == n ? 3 : 5) / (n + 2);
            if (i == n) {
                let risk = $(".plinko-risk-select select").val();
                let backgroundColor = Chances[n][j] > 0.1 ? "rgb(255, 144, 16)" : "rgb(255, 0, 63)";
                let boxShadow = Chances[n][j] > 0.1 ? "0 .2em 0 0 #aa4b00" : "0 .2em 0 0 #a60004";
                var css = {
                    position: 'absolute',
                    top: (100 * y) + '%',
                    left: (100 * x) + '%',
                    width: (100 * s * 2.5) + '%',
                    height: (100 * s * 1.5) + '%',
                    background: backgroundColor,
                    borderRadius: '5px',
                    boxShadow: boxShadow,
                    transform: 'translate(-50%, -50%)',
                    display: 'flex',
                    justifyContent: 'center',
                    alignItems: 'center',
                    fontSize: '.8em',
                };
                var attr = {
                    row: i,
                    pos: j
                };
                let multiplier = BucketMultipliers[risk][n][j];
                if (multiplier != 1000){
                    board.append($('<div>').text(multiplier+"x").css(css).attr(attr).addClass(i == n ? 'bucket' : 'pin'));
                } else {
                    board.append($('<div>').text(multiplier).css(css).attr(attr).addClass(i == n ? 'bucket' : 'pin'));
                }
            } else {
                var css = {
                    position: 'absolute',
                    top: (100 * y) + '%',
                    left: (100 * x) + '%',
                    width: (100 * s) + '%',
                    height: (100 * s) + '%',
                    background: ('#fff'),
                    borderRadius: '50%',
                    transform: 'translate(-50%, -50%)'
                };
                var attr = {
                    row: i,
                    pos: j
                };
                board.append($('<div>').css(css).attr(attr).addClass(i == n ? 'bucket' : 'pin'));

            }
        }
    }
}

function dropBall(targetBucket) {
    var s = 1 / 3 / (parseInt(board.attr('size')) + 2);
    var speed = 200;
    let ballColor;
    let risk = $(".plinko-risk-select select").val();
    if(risk === "low"){
        ballColor = "rgb(255, 192, 0)";
    } else if (risk === "medium"){
        ballColor = "rgb(255, 144, 16)";
    } else if (risk === "high"){
        ballColor = "rgb(255, 0, 63)";
    }
    var css = {
        position: 'absolute',
        top: (-100 * s) + '%',
        left: '50%',
        width: (100 * s) + '%',
        height: (100 * s) + '%',
        background: ballColor,
        borderRadius: '50%',
        animationDuration: (speed / 1000) + 's',
        transform: 'translate(-50%, -125%)'
    };
    var attr = {
        step: 0,
        delta: 0,
        target: targetBucket
    };
    var ball = $('<div>').css(css).attr(attr);
    board.append(ball);
    function getDataFromObj(obj) {
        var step = parseInt(obj.attr('step'));
        var delta = parseInt(obj.attr('delta'));
        var target = board.find('[row=' + step + '][pos=' + delta + ']');
        return {
            top: target.css('top'),
            left: target.css('left')
        }
    }
    function animationCallback() {
        var obj = $(this);
        obj.attr('step', parseInt(obj.attr('step')) + 1);
        var step = parseInt(obj.attr('step'));
        var size = parseInt(board.attr('size'));
        if (step != size + 1) {
            var heading = (Math.random() < 0.5 ? 0 : 1);
            var target = parseInt(obj.attr('target'));
            var delta = parseInt(obj.attr('delta'));
            if (delta == target) {
                heading = 0;
            } else if (size - step + 1 == target - delta) {
                heading = 1;
            }
            obj.attr('delta', parseInt(obj.attr('delta')) + heading);
            obj.removeAttr('heading').delay(speed / 10).queue(function () {
                $(this).attr('heading', heading).dequeue();
            });
            obj.animate(getDataFromObj(obj), speed, animationCallback);
        } else {
            obj.removeAttr('heading').delay(speed / 10).queue(function () {
                $(this).attr('heading', 2).dequeue();
            }).delay(speed).queue(function () {
                $(this).remove().dequeue();
                $.post("https://"+GetParentResourceName()+"/plinkoResult", JSON.stringify({
                    amount: Number($("#plinko-bet-amount-input").val()),
                    risk: $(".plinko-risk-select select").val(),
                    row: Number($(".plinko-row-select select").val()),
                    index: targetBucket
                }));
            });
        }
    }
    ball.animate(getDataFromObj(ball), speed, animationCallback);
}

createBoard(16);

function selectIndexByProbability(array) {
    // Toplam olasılık hesaplanır
    const totalProbability = array.reduce((sum, probability) => sum + probability, 0);

    // Rastgele bir sayı seçilir
    const randomNum = Math.random() * totalProbability;

    // Seçilen sayıya göre indeks belirlenir
    let cumulativeProbability = 0;
    for (let i = 0; i < array.length; i++) {
        cumulativeProbability += array[i];
        if (randomNum <= cumulativeProbability) {
            return i;
        }
    }

    // Hata durumu için son indeksi döndürür
    return array.length - 1;
}
