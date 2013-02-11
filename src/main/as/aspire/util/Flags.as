//
// aspire

package aspire.util {

public class Flags
{
    public static function isFlagSet (bits :uint, flag :uint) :Boolean {
        Preconditions.checkArgument(flag < 32, "flag out of range");
        return (bits & (1 << flag)) != 0;
    }
    
    public static function setFlag (bits :uint, flag :uint) :void {
        Preconditions.checkArgument(flag < 32, "flag out of range");
        bits |= (1 << flag);
    }
    
    public static function clearFlag (bits :uint, flag :uint) :void {
        Preconditions.checkArgument(flag < 32, "flag out of range");
        bits &= ~(1 << flag);
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
