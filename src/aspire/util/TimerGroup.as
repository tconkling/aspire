//
// aspire

package aspire.util {

import flash.events.TimerEvent;
import flash.utils.Timer;

/**
 * Allows a group of Timers to be cancelled en masse.
 */
public class TimerGroup
    implements Registration
{
    /**
     * Cancels all running timers, and disconnects the TimerGroup from its parent, if it has one.
     * All child TimerGroups will be shutdown as well.
     *
     * It's an error to call any function on TimerGroup after shutdown() has been called.
     */
    public function cancel () :void
    {
        stopAllTimers();
        // null out internal state so that future calls to this TimerGroup will
        // immediately NPE
        _timers = null;
    }

    /**
     * Creates and runs a timer that will run once, and clean up after itself.
     */
    public function runOnce (delay :Number, callback :Function) :void
    {
        var timer :Timer = createTimer(delay, 1);
        timer.addEventListener(TimerEvent.TIMER,
            function (e :TimerEvent) :void {
                stopTimer(timer);
                callback(e);
            });

        timer.start();
    }

    /**
     * Creates and runs a timer that will run forever, or until canceled.
     */
    public function runForever (delay :Number, callback :Function) :Timer
    {
        var timer :Timer = createTimer(delay, 0);
        timer.addEventListener(TimerEvent.TIMER, callback);
        timer.start();
        return timer;
    }

    /**
     * Creates, but doesn't run, a new Timer managed by this TimerGroup.
     */
    public function createTimer (delay :Number, repeatCount :int = 0) :Timer
    {
        var timer :Timer = new Timer(delay, repeatCount);
        _timers.push(timer);
        return timer;
    }

    /**
     * Delay invocation of the specified function closure by one frame.
     */
    public function delayFrame (fn :Function, args :Array = null) :void
    {
        delayFrames(1, fn, args);
    }

    /**
     * Delay invocation of the specified function closure by one or more frames.
     */
    public function delayFrames (frames :int, fn :Function, args :Array = null) :void
    {
        if (_delayer == null) {
            _delayer = new FrameDelayer();
        }
        _delayer.delayFrames(frames, fn, args);
    }

    /**
     * Stops all timers being managed by this TimerGroup.
     * All child TimerGroups will have their timers stopped as well.
     */
    public function stopAllTimers () :void
    {
        for each (var timer :Timer in _timers) {
            // we can have holes in the _timers array
            if (timer != null) {
                timer.stop();
            }
        }

        _timers = [];

        if (_delayer != null) {
            _delayer.cancel();
            _delayer = null;
        }
    }

    /**
     * Causes the timer to be stopped, and removed from the TimerGroup's list of managed timers.
     */
    public function stopTimer (timer :Timer) :void
    {
        var idx :int = Arrays.indexOf(_timers, timer);
        if (idx >= 0) {
            _timers.splice(idx, 1);
        }

        timer.stop();
    }

    protected var _delayer :FrameDelayer;
    protected var _timers :Array = []; // Array<Timer>
}
}
