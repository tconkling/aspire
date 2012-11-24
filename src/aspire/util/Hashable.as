//
// aspire

package aspire.util {

/**
 * Builds upon the Equalable interface to allow instances to be stored efficiently in Maps or Sets.
 */
public interface Hashable extends Equalable
{
    /**
     * Return a hash code. This code must be identical for any two instances that are equals(),
     * but it is not required that every non-equals() instance returns a unique code.
     */
    function hashCode () :int;
}
}
