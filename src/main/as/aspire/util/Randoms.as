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
     * Returns a pseudorandom, uniformly distributed <code>int</code> value between
     * <code>base-variance</code> (inclusive) and <code>base+variance</code> (inclusive).
     *
     * @throws IllegalArgumentException if <code>high - low</code> is not positive.
     */
    public function getIntWithVariance (base :int, variance :int) :int {
        return getIntInRange(base - variance, base + variance + 1);
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
     * Returns a pseudorandom, uniformly distributed <code>Number</code> value between
     * <code>base-variance</code> (inclusive) and <code>base+variance</code> (exclusive).
     */
    public function getNumberWithVariance (base :Number, variance :Number) :Number {
        return getNumberInRange(base - variance, base + variance);
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

        return arr.removeAt(_stream.nextInt(arr.length));
    }

    /**
     * Pick a random index from the array, weighted by the value of the corresponding array
     * element.
     *
     * @param weightsArray an Array or Vector of non-negative floats.
     *
     * @return an index into the array, or -1 if the sum of the weights is less than or equal to
     * 0.0 or any individual element is negative.  For example, passing in {0.2, 0.0, 0.6, 0.8}
     * will return:
     *
     * <pre>{@code
     * 0 - 1/8th of the time
     * 1 - never
     * 2 - 3/8th of the time
     * 3 - half of the time
     * }</pre>
     *
     * (See also: WeightedArray)
     */
    public function getWeightedIndex (weightsArray :*) :int {
        var sum :Number = 0;
        for each (var weight :Number in weightsArray) {
            if (weight < 0) {
                return -1;
            }
            sum += weight;
        }

        if (sum <= 0.0) {
            return -1;
        }
        var pick :Number = getNumber(sum);
        for (var ii :int = 0, nn :int = weightsArray.length; ii < nn; ++ii) {
            pick -= weightsArray[ii];
            if (pick < 0) {
                return ii;
            }
        }

        // we'll never get here
        return 0;
    }

    protected var _stream :RandomStream;
}
}
