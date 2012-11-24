//
// aspire

package aspire.display {

/**
 * An Animation that linearly transitions from one value to another and optionally executes a
 * callback function when the transition is complete.  A subclass must implement updateForValue
 * to change whatever is being animated for the value.
 */
public class LinearAnimation extends AnimationImpl
{
    public function LinearAnimation (
        from :Number = 0, to :Number = 1, duration :Number = 1, done :Function = null)
    {
        _from = from;
        _to = to;
        _duration = duration;
        _done = done;
    }

    override public function updateAnimation (elapsed :Number) :void
    {
        if (elapsed < _duration) {
            updateForValue(_from + ((_to - _from) * elapsed) / _duration);
        } else {
            updateForValue(_to);
            stopAnimation();
            if (_done != null) {
                _done();
            }
        }
    }

    public function updateForValue (value :Number) :void
    {
        // please implement!
    }

    protected var _from :Number;
    protected var _to :Number;
    protected var _duration :Number;
    protected var _done :Function;
}
}
