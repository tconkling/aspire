//
// aspire

package aspire.display {

import flash.display.DisplayObject;

/**
 * An Animation that linearly transitions the alpha attribute of a given display object from
 * one value to another and optionally executes a callback function when the transition is
 * complete.
 */
public class AlphaFade extends LinearAnimation
{
    /**
     * Constructs a new AlphaFade instance. The alpha values should lie in [0, 1] and the
     * duration is measured in milliseconds.
     */
    public function AlphaFade (
        disp :DisplayObject, from :Number = 0, to :Number = 1, duration :Number = 1,
        done :Function = null)
    {
        super(from, to, duration, done);
        _disp = disp;
    }

    override public function updateForValue (value :Number) :void
    {
        _disp.alpha = value;
    }

    protected var _disp :DisplayObject;
}
}
