//
// aspire

package aspire.util {

public class Flags
{
    public static function isFlagSet (bits :uint, flag :uint) :Boolean {
        Preconditions.checkArgument(flag < 32, "flag out of range");
        return (bits & (1 << flag)) != 0;
    }

    public static function setFlag (bits :uint, flag :uint) :uint {
        Preconditions.checkArgument(flag < 32, "flag out of range");
        return (bits | (1 << flag));
    }

    public static function clearFlag (bits :uint, flag :uint) :uint {
        Preconditions.checkArgument(flag < 32, "flag out of range");
        return (bits & ~(1 << flag));
    }

    public static function setFlags (bits :uint, flags :Array) :uint {
        for each (var flag :uint in flags) {
            bits = setFlag(bits, flag);
        }
        return bits;
    }

    public static function clearFlags (bits :uint, flags :Array) :uint {
        for each (var flag :uint in flags) {
            bits = clearFlag(bits, flag);
        }
        return bits;
    }

    public function Flags (bits :uint = 0) {
        _bits = bits;
    }

    public function isSet (flag :uint) :Boolean {
        return isFlagSet(_bits, flag);
    }

    public function get bits () :uint {
        return _bits;
    }

    protected var _bits :uint;
}
}
