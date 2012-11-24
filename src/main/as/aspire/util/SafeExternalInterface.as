//
// aspire

package aspire.util {

import flash.external.ExternalInterface;

/**
 * A wrapper around ExternalInterface that fails silently if ExternalInterface is not available,
 * instead of throwing an error.
 */
public class SafeExternalInterface
{
    public static function addCallback (functionName :String, closure :Function) :void
    {
        if (available) {
            ExternalInterface.addCallback(functionName, closure);
        }
    }

    public static function removeCallback (functionName :String) :void
    {
        addCallback(functionName, null);
    }

    public static function call (functionName :String, ...arguments) :*
    {
        if (available) {
            arguments.unshift(functionName);
            return ExternalInterface.call.apply(null, arguments);
        } else {
            return undefined;
        }
    }

    public static function get available () :Boolean
    {
        return ExternalInterface.available;
    }

    public static function get marshallExceptions () :Boolean
    {
        return (available && ExternalInterface.marshallExceptions);
    }

    public static function set marshallExceptions (val :Boolean) :void
    {
        if (available) {
            ExternalInterface.marshallExceptions = val;
        }
    }

    public static function get objectId () :String
    {
        return (available ? ExternalInterface.objectID : "");
    }
}

}
