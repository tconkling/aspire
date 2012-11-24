//
// aspire

package aspire.util {

import flash.events.Event;

/**
 * A handy event for simply dispatching a value associated with the event type.
 */
public class ValueEvent extends Event
{
    /**
     * Returns an event handler for a value event that will call the given listener with the value
     * of the event. Since actionscript will attempt to cast the value on call, the listener
     * parameter type can be * or whatever is expected.
     * @param listener
     * <listing version="3.0">
     *      function listener (value :~~) :void {}
     *      function listener (foo :Foo) :void {}
     * </listing>
     */
    public static function adapt (listener :Function) :Function
    {
        return function (evt :ValueEvent) :void {
            listener(evt.value);
        }
    }

    /**
     * Accessor: get the value.
     */
    public function get value () :*
    {
        return _value;
    }

    /**
     * Construct the value event.
     */
    public function ValueEvent (
        type :String, value :*, bubbles :Boolean = false, cancelable :Boolean = false)
    {
        super(type, bubbles, cancelable);
        _value = value;
    }

    override public function clone () :Event
    {
        return new ValueEvent(type, _value, bubbles, cancelable);
    }

    /** The value. */
    protected var _value :*;
}
}
