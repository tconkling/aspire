//
// aspire

package aspire.util.maps {

import aspire.util.Map;
import aspire.util.Maps;

/**
 * A Map that fills in values for missing keys using a supplied function rather than returning
 * undefined. containsKey() can still safely be used to see whether a mapping exists or not.
 */
public class ValueComputingMap extends ForwardingMap
{
    /** Creates a new ValueComputingMap that uses the given function */
    public static function newMapOf(keyClazz :Class, computer :Function) :Map {
        return new ValueComputingMap(Maps.newMapOf(keyClazz), computer);
    }

    /** Creates a new ValueComputing map that fills in empty arrays for missing keys. */
    public static function newArrayMapOf(keyClazz :Class) :Map {
        return new ValueComputingMap(Maps.newMapOf(keyClazz), function (..._) :Array { return []; });
    }

    public function ValueComputingMap (source :Map, computer :Function) {
        super(source);
        _computer = computer;
    }

    /** @inheritDoc */
    override public function get (key :Object) :* {
        var val :* = super.get(key);
        if (val === undefined) {
            val = _computer(key);
            if (val !== undefined) {
                put(key, val);
            }
        }
        return val;
    }

    /** The function used to calculate values for missing keys. @private */
    protected var _computer :Function;
}
}
