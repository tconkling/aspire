//
// aspire

package aspire.util {

/**
 * A MapView is an immutable view of a Map
 *
 * @see com.threerings.util.Maps
 */
public interface MapView extends Equalable
{
    /**
     * Retrieve the value stored in this map for the specified key.
     * Returns the value, or undefined if there is no mapping for the key.
     */
    function get (key :Object) :*;

    /**
     * Returns true if the specified key exists in the map.
     */
    function containsKey (key :Object) :Boolean;

    /**
     * Return the current size of the map.
     */
    function size () :int;

    /**
     * Returns true if this map contains no elements.
     */
    function isEmpty () :Boolean;

    /**
     * Return all the unique keys in this Map, in Array form.
     * The Array is not a 'view': it can be modified without disturbing
     * the Map from whence it came.
     */
    function keys () :Array;

    /**
     * Return all the values in this Map, in Array form.
     * The Array is not a 'view': it can be modified without disturbing
     * the Map from whence it came.
     */
    function values () :Array;

    /**
     * Returns an Array of Arrays of [key, value] for each key and value in this Map.
     * The Array is not a 'view': it can be modified without disturbing the Map from whence it came.
     */
    function items () :Array;

    /**
     * Call the specified function to iterate over the mappings in this Map.
     * Signature:
     * function (key :Object, value :Object) :void
     *    or
     * function (key :Object, value :Object) :Boolean
     *
     * If you return a Boolean, you may return <code>true</code> to indicate that you've
     * found what you were looking for, and halt iteration.
     */
    function forEach (fn :Function) :void;
}
}
