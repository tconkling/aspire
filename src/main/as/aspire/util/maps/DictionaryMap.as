//
// aspire

package aspire.util.maps {

import flash.utils.Dictionary;

import aspire.util.Map;
import aspire.util.Util;

/**
 * An implemention of Map that uses a Dictionary internally for storage. Any Object (and null)
 * may be used as a key with no loss in efficiency.
 */
public class DictionaryMap extends AbstractMap
    implements Map
{
    /** @inheritDoc */
    public function put (key :Object, value :Object) :* {
        var oldVal :* = _dict[key];
        _dict[key] = value;
        if (oldVal === undefined) {
            _size++;
        }
        return oldVal;
    }

    /** @inheritDoc */
    public function get (key :Object) :* {
        return _dict[key];
    }

    /** @inheritDoc */
    public function containsKey (key :Object) :Boolean {
        return (key in _dict);
    }

    /** @inheritDoc */
    public function remove (key :Object) :* {
        var oldVal :* = _dict[key];
        if (oldVal !== undefined) {
            delete _dict[key];
            _size--;
        }
        return oldVal;
    }

    /** @inheritDoc */
    public function clear () :void {
        _dict = new Dictionary();
        _size = 0;
    }

    /** @inheritDoc */
    public function keys () :Array {
        return Util.keys(_dict);
    }

    /** @inheritDoc */
    public function values () :Array {
        return Util.values(_dict);
    }

    /**
     * @copy com.threerings.util.Map#forEach()
     *
     * @internal inheritDoc doesn't work here because forEach is defined in our private superclass.
     */
    override public function forEach (fn :Function) :void {
        for (var key :Object in _dict) {
            if (Boolean(fn(key, _dict[key]))) {
                return;
            }
        }
    }

    /** Our actual storage. @private */
    protected var _dict :Dictionary = new Dictionary();
}
}
