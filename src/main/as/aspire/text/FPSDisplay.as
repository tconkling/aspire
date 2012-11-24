//
// aspire

package aspire.text {

import flash.events.Event;
import flash.text.TextField;
import flash.utils.getTimer;

public class FPSDisplay extends TextField
{
    public function FPSDisplay (framesToTrack :int = 150)
    {
        background = true;
        text = "fps: 000.00";
        width = textWidth + 5;
        height = textHeight + 4;

        _framesToTrack = framesToTrack;

        addEventListener(Event.ENTER_FRAME, handleEnterFrame);
    }

    protected function handleEnterFrame (event :Event) :void
    {
        var curStamp :Number = getTimer();
        _frameStamps.push(curStamp);
        if (_frameStamps.length > _framesToTrack) {
            _frameStamps.shift(); // forget the oldest timestamps
        }

        var firstStamp :Number = Number(_frameStamps[0]);
        var seconds :Number = (curStamp - firstStamp) / 1000;
        // subtract one from the frames, since we're measuring the time
        // elapsed over the frames (when there are two timestamps, that's
        // the difference between 1 frame)
        var frames :Number = _frameStamps.length - 1;

        this.text = "fps: " + (frames / seconds).toFixed(2);
    }

    /** Timestamps of past ENTER_FRAME events. */
    protected var _frameStamps :Array = [];

    /** The number of running frames we track. */
    protected var _framesToTrack :int;
}
}
