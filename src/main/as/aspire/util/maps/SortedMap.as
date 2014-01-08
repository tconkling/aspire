//
// aspire

package aspire.util.maps {

import aspire.util.Comparators;
import aspire.util.F;
import aspire.util.Map;

/**
 * A sorted Map implementation.
 * Note that the sorting is performed when you iterate over the map, the internal representation
 * is not sorted. Thus, it does not offer performance benefits, it is merely a convenience class.
 */
public class SortedMap extends ForwardingMap
{
    /**
     * Construct a SortedMap.
     *
     * @param source the backing Map
     * @param comp the Comparator used to sort the keys, or null to use Comparators.compareUnknown.
     */
    public function SortedMap (source :Map, comp :Function = null) {
        super(source);
        _comp = comp || Comparators.compareUnknowns;
    }

    /** @inheritDoc */
    override public function keys () :Array {
        var keys :Array = super.keys();
        keys.sort(_comp);
        return keys;
    }

    /** @inheritDoc */
    override public function values () :Array {
        // not very optimal, but we need to return the values in order...
        return keys().map(F.adapt(get));
    }

    /** @inheritDoc */
    override public function forEach (fn :Function) :void {
        // also not very optimal. In an ideal world we'd maintain an ordering of entries,
        // but since we can be combined with expiring maps, etc, this is fine for now.
        var keys :Array = keys();
        for each (var key :Object in keys) {
            if (Boolean(fn(key, get(key)))) {
                return;
            }
        }
    }

    /** The comparator used to sort the keys of this Map. @private */
    protected var _comp :Function;
}
}
