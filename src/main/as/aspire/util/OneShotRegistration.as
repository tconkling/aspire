//
// aspire

package aspire.util {

/**
 * Extends the Registration interface to add a "once" function (for signals, event listeners,
 * and other registerable actions that can be one-shots).
 */
public interface OneShotRegistration extends Registration
{
    function once () :OneShotRegistration;
}
}
