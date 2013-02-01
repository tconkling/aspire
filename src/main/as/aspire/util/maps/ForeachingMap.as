//
// aspire

package aspire.util.maps {

import aspire.util.Map;

/**
 * A forwarding Map that runs keys() and values() through forEach(), to take
 * advantage of subclass logic therein.
 * @private
 */
public /* abstract */ class ForeachingMap extends ForwardingMap
{
    public function ForeachingMap (source :Map) {
        super(source);
    }

    /** @inheritDoc */
    override public function keys () :Array {
        var arr :Array = [];
        forEach(function (k :*, v :*) :void {
            arr.push(k);
        });
        return arr;
    }

    /** @inheritDoc */
    override public function values () :Array {
        var arr :Array = [];
        forEach(function (k :*, v :*) :void {
            arr.push(v);
        });
        return arr;
    }
}
}
