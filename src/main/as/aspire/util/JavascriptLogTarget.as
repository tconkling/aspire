//
// aspire

package aspire.util {

import flash.external.ExternalInterface;

/**
 * Writes to the Javascript console in Web Inspector in Safari, Firebug in Firefox and IE 8's
 * Developer Tools.
 */
public class JavascriptLogTarget implements LogTarget
{
    public function log (msg :String) :void {
        try {
            ExternalInterface.call("console.log", msg);
        } catch (error :Error) {
            // Guess we can't write to javascript.  Oh well, trace will still get it.
        }
    }
}
}
