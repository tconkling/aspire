//
// aspire

package aspire.util {

/**
 * <p>Provides utility routines to simplify obtaining randomized values.</p>
 */
public class Randoms
{
    /**
     * Construct a Randoms with the given RandomStream.
     * If the stream is null, a default one will be created.
     */
    public function Randoms (stream :RandomStream = null) {
        _stream = (stream || Random.create());
    }

    /**
     * Returns a pseudorandom, uniformly distributed <code>int</code> value between <code>0</code>
     * (inclusive) and <code>high</code> (exclusive).
     *
     * @param high the high value limiting the random number sought.
     *
     * @throws IllegalArgumentException if <code>high</code> is not positive.
     */
    public function getInt (high :int) :int {
        return _stream.nextInt(high);
    }

    /**
     * Returns a pseudorandom, uniformly distributed <code>int</code> value between
     * <code>low</code> (inclusive) and <code>high</code> (exclusive).
     *
     * @throws IllegalArgumentException if <code>high - low</code> is not positive.
     */
    public function getIntInRange (low :int, high :int) :int {
        return low + _stream.nextInt(high - low);
    }

    /**
     * Returns a pseudorandom, uniformly distributed <code>Number</code> value between
     * <code>0.0</code> (inclusive) and the <code>high</code> (exclusive).
     *
     * @param high the high value limiting the random number sought.
     */
    public function getNumber (high :Number) :Number {
        return _stream.nextNumber() * high;
    }

    /**
     * Returns a pseudorandom, uniformly distributed <code>Number</code> value between
     * <code>low</code> (inclusive) and <code>high</code> (exclusive).
     */
    public function getNumberInRange (low :Number, high :Number) :Number {
        return low + (_stream.nextNumber() * (high - low));
    }

    /**
     * Returns true approximately one in <code>n</code> times.
     *
     * @throws IllegalArgumentException if <code>n</code> is not positive.
     */
    public function oneIn (n :int) :Boolean {
        return (0 == _stream.nextInt(n));
    }

    /**
     * Has a probability <code>p</code> of returning true.
     */
    public function getProbability (p :Number) :Boolean {
        return _stream.nextNumber() < p;
    }

    /**
     * Returns <code>true</code> or <code>false</code> with approximately even probability.
     */
    public function getBoolean () :Boolean {
        return oneIn(2);
    }

    /**
     * Shuffle the specified Array or Vector.
     */
    public function shuffle (arr :*) :void {
        if (arr["length"] === undefined) {
            throw new ArgumentError("arr must be an Array or Vector!");
        }
        // starting from the end of the list, repeatedly swap the element in question with a
        // random element previous to it up to and including itself
        for (var ii :int = arr.length; ii > 1; ii--) {
            Arrays.swap(arr, ii - 1, getInt(ii));
        }
    }

    /**
     * Pick a random element from the specified Array or Vector, or return <code>ifEmpty</code>
     * if it is empty.
     */
    public function pick (arr :*, ifEmpty :* = undefined) :* {
        if (arr["length"] === undefined) {
            throw new ArgumentError("arr must be an Array or Vector!");
        }
        if (arr.length == 0) {
            return ifEmpty;
        }

        return arr[_stream.nextInt(arr.length)];
    }

    /**
     * Pick a random element from the specified Array or Vector and remove it from the list, or
     * return <code>ifEmpty</code> if it is empty.
     */
    public function pluck (arr :*, ifEmpty :* = undefined) :* {
        if (arr["length"] === undefined) {
            throw new ArgumentError("arr must be an Array or Vector!");
        }
        if (arr.length == 0) {
            return ifEmpty;
        }

        return arr.splice(_stream.nextInt(arr.length), 1)[0];
    }

    protected var _stream :RandomStream;
}
}
