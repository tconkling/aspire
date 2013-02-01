//
// aspire

package aspire.util {

import aspire.util.lists.ArrayList;

/**
 * Factory methods for creating Lists.
 */
public class Lists
{
    /**
     * Create a new List.
     */
    public static function newList () :List {
        return new ArrayList();
    }
}
}
