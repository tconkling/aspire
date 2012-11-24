//
// aspire

package aspire.ui {

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

/**
 * Takes a MovieClip with specific frame labels and sets the current frame of the clip based on the
 * mouse interaction.
 *
 * This class enables two things that turning on buttonMode on a MovieClip does not: the frame
 * labels can be whatever you want, and it has a disabled state.
 */
public class MovieClipButton extends Sprite
{
    public function MovieClipButton (clip :MovieClip, upFrame :String, overFrame :String = null,
        downFrame :String = null, disabledFrame :String = null)
    {
        _upFrame = upFrame;
        _overFrame = overFrame;
        _downFrame = downFrame;
        _disabledFrame = disabledFrame;

        // respond to mouse events to change visual state
        addEventListener(MouseEvent.ROLL_OVER, onMouseEvent);
        addEventListener(MouseEvent.ROLL_OUT, onMouseEvent);
        addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
        addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
        addEventListener(MouseEvent.CLICK, onMouseEvent);

        // make it look like a button for mouse interactivity
        buttonMode = true;
        mouseChildren = false;

        // don't let the MC play right away.
        (_clip = clip).stop();
        addChild(_clip);
    }

    public function set enabled (value :Boolean) :void
    {
        _clip.enabled = value;
        _clip.gotoAndStop(value || _disabledFrame == null ? _upFrame : _disabledFrame);
    }

    public function get enabled () :Boolean
    {
        return _clip.enabled;
    }

    protected function onMouseEvent (event :MouseEvent) :void
    {
        if (!enabled) {
            if (event.type == MouseEvent.CLICK) {
                // fizzle CLICK on disabled buttons
                event.stopImmediatePropagation();
            }
            return;
        }

        var targetFrame :String;
        switch (event.type) {
        case MouseEvent.ROLL_OVER:
            // we sometimes get extra roll_overs after a click
            targetFrame = event.buttonDown || _overFrame == null ? _downFrame : _overFrame;
            break;

        case MouseEvent.MOUSE_DOWN:
            targetFrame = _downFrame;
            break;

        case MouseEvent.ROLL_OUT:
            targetFrame = _upFrame;
            break;

        case MouseEvent.MOUSE_UP:
            var mouseOver :Boolean = hitTestPoint(event.stageX, event.stageY);
            targetFrame = mouseOver ? _overFrame : _upFrame;
            break;

        default:
            return; // don't set a frame on mouse events we don't recognize
        }

        _clip.gotoAndStop(targetFrame == null ? _upFrame : targetFrame);
    }

    protected var _clip :MovieClip;
    protected var _upFrame :String, _overFrame :String, _downFrame :String, _disabledFrame :String;
}
}
