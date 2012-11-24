//
// aspire

package aspire.util {

/**
 * Utility methods relating to the electronic mails.
 */
public class MailUtil
{
    /**
     * Returns true if the supplied email address appears valid (according to a widely used regular
     * expression). False if it does not.
     */
    public static function isValidAddress (email :String) :Boolean
    {
        var matches :Array = email.match(EMAIL_REGEX);
        // in theory there should only be one match and we should check for 'matches.length == 1',
        // but Flash's regular expression code likes to return nonsensical things, so we just check
        // that the first match is equal to the entire supplied address
        return (matches != null && matches.length > 0) && ((matches[0] as String) == email);
    }

    /** Originally formulated by lambert@nas.nasa.gov. */
    protected static const EMAIL_REGEX :RegExp = new RegExp(
        "^([-a-z0-9_.!%+]+@[-a-z0-9]+(\\.[-a-z0-9]+)*\\.[-a-z0-9]+)$", "i");
}
}
