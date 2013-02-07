//
// aspire

package aspire.util {

public class MutableFlags extends Flags
{
    public function MutableFlags (bits :uint = 0) {
        super(bits);
    }

    public function setFlag (flag :uint) :void {
        Preconditions.checkArgument(flag < 32, "flag out of range");
        _bits |= (1 << flag);
    }

    public function clearFlag (flag :uint) :void {
        Preconditions.checkArgument(flag < 32, "flag out of range");
        _bits &= ~(1 << flag);
    }

    public function set bits (val :uint) :void {
        _bits = val;
    }
}
}
