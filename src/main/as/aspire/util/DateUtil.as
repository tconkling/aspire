//
// aspire

package aspire.util {

/**
 * Utility for dates.
 */
public class DateUtil
{
    /**
     * Calculates a brief, conversational representation of the given date relative to 'now':
     *
     * Date occured in a past year:
     *    10/10/1969
     * Date occured over 6 days ago:
     *    Oct 10
     * Date occured over 23 hours ago:
     *    Wed 15:10
     * Date occured in the past 23 hours:
     *   15:10
     **/
    public static function getConversationalDateString (date :Date, now :Date = null) :String {
        if (now == null) {
            now = new Date();
        }
        if (date.fullYear != now.fullYear) {
            // e.g. 25/10/06
            return date.day + "/" + date.month + "/" + date.fullYear;
        }
        var hourDiff :uint = (now.time - date.time) / (3600 * 1000);
        if (hourDiff > 6*24) {
            // e.g. Oct 25
            return getMonthName(date.month) + " " + date.day;
        }
        if (hourDiff > 23) {
            // e.g. Wed 15:10
            return getDayName(date.day) + " " + date.hours + ":" +
                   (date.minutes < 10 ? "0" : "") + date.minutes;
        }
        // e.g. 15:10
        return date.hours + ":" + (date.minutes < 10 ? "0" : "") + date.minutes;
    }

    /**
     * Return the name of the given (integer) month; 0 is January, and so on.
     */
    public static function getMonthName (month :uint, full :Boolean = false) :String {
        return full ? _months[month] : (_months[month] as String).substr(0, 3);
    }

    /**
     * Return the name of the given (integer) day; 0 is Sunday, and so on.
     */
    public static function getDayName (day :uint, full :Boolean = false) :String {
        return full ? _days[day] : (_days[day] as String).substr(0, 3);
    }

    protected static var _days :Array =
        [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ];
    protected static var _months :Array =
        [ "January", "February", "March", "April", "May", "June",
          "July", "August", "September", "October", "November", "December" ];
}
}
