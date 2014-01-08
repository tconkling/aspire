//
// aspire

package aspire.util.maps {

import aspire.util.Equalable;
import aspire.util.Map;
import aspire.util.Maps;

/**
 * A skeletal building block for maps.
 * @private
 */
public /* abstract */ class AbstractMap
    implements Equalable
{
    /** @copy com.threerings.util.Map#size() */
    public function size () :int {
        return _size;
    }

    /** @copy com.threerings.util.Map#isEmpty() */
    public function isEmpty () :Boolean {
        // call size(), don't examine _size directly, this helps subclasses...
        return (0 == size());
    }

    /**
     * Return a String representation of this Map.
     */
    public function toString () :String {
        var s :String = "Map {";
        var theMap :Object = this;
        var comma :Boolean = false;
        forEach(function (key :Object, value :Object) :void {
            if (comma) {
                s += ", ";
            }
            s += ((key === theMap) ? "(this Map)" : key) + "=" +
                ((value === theMap) ? "(this Map)" : value);
            comma = true;
        });
        s += "}";
        return s;
    }

    /** @copy com.threerings.util.Map#items() */
    public function items () :Array {
        var result :Array = [];
        forEach(function (k :Object, v :Object) :void { result.push([k, v]); });
        return result;
    }

    /** @copy com.threerings.util.Map#forEach() */
    public function forEach (fn :Function) :void {
        throw new Error("Abstract");
    }

    /** @copy com.threerings.util.Equalable#equals() */
    public function equals (o :Object) :Boolean {
        const m :Map = o as Map;
        if (m == null) return false;
        return Maps.equals(Map(this), m);

    }

    /** The size of the map. @private */
    protected var _size :int;
}
}
