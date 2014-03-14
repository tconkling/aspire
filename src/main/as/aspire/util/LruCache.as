//
// aspire

package aspire.util {

/**
 * A simple least-recently-used cache implementation.
 */
public class LruCache
{
    /**
     * Creates a cache.
     * @param maxSize the maximum size of the cache before it purges its oldest entry.
     * @param allowDuplicateKeys if false, storing a keyed value will remove any other value that
     * shares that key.
     * @param disposeValue (optional) a function that is called when a value is purged from the
     * cache, either from a 'purge' call or to make room for a new value.
     */
    public function LruCache (maxSize :uint, allowDuplicateKeys :Boolean,
        disposeValue :Function = null) {

        Preconditions.checkArgument(maxSize > 0, "maxSize must be > 0");
        _maxSize = maxSize;
        _allowDuplicateKeys = allowDuplicateKeys;
        _disposeValue = disposeValue;
    }

    /**
     * Removes and returns the value stored with the given key,
     * or returns undefined if the cache doesn't contain the key
     */
    public function getValue (key :Object) :* {
        var cur :Entry = _head;
        while (cur != null) {
            if (cur.key == key) {
                var val :Object = cur.val;
                removeEntry(cur);
                return val;
            }
            cur = cur.next;
        }

        return undefined;
    }

    /** Stores a value in the cache. */
    public function storeValue (key :Object, val :Object) :void {
        if (!_allowDuplicateKeys) {
            getValue(key);
        }

        if (_size == _maxSize) {
            removeEntry(_tail);
        }
        addEntry(key, val);
    }

    public function purge () :void {
        var cur :Entry = _head;
        while (cur != null) {
            var next :Entry = cur.next;
            disposeEntry(cur);
            cur = next;
        }
        _size = 0;
        _head = _tail = null;
    }

    protected function addEntry (key :Object, val :Object) :void {
        var entry :Entry = null;
        if (_entryPool.length > 0) {
            entry = _entryPool.pop();
        } else {
            entry = new Entry();
        }
        entry.key = key;
        entry.val = val;

        // We push to the head and pop from the tail
        var oldHead :Entry = _head;
        _head = entry;
        if (oldHead != null) {
            _head.next = oldHead;
            oldHead.prev = _head;
        } else {
            _tail = _head;
        }

        _size++;
    }

    protected function removeEntry (entry :Entry) :void {
        var prev :Entry = entry.prev;
        var next :Entry = entry.next;
        if (prev != null) {
            prev.next = next;
        }
        if (next != null) {
            next.prev = prev;
        }

        if (_head == entry) {
            _head = next;
        }
        if (_tail == entry) {
            _tail = prev;
        }

        disposeEntry(entry);
        _size--;
    }

    protected function disposeEntry (entry :Entry) :void {
        if (_disposeValue != null) {
            _disposeValue(entry.val);
        }
        entry.reset();
        _entryPool.push(entry);
    }

    protected var _maxSize :uint;
    protected var _allowDuplicateKeys :Boolean;
    protected var _disposeValue :Function;

    protected var _size :uint;
    protected var _head :Entry;
    protected var _tail :Entry;

    protected static const _entryPool :Vector.<Entry> = new Vector.<Entry>();
}
}

class Entry {
    public var key :Object;
    public var val :Object;
    public var next :Entry;
    public var prev :Entry;

    public function reset () :void {
        key = null;
        val = null;
        next = null;
        prev = null;
    }
}
