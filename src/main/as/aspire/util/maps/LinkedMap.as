//
// aspire

package aspire.util.maps {

import aspire.util.Map;

/**
 * A map that maintains a linked list of entries. Can use a Dictionary as backing.
 * keys(), values(), and forEach() will all visit the oldest mappings first.
 *
 * @private
 */
public /* abstract */ class LinkedMap extends ForeachingMap
{
    public function LinkedMap (source :Map) {
        super(source);
        _anchor = new LinkedEntry(this, this); // fake entry
        _anchor.before = _anchor.after = _anchor;
    }

    override public function put (key :Object, value :Object) :* {
        var entry :LinkedEntry = newEntry(key, value);
        entry.addBefore(_anchor);
        return unlink(super.put(key, entry));
    }

    override public function get (key :Object) :* {
        return unwrap(getEntry(key));
    }

    override public function remove (key :Object) :* {
        return unlink(super.remove(key));
    }

    override public function clear () :void {
        super.clear();
        _anchor.before = _anchor.after = _anchor;
    }

    override public function forEach (fn :Function) :void {
        // iterate over entries, oldest to newest.
        for (var entry :LinkedEntry = _anchor.after; entry != _anchor; entry = entry.after) {
            if (Boolean(fn(entry.key, entry.value))) {
                break;
            }
        }
    }

    /**
     * Unlink the specified entry and return the value.
     * @private
     */
    protected function unlink (val :*) :* {
        if (val === undefined) {
            return undefined;
        }
        var le :LinkedEntry = LinkedEntry(val);
        le.remove();
        return le.value;
    }

    /**
     * Unwrap the entry. Varargs so that it can be passed to Array.map.
     * @private
     */
    protected function unwrap (val :*, ... ignored) :* {
        return (val is LinkedEntry) ? LinkedEntry(val).value : val;
    }

    /**
     * So that this can be overridden separately from the unwrap.
     * @private
     */
    protected function getEntry (key :Object) :* {
        return super.get(key);
    }

    /**
     * For overriding.
     * @private
     */
    protected function newEntry (key :Object, value :Object) :LinkedEntry {
        return new LinkedEntry(key, value);
    }

    /** The anchor of our linked list. @private */
    protected var _anchor :LinkedEntry;
}
}
