//
// aspire

package aspire.util {

/**
 * A SetView is an immutable view of a Set.
 *
 * @see com.threerings.util.Sets
 */
public interface SetView
{
    /**
     * Returns true if this set contains the specified element.
     */
    function contains (o :Object) :Boolean;

    /**
     * Retuns the number of elements in this set.
     */
    function size () :int;

    /**
     * Returns true if this set contains no elements.
     */
    function isEmpty () :Boolean;

    /**
     * Returns all elements in the set in an Array.
     * The Array is not a 'view': it can be modified without disturbing
     * the Map from whence it came.
     */
    function toArray () :Array;

    /**
     * Call the specified function, which accepts an element as an argument.
     * Signature:
     * function (o :Object) :void
     *    or
     * function (o :Object) :Boolean
     *
     * If you return a Boolean, you may return <code>true</code> to indicate that you've
     * found what you were looking for, and halt iteration.
     */
    function forEach (fn :Function) :void;
}
}

