//
// aspire

package aspire.util.maps {

import aspire.util.Map;

/**
 * A Map that disposes of key/value mappings that were least-recently used or inserted
 * after filling up.
 * Re-inserting a value for a key updates the ordering.
 * Note: this implementation is O(n) for maintaining the ordering. This was done
 * (rather than using a linked map implementation) because it was easy, it works
 * with a HashMap or DictionaryMap underneath, and we don't really need more.
 * Does not work with a weak-value map as the source.
 */
public class LRMap extends LinkedMap
{
    public function LRMap (source :Map, maxSize :int, accessOrder :Boolean = true,
            invalidationHandler :Function = null) {
        super(source);
        _maxSize = maxSize;
        _accessOrder = accessOrder;
        _invalidationHandler = invalidationHandler;
    }

    /** @inheritDoc */
    override public function put (key :Object, value :Object) :* {
        var oldVal :* = super.put(key, value);
        if ((oldVal === undefined) && (size() > _maxSize)) {
            // remove the oldest entry
            if (_invalidationHandler != null) {
                _invalidationHandler(_anchor.after.key, _anchor.after.value);
            }
            remove(_anchor.after.key);
        }
        return oldVal;
    }

    /** @private */
    override protected function getEntry (key :Object) :* {
        var val :* = super.getEntry(key);
        if ((val !== undefined) && _accessOrder) {
            var le :LinkedEntry = LinkedEntry(val);
            le.remove();
            le.addBefore(_anchor);
        }
        return val;
    }

    /** The maximum size before we roll off entries. @private */
    protected var _maxSize :int;

    /** Are we keeping in access order, or merely insertion order? @private */
    protected var _accessOrder :Boolean;

    /** A function to optionally receive notification when a mapping is invalidated */
    protected var _invalidationHandler :Function;
}
}
