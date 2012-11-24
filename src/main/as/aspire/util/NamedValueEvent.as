//
// aspire

package aspire.util {

import flash.events.Event;

/**
 * A handy event for dispatching a name/value pair associated with the event type.
 */
public class NamedValueEvent extends ValueEvent
{
    /**
     * Accessor: get the name.
     */
    public function get name () :String
    {
        return _name;
    }

    /**
     * Construct the name/value event.
     */
    public function NamedValueEvent (
        type :String, name :String, value :*, bubbles :Boolean = false, cancelable :Boolean = false)
    {
        super(type, value, bubbles, cancelable);
        _name = name;
    }

    override public function clone () :Event
    {
        return new NamedValueEvent(type, _name, _value, bubbles, cancelable);
    }

    /** The name. */
    protected var _name :String;
}
}
