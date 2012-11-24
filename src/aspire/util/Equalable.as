//
// aspire

package aspire.util {

/**
 * Implemented by classes that can have separate instances indicate that they are equal.
 */
public interface Equalable
{
    /**
     * Returns true to indicate that the specified object is equal to this instance.
     */
    function equals (other :Object) :Boolean;
}
}
