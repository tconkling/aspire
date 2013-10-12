//
// aspire

package aspire.error {

import aspire.util.Joiner;
import aspire.util.XmlUtil;

public class XmlReadError extends ChainableError
{
    /**
     * Creates a new XmlReadError
     *
     * @param args a list of argument pairs that will be included in the error string, in
     * the form: message [arg0=arg1, arg2=arg3 ... ]. If the last argument is an un-paired XML
     * (that is, if the args list has an odd number of elements, and the last element is an XML),
     * its XML content will be included in a new line, below the rest of the message content.
     */
    public function XmlReadError (message :String, ...args) {
        super(getErrString(message, args));
    }

    protected static function getErrString (message :String, args :Array) :String {
        // if the last arg is an XML, pull it out
        var badXml :XML;
        if (args.length % 2 != 0 && args[args.length - 1] is XML) {
            badXml = args.pop();
        }
        var errString :String = Joiner.pairsArray(message, args);
        if (badXml != null) {
            errString += "\n" + XmlUtil.toXMLString(badXml);
        }

        return errString;
    }
}

}
