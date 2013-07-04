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
public interface Map extends MapView
{
    /**
     * Store a value in the map associated with the specified key.
     * Returns the previous value stored for that key, or undefined.
     */
    function put (key :Object, value :Object) :*;

    /**
     * Removes the mapping for the specified key.
     * Returns the value that had been stored, or undefined.
     */
    function remove (key :Object) :*;

    /**
     * Clear this map, removing all stored elements.
     */
    function clear () :void;
}
}
