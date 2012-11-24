//
// aspire

package aspire.display {

public class AnimationImpl implements Animation
{
    public function startAnimation () :void
    {
        AnimationManager.start(this);
    }

    public function stopAnimation () :void
    {
        AnimationManager.stop(this);
    }

    public function isPlaying () :Boolean
    {
        return AnimationManager.isPlaying(this);
    }

    public function updateAnimation (elapsed :Number) :void
    {
        // please implement!
    }
}
}
