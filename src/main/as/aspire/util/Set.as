//
// aspire

package aspire.util {

/**
 * A Set contains unique instances of objects.
 *
 * @see com.threerings.util.Sets
 */
public interface Set extends SetView
{
    /**
     * Adds the specified element to the set if it's not already present.
     * Returns true if the set did not already contain the specified element.
     */
    function add (o :Object) :Boolean;

    /**
     * Removes the specified element from this set if it is present.
     * Returns true if the set contained the specified element.
     */
    function remove (o :Object) :Boolean;

    /**
     * Remove all elements from this set.
     */
    function clear () :void;
}
}
