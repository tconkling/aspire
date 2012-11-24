//
// aspire

package aspire.util {
import flash.utils.Dictionary;

/**
 * Implements a sort function based on position in a fixed backing array. This is equivalent to
 * using indexOf(a) - indexOf(b) but with dictionary lookup performance instead of linear. This is
 * intended for arrays that do not change often, but could be adapted by exposing specific
 * mutators like push and splice that only update the necessary indices.
 */
public class Ordering
{
    /**
     * Creates a new ordering backed by the given array. The array is copied so subsequent
     * modifications have no effect.
     */
    public function Ordering (elements :Array = null)
    {
        if (elements != null) {
            this.elements = elements;
        }
    }

    /**
     * Compares two elements in the array in the usual way. Throws an error is either element is
     * not in the array.
     */
    public function compare (elema :*, elemb :*) :int
    {
        return _indices[elema] - _indices[elemb];
    }

    /**
     * Returns a copy of the backing array for the ordering.
     */
    public function get elements () :Array
    {
        return Arrays.copyOf(_elements);
    }

    /**
     * Sets the backing array for this ordering. The array is copied so subsequent modifications
     * have no effect.
     */
    public function set elements (elems :Array) :void
    {
        _elements = Arrays.copyOf(elems);
        refresh();
    }

    /**
     * Invokes a function on the backing array then updates the sorting index.
     * <listing version ="3.0">
     *     function doSomething (elements :Array) :void;
     * </listing>
     */
    public function withElements (doSomething :Function) :void
    {
        try {
            doSomething(_elements);
        } finally {
            refresh();
        }
    }

    private function refresh () :void
    {
        _indices = new Dictionary();
        for (var ii :int = 0; ii < _elements.length; ++ii) {
            _indices[_elements[ii]] = ii;
        }
    }

    private var _elements :Array = [];
    private var _indices :Dictionary;
}
}
