//
// aspire

package aspire.util {

/**
 * <p>A Map is an object that maps keys to values.</p>
 *
 * <p>
 * <i>N.B.</i> equals returns true on a Map if the passed in object meets a few conditions:
 * <ul>
 * <li>it's also a Map</li>
 * <li>it contains the same set of keys as the called Map as signified by its get function returning something other than undefined for those keys</li>
 * <li>its values for those keys are equal to the value in the called Map according to
 * Util.equals.</li>
 * </ul>
 * </p>
 *
 * @see com.threerings.util.Maps
 */
public interface Map
    extends Equalable
{
    /**
     * Store a value in the map associated with the specified key.
     * Returns the previous value stored for that key, or undefined.
     */
    function put (key :Object, value :Object) :*;

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
     * Removes the mapping for the specified key.
     * Returns the value that had been stored, or undefined.
     */
    function remove (key :Object) :*;

    /**
     * Return the current size of the map.
     */
    function size () :int;

    /**
     * Returns true if this map contains no elements.
     */
    function isEmpty () :Boolean;

    /**
     * Clear this map, removing all stored elements.
     */
    function clear () :void;

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
