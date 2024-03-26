$('document').ready(function () {
    alerts = {};

    window.addEventListener('message', function (event) {
        ShowNotif(event.data);
    });

    function ShowNotif(data) {
        var $notification = CreateNotification(data);
        $('#main').append($notification);
        setTimeout(function () {
            $.when($notification.fadeOut()).done(function () {
                $notification.remove()
            });
        }, data.length != null ? data.length : 2500);
    }

    function CreateNotification(data) {
        var $notification = $(document.createElement('div'));
        if (!data) return null;
        // console.log(data.info.loc);
        $notification.addClass('notification-block').addClass(data.style);
        $notification.html(`
        <div class="notification police animate__animated animate__bounceInRight">
            <div class="content">
                <div class="col hidden-xs">
                    <img src="" alt="">
                </div>
                <div class="col right">
                    <div class="title">${data.info["code"]} <div class="location"> | ${data.info.loc ? `<i class="fas fa-map-marker-alt" aria-hidden="true"></i> ${data.info.loc}` : ''}</div></div>
                    <div class="description">${data.info["name"]}</div>
                </div>
            </div>
        </div>`);
        $notification.fadeIn();
        if (data.style !== undefined) {
            Object.keys(data.style).forEach(function (css) {
                $notification.css(css, data.style[css])
            });
        }
        return $notification;
    }


    alerts.BaseAlert = function (style, info) {
        switch (style) {
            case 'ems':
                alerts.EMSAlert(info)
                break;
            case 'police':
                alerts.PoPo(info)
                break;
        }
    };

    alerts.PoPo = function (info) {

        $('.alerts-wrapper').html('\
        <div class="alerts police">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-globe-europe"></i>' + info["loc"] + '</div>\
        </div>').fadeIn(1000);

        setTimeout(HideAlert, 4500);
    };

    alerts.EMSAlert = function (info) {
        //console.log(info["code"])
        $('.alerts-wrapper').html('\
        <div class="alerts ems">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-skull-crossbones"></i> ' + info["loc"] + '</div>\
        </div>').fadeIn(1000);

        setTimeout(HideAlert, 4500);
    };


    function HideAlert() {
        $('.alerts-wrapper').fadeOut(1000);
    };
});