//
// aspire

package aspire.util {

/**
 * A very simple Logging interface used by Log.
 */
public interface LogTarget
{
    /**
     * Log the specified message, which is already fully formatted.
     */
    function log (msg :String) :void;
}
}
