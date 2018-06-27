var Index = function () {


    return {

        //main function to initiate the module
        init: function () {

            App.addResponsiveHandler(function () {
                Index.initCalendar();
                jQuery('.vmaps').each(function () {
                    var map = jQuery(this);
                    map.width(map.parent().width());
                });
            });
        },


        initCalendar: function () {
            if (!jQuery().fullCalendar) {
                return;
            }

            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();

            var h = {};

            if ($('#calendar').width() <= 400) {
                $('#calendar').addClass("mobile");
                h = {
                    left: 'title, prev, next',
                    center: '',
                    right: 'today,month,agendaWeek,agendaDay'
                };
            } else {
                $('#calendar').removeClass("mobile");
                if (App.isRTL()) {
                    h = {
                        right: 'title',
                        center: '',
                        left: 'prev,next,today,month,agendaWeek,agendaDay'
                    };
                } else {
                    h = {
                        left: 'title',
                        center: '',
                        right: 'prev,next,today,month,agendaWeek,agendaDay'
                    };
                }               
            }

            $('#calendar').fullCalendar('destroy'); // destroy the calendar
            $('#calendar').fullCalendar({ //re-initialize the calendar
                disableDragging: false,
                header: h,
                editable: true,
                events: [{
                        title: 'All Day Event',                        
                        start: new Date(y, m, 1),
                        backgroundColor: App.getLayoutColorCode('yellow')
                    }, {
                        title: 'Long Event',
                        start: new Date(y, m, d - 5),
                        end: new Date(y, m, d - 2),
                        backgroundColor: App.getLayoutColorCode('green')
                    }, {
                        title: 'Repeating Event',
                        start: new Date(y, m, d - 3, 16, 0),
                        allDay: false,
                        backgroundColor: App.getLayoutColorCode('red')
                    }, {
                        title: 'Repeating Event',
                        start: new Date(y, m, d + 4, 16, 0),
                        allDay: false,
                        backgroundColor: App.getLayoutColorCode('green')
                    }, {
                        title: 'Meeting',
                        start: new Date(y, m, d, 10, 30),
                        allDay: false,
                    }, {
                        title: 'Lunch',
                        start: new Date(y, m, d, 12, 0),
                        end: new Date(y, m, d, 14, 0),
                        backgroundColor: App.getLayoutColorCode('grey'),
                        allDay: false,
                    }, {
                        title: 'Birthday Party',
                        start: new Date(y, m, d + 1, 19, 0),
                        end: new Date(y, m, d + 1, 22, 30),
                        backgroundColor: App.getLayoutColorCode('purple'),
                        allDay: false,
                    }, {
                        title: 'Click for Google',
                        start: new Date(y, m, 28),
                        end: new Date(y, m, 29),
                        backgroundColor: App.getLayoutColorCode('yellow'),
                        url: 'http://google.com/',
                    }
                ]
            });
        },




        initDashboardDaterange: function () {

            $('#dashboard-report-range').daterangepicker({
                ranges: {
                    'Today': ['today', 'today'],
                    'Yesterday': ['yesterday', 'yesterday'],
                    'Last 7 Days': [Date.today().add({
                            days: -6
                        }), 'today'],
                    'Last 30 Days': [Date.today().add({
                            days: -29
                        }), 'today'],
                    'This Month': [Date.today().moveToFirstDayOfMonth(), Date.today().moveToLastDayOfMonth()],
                    'Last Month': [Date.today().moveToFirstDayOfMonth().add({
                            months: -1
                        }), Date.today().moveToFirstDayOfMonth().add({
                            days: -1
                        })]
                },
                opens: (App.isRTL() ? 'right' : 'left'),
                format: 'MM/dd/yyyy',
                separator: ' to ',
                startDate: Date.today().add({
                    days: -29
                }),
                endDate: Date.today(),
                minDate: '01/01/2012',
                maxDate: '12/31/2014',
                locale: {
                    applyLabel: '提交',
                    fromLabel: 'From',
                    toLabel: 'To',
                    customRangeLabel: 'Custom Range',
                    daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
                    monthNames: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
                    firstDay: 1
                },
                showWeekNumbers: true,
                buttonClasses: ['btn-danger']
            },

            function (start, end) {
                App.blockUI(jQuery("#dashboard"));
                setTimeout(function () {
                    App.unblockUI(jQuery("#dashboard"));
                    $.gritter.add({
                        title: 'Dashboard',
                        text: 'Dashboard date range updated.'
                    });
                    App.scrollTo();
                }, 1000);
                $('#dashboard-report-range span').html(start.toString('MMMM d, yyyy') );

            });

            $('#dashboard-report-range').show();

            $('#dashboard-report-range span').html(Date.today().add({
                days: -29
            }).toString('MMMM d, yyyy') );
        },

        initIntro: function () {
            if ($.cookie('intro_show')) {
                return;
            }

            $.cookie('intro_show', 1);

            setTimeout(function () {
                var unique_id = $.gritter.add({
                    // (string | mandatory) the heading of the notification
                    title: 'Meet Metronic!',
                    // (string | mandatory) the text inside the notification
                    text: 'Metronic is a brand new Responsive Admin Dashboard Template you have always been looking for!',
                    // (string | optional) the image to display on the left
                    image: './assets/img/avatar1.jpg',
                    // (bool | optional) if you want it to fade out on its own or just sit there
                    sticky: true,
                    // (int | optional) the time you want it to be alive for before fading out
                    time: '',
                    // (string | optional) the class name you want to apply to that specific message
                    class_name: 'my-sticky-class'
                });

                // You can have it return a unique id, this can be used to manually remove it later using
                setTimeout(function () {
                    $.gritter.remove(unique_id, {
                        fade: true,
                        speed: 'slow'
                    });
                }, 12000);
            }, 2000);

            setTimeout(function () {
                var unique_id = $.gritter.add({
                    // (string | mandatory) the heading of the notification
                    title: 'Buy Metronic!',
                    // (string | mandatory) the text inside the notification
                    text: 'Metronic comes with a huge collection of reusable and easy customizable UI components and plugins. Buy Metronic today!',
                    // (string | optional) the image to display on the left
                    image: './assets/img/avatar1.jpg',
                    // (bool | optional) if you want it to fade out on its own or just sit there
                    sticky: true,
                    // (int | optional) the time you want it to be alive for before fading out
                    time: '',
                    // (string | optional) the class name you want to apply to that specific message
                    class_name: 'my-sticky-class'
                });

                // You can have it return a unique id, this can be used to manually remove it later using
                setTimeout(function () {
                    $.gritter.remove(unique_id, {
                        fade: true,
                        speed: 'slow'
                    });
                }, 13000);
            }, 8000);

            setTimeout(function () {

                $('#styler').pulsate({
                    color: "#bb3319",
                    repeat: 10
                });

                $.extend($.gritter.options, {
                    position: 'top-left'
                });

                var unique_id = $.gritter.add({
                    position: 'top-left',
                    // (string | mandatory) the heading of the notification
                    title: 'Customize Metronic!',
                    // (string | mandatory) the text inside the notification
                    text: 'Metronic allows you to easily customize the theme colors and layout settings.',
                    // (string | optional) the image to display on the left
                    image1: './assets/img/avatar1.png',
                    // (bool | optional) if you want it to fade out on its own or just sit there
                    sticky: true,
                    // (int | optional) the time you want it to be alive for before fading out
                    time: '',
                    // (string | optional) the class name you want to apply to that specific message
                    class_name: 'my-sticky-class'
                });

                $.extend($.gritter.options, {
                    position: 'top-right'
                });

                // You can have it return a unique id, this can be used to manually remove it later using
                setTimeout(function () {
                    $.gritter.remove(unique_id, {
                        fade: true,
                        speed: 'slow'
                    });
                }, 15000);

            }, 23000);

            setTimeout(function () {

                $.extend($.gritter.options, {
                    position: 'top-left'
                });

                var unique_id = $.gritter.add({
                    // (string | mandatory) the heading of the notification
                    title: 'Notification',
                    // (string | mandatory) the text inside the notification
                    text: 'You have 3 new notifications.',
                    // (string | optional) the image to display on the left
                    image1: './assets/img/image1.jpg',
                    // (bool | optional) if you want it to fade out on its own or just sit there
                    sticky: true,
                    // (int | optional) the time you want it to be alive for before fading out
                    time: '',
                    // (string | optional) the class name you want to apply to that specific message
                    class_name: 'my-sticky-class'
                });

                setTimeout(function () {
                    $.gritter.remove(unique_id, {
                        fade: true,
                        speed: 'slow'
                    });
                }, 4000);

                $.extend($.gritter.options, {
                    position: 'top-right'
                });

                var number = $('#header_notification_bar .badge').text();
                number = parseInt(number);
                number = number + 3;
                $('#header_notification_bar .badge').text(number);
                $('#header_notification_bar').pulsate({
                    color: "#66bce6",
                    repeat: 5
                });

            }, 40000);

            setTimeout(function () {

                $.extend($.gritter.options, {
                    position: 'top-left'
                });

                var unique_id = $.gritter.add({
                    // (string | mandatory) the heading of the notification
                    title: 'Inbox',
                    // (string | mandatory) the text inside the notification
                    text: 'You have 2 new messages in your inbox.',
                    // (string | optional) the image to display on the left
                    image1: './assets/img/avatar1.jpg',
                    // (bool | optional) if you want it to fade out on its own or just sit there
                    sticky: true,
                    // (int | optional) the time you want it to be alive for before fading out
                    time: '',
                    // (string | optional) the class name you want to apply to that specific message
                    class_name: 'my-sticky-class'
                });

                $.extend($.gritter.options, {
                    position: 'top-right'
                });

                setTimeout(function () {
                    $.gritter.remove(unique_id, {
                        fade: true,
                        speed: 'slow'
                    });
                }, 4000);

                var number = $('#header_inbox_bar .badge').text();
                number = parseInt(number);
                number = number + 2;
                $('#header_inbox_bar .badge').text(number);
                $('#header_inbox_bar').pulsate({
                    color: "#dd5131",
                    repeat: 5
                });

            }, 60000);
        }

    };

}();