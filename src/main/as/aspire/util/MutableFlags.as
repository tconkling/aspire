//
// aspire

package aspire.util {

public class MutableFlags extends Flags
{
    public function MutableFlags (bits :uint = 0) {
        super(bits);
    }

    public function setFlag (flag :uint) :void {
        _bits = Flags.setFlag(_bits, flag);
    }

    public function clearFlag (flag :uint) :void {
        _bits = Flags.clearFlag(_bits, flag);
    }

    public function set bits (val :uint) :void {
        _bits = val;
    }
}
}
