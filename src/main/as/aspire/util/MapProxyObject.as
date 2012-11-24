//
// aspire

package aspire.util {

import flash.utils.Proxy;
import flash.utils.flash_proxy;

use namespace flash_proxy;

/**
 * Makes a Map behave like an object. Iterations are done in the order of the keys
 * returned by the Map's keys() function.
 * Warning: "for" loops convert all keys to Strings, due to limitations with Proxy.
 */
public class MapProxyObject extends Proxy
{
    /**
     * Construct a MapProxyObject backed by the specified Map.
     */
    public function MapProxyObject (source :Map)
    {
        _map = source;
    }

// The following are not strictly necessary and are freaking out asdoc, so I'll
// comment them out for now.
//
//    // from Object (but does not require 'override')
//    public function hasOwnProperty (name :String) :Boolean
//    {
//        return _map.containsKey(name);
//    }
//
//    // from Object (but does not require 'override')
//    public function propertyIsEnumerable (name :String) :Boolean
//    {
//        return _map.containsKey(name);
//    }
//
//    // from Object (but does not require 'override')
//    public function setPropertyIsEnumerable (name :String, isEnum :Boolean = true) :void
//    {
//        // no-op
//        // (Alternatively, we could keep a dictionary of keys that we ignore for enumeration...)
//    }

    /**
     * Handle value = proxy[key].
     */
    override flash_proxy function getProperty (key :*) :*
    {
        return _map.get(key);
    }

    /**
     * Handle proxy[key] = value.
     */
    override flash_proxy function setProperty (key :*, value :*) :void
    {
        _map.put(key, value);
    }

    /**
     * Handle delete proxy[key].
     */
    override flash_proxy function deleteProperty (key :*) :Boolean
    {
        return (_map.remove(key) !== undefined);
    }

    /**
     * Used when iterating with a "for" loop. Note well that keys are turned into
     * Strings. This is a major failing.
     */
    override flash_proxy function nextName (index :int) :String
    {
        return StringUtil.toString(_itrKeys[index - 1]);
    }

    /**
     * Used when iterating with a "for each" loop.
     */
    override flash_proxy function nextValue (index :int) :*
    {
        return _map.get(_itrKeys[index - 1]);
    }

    /**
     * Iteration support.
     */
    override flash_proxy function nextNameIndex (index :int) :int
    {
        // on the first call, set up a list to be iterated
        if (index == 0) {
            _itrKeys = _map.keys();
        }

        // return a 1-based index to indicate that there is a property
        if (index < _itrKeys.length) {
            return index + 1;

        } else {
            _itrKeys = null; // we're done, clear the list
            return 0;
        }
    }

    /** The map we use for storage. */
    protected var _map :Map;

    /** A temporary ordering for iteration. */
    protected var _itrKeys :Array;
}
}
