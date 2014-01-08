//
// aspire

package aspire.util {

/**
 * Predicates suitable for Array.filter() and other needs.
 */
public class Predicates
{
    /**
     * A predicate that tests for null (or undefined) items.
     */
    public static function isNull (item :*, ... ignored) :Boolean {
        return (item == null);
    }

    /**
     * A predicate that tests for items that are not null (or undefined).
     */
    public static function notNull (item :*, ... ignored) :Boolean {
        return (item != null);
    }

    /**
     * Create a predicate that tests if the item is Util.equals() to the specified value.
     */
    public static function createEquals (value :Object) :Function {
        return function (item :*, ... _) :Boolean {
            return Util.equals(item, value);
        };
    }

    /**
     * Create a predicate that tests if the item has the specified property (with any value).
     */
    public static function hasProperty (propName :String) :Function {
        return function (item :*, ... _) :Boolean {
            return (item != null) && (item as Object).hasOwnProperty(propName);
        };
    }

    /**
     * Create a predicate that tests if the item has a property that is Util.equals() to the
     * specified value.
     */
    public static function propertyEquals (propName :String, value :Object) :Function {
        return function (item :*, ... _) :Boolean {
            return (item != null) && (item as Object).hasOwnProperty(propName) &&
                Util.equals(item[propName], value);
        };
    }

    /**
     * Create a predicate that returns true if the item is in the specified Array.
     */
    public static function isIn (array :Array) :Function {
        return function (item :*, ... _) :Boolean {
            return Arrays.contains(array, item);
        };
    }

    /**
     * Return a predicate that tests for items that are "is" the specified class.
     */
    public static function isClass (clazz :Class) :Function {
        return function (item :*, ... _) :Boolean {
            return (item is clazz);
        };
    }

    /**
     * Return a predicate that is the negation of the specified predicate.
     */
    public static function not (pred :Function) :Function {
        return function (item :*, ... args) :Boolean {
            args.unshift(item);
            return !pred.apply(null, args);
        };
    }

    /**
     * Return a predicate that is true if all the specified predicate Functions are true
     * for any item.
     */
    public static function and (... predicates) :Function {
        return function (item :*, ... args) :Boolean {
            args.unshift(item);
            for each (var pred :Function in predicates) {
                if (!pred.apply(null, args)) {
                    return false;
                }
            }
            return true;
        };
    }

    /**
     * Return a predicate that is true if any of the specified predicate Functions are true
     * for any item.
     */
    public static function or (... predicates) :Function {
        return function (item :*, ... args) :Boolean {
            args.unshift(item);
            for each (var pred :Function in predicates) {
                if (pred.apply(null, args)) {
                    return true;
                }
            }
            return false;
        };
    }
}
}
