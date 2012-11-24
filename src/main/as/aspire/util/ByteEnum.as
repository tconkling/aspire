//
// aspire

package aspire.util {

/**
 * An enum value that can be persisted as a byte.
 *
 * On the Java side this is an interface, because all Enum classes are final.
 * But here, we can just let you extend ByteEnum and get in on the goodness from
 * the ground floor!
 *
 * Please follow all other conventions as specified in our Enum class.
 */
public /* abstract */ class ByteEnum extends Enum
{
    /**
     * Returns the enum value with the specified code in the supplied enum class.
     * Throws ArgumentError if the enum lacks a value that maps to the supplied code.
     */
    public static function fromByte (clazz :Class, code :int) :ByteEnum
    {
        for each (var e :ByteEnum in Enum.values(clazz)) {
            if (e.toByte() == code) {
                return e;
            }
        }
        throw new ArgumentError(Joiner.pairs("No ByteEnum code", "class", clazz, "code", code));
    }

    /**
     * Call this constructor from your subclass' constructor.
     * Note that we do not verify that you're using a valid byte, or that you haven't
     * assigned two enums to the same byte.
     */
    public function ByteEnum (name :String, code :int)
    {
        super(name);
        _code = code;
    }

    /**
     * Return the byte form of this enum.
     */
    public final function toByte () :int
    {
        return _code;
    }

    /** The byte value of this ByteEnum. */
    protected var _code :int;

    // prevent funnybiz
    finishedEnumerating(ByteEnum);
}
}
