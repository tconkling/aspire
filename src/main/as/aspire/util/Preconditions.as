//
// aspire

package aspire.util {

/**
 * Utility functions for verifying program state and throwing appropriate errors.
 */
public class Preconditions
{
    /**
     * Checks that the specified expression is true.
     * @throws Error
     */
    public static function checkState (expression :Boolean, message :String = null, ... args) :void {
        if (!expression) {
            throw new Error(Joiner.pairsArray(message || "", args));
        }
    }

    /**
     * Check that the reference is not null (or undefined) and return it as a convenience.
     * @return the reference that was checked.
     * @throws TypeError
     */
    public static function checkNotNull (ref :*, message :String = null, ... args) :* {
        if (ref == null) {
            throw new TypeError(Joiner.pairsArray(message || "Null reference", args));
        }
        return ref;
    }

    /**
     * Check that the specified expression is true.
     * @throws ArgumentError
     */
    public static function checkArgument (expression :Boolean, message :String = null, ... args)
        :void
    {
        if (!expression) {
            throw new ArgumentError(Joiner.pairsArray(message || "", args));
        }
    }

    /**
     * Check that the specified index is valid: greater than or equal to 0, and less than size.
     * @return the index that was checked.
     * @throws RangeError
     */
    public static function checkIndex (index :int, size :int, message :String = null, ... args) :int {
        if ((index < 0) || (index >= size)) {
            if (message == null) {
                message = "Index out of bounds";
                args = ["index", index, "size", size];
            }
            throw new RangeError(Joiner.pairsArray(message, args));
        }
        return index;
    }

    /**
     * Check that the specified value is not NaN and between the low and high values (inclusive).
     * Passing NaN for low or high will disable that test.
     * @return the value that was checked.
     * @throws RangeError
     */
    public static function checkRange (
        value :Number, low :Number, high :Number, message :String = null, ... args) :Number
    {
        if (isNaN(value) || (value < low) || (value > high)) {
            if (message == null) {
                message = "Value out of range";
                args = ["value", value, "low", low, "high", high];
            }
            throw new RangeError(Joiner.pairsArray(message, args));
        }
        return value;
    }
}
}
