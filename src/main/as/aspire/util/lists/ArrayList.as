//
// aspire

package aspire.util.lists {

import aspire.util.List;
import aspire.util.Preconditions;
import aspire.util.Util;

/**
 * A List that uses an Array for backing.
 */
public class ArrayList
    implements List
{
    /**
     * Construct a new ArrayList.
     */
    public function ArrayList () {
        _array = [];
    }

    /** @inheritDoc */
    public function add (o :Object) :Boolean {
        _array.push(o);
        return true;
    }

    /** @inheritDoc */
    public function addAt (index :int, o :Object) :void {
        _array.splice(Preconditions.checkIndex(index, _array.length + 1), 0, o);
    }

    /** @inheritDoc */
    public function get (index :int) :Object {
        return _array[Preconditions.checkIndex(index, _array.length)];
    }

    /** @inheritDoc */
    public function set (index :int, o :Object) :void {
        _array[Preconditions.checkIndex(index, _array.length)] = o;
    }

    /** @inheritDoc */
    public function contains (o :Object) :Boolean {
        return (indexOf(o) != -1);
    }

    /** @inheritDoc */
    public function indexOf (o :Object) :int {
        for (var ii :int = 0, nn :int = _array.length; ii < nn; ii++) {
            if (Util.equals(_array[ii], o)) {
                return ii;
            }
        }
        return -1;
    }

    /** @inheritDoc */
    public function lastIndexOf (o :Object) :int {
        for (var ii :int = _array.length - 1; ii >= 0; ii--) {
            if (Util.equals(_array[ii], o)) {
                return ii;
            }
        }
        return -1;
    }

    /** @inheritDoc */
    public function remove (o :Object) :Boolean {
        var index :int = indexOf(o);
        if (index == -1) {
            return false;
        }
        _array.splice(index, 1);
        return true;
    }

    /** @inheritDoc */
    public function removeAt (index :int) :Object {
        return _array.splice(Preconditions.checkIndex(index, _array.length), 1)[0];
    }

    /** @inheritDoc */
    public function size () :int {
        return _array.length;
    }

    /** @inheritDoc */
    public function isEmpty () :Boolean {
        return (size() == 0);
    }

    /** @inheritDoc */
    public function clear () :void {
        _array = [];
    }

    /** @inheritDoc */
    public function toArray () :Array {
        return _array.slice();
    }

    /** @inheritDoc */
    public function forEach (fn :Function) :void {
        for each (var o :Object in _array) {
            if (Boolean(fn(o))) {
                return;
            }
        }
    }

    /** Our array o' storage. @private */
    protected var _array :Array;
}
}
