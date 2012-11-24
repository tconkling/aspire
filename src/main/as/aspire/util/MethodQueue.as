//
// aspire

package aspire.util {

/**
 * This is deprecated. Use DelayUtil.
 */
[Deprecated(replacement="com.threerings.util.DelayUtil")]
public class MethodQueue
{
    public static function callLater (fn :Function, args :Array = null) :void
    {
        DelayUtil.delayFrame(fn, args);
    }
}
}
