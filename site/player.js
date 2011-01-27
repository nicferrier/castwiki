// Techgrumps audio marker

var wikiplayer_start = function() {
    wikiplayer.player_started();
};

// Wikiplayer object
var wikiplayer = function ($) {
    var log = function (s) {
        window.console.log(s);
    };

    var to_time = function(newtime) {
        var newhref = "#" + newtime;
        var timepanel = $("#currenttimepanel");
        timepanel.text(newhref);
        return newhref;
    };

    var self = {
        player_started: function () {
            $("#playctrl").click(function () {
                play(0);
                return false;
            });

            $("#skipfwd").click(function () {
                var player = swfobject.getObjectById("player");
                var newtime = player.get_time() + 10000;
                var nexturl = to_time(newtime);
                player.stop();
                document.location.href = nexturl;
                self.play(newtime);
                return false;
            });

            $("#skipback").click(function () {
                var player = swfobject.getObjectById("player");
                var newtime = player.get_time() - 10000;
                var nexturl = to_time(newtime);
                player.stop();
                document.location.href = nexturl;
                self.play(newtime);
                return false;
            });
            
            $("#timectrl").click(function () {
                // This is a key function
                // Grab the time from the playing stream and do something with it
                // I think this should make a link in the page with a comment collection form by it
                // the collection should include a username and the comment
                var player = swfobject.getObjectById("player");
                var newtime = player.get_time();
                to_time(newtime);
                return false;
            });

            $("#currenttimepanel").click(function () {
                // This should be used to restart the play from a link
                // It has to pull in the correct comments
                var player = swfobject.getObjectById("player");
                player.stop();
                var time_stored = $("#currenttimepanel").text();
                var time_match = /#([0-9]+)/.exec(time_stored);
                if (time_match) {
                    document.location.href = time_stored;
                    self.play(parseInt(time_match[1]));    
                }
            });

            var autoplay = /^#([0-9]+)/.exec(document.location.hash);
            if (autoplay) {
                var time_to_start = parseInt(autoplay[1]);
                self.play(time_to_start);
            }
        },

        play: function(t) {
            var url = $("#audio").attr("href");
            var player = swfobject.getObjectById("player");
            player.play_url(url, t);
        },

        playing: function (t) {
            $("#playctrl").text("||");
            $("#playctrl").unbind("click").click(function () {
                if ($("#playctrl").text() == ">") {
                    $("#playctrl").text("||");
                }
                else {
                    $("#playctrl").text(">");
                }
                player.pause_resume();
                return false;
            });
        },
    };
    return self;
};

$(document).ready(function (v) {
    wikiplayer = wikiplayer($);
});

// End
