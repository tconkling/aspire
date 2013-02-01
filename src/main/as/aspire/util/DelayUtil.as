//
// aspire

package aspire.util {

/**
 * A simple way to delay invocation of a function closure by one or more frames.
 * Similar to UIComponent's callLater, only flex-free.
 * If not running in the flash player, but instead in some tamarin environment like
 * thane, "frames" are a minimum of 1ms apart, but may be more if other code doesn't yield.
 */
public class DelayUtil
{
    /**
     * Delay invocation of the specified function closure by one frame.
     */
    public static function delayFrame (fn :Function, args :Array = null) :void {
        delayFrames(1, fn, args);
    }

    /**
     * Delay invocation of the specified function closure by one or more frames.
     */
    public static function delayFrames (frames :int, fn :Function, args :Array = null) :void {
        _delayer.delayFrames(frames, fn, args);
    }

    /** The underlying delayer. */
    protected static var _delayer :FrameDelayer = new FrameDelayer();
}
}
