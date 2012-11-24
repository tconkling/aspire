//
// aspire

package aspire.display {

import flash.display.DisplayObject;
import flash.display.SimpleButton;

/**
 * A SimpleButton subclass that includes a disabledState.
 * DisablingButtons don't dispatch mouse events when disabled.
 */
public class DisablingButton extends SimpleButton
{
    public function DisablingButton (
       upState :DisplayObject = null,
       overState :DisplayObject = null,
       downState :DisplayObject = null,
       hitTestState :DisplayObject = null,
       disabledState :DisplayObject = null)
    {
        super(null, overState, downState, hitTestState);

        _disabledState = disabledState;
        _upState = upState;

        updateState();
    }

    /**
     * Returns the DisplayObject that will be displayed when the button is disabled.
     */
    public function get disabledState () :DisplayObject
    {
        return _disabledState;
    }

    /**
     * Sets the DisplayObject that will be displayed when the button is disabled.
     */
    public function set disabledState (newState :DisplayObject) :void
    {
        _disabledState = newState;
        updateState();
    }

    // from SimpleButton
    override public function set upState (newState :DisplayObject) :void
    {
        _upState = newState;
        updateState();
    }

    // from SimpleButton
    override public function get upState () :DisplayObject
    {
        return _upState;
    }

    // from SimpleButton
    override public function set enabled (val :Boolean) :void
    {
        super.enabled = val;

        updateState();
    }

    override public function get mouseEnabled () :Boolean
    {
        return _mouseEnabled;
    }

    override public function set mouseEnabled (enabled :Boolean) :void
    {
        _mouseEnabled = enabled;

        updateState();
    }

    protected function updateState () :void
    {
        super.upState = ((null != _disabledState && !super.enabled) ? _disabledState : _upState);

        // mouseEnabled is always false when the button is disabled
        super.mouseEnabled = super.enabled && _mouseEnabled;

        // force a visual update.
        super.enabled = !super.enabled;
        super.enabled = !super.enabled;
    }

    protected var _disabledState :DisplayObject;
    protected var _upState :DisplayObject;
    protected var _mouseEnabled :Boolean = true;
}

}
