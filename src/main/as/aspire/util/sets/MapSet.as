//
// aspire

package aspire.util.sets {

import aspire.util.Map;
import aspire.util.Preconditions;
import aspire.util.Set;

/**
 * A Set that uses a Map for backing store, thus allowing us to build on the
 * various Maps in useful ways.
 */
public class MapSet extends AbstractSet
    implements Set
{
    public function MapSet (source :Map) {
        _source = Preconditions.checkNotNull(source);
    }

    /** @inheritDoc */
    public function add (o :Object) :Boolean {
        return (undefined === _source.put(o, true));
    }

    /** @inheritDoc */
    public function contains (o :Object) :Boolean {
        return _source.containsKey(o);
    }

    /** @inheritDoc */
    public function remove (o :Object) :Boolean {
        return (undefined !== _source.remove(o));
    }

    /** @inheritDoc */
    public function size () :int {
        return _source.size();
    }

    /** @inheritDoc */
    public function isEmpty () :Boolean {
        return _source.isEmpty();
    }

    /** @inheritDoc */
    public function clear () :void {
        _source.clear();
    }

    /** @inheritDoc */
    public function toArray () :Array {
        return _source.keys();
    }

    /**
     * @copy com.threerings.util.Set#forEach()
     *
     * @internal inheritDoc doesn't work here because forEach is defined in our private superclass.
     */
    override public function forEach (fn :Function) :void {
        _source.forEach(function (k :Object, v :Object) :* {
            return fn(k);
        });
    }

    /** The map used for our source. @private */
    protected var _source :Map;
}
}
