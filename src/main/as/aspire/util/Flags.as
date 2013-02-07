//
// aspire

package aspire.util {

public class Flags
{
    public function Flags (bits :uint = 0) {
        _bits = bits;
    }

    public function isSet (flag :uint) :Boolean {
        Preconditions.checkArgument(flag < 32, "flag out of range");
        return (_bits & (1 << flag)) != 0;
    }

    public function get bits () :uint {
        return _bits;
    }

    protected var _bits :uint;
}
}
