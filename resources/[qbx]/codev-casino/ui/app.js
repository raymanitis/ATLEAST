const formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
});
let avatarChanged = false;
$(document).ready(function(){
    $(document).on('click', '.sidebar ul li', function(e){
        e.preventDefault();
        $(".selected").removeClass("selected");
        $(this).addClass("selected");
        var page = $(this).attr('data-page');
        loadPage(page);
    });
})

$(function(){
    // toggleUI()
    // $("#homepage").fadeOut();
    // $("#mines").css("display", "flex");
    window.addEventListener('message', function(event){
        var item = event.data;
        switch(item.action){
            case 'open':
                toggleUI();
                let titleName = item.casinoName; // add &hairsp; every letter
                let titleNameConverted = "";
                for (let i = 0; i < titleName.length; i++) {
                    titleNameConverted += titleName[i] + "&hairsp;";
                }
                $(".header .title").html(titleNameConverted);
                break;
            case 'close':
                toggleUI();
                break;
            case 'updateBalance':
                $('.balance').html(item.balance);
                break;
            case 'updateName':
                $('.name').html(item.name);
                break;
            case 'updateAvatar':
                $('.avatar').css('background-image', 'url('+item.avatar+')');
                break;
            case 'receiveLivematches':
                loadLiveMatches(item.data);
                break;
            case 'receiveUpcomingmatches':
                loadUpcomingMatches(item.data);
            case 'receiveData':
                loadPlayerData(item.data);
                break;
            case 'receiveBets':
                loadMyBets(item.data);
                break;
            case 'receiveMessages':
                loadMessages(item.data);
                break;
            case 'loadLanguage':
                loadLanguage(item.data);
                break;
            case 'sendNotification':
                sendNotification(item.data);
                break;
            default:
                break;
        }
    });
})

function loadLanguage(data){
    $.each(data, function(_, val){
        let element = $("[data-lang='"+_+"']");
        if(element.length > 0){
            element.html(val);
        }
    })
}
NotifTimeout = null;
function sendNotification(data){ 
    if (NotifTimeout != null) clearTimeout(NotifTimeout);
    $(".notification").fadeIn();
    $(".notification-title").html(data.title);
    $(".notification-desc").html(data.desc);
    
    NotifTimeout = setTimeout(function(){
        $(".notification").fadeOut();
    }, 5000);
}

function loadMessages(data){
    $(".chat-list").empty();
    $.each(data, function(_, val){
        let html = "";
        html += `
        <div class="chat-message" data-index="${_}">
            <div class="msg-title">
                <div class="chat-image" style="background-image: url('${val.image}');"></div>
                <div class="chat-sender">${val.name}</div>
                <div class="chat-time">${val.time}</div>
            </div>
            <div class="chat-text">${val.message}</div>
        </div>
        `;
        $(".chat-list").append(html);
    })
}

function loadMyBets(data){
    $(".bets").empty();
    $.each(data, function(_, val){
        let html = `
            <div class="bet" id="bet-${val.id}">
                <div class="bets-title">
                    <div class="bets-title-div">
                        <div class="bets-text">${val.coupons.length} Matches ${val.day} &nbsp; #${val.id}</div>
                    </div>
                    <div class="bets-title-div">
                        <div class="bets-text">MAX WIN ${formatter.format(val.potential)}</div>
                    </div>
                </div>
                <div class="my-bets">
                    <div class="bets-table">
                        <div class="bets-table-head">
                            <div class="bets-head-item">ID</div>
                            <div class="bets-head-item">Match</div>
                            <div class="bets-head-item">Odds</div>
                            <div class="bets-head-item">Bet Type</div>
                            <div class="bets-head-item">Status</div>
                        </div>
                        <div class="bets-table-bodies" id="bets-table-${val.id}">

                        </div>
                        <div class="bets-bottom">
                            <div class="bets-bottom-class">
                                <div class="bets-bottom-item first">MAX ODD</div>
                                <div class="bets-bottom-item">${val.maxOdd}</div>
                            </div>
                            <div class="bets-bottom-class">
                                <div class="bets-bottom-item first">PRICE</div>
                                <div class="bets-bottom-item">${formatter.format(val.amount)}</div>
                            </div>
                        </div>
                        <div class="line" style="margin-top: 1%;width: 100%;"></div>
                    </div>
                </div>
            </div>
        `
        $(".bets").prepend(html);
        $.each(val.coupons, function(_, coupon){
            let html = `
            <div class="bets-table-body">
                <div class="bets-body-item">
                    <div class="bets-table-item">${coupon.matchid}</div>
                    <div class="bets-table-item">${coupon.match}</div>
                    <div class="bets-table-item">${coupon.odd}</div>
                    <div class="bets-table-item">${coupon.type}</div>
                    <div class="bets-table-item" data-table-item="status"><img src="imgs/${coupon.status}.png"></div>
                </div>
            </div>
            `
            $("#bets-table-"+val.id).append(html);
        });
    });
}

function loadPlayerData(data){
    let balance = data.money;
    let name = data.name;
    let avatar = data.image;
    if(balance != undefined && name != undefined && avatar != undefined){
        $("#balance").html(formatter.format(balance));
        $("#wallet-balance").html(formatter.format(balance));
        $("#nickname-input").attr("placeholder", name);
        $(".pfp-image").css("background-image", "url("+avatar+")");
        $(".avatar").css("background-image", "url("+avatar+")");
    }

    if(data.isAdmin){
        $.contextMenu({
            selector: '.chat-sender', 
            callback: function(key, options) {
                let index = $(this).parent().parent().data("index");
                switch(key){
                    case 'ban':
                        $.post('https://'+GetParentResourceName()+'/banPlayer', JSON.stringify({
                            index: index
                        }))
                        break;
                    case 'timeout':
                        $.post('https://'+GetParentResourceName()+'/timeoutPlayer', JSON.stringify({
                            index: index
                        }))
                        break;
                    case 'delete':
                        $.post('https://'+GetParentResourceName()+'/deleteMessage', JSON.stringify({
                            index: index
                        }))
                        break;
                }
            },
            items: {
                "ban": {name: "Ban Player", icon: "fa-ban"},
                "timeout": {name: "Timeout Player", icon: "fa-hourglass"},
                "delete": {name: "Delete", icon: "fa-trash"},
            }
        });
    }

    if(data.timeout){
        $("#chat-message-input").attr("disabled", "disabled");
        $("#chat-message-input").attr("placeholder", "You can't use chat for 1 hour!");
        $("#send-message").attr("disabled", "disabled");
    }

    if(data.chatban){
        $("#chat-message-input").attr("disabled", "disabled");
        $("#chat-message-input").attr("placeholder", "You are chat banned!");
        $("#send-message").attr("disabled", "disabled");
    }

    if(data.veniatorHistory){
        $(".table-body").empty();
        $.each(data.veniatorHistory, function(_, val){
            let classText = "";
            if(val.coeff >= 2){
                classText = "f2x";
            } else if(val.coeff >= 10){
                classText = "f10x";
            }
            let html = `
            <div class="table-body-item">
                <div class="table-body-item-inner body-item-time">${val.time}</div>
                <div class="table-body-item-inner">${formatter.format(val.amount)}</div>
                <div class="table-body-item-inner body-item-multiply ${classText}">${val.coeff}x</div>
                <div class="table-body-item-inner">${formatter.format(val.win)}</div>
            </div>
            `
            $(".table-body").prepend(html);
        })
    }
}

function loadUpcomingMatches(data){
    $(".current-upcoming-matches").empty();
    $("#upcoming-matches-title span").html("("+data.length+")")
    $.each(data, function(_, val){
        let league = val.leagues;
        let homeTeam = val.home;
        let matchid = val.matchid;
        let awayTeam = val.away;
        let html = `
        <div class="upcoming-match">
            <div class="upcoming-teams">
                <div class="upcoming-team-name" data-home="${homeTeam}" data-away="${awayTeam}" data-league="${league}">${homeTeam}</div>
                <div class="upcoming-team-name" data-home="${homeTeam}" data-away="${awayTeam}" data-league="${league}">${awayTeam}</div>
            </div>
            <div class="upcoming-match-details">
                <div class="upcoming-odds">
                    <div class="odds-top">
                        <div class="upcoming-item">
                            <img src="imgs/date.png">
                            <div class="upcoming-child-item">${val.start_time}</div>
                        </div>
                        <div class="upcoming-item">
                            <img src="imgs/time.png">
                            <div class="upcoming-child-item">${val.start_hours}</div>
                        </div>
                        <div class="upcoming-item">
                            <img src="imgs/league.png">
                            <div class="upcoming-child-item" id="league-text">${league}</div>
                        </div>
                    </div>
                </div>
            <div class="pulsating-circle" id="create-coupon" data-odds='${JSON.stringify(val.odds)}' data-home="${homeTeam}" data-away="${awayTeam}" data-match="${matchid}">
                    <div class="second-circle">
                        <div class="third-circle">VS</div>
                    </div>
                </div>
            </div>
        </div>
        `;
        $(".current-upcoming-matches").append(html);
    });
}

function loadLiveMatches(data){
    $(".current-matches").empty();
    $("#live-matches-title span").html("("+data.length+")")
    $.each(data, function(_, val){
        let league = val.leagues;
        let homeScore = val.home_score;
        let awayScore = val.away_score;
        let minutes = val.minutes;
        let homeTeam = val.home;
        let awayTeam = val.away;
        let half = val.periodTXT;
        let html = `
        <div class="live-match">
            <div class="team-name" style="margin-left: 5%;">${homeTeam}</div>
            <div class="team-score-section">
                <div class="team-score">${homeScore}</div>
                <div class="score-bottom"><img src="imgs/score-arrow.png"></div>
            </div>
            <div class="match-details">
                <div class="pulsating-circle">
                    <div class="second-circle">
                        <div class="third-circle">VS</div>
                    </div>
                </div>
                <div class="match-league">${league}</div>
                <div class="match-timer">${half} | ${minutes}'</div>
            </div>
            <div class="team-score-section">
                <div class="team-score">${awayScore}</div>
                <div class="score-bottom"><img src="imgs/score-arrow.png"></div>
            </div>
            <div class="team-name" style="margin-right: 5%;" data-team="${awayTeam}">${awayTeam}</div>
        </div>
        `;
        $(".current-matches").append(html);
    });
}

function toggleUI(){
    let menuState = $(".ui").css("display");
    if(menuState == "none"){
        $(".ui").fadeIn();
        $(".ui").css("display", "flex");
        $(".menus").fadeIn();
    } else{
        $(".ui").fadeOut();
        $(".menus").hide();
    }
}

function loadPage(page){
    switch(page){
        case 'leave':
        toggleUI();
        $(".sidebar ul li[data-page='homepage']").addClass("selected");
        $(".sidebar ul li[data-page='leave']").removeClass("selected");
        $.post('https://'+GetParentResourceName()+'/close')
            break;
    }
}

$(function() {
    $(".spinner-button-down").on('click', function(e){
        let val = $(this).parent().children("input").val();
        if(val > 1){
            $(this).parent().children("input").val(Number(Number(val) - 1).toFixed(2));
            $(this).parent().children("input").trigger('keyup');
        }
    });
    $(".spinner-button-up").on('click', function(e){
        let val = $(this).parent().children("input").val();
        $(this).parent().children("input").val(Number(Number(val) + 1).toFixed(2));
        $(this).parent().children("input").trigger('keyup');
    });

    $('.h-sidebar').on('click', function(e){
        let menuState = $('.avatarmenu').data('state');
        if (menuState == "closed"){
            $('.avatarmenu').data('state', 'open');
            $('.avatarmenu').fadeIn(500);
        } else {
            $('.avatarmenu').fadeOut();
            $('.avatarmenu').data('state', 'closed');
        }
    })    
    $('.chat').on('click', function(e){
        let menuState = $('.chatmenu').data('state');
        if (menuState == "closed"){
            $('.chatmenu').data('state', 'open');
            $('.chatmenu').fadeIn(500);
        } else {
            $('.chatmenu').fadeOut();
            $('.chatmenu').data('state', 'closed');
        }
    })    
    $('#plus-sign').on('click', function(e){
        let menuState = $('.walletmenu').data('state');
        if (menuState == "closed"){
            $('.walletmenu').data('state', 'open');
            $('.walletmenu').fadeIn(500);
            $(".container").css("filter", "blur(5px)");
        } else {
            $('.walletmenu').fadeOut();
            $('.walletmenu').data('state', 'closed');
            $(".container").css("filter", "blur(0px)");
        }
    })
    $("#withdraw-options .menu-option").on('click', function(e){
        let optionState = $(this).hasClass('option-selected');
        if(!optionState){
            $(".option-selected").children("img").attr("src", "imgs/menu-select-item.png");
            $(".option-selected").removeClass("option-selected");
            $(this).addClass("option-selected");
            $(this).children(".menu-option-text").addClass("option-selected");
            $(this).children("img").attr("src", "imgs/menu-selected.png");
        }
    })
    $("#deposit-options .menu-option").on('click', function(e){
        let optionState = $(this).hasClass('option-selected2');
        if(!optionState){
            $(".option-selected2").children("img").attr("src", "imgs/menu-select-item.png");
            $(".option-selected2").removeClass("option-selected2");
            $(this).addClass("option-selected2");
            $(this).children(".menu-option-text").addClass("option-selected2");
            $(this).children("img").attr("src", "imgs/menu-selected2.png");
        }
    })
    $(".closebutton").on('click', function(e){
        $(this).parent().fadeOut();
        $(this).parent().data('state', 'closed');
        $(".container").css("filter", "blur(0px)");
    })
    $("#hide-coupon").on('click', function(e){
        let state = $(".coupon-to-hide").css("display");
        if(state == "none"){
            $(".coupon-to-hide").css("display", "unset");
            $(".couponmenu").css("height", "67.8vh");
            $(".couponmenu").css("top", "23%");
        } else {
            $(".coupon-to-hide").fadeOut();
            $(".couponmenu").css("height", "6.7vh");
            $(".couponmenu").css("top", "83%");
        }
    })
    $("#update-pfp").on('click', function(e){
        let val = $("#pfp-input").val();
        if(val != ""){
            $(".pfp-image").css('filter', 'brightness(0.3)');
            $(".avatar-loading").fadeIn();
            $(".avatar-loading").circleProgress({
                value: 1,
                startAngle: -Math.PI / 2,
                size: 65,
                fill: '#1CA7E2',
            });
            avatarChanged = val
            setTimeout(function(){
                $(".avatar-loading").fadeOut();
                $(".pfp-image").css('filter', 'brightness(1)');
                $(".pfp-image").css("background-image", `url('${val}')`);
            }, 2000);
        }
    })
    $("#update-name").on('click', function(e){
        let val = $("#nickname-input").val();
        if(val != ""){
            $.post('https://'+GetParentResourceName()+'/updateName', JSON.stringify({
                name: val
            }))
        }
    })
    $("#edit-submit").on('click', function(e){
        $('.avatarmenu').fadeOut();
        $('.avatarmenu').data('state', 'closed');
        if(avatarChanged){
            $.post('https://'+GetParentResourceName()+'/updatePFP', JSON.stringify({
                url: avatarChanged
            }));
        }
    })
    $(".chat-sender").on('click', function(e){
        $( "#target" ).contextmenu(function() {
            alert( "Handler for .contextmenu() called." );
        });
    })
    let playerCoupons = [];
    $(document).on('click', '#create-coupon', function(e){
        $(".coupon-to-hide").css("display", "unset");
        $(".couponmenu").fadeIn(300);
        let home = $(this).data("home").substring(0, 3);
        let away = $(this).data("away").substring(0, 3);
        let match = $(this).data("match");
        let odds = $(this).data("odds");
        if (playerCoupons.includes(match)) return;
        let oddsHtml = "";
        $.each(odds, function(_, val){
            oddsHtml += `<option value='${JSON.stringify({type: val.type, odd: val.odd})}'>${val.title} (${val.odd})</option>`;
        })
        let html = `
        <div class="coupon" id="coupon-${match}">
            <div class="coupon-details">
                <div class="coupon-id">${match}</div>
                <div class="coupon-match">${home} - ${away}</div>
                <div class="coupon-odd">--- ODD</div>
            </div>
            <div class="line" style="width: 90%;background: rgba(255, 255, 255, 0.12);height: 2px;margin: 4% auto;"></div>
            <div class="coupon-odds">
                <div class="coupon-time">Today, 20:00</div>
                <select name="odds" id="odds-${match}" data-odds='${JSON.stringify(odds)}'>
                    <option value="default">SELECT</option>
                    ${oddsHtml}
                </select>
            </div>
        </div>
        `;
        $(".coupons").append(html);
        playerCoupons.push(match);
    })
    $(document).on('change', '.coupon-odds select', function(e){
        let oddJSON = $(this).val();
        if(oddJSON == "default"){
            $(this).parent().parent().children(".coupon-details").children(".coupon-odd").html("--- ODD");
            $("#odd-total").html("---");
            $("#maxWin").html("$---");
            return;
        }
        let odd = JSON.parse(oddJSON).odd;
        $(this).parent().parent().children(".coupon-details").children(".coupon-odd").html(odd + " ODD");
        let couponLength = playerCoupons.length;
        if(couponLength > 2){
            // get all odds and multiply them
            let totalOdd = 1;
            let counted = 0;
            playerCoupons.forEach(function(coupon){
                let odd = $("#coupon-"+coupon).children(".coupon-details").children(".coupon-odd").html();
                if(odd != "--- ODD"){
                    odd = Number(odd.substring(0, odd.length - 4));
                    totalOdd = odd * totalOdd;
                    counted++;
                }
            })
            if (counted == couponLength) {
                $("#odd-total").html(totalOdd.toFixed(2));
                let price = $("#totalPrice").val();
                if(price != ""){
                    let total = price * totalOdd;
                    $("#maxWin").html(formatter.format(total.toFixed(2)));
                }
            } else {
                $("#odd-total").html("---");
            }
        }    
    })

    $("#playCoupon").on('click', function(e){
        let couponLength = playerCoupons.length;
        let coupons = [];
        let totalPrice = $("#totalPrice").val();
        $(".coupon").each(function(_){
            let match = $(this).attr("id").substring(7);
            // get selected odd
            let selectedOdd = $(this).children(".coupon-odds").children("select").val();
            let oddType = JSON.parse(selectedOdd).type;
            if(selectedOdd != "default"){
                coupons.push({
                    match: match,
                    value: oddType
                })
            }
        });
        if(couponLength > 2){
            if(totalPrice != "---"){
                $.post('https://'+GetParentResourceName()+'/playCoupon', JSON.stringify({
                    coupons: coupons,
                    price: totalPrice
                }))
                $(".coupons").empty();
                $(".couponmenu").fadeOut();
                $("#maxWin").html("$---");
                $("#totalPrice").val("");
                $("#odd-total").val("0");
                playerCoupons = [];
            }
        }
    })

    $(".veniator").on('click', function(e){
        $("#casino").hide();
        $("#veniator").css("display", "flex");
    });

    $(".mines").on('click', function(e){
        $("#casino").hide();
        $("#mines").css("display", "flex");
    });

    $(".plinko").on('click', function(e){
        $("#casino").hide();
        $("#plinko").css("display", "flex");
    });

    $(".dice").on('click', function(e){
        $("#casino").hide();
        $("#dice").css("display", "flex");
    });

    $(document).on('click', '#send-message', function(e){
        sendChatMessage();
    })

    $(".category").on('click', function(e){
        let data = $(this).data("category");
        $(".category-selected").removeClass("category-selected");
        $(this).addClass("category-selected");
        $(".bets").hide();
        $(".live-and-upcoming").hide();
        $("."+data).fadeIn();

        if(data == "bets"){
            $.post('https://'+GetParentResourceName()+'/getMyBets')
        }
    })
    function hideAll(){
        $("#homepage").hide();
        $("#sports").hide();
        $("#casino").hide();
        $("#veniator").hide();
        $("#plinko").hide();
        $("#mines").hide();
        $("#dice").hide();
    }

    $(".header .title").on('click', function(e){
        hideAll();
        $(".sidebar ul li").removeClass("selected");
        $(".sidebar ul li[data-page='homepage']").addClass("selected");
        $("#homepage").fadeIn();
    })
    $(".sidebar ul li[data-page='homepage']").on('click', function(e){
        hideAll();
        $(".sidebar ul li").removeClass("selected");
        $(".sidebar ul li[data-page='homepage']").addClass("selected");
        $("#homepage").fadeIn();
    })
    $(".sidebar ul li[data-page='sports']").on('click', function(e){
        hideAll();
        $.post('https://'+GetParentResourceName()+'/getLivematches')
        $(".sidebar ul li").removeClass("selected");
        $(".sidebar ul li[data-page='sports']").addClass("selected");
        $("#sports").fadeIn();
    })
    $(".sidebar ul li[data-page='casino']").on('click', function(e){
        $.post('https://'+GetParentResourceName()+'/getLivematches')
        hideAll();
        $(".sidebar ul li").removeClass("selected");
        $(".sidebar ul li[data-page='casino']").addClass("selected");
        $("#casino").fadeIn();
    })
    $("#casino-button").on('click', function(e){
        $.post('https://'+GetParentResourceName()+'/getCasinoGames')
        hideAll();
        $(".sidebar ul li").removeClass("selected");
        $(".sidebar ul li[data-page='casino']").addClass("selected");
        $("#casino").fadeIn();
    })
    $("#sports-button").on('click', function(e){
        $.post('https://'+GetParentResourceName()+'/getLivematches')
        hideAll();
        $(".sidebar ul li").removeClass("selected");
        $(".sidebar ul li[data-page='sports']").addClass("selected");
        $("#sports").fadeIn();
    })
    $(".icons-and-buttons .icons img").on('click', function(e){
        if($(this).attr("src") == "imgs/remove.png"){
            $(".coupons").empty();
            $(".couponmenu").fadeOut();
            $("#maxWin").html("$---");
            $("#totalPrice").val("");
            $("#odd-total").val("0");
            playerCoupons = [];
        }
    })
    $("#deposit-button").on('click', function(e){
        let amount = $("#deposit-input").val();
        let type = $("#deposit-options .option-selected2").data("type");
        $.post('https://'+GetParentResourceName()+'/deposit', JSON.stringify({
            type: type,
            amount: amount
        }))
    })
    $("#withdraw-button").on('click', function(e){
        let amount = $("#withdraw-input").val();
        let type = $("#withdraw-options .option-selected").data("type");
        $.post('https://'+GetParentResourceName()+'/withdraw', JSON.stringify({
            type: type,
            amount: amount
        }))
    })

    $.contextMenu({
        selector: '.coupon', 
        callback: function(key, options) {
            playerCoupons.splice(playerCoupons.indexOf($(this).attr("id").substring(7)), 1);
            $(this).remove();
            $("#maxWin").html();
            $("#totalPrice").val("");
            $("#odd-total").val("---");
            if ($('.coupon').length == 0) {
                $(".couponmenu").fadeOut();
            }
        },
        items: {
            "delete": {name: "Remove", icon: "delete"},
        }
    });

    $("#totalPrice").on('keyup', function(e){
        let val = $(this).val();
        let totalOdd = $("#odd-total").html();
        if(val != ""){
            let total = val * totalOdd;
            if (totalOdd != "---") {
                $("#maxWin").html(formatter.format(total.toFixed(2)));
            }
        }
    })

    // search in .current-upcoming-matches with input #upcoming-match-search 
    $("#upcoming-match-search").on('keyup', function(e){
        let val = $(this).val();
        let amount = 0;
        $(".current-upcoming-matches .upcoming-match").each(function(){
            // get match name = home + away +  
            let match = $(this).children(".upcoming-teams").children(".upcoming-team-name").data("home") + " " + $(this).children(".upcoming-teams").children(".upcoming-team-name").data("away") + " " + $(this).children(".upcoming-teams").children(".upcoming-team-name").data("league")
            console.log(match)
            if(match.toLowerCase().includes(val.toLowerCase())){
                amount++;
                $("#upcoming-matches-title span").html("("+amount+")")     
                $(this).fadeIn("fast");
            } else {
                $(this).fadeOut("fast");
            }
        })
    })
});

function sendChatMessage(){
    let message = $("#chat-message-input").val();

    $.post('https://'+GetParentResourceName()+'/sendMessage', JSON.stringify({
        message: message
    }))
    $("#chat-message-input").val("");
    // if(message != ""){
    //     $("#chat-message-input").val("");
    //     let html = "";
    //     html += `
    //     <div class="chat-message">
    //         <div class="msg-title">
    //             <div class="chat-image" style="background-image: url('${data.image}');"></div>
    //             <div class="chat-sender">${data.nickname}</div>
    //             <div class="chat-time">${data.time}</div>
    //         </div>
    //         <div class="chat-text">${data.message}</div>
    //     </div>
    //     `;
    //     $(".chat-list").append(html);
    // }
}
