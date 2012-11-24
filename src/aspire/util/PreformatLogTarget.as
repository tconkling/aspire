//
// aspire

package aspire.util {

/**
 * A logging target that receives the log arguments before formatting
 */
public interface PreformatLogTarget
{
    /**
     * Handle logging. If you must modify the args array, create a local copy first.
     */
    function logArgs (module :String, level :int, args :Array) :void
}
}
