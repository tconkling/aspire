//
// aspire

package aspire.util.sets {

import aspire.util.ClassUtil;
import aspire.util.Set;
import aspire.util.SetView;
import aspire.util.maps.MapBuilder;

/**
 * Builds Sets.
 *
 * @example
 * <listing version="3.0">
 * // builds a sorted Set that keeps the 10 most-recently inserted entries.
 * var mySet :Set = Sets.newBuilder(String)
 *     .makeSorted()
 *     .makeLRI(10)
 *     .build();
 * </listing>
 */
public class SetBuilder
{
    public function SetBuilder (valueClazz :Class) {
        _mb = new MapBuilder(valueClazz);
    }

    /**
     * Make the Map sorted. If no Comparator is specified, then one is picked
     * based on the valueClazz, falling back to Comparators.compareUnknowns.
     *
     * @return this SetBuilder, for chaining.
     */
    public function makeSorted (comp :Function = null) :SetBuilder {
        _mb.makeSorted(comp);
        return this;
    }

    /**
     * Make the Set a cache, disposing of the least-recently-accessed (or just inserted) value
     * whenever size exceeds maxSize. Iterating over this Set (via forEach() or toArray()) will
     * see the oldest entries first.
     *
     * @return this SetBuilder, for chaining.
     */
    public function makeLR (maxSize :int, accessOrder :Boolean = true) :SetBuilder {
        _mb.makeLR(maxSize, accessOrder);
        return this;
    }

    /**
     * Make the Set auto-expire elements.
     *
     * @param ttl the time to live
     * @param a function to receieve notifications when an element expires.
     * signature: function (element :Object) :void;
     *
     * @return this SetBuilder, for chaining.
     */
    public function makeExpiring (ttl :int, expireHandler :Function = null) :SetBuilder {
        _mb.makeExpiring(ttl, (expireHandler == null) ? null :
            function (key :*, value :*) :* {
                return expireHandler(key);
            });
        return this;
    }

    /**
     * Make the Set immutable.
     */
    public function makeImmutable () :SetBuilder {
        _mb.makeImmutable();
        return this;
    }

    /**
     * Add a value to the Set, once built.
     */
    public function add (value :Object) :SetBuilder {
        _mb.put(value, true); // since MapSet stores trues for everything
        return this;
    }

    /**
     * Add all the values in the specified Set or Array to this Set, once built.
     */
    public function addAll (setOrArray :Object) :SetBuilder {
        if (setOrArray is SetView) {
            SetView(setOrArray).forEach(function (item :Object) :void {
                _mb.put(item, true);
            });
        } else if (setOrArray is Array) {
            for each (var o :Object in setOrArray as Array) {
                _mb.put(o, true);
            }
        } else {
            throw new ArgumentError("'setOrArray' must be an Array or a Set, not a '" +
                ClassUtil.getClassName(setOrArray) + "'");
        }
        return this;
    }

    /**
     * Build the Set!
     */
    public function build () :Set {
        return new MapSet(_mb.build());
    }

    /** @private */
    protected var _mb :MapBuilder;
}
}
