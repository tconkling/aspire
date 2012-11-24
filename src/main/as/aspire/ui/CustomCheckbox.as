//
// aspire

package aspire.ui {

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import aspire.ui.CustomButton;

/**
 * Dispatched when the checkbox's "checked" property changes
 * @eventType flash.events.Event.CHANGE
 */
[Event(name="change", type="flash.events.Event.CHANGE")]

public class CustomCheckbox extends Sprite
{
    public function CustomCheckbox (
        uncheckedUpState :DisplayObject = null,
        uncheckedOverState :DisplayObject = null,
        uncheckedDownState :DisplayObject = null,
        checkedUpState :DisplayObject = null,
        checkedOverState :DisplayObject = null,
        checkedDownState :DisplayObject = null)
    {
        _btnUnchecked = new CustomButton(uncheckedUpState, uncheckedOverState, uncheckedDownState);
        _btnChecked = new CustomButton(checkedUpState, checkedOverState, checkedDownState);

        addEventListener(MouseEvent.CLICK,
            function (..._) :void {
                checked = !checked;
            });

        addChild(_btnChecked);
        addChild(_btnUnchecked);

        // unchecked by default
        _checked = false;
        _btnChecked.visible = false;
    }

    public function get checked () :Boolean
    {
        return _checked;
    }

    public function set checked (val :Boolean) :void
    {
        if (_checked != val) {
            _checked = val;
            _btnChecked.visible = _checked;
            _btnUnchecked.visible = !_checked;
            dispatchEvent(new Event(Event.CHANGE));
        }
    }

    protected var _btnUnchecked :CustomButton;
    protected var _btnChecked :CustomButton;
    protected var _checked :Boolean;
}

}
