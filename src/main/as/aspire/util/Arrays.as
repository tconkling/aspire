//
// aspire

package aspire.util {

/**
 * Contains methods that should be in Array, but aren't. Additionally
 * contains methods that understand the interfaces in this package.
 * So, for example, removeFirst() understands Equalable and will remove
 * an element that is equals() to the specified element, rather than just
 * === (strictly equals) to the specified element.
 *
 * Methods which take * for the array parameter may accept either an Array or Vector.
 */
public class Arrays
{
    /**
     * Creates a new Array and fills it with a default value.
     * @param size the size of the array
     * @param val the value to store at each index of the Array
     */
    public static function create (size :uint, val :* = null) :Array {
        return padToLength([], size, val);
    }

    /**
     * Properly resizes an Array, truncating if it's too large, and padding it with 'undefined'
     * if too small.
     *
     * An Array grown with the Array class's length setter will not actually have the
     * number of elements that it claims to.
     */
    public static function resize (arr :*, newLength :uint) :void {
        requireArrayOrVector(arr);
        if (arr.length > newLength) {
            arr.length = newLength;
        } else {
            padToLength(arr, newLength, undefined);
        }
    }

    /**
     * Pad the array to the specified length with the value specified, returning the passed-in
     * array for convenience.
     */
    public static function padToLength (arr :*, size :uint, val :* = null) :Array {
        requireArrayOrVector(arr);
        while (arr.length < size) {
            arr.push(val);
        }
        return arr;
    }

    /**
     * Creates a shallow copy of the array.
     *
     * @internal TODO: add support for copy ranges and deep copies?
     */
    public static function copyOf (arr :*) :Array {
        requireArrayOrVector(arr);
        return arr.concat();
    }

    /**
     * Find the maximum element in the array according to the specified Comparator, or
     * according to Comparators.compareUnknowns if no Comparator is specified.
     *
     * @return the maximum value, or undefined if the array is empty.
     */
    public static function max (arr :*, comp :Function = null) :* {
        // min will check arr type
        if (comp == null) {
            comp = Comparators.compareUnknowns;
        }
        return min(arr, Comparators.createReverse(comp));
    }

    /**
     * Find the minimum element in the array according to the specified Comparator, or
     * according to Comparators.compareUnknowns if no Comparator is specified.
     *
     * @return the minimum value, or undefined if the array is empty.
     */
    public static function min (arr :*, comp :Function = null) :* {
        requireArrayOrVector(arr);
        var len :uint = arr.length;
        if (len == 0) {
            return undefined;
        }
        if (comp == null) {
            comp = Comparators.compareUnknowns;
        }
        var min :* = arr[0];
        for (var ii :uint = 1; ii < len; ii++) {
            if (comp(arr[ii], min) < 0) {
                min = arr[ii];
            }
        }
        return min;
    }

    /**
     * Sort the specified array according to one or more fields of the objects in the Array.
     *
     * Array.sortOn() only works with public variables, and not with public getters.
     * This implementation works with both.
     *
     * @param sortFields an Array of Strings, representing the order of fields to sort the array by
     */
    public static function sortOn (arr :*, sortFields :Array) :void {
        // stableSort will check arr type
        stableSort(arr, Comparators.createFields(sortFields));
    }

    /**
     * Perform a stable sort on the specified array.
     * @param comp a function that takes two objects in the array and returns -1 if the first
     * object should appear before the second in the container, 1 if it should appear after,
     * and 0 if the order does not matter. If omitted, Comparators.compareComparables is used and
     * the array elements should be Comparable objects.
     */
    public static function stableSort (arr :*, comp :Function = null) :void {
        requireArrayOrVector(arr);
        if (comp == null) {
            comp = Comparators.compareComparables;
        }
        // insertion sort implementation
        var nn :int = arr.length;
        for (var ii :int = 1; ii < nn; ii++) {
            var val :* = arr[ii];
            var jj :int = ii - 1;
            var compVal :* = arr[jj];
            if (comp(val, compVal) >= 0) {
                continue;
            }
            arr[ii] = compVal;
            for (jj--; jj >= 0; jj--) {
                compVal = arr[jj];
                if (comp(val, compVal) >= 0) {
                    break;
                }
                arr[jj + 1] = compVal;
            }
            arr[jj + 1] = val;
        }
    }

    /**
     * Inserts an object into a sorted Array in its correct, sorted location.
     *
     * @param comp a function that takes two objects in the array and returns -1 if the first
     * object should appear before the second in the container, 1 if it should appear after,
     * and 0 if the order does not matter. If omitted, Comparators.compareComparables is used and
     * the array elements should be Comparable objects.
     *
     * @return the index of the inserted item
     */
    public static function sortedInsert (arr :*, val :*, comp :Function = null) :int {
        requireArrayOrVector(arr);
        if (comp == null) {
            comp = Comparators.compareComparables;
        }
        var index :int = binarySearch(arr, 0, arr.length, val, comp);
        if (index < 0) {
            index = -(index + 1);
        }
        arr.splice(index, 0, val);
        return index;
    }

    /**
     * Swap the elements in the specified positions in the specified list.
     */
    public static function swap (arr :*, ii :int, jj :int) :void {
        requireArrayOrVector(arr);
        var tmp :* = arr[ii];
        arr[ii] = arr[jj];
        arr[jj] = tmp;
    }

    /**
     * Returns true if the given predicate returns true for any of the items in the array.
     */
    public static function any (arr :*, predicate :Function) :Boolean {
        // indexIf will check arr type
        return indexIf(arr, predicate) >= 0;
    }

    /**
     * Returns true if the given predicate returns true for all of the items in the array.
     */
    public static function all (arr :*, predicate :Function) :Boolean {
        // any will check arr type
        return !(any(arr, function (item :*) :Boolean { return !predicate(item); }));
    }

    /**
     * Returns the number of elements in the Array for which the given predicate returns true.
     */
   public static function count (arr :Array, predicate :Function) :uint {
       var count :uint = 0;
       for (var ii :int = 0; ii < arr.length; ++ii) {
           if (predicate(arr[ii])) {
               count++;
           }
       }
       return count;
   }

    /**
     * Returns the index of the first item in the array for which the predicate function
     * returns true, or -1 if no such item was found. The predicate function should be of type:
     *   function (element :*) :Boolean { }
     *
     * @return the zero-based index of the matching element, or -1 if none found.
     */
    public static function indexIf (arr :*, predicate :Function) :int {
        requireArrayOrVector(arr);
        for (var ii :int = 0; ii < arr.length; ii++) {
            if (predicate(arr[ii])) {
                return ii;
            }
        }
        return -1; // never found
    }

    /**
     * Returns the index of the last item in the array for which the predicate function
     * returns true, or -1 if no such item was found. The predicate function should be of type:
     *   function (element :*) :Boolean { }
     *
     * @return the zero-based index of the matching element, or -1 if none found.
     */
    public static function lastIndexIf (arr :*, predicate :Function) :int {
        requireArrayOrVector(arr);
        for (var ii :int = arr.length - 1; ii >= 0; ii--) {
            if (predicate(arr[ii])) {
                return ii;
            }
        }
        return -1; // never found
    }

    /**
     * Returns the first item in the array for which the predicate function returns true, or
     * undefined if no such item was found. The predicate function should be of type:
     *   function (element :*) :Boolean { }
     *
     * @return the matching element, or undefined if no matching element was found.
     */
    public static function findIf (arr :*, predicate :Function) :* {
        // indexIf will check arr type
        var index :int = indexIf(arr, predicate);
        return (index >= 0 ? arr[index] : undefined);
    }

    /**
     * Returns the last item in the array for which the predicate function returns true, or
     * undefined if no such item was found. The predicate function should be of type:
     *   function (element :*) :Boolean { }
     *
     * @return the matching element, or undefined if no matching element was found.
     */
    public static function findLastIf (arr :*, predicate :Function) :* {
        // lastIndexIf will check arr type
        var index :int = lastIndexIf(arr, predicate);
        return (index >= 0 ? arr[index] : undefined);
    }

    /**
     * Returns the first index of the supplied element in the array. Note that if the element
     * implements Equalable, an element that is equals() will have its index returned, instead
     * of requiring the search element to be === (strictly equal) to an element in the array
     * like Array.indexOf().
     *
     * @return the zero-based index of the matching element, or -1 if none found.
     */
    public static function indexOf (arr :*, element :Object) :int {
        requireArrayOrVector(arr);
        for (var ii :int = 0; ii < arr.length; ii++) {
            if (Util.equals(arr[ii], element)) {
                return ii;
            }
        }
        return -1; // never found
    }

    /**
     * Returns the last index of the supplied element in the array. Note that if the element
     * implements Equalable, an element that is equals() will have its index returned, instead
     * of requiring the search element to be === (strictly equal) to an element in the array
     * like Array.lastIndexOf().
     *
     * @return the zero-based index of the matching element, or -1 if none found.
     */
    public static function lastIndexOf (arr :*, element :Object) :int {
        requireArrayOrVector(arr);
        for (var ii :int = arr.length - 1; ii >= 0; ii--) {
            if (Util.equals(arr[ii], element)) {
                return ii;
            }
        }
        return -1; // never found
    }

    /**
     * @return true if the specified element, or one that is Equalable.equals() to it, is
     * contained in the array.
     */
    public static function contains (arr :*, element :Object) :Boolean {
        // indexOf will check arr type.
        return (indexOf(arr, element) != -1);
    }

    /**
     * Remove the first instance of the specified element from the array.
     *
     * @return the element that was removed, or undefined if the element was not in the array.
     */
    public static function removeFirst (arr :*, element :Object) :* {
        // removeImpl will check arr type
        return removeImpl(arr, element, true);
    }

    /**
     * Remove the last instance of the specified element from the array.
     *
     * @return the element that was removed, or undefined if the element was not in the array.
     */
    public static function removeLast (arr :*, element :Object) :* {
        requireArrayOrVector(arr);
        arr.reverse();
        var removed :* = removeFirst(arr, element);
        arr.reverse();
        return removed;
    }

    /**
     * Removes all instances of the specified element from the array.
     *
     * @return true if at least one element was removed, false otherwise.
     */
    public static function removeAll (arr :*, element :Object) :Boolean {
        // removeImpl will check arr type
        return (removeImpl(arr, element, false) !== undefined);
    }

    /**
     * Removes the first element in the array for which the specified predicate returns true.
     *
     * @param pred a Function of the form: function (element :*) :Boolean
     *
     * @return the element that was removed, or undefined if the element was not in the array.
     */
    public static function removeFirstIf (arr :*, pred :Function) :* {
        // removeIfImpl will check arr type
        return removeIfImpl(arr, pred, true);
    }

    /**
     * Removes the last element in the array for which the specified predicate returns true.
     *
     * @param pred a Function of the form: function (element :*) :Boolean
     *
     * @return the element that was removed, or undefined if the element was not in the array.
     */
    public static function removeLastIf (arr :*, pred :Function) :* {
        requireArrayOrVector(arr);
        arr.reverse();
        var removed :* = removeFirstIf(arr, pred);
        arr.reverse();
        return removed;
    }

    /**
     * Removes all elements in the array for which the specified predicate returns true.
     *
     * @param pred a Function of the form: function (element :*) :Boolean
     *
     * @return true if an element was removed, false otherwise.
     */
    public static function removeAllIf (arr :*, pred :Function) :Boolean {
        // removeIfImpl will check arr type
        return (removeIfImpl(arr, pred, false) !== undefined);
    }

    /**
     * Provides a set equal to the relative compliment of subtrahend in minuend
     * @param minuend The array you want most of
     * @param subtrahend The array you want none of
     * @return A new array, containing all of minuend, excluding subtrahend
     */
    public static function subtract (minuend :Array, subtrahend :Array) :Array {
        var list:Array = copyOf(minuend);
        for each (var obj :Object in subtrahend) {
            removeAll(list, obj);
        }
        return list;
    }

    /**
     * A splice that takes an optional Array of elements to splice in.
     * The function on Array is fairly useless unless you know exactly what you're splicing
     * in at compile time. Fucking varargs.
     */
    public static function splice (arr :Array, index :int, deleteCount :int, insertions :Array = null) :Array {
        var ii :Array = (insertions == null) ? [] : insertions.concat(); // don't modify insertions
        ii.unshift(index, deleteCount);
        return arr.splice.apply(arr, ii);
    }

    /**
     * Do the two arrays contain elements that are all equals()?
     */
    public static function equals (ar1 :*, ar2 :*) :Boolean {
        requireArrayOrVector(ar1);
        requireArrayOrVector(ar2);
        if (ar1 === ar2) {
            return true;

        } else if (ar1 == null || ar2 == null || ar1.length != ar2.length) {
            return false;
        }

        for (var jj :int = 0; jj < ar1.length; jj++) {
            if (!Util.equals(ar1[jj], ar2[jj])) {
                return false;
            }
        }
        return true;
    }

    /**
     * Copy a segment of one array to another. If the two arrays are the same reference,
     * a temporary copy may be made to safely copy the range.
     *
     * @param src the array to copy from
     * @param srcOffset the position in the source array to begin copying from
     * @param dst the array to copy into
     * @param dstOffset the position in the destition array to begin copying into
     * @param count the number of elements to copy
     */
    public static function copy (src :*, srcOffset :uint, dst :*, dstOffset :uint, count :uint) :void {
        requireArrayOrVector(src);
        requireArrayOrVector(dst);
        // see if we need to make a temporary copy
        if ((src == dst) && (srcOffset + count > dstOffset)) {
            src = src.slice(srcOffset, srcOffset + count);
            srcOffset = 0;
        }
        for (var ii :uint = 0; ii < count; ++ii) {
            dst[dstOffset++] = src[srcOffset++];
        }
    }

    /**
     * Returns an array whose nth element is an array of the nth elements of each of the passed
     * in arrays. Therefore, the length of the returned array will be the maximum of the lengths
     * of the passed in arrays and will have no undefined entries. Also, the nth element of the
     * returned array will contain undefined entries for each corresponding array whose nth
     * element was undefined.
     * @example
     * <listing version="3.0">
     *     var trans :Array = transpose([1, 2, 3], ["a", "b", "c"], ["foo", "bar", "baz"]);
     *     trace(trans[0]); // [1, "a", "foo"]
     *     trace(trans[1]); // [2, "b", "bar"]
     *     trace(trans[2]); // [3, "c", "baz"]
     * </listing>
     */
    public static function transpose (x :Array, y :Array, ...arrays) :Array {
        arrays.splice(0, 0, x, y);
        var len :int = Math.max.apply(null, arrays.map(F.adapt(function (arr :Array) :int {
            return arr.length;
        })));
        var result :Array = new Array(len);
        var tuple :Array;
        for (var ii :int = 0; ii < len; ++ii) {
            result[ii] = tuple = new Array(arrays.length);
            for (var jj :int = 0; jj < arrays.length; ++jj) {
                tuple[jj] = arrays[jj][ii]; // may be undefined, ok
            }
        }
        return result;
    }

    /**
     * Performs a binary search, attempting to locate the specified
     * object. The array must be in the sort order defined by the supplied
     * comparator function for this to operate correctly.
     *
     * @param array the array of objects to be searched.
     * @param offset the index of the first element in the array to be* considered.
     * @param length the number of elements including and following the
     * element at <code>offset</code> to consider when searching.
     * @param key the object to be located.
     * @param comp the comparison function to use when searching.
     *
     * @return the index of the object in question or
     * <code>(-(<i>insertion point</i>) - 1)</code> (always a negative
     * value) if the object was not found in the list.
     */
    public static function binarySearch (array :*, offset :int, length :int, key :*, comp :Function) :int {
        requireArrayOrVector(array);
        var low :int = offset;
        var high :int = offset + length - 1;
        while (low <= high) {
            // http://googleresearch.blogspot.com/2006/06/extra-extra-read-all-about-it-nearly.html
            var mid :int = (low + high) >>> 1;
            var midVal :* = array[mid];
            var cmp :int = comp(midVal, key);
            if (cmp < 0) {
                low = mid + 1;
            } else if (cmp > 0) {
                high = mid - 1;
            } else {
                return mid; // key found
            }
        }
        return -(low + 1); // key not found.
    }

    /**
     * Fills the array entirely with the value provided.
     */
    public static function fill (array :*, val :*) :void {
        requireArrayOrVector(array);
        for (var idx :* in array) {
            array[idx] = val;
        }
    }

    /**
     * Implementation of remove methods.
     */
    private static function removeImpl (arr :*, element :Object, firstOnly :Boolean) :* {
        // removeIfImpl will check arr type.
        return removeIfImpl(arr, Predicates.createEquals(element), firstOnly);
    }

    /**
     * Implementation of removeIf methods.
     */
    private static function removeIfImpl (arr :*, pred :Function, firstOnly :Boolean) :* {
        requireArrayOrVector(arr);
        var removed :* = undefined;
        for (var ii :int = 0; ii < arr.length; ii++) {
            var item :* = arr[ii];
            if (pred(item)) {
                arr.splice(ii--, 1);
                if (firstOnly) {
                    return item;
                }
                removed = item;
            }
        }

        return removed;
    }

    private static function requireArrayOrVector (arr :*) :void {
        if (arr["length"] === undefined) {
            throw new ArgumentError("Parameter must be an Array or Vector");
        }
    }
}
}
