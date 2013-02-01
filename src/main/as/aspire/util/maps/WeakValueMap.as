//
// aspire

package aspire.util.maps {

import aspire.util.Map;
import aspire.util.WeakReference;

/**
 * A Map that stores weak values. If the values are not referenced anywhere else in
 * the runtime, this Map may unexpectedly shrink in size.
 */
public class WeakValueMap extends ForeachingMap
{
    public function WeakValueMap (source :Map) {
        super(source);
    }

    /** @inheritDoc */
    override public function put (key :Object, value :Object) :* {
        return unwrap(super.put(key, (value == null) ? null : new WeakReference(value)));
    }

    /** @inheritDoc */
    override public function get (key :Object) :* {
        return unwrap(super.get(key));
    }

    /** @inheritDoc */
    override public function containsKey (key :Object) :Boolean {
        // take special care here
        var val :* = super.get(key);
        return ((val is WeakReference) && (undefined !== WeakReference(val).get()));
    }

    /** @inheritDoc */
    override public function remove (key :Object) :* {
        return unwrap(super.remove(key));
    }

    /** @inheritDoc */
    override public function size () :int {
        forEach(function (... args) :void {});
        return super.size();
    }

    /** @inheritDoc */
    override public function forEach (fn :Function) :void {
        var removeKeys :Array = [];
        super.forEach(function (key :*, value :*) :Boolean {
            var rawVal :* = unwrap(value);
            if (rawVal === undefined) {
                removeKeys.push(key);
                return false; // keep iterating
            } else {
                return Boolean(fn(key, rawVal));
            }
        });
        for each (var key :Object in removeKeys) {
            super.remove(key); // avoid unwrapping the value that's gone (and we don't care about)
        }
    }

    /**
     * Unwrap a possible WeakReference for returning.
     * @private
     */
    protected function unwrap (val :*) :* {
        return (val is WeakReference) ? WeakReference(val).get() : val;
    }
}
}
