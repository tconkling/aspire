//
// aspire

package aspire.util {
import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.Event;

/**
 * Manages the pairing of ADDED_TO_STAGE and REMOVED_FROM_STAGE events since strict pairing is
 * very useful but not supported. Also some other related stage event hackery.
 */
public class StageLifetime
{
    /**
     * Adds the given handlers for ADDED_TO_STAGE and REMOVED_FROM_STAGE events coming from the
     * given disp, but guarantee the call order will always be interleaved. The first listener
     * added will be onAdd if disp.stage is null, otherwise onRemove.
     * @param disp
     * @param onAdd
     * @param onRemove
     * @param sync if passed and set to true then the onAdd callback will be called initially
     * if the given object is already on stage. A null event is used in this case.
     */
    public static function listen (disp :DisplayObject, onAdd :Function, onRemove :Function,
        sync :Boolean=false) :void
    {
        function handleOn (_:*) :void {
            toggle(true);
            handle(_, true);
        }
        function handleOff (_:*) :void {
            toggle(false);
            handle(_, false);
        }
        function toggle (added :Boolean) :void {
            if (added) {
                disp.addEventListener(Event.REMOVED_FROM_STAGE, handleOff);
                disp.removeEventListener(Event.ADDED_TO_STAGE, handleOn);
            } else {
                disp.addEventListener(Event.ADDED_TO_STAGE, handleOn);
                disp.removeEventListener(Event.REMOVED_FROM_STAGE, handleOff);
            }
        }
        function handle (_:*, added :Boolean) :void {
            var fn :Function = added ? onAdd : onRemove;
            if (fn != null) {
                fn(_);
            }
        }

        // listen for the next event the disp will dispatch
        toggle(disp.stage != null);

        // if sync is requested and the object is already on stage, call back
        if (sync && disp.stage != null) {
            handle(null, true);
        }
    }

    /**
     * Calls the given function whenever the display object is added to the stage
     * <em>or</em> once the object is on the stage and the stage is resized.
     * @param disp
     * @param setNewSize closure that receives the width and height of the stage:
     * <listing version="3.0">
     *     function setNewSize (newStageWidth :Number, newStageHeight :Number) :void
     * </listing>
     * @param sync Optionally make one synchronous call to the callback if the display object is
     * currently on stage.
     */
    public static function listenForSizeChange (disp :DisplayObject, setNewSize :Function,
        sync :Boolean=true) :void
    {
        var stage :Stage;
        function onResize (_:*) :void {
            setNewSize(disp.stage.stageWidth, disp.stage.stageHeight);
        }
        function onAdd (_:*) :void {
            (stage = disp.stage).addEventListener(Event.RESIZE, onResize);
            if (sync) {
                onResize(null);
            } else {
                sync = true;
            }
        }
        function onRemove (_:*) :void {
            if (stage != null) {
                stage.removeEventListener(Event.RESIZE, onResize);
            }
        }
        sync = sync || disp.stage == null;
        listen(disp, onAdd, onRemove, true);
    }

    /**
     * Adds the given handler for ADDED_TO_STAGE, but guarantees not to call twice in succession
     * without an intervening REMOVED_FROM_STAGE event.
     */
    public static function onEachAdd (disp :DisplayObject, onAdd :Function) :void
    {
        listen(disp, onAdd, null);
    }

    /**
     * Adds the given handler for REMOVED_FROM_STAGE, but guarantees not to call twice in
     * succession without an intervening ADDED_TO_STAGE event.
     */
    public static function onEachRemove (disp :DisplayObject, onRemove :Function) :void
    {
        listen(disp, null, onRemove);
    }
}
}
