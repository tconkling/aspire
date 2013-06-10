//
// aspire

package aspire.util {

public class Timers
{
    /**
     * Returns a timer with the given delay that will call the given callback when it fires.
     * Timers are not running when created; to run the timer you must call start()
     * To have the timer run just once, you may call once().
     *
     * @param delay the number of seconds to delay.
     * @param callback the function to call when the timer fires.
     */
    public static function create (delay :Number, callback :Function) :TimerRegistration {
        // convert seconds to millis
        return new TimerImpl(delay * 1000, callback);
    }

    /** A convenience function that creates a timer that will call 'callback' on the next frame */
    public static function delayFrame (callback :Function) :TimerRegistration {
        return delayFrames(1, callback);
    }

    /**
     * A convenience function that creates a timer that will call 'callback' after the
     * specified number of frames have elapsed, and then cancel itself.
     */
    public static function delayFrames (numFrames :int, callback :Function) :TimerRegistration {
        var timer :TimerRegistration = create(1, function (..._) :void {
            if (--numFrames <= 0) {
                timer.cancel();
                callback();
            }
        }).start();

        return timer;
    }
}
}

import aspire.util.TimerRegistration;

import flash.events.TimerEvent;
import flash.utils.Timer;

class TimerImpl
    implements TimerRegistration
{
    public function TimerImpl (delayMs :Number, callback :Function) {
        _timer = new Timer(delayMs);
        _callback = callback;
        _timer.addEventListener(TimerEvent.TIMER, onTimerEvent);
    }

    public function start () :TimerRegistration {
        if (_timer != null) {
            _timer.start();
        }
        return this;
    }

    public function stop () :TimerRegistration {
        if (_timer != null) {
            _timer.stop();
        }
        return this;
    }

    public function cancel () :void {
        if (_timer != null) {
            _timer.stop();
            _timer.removeEventListener(TimerEvent.TIMER, onTimerEvent);
            _timer = null;
            _callback = null;
        }
    }

    public function once () :TimerRegistration {
        _once = true;
        return this;
    }

    protected function onTimerEvent (e :TimerEvent) :void {
        var callback :Function = _callback;
        if (_once) {
            cancel();
        }
        callback();
    }

    protected var _timer :Timer;
    protected var _callback :Function;
    protected var _once :Boolean;
}
