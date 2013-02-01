//
// aspire

package aspire.util.maps {

import aspire.util.Hashable;
import aspire.util.StringUtil;

/**
 * Wraps Strings (and nulls) for use in a HashMap.
 *
 * @private
 */
// This can be made a private subclass of HashMap when the Flash CS3 compiler doesn't choke on it.
public class StringWrapper
    implements Hashable
{
    public function StringWrapper (val :String) {
        _val = val;
    }

    public function hashCode () :int {
        return StringUtil.hashCode(_val); // this function returns 0 for nulls
    }

    public function equals (other :Object) :Boolean {
        return (other is StringWrapper) && (_val == StringWrapper(other)._val);
    }

    public function get () :String {
        return _val;
    }

    /** @private */
    protected var _val :String;
}
}
