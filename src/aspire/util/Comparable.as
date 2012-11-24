//
// aspire

package aspire.util {

/**
 * Implemented by classes whose instances have a natural ordering with respect to each other.
 */
public interface Comparable
{
    /**
     * Compare this object to the other one, and return 0 if they're equal,
     * -1 if this object is less than the other, or 1 if this object is greater.
     * You may throw an Error if compared with null or an object of the wrong type.
     * Note: Please use [-1, 0, 1] to be compatible with flex Sort objects.
     */
    function compareTo (other :Object) :int;
}
}
