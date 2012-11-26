//
// aspire

package aspire.util {

/**
 * <p>Provides utility routines to simplify obtaining randomized values.</p>
 *
 * Each instance of Randoms contains an underlying Random instance. If you wish to have a
 * private stream of pseudorandom numbers, pass an unshared Random to the constructor.
 */
public class Randoms
{
    public static const RAND :Randoms = new Randoms(Random.createRandom());

    /**
     * Construct a Randoms.
     */
    public function Randoms (rand :Random)
    {
        _r = rand;
    }

    /**
     * Returns a pseudorandom, uniformly distributed <code>int</code> value between <code>0</code>
     * (inclusive) and <code>high</code> (exclusive).
     *
     * @param high the high value limiting the random number sought.
     *
     * @throws IllegalArgumentException if <code>high</code> is not positive.
     */
    public function getInt (high :int) :int
    {
        return _r.nextInt(high);
    }

    /**
     * Returns a pseudorandom, uniformly distributed <code>int</code> value between
     * <code>low</code> (inclusive) and <code>high</code> (exclusive).
     *
     * @throws IllegalArgumentException if <code>high - low</code> is not positive.
     */
    public function getInRange (low :int, high :int) :int
    {
        return low + _r.nextInt(high - low);
    }

    /**
     * Returns a pseudorandom, uniformly distributed <code>Number</code> value between
     * <code>0.0</code> (inclusive) and the <code>high</code> (exclusive).
     *
     * @param high the high value limiting the random number sought.
     */
    public function getNumber (high :Number) :Number
    {
        return _r.nextNumber() * high;
    }

    /**
     * Returns a pseudorandom, uniformly distributed <code>Number</code> value between
     * <code>low</code> (inclusive) and <code>high</code> (exclusive).
     */
    public function getNumberInRange (low :Number, high :Number) :Number
    {
        return low + (_r.nextNumber() * (high - low));
    }

    /**
     * Returns true approximately one in <code>n</code> times.
     *
     * @throws IllegalArgumentException if <code>n</code> is not positive.
     */
    public function getChance (n :int) :Boolean
    {
        return (0 == _r.nextInt(n));
    }

    /**
     * Has a probability <code>p</code> of returning true.
     */
    public function getProbability (p :Number) :Boolean
    {
        return _r.nextNumber() < p;
    }

    /**
     * Returns <code>true</code> or <code>false</code> with approximately even probability.
     */
    public function getBoolean () :Boolean
    {
        return _r.nextBoolean();
    }

    /**
     * Shuffle the specified list using our Random.
     */
    public function shuffle (list :Array) :void
    {
        Arrays.shuffle(list, _r);
    }

    /**
     * Pick a random element from the specified Array, or return <code>ifEmpty</code>
     * if it is empty.
     */
    public function pick (list :Array, ifEmpty :*) :*
    {
        if (list == null || list.length == 0) {
            return ifEmpty;
        }

        return list[_r.nextInt(list.length)];
    }

    /**
     * Pick a random element from the specified Array and remove it from the list, or return
     * <code>ifEmpty</code> if it is empty.
     */
    public function pluck (list :Array, ifEmpty :*) :*
    {
        if (list == null || list.length == 0) {
            return ifEmpty;
        }

        return list.splice(_r.nextInt(list.length), 1)[0];
    }

    protected var _r :Random;
}
}
