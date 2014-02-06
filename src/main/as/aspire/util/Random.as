//
// aspire

package aspire.util {

import flash.utils.ByteArray;

/**
 * A seedable pseudorandom generator of the Mersenne Twister variety, with an extremely
 * long period. Note that this is not a cryptographically sound generator.
 * This implementation is based on one found at --
 *    http://onegame.bona.jp/tips/mersennetwister.html
 * An explanation of the algorithm can be found at --
 *    http://en.wikipedia.org/wiki/Mersenne_twister
 */
public class Random
    implements RandomStream
{
    /**
     * Creates a pseudo random number generator with a random seed.
     */
    public static function create () :Random {
        return new Random(uint(_seedUniquifier++ + uint(Math.random() * 4294967295)));
    }

    /**
     * Creates a pseudo random number generator with the specified seed.
     */
    public function Random (seed :uint) {
        setSeed(seed);
    }

    /** Serialize our internal state into a ByteArray */
    public function saveState (ba :ByteArray = null) :ByteArray {
        ba = (ba || new ByteArray());
        for (var ii :int = 0; ii < N; ++ii) {
            ba.writeUnsignedInt(_x[ii]);
        }
        ba.writeInt(_p);
        ba.writeInt(_q);
        ba.writeInt(_r);
        return ba;
    }

    /** Restore our internal state from a ByteArray */
    public function restoreState (ba :ByteArray) :void {
        for (var ii :int = 0; ii < N; ++ii) {
            _x[ii] = ba.readUnsignedInt();
        }
        _p = ba.readInt();
        _q = ba.readInt();
        _r = ba.readInt();
    }

    /**
     * Sets the seed of the generator. This will result in the same generator sequence of values
     * as a new generator created with the specified seed.
     */
    public function setSeed (seed :uint) :void {
        _x[0] = seed;
        for (var ii :int = 1; ii < N; ii++) {
            _x[ii] = (imul(1812433253, _x[ii - 1] ^ (_x[ii - 1] >>> 30)) + ii) & 0xffffffff;
        }
        _p = 0;
        _q = 1;
        _r = M;
    }

    /** Returns an int value where int.MIN_VALUE &lt;= value &lt;= int.MAX_VALUE */
    public function next () :int {
        return int(nextBits(32));
    }

    /**
     * Returns the an int value n where 0 &lt;= value &lt; n.
     *
     * @param n the range to return. Must be > 0.
     */
    public function nextInt (n :int) :int {
        if (n <= 0) {
            throw new Error("n must be positive");
        }

        // Eyeball Sun's documentation of java.util.Random for an explanation of this while loop.
        var bits :int, val :int;
        do {
            bits = int(nextBits(31));
            val = bits % n;
        } while (bits - val + (n - 1) < 0);
        return val;
    }

    /**
     * Returns a random Boolean value.
     */
    public function nextBoolean () :Boolean {
        return nextBits(1) != 0;
    }

    /**
     * Returns a random Number where 0.0 &lt;= value &lt; 1.0.
     */
    public function nextNumber () :Number {
        return nextBits(32) / 4294967296;
    }

    protected function nextBits (bits: int) :uint {
        var y :uint = (_x[_p] & UPPER_MASK) | (_x[_q] & LOWER_MASK);
        _x[_p] = _x[_r] ^ (y >>> 1) ^ ((y & 1) * MATRIX_A);
        y = _x[_p];

        if (++_p == N) { _p = 0; }
        if (++_q == N) { _q = 0; }
        if (++_r == N) { _r = 0; }

        y ^= (y >>> 11);
        y ^= (y << 7) & 0x9d2c5680;
        y ^= (y << 15) & 0xefc60000;
        y ^= (y >>> 18);

        return y >>> (32 - bits);
    }

    protected function imul (a: Number, b: Number): Number {
        var al :Number = a & 0xffff;
        var ah :Number = a >>> 16;
        var bl :Number = b & 0xffff;
        var bh :Number = b >>> 16;
        var ml :Number = al * bl;
        var mh :Number = ((((ml >>> 16) + al * bh) & 0xffff) + ah * bl) & 0xffff;

        return (mh << 16) | (ml & 0xffff);
    }

    protected var _x :Vector.<uint> = new Vector.<uint>(N, true);
    protected var _p :int;
    protected var _q :int;
    protected var _r :int;

    protected static var _seedUniquifier :uint = 2812526361;

    protected static const N :int = 624;
    protected static const M :int = 397;
    protected static const UPPER_MASK :uint = 0x80000000;
    protected static const LOWER_MASK :uint = 0x7fffffff;
    protected static const MATRIX_A :uint   = 0x9908b0df;

}
}
