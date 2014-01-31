//
// aspire

package aspire.util {

import aspire.util.sets.MapSet;
import aspire.util.sets.SetBuilder;

/**
 * Factory methods for creating Sets.
 *
 * @example
 * <listing version="3.0">
 * // contains the userIds of seen players
 * var seenUsers :Set = Sets.newSetOf(int);
 * </listing>
 *
 * @example
 * <listing version="3.0">
 * // contains a cache of the last 5 added instances of the Hashable class User.
 * var users :Set = Sets.newBuilder(User).makeLRI(5).build();
 * </listing>
 */
// TODO: expiring Sets
// TODO: weak-value Sets (requires weak-key maps)
public class Sets
{
    /**
     * Create a new Set for storing values of the specified class. If values is given, the items in
     * the Array or Set are added to the created Set.
     */
    public static function newSetOf (valueClazz :Class, values :Object = null) :Set {
        var set :Set = new MapSet(Maps.newMapOf(valueClazz));
        if (values != null) {
            addAll(set, values);
        }
        return set;
    }

    /**
     * Create a new sorted Set for storing value of the specified class.
     */
    public static function newSortedSetOf (valueClazz :Class, comp :Function = null,
        values :Object = null) :Set
    {
        var set :Set = new MapSet(Maps.newSortedMapOf(valueClazz, comp));
        if (values != null) {
            addAll(set, values);
        }
        return set;
    }

    /**
     * Create a SetBuilder for creating a more complicated Set type.
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
    public static function newBuilder (valueClazz :Class) :SetBuilder {
        return new SetBuilder(valueClazz);
    }

    /**
     * Returns an immutable, empty Set.
     *
     * This method returns the same Set instance to every caller.
     */
    public static function empty () :Set {
        if (EMPTY == null) {
            // Type doesn't matter, and DictionaryMap has slightly less overhead.
            EMPTY = newBuilder(int).makeImmutable().build();
        }
        return EMPTY;
    }

    /**
     * Return true if the two sets are equal.
     */
    public static function equals (a :SetView, b :SetView) :Boolean {
        if (a === b) {
            return true;

        } else if (a == null || b == null || (a.size() != b.size())) {
            return false;
        }

        // now see if they have the same contents (assume they do, for empty maps)
        var sameContents :Boolean = true;
        a.forEach(function (val :Object) :Boolean {
            if (!b.contains(val)) {
                sameContents = false;
            }
            return !sameContents; // keep iterating until sameContents is false
        });
        return sameContents;
    }

    /**
     * Calculates the union of a and b and places it in result.
     * a and b are unmodified. result must be empty, and must not be a or b.
     *
     * @return result
     */
    public static function union (a :SetView, b :SetView, result :Set) :Set {
        checkSets(a, b, result);

        function addToResult (e :Object) :void {
            result.add(e);
        }
        a.forEach(addToResult);
        b.forEach(addToResult);

        return result;
    }

    /**
     * Calculates the intersection of a and b and places it in result.
     * a and b are unmodified. result must be empty, and must not be a or b.
     *
     * @return result
     */
    public static function intersection (a :SetView, b :SetView, result :Set) :Set {
        checkSets(a, b, result);

        // iterate the smaller of the two sets
        if (b.size() < a.size()) {
            var tmp :SetView = a;
            a = b;
            b = tmp;
        }

        a.forEach(function (o :Object) :void {
            if (b.contains(o)) {
                result.add(o);
            }
        });

        return result;
    }

    /**
     * Calculates a - b and places it in result.
     * a and b are unmodified. result must be empty, and must not be a or b.
     *
     * @return result
     */
    public static function difference (a :SetView, b :SetView, result :Set) :Set {
        checkSets(a, b, result);

        a.forEach(function (o :Object) :void {
            if (!b.contains(o)) {
                result.add(o);
            }
        });

        return result;
    }

    /**
     * Returns a Set that contains all elements that are contained in either 'a' or 'b',
     * but not in both.
     *
     * a and b are unmodified. result must be empty, and must not be a or b.
     *
     * @return result
     */
    public static function symmetricDifference (a :SetView, b :SetView, result :Set) :Set {
        checkSets(a, b, result);

        a.forEach(function (o :Object) :void {
            if (!b.contains(o)) {
                result.add(o);
            }
        });

        b.forEach(function (o :Object) :void {
            if (!a.contains(o)) {
                result.add(o);
            }
        });

        return result;
    }

    /**
     * Tests if at least one entry in a set meets a condition.
     * @param theSet the set whose entries are to be tested
     * @param condition a function that tests a set entry:
     * <listing version="3.0">
     *     function condition (o :Object) :Boolean
     * </listing>
     * @see Predicates
     */
    public static function some (theSet :SetView, condition :Function) :Boolean {
        var found :Boolean = false;
        theSet.forEach(function (o :Object) :Boolean {
            if (condition(o)) {
                found = true;
                return true;
            }
            return false;
        });
        return found;
    }

    /**
     * Adds an Array or Set of objects to the given set.
     * @return true if any object was added to the set, and false otherwise.
     */
    public static function addAll (theSet :Set, setOrArray :Object) :Boolean {
        var modified :Boolean = false;
        if (setOrArray is SetView) {
            SetView(setOrArray).forEach(function (item :Object) :void {
                if (theSet.add(item)) {
                    modified = true;
                }
            });
        } else if (setOrArray is Array) {
            for each (var o :Object in setOrArray as Array) {
                if (theSet.add(o)) {
                    modified = true;
                }
            }
        } else {
            throw new ArgumentError("'setOrArray' must be an Array or a Set, not a '" +
                ClassUtil.getClassName(setOrArray) + "'");
        }
        return modified;
    }

    /**
     * Removes an Array or Set of objects from the given set.
     * @return true if any object was removed from the set, and false otherwise.
     */
    public static function removeAll (theSet :Set, setOrArray :Object) :Boolean {
        var modified :Boolean = false;
        if (setOrArray is SetView) {
            SetView(setOrArray).forEach(function (item :Object) :void {
                if (theSet.remove(item)) {
                    modified = true;
                }
            });
        } else if (setOrArray is Array) {
            for each (var o :Object in setOrArray as Array) {
                if (theSet.remove(o)) {
                    modified = true;
                }
            }
        } else {
            throw new ArgumentError("'setOrArray' must be an Array or a Set, not a '" +
                ClassUtil.getClassName(setOrArray) + "'");
        }
        return modified;
    }

    /**
     * Helper method for Set operations.
     */
    protected static function checkSets (a :SetView, b :SetView, result :Set) :void {
        if (a == result || b == result) {
            throw new ArgumentError("result must not be a or b");
        }
        if (result.size() > 0) {
            throw new ArgumentError("result must be empty");
        }
    }

    // this has to be lazily initialized. Don't modify!
    protected static var EMPTY :Set;
}
}
