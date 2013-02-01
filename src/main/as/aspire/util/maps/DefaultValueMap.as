//
// aspire

package aspire.util.maps {

import aspire.util.Map;

/**
 * A Map that returns the specified default value for missing keys, rather than returning
 * undefined. containsKey() can still safely be used to see whether a mapping exists or not.
 */
public class DefaultValueMap extends ForwardingMap
{
    public function DefaultValueMap (source :Map, defaultValue :Object) {
        super(source);
        _defVal = defaultValue;
    }

    /** @inheritDoc */
    override public function get (key :Object) :* {
        var val :* = super.get(key);
        return (val !== undefined) ? val : _defVal;
    }

    /** The default value to return. @private */
    protected var _defVal :Object;
}
}
