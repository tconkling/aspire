//
// aspire

package aspire.util.maps {

import aspire.util.Map;
import aspire.util.Preconditions;

/**
 * A building-block Map that forwards requests to another map.
 * @private
 */
public class ForwardingMap
    implements Map
{
    public function ForwardingMap (source :Map) {
        _source = Preconditions.checkNotNull(source);
    }

    /** @inheritDoc */
    public function put (key :Object, value :Object) :* {
        return _source.put(key, value);
    }

    /** @inheritDoc */
    public function get (key :Object) :* {
        return _source.get(key);
    }

    /** @inheritDoc */
    public function containsKey (key :Object) :Boolean {
        return _source.containsKey(key);
    }

    /** @inheritDoc */
    public function remove (key :Object) :* {
        return _source.remove(key);
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
    public function keys () :Array {
        return _source.keys();
    }

    /** @inheritDoc */
    public function values () :Array {
        return _source.values();
    }

    /** @inheritDoc */
    public function items () :Array {
        return _source.items();
    }

    /** @inheritDoc */
    public function forEach (fn :Function) :void {
        _source.forEach(fn);
    }

    /** @inheritDoc */
    public function equals (o :Object) :Boolean {
        return _source.equals(o);
    }

    /** @inheritDoc */
    public function toString () :String {
        return Object(_source).toString();
    }

    /** The Map to which we forward requests. @private */
    protected var _source :Map;
}
}
