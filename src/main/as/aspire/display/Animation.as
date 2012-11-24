//
// aspire

package aspire.display {

public interface Animation
{
    /**
     * The primary working method for your animation. The argument indicates how
     * many milliseconds have passed since the animation was started.
     */
    function updateAnimation (elapsed :Number) :void;
}
}
