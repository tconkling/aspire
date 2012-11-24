//
// aspire

package aspire.util {

import flash.net.URLRequest;

public class NetUtil
{
    /**
     * Convenience method to load a web page in the browser window without
     * having to worry about SecurityErrors in various conditions.
     *
     * @param url a String or a URLRequest.
     * @param preferredWindow the browser tab/window identifier in which to load. If you
     * specify a non-null window and it causes a security error, the request is retried with null.
     *
     * @return true if the url was able to be loaded.
     */
    public static function navigateToURL (url :*, preferredWindow :String = "_self") :Boolean
    {
        var ureq :URLRequest = (url is URLRequest) ? URLRequest(url) : new URLRequest(String(url));
        while (true) {
            try {
                flash.net.navigateToURL(ureq, preferredWindow);
                return true;
            } catch (e :SecurityError) {
                if (preferredWindow != null) {
                    preferredWindow = null; // try again with no preferred window

                } else {
                    Log.getLog(NetUtil).warning("Unable to navigate to URL", "e", e);
                    break;
                }
            }
        }

        return false; // failure!
    }
}
}
