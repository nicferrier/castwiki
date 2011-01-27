package
{
    import flash.events.StatusEvent;
    import flash.events.NetStatusEvent;
    import flash.events.Event;
    import flash.media.SoundTransform;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;
    import flash.system.Security;
    import flash.utils.*;
    import flash.external.ExternalInterface;
    import mx.core.Application;

    public class Player extends Application
    {
        Security.LOCAL_TRUSTED;
        private var ch:SoundChannel = null;
        private var snd:Sound = null;
        private var paused:Boolean = false;
        private var pausedPos:Number = 0; 

        public function Player()
        {
            ExternalInterface.addCallback("play_url", playUrl);
            ExternalInterface.addCallback("pause_resume", pauseResume);
            ExternalInterface.addCallback("get_time", getTime);
            ExternalInterface.addCallback("ping", ping);
            ExternalInterface.addCallback("stop", stop);
            debug("starting the js");
            ExternalInterface.call("wikiplayer_start");
            debug("this player is registered cheddar.");
        }

        // A simple ping to test embedding
        public function ping():void {
            debug("PING!");
        }


        // Function to play the specified url
        public function playUrl(url:String, position:Number):void {
            debug("play called");
            var urlReq:URLRequest = new URLRequest(url);
            snd = new Sound(urlReq);
            ch = snd.play(position, 1);
            ExternalInterface.call("wikiplayer.playing", url);
        }

        public function stop():void {
            debug("stop called");
            ch.stop();
        }

        public function pauseResume():void {
            if (paused) {
                ch = snd.play(pausedPos, 1);
                paused = false;
            }
            else {
                pausedPos = ch.position;
                ch.stop();
                paused = true;
            }
        }

        public function getTime():Number {
            return ch.position;
        }

        private function debug(msg:String):void 
        {
            ExternalInterface.call("console.info", "DEBUG: " + msg);
            trace("DEBUG " + msg);
        }

    }
}
