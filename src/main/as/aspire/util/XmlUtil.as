//
// aspire

package aspire.util {
import aspire.error.XmlReadError;

public class XmlUtil
{
    /**
     * Parse the 'value' object into XML safely. This is equivalent to <code>new XML(value)</code>
     * but offers protection from other code that may have changing the default settings
     * used for parsing XML. Also, if you would like to use non-standard parsing settings
     * this method will protect other code from being broken by you.
     *
     * @param value the value to parse into XML.
     * @param settings an Object containing your desired XML settings, or null (or omitted) to
     * use the default settings.
     * @see XML#setSettings()
     */
    public static function newXML (value :Object, settings :Object = null) :XML {
        return safeOp(function () :* {
            return new XML(value);
        }, settings) as XML;
    }

    /**
     * Call toString() on the specified XML object safely. This is equivalent to
     * <code>xml.toString()</code> but offers protection from other code that may have changed
     * the default settings used for stringing XML. Also, if you would like to use the
     * non-standard printing settings this method will protect other code from being
     * broken by you.
     *
     * @param xml the xml value to Stringify.
     * @param settings an Object containing your desired XML settings, or null (or omitted) to
     * use the default settings.
     * @see XML#toString()
     * @see XML#setSettings()
     */
    public static function toString (xml :XML, settings :Object = null) :String {
        return safeOp(function () :* {
            return xml.toString();
        }, settings) as String;
    }

    /**
     * Call toXMLString() on the specified XML object safely. This is equivalent to
     * <code>xml.toXMLString()</code> but offers protection from other code that may have changed
     * the default settings used for stringing XML. Also, if you would like to use the
     * non-standard printing settings this method will protect other code from being
     * broken by you.
     *
     * @param xml the xml value to Stringify.
     * @param settings an Object containing your desired XML settings, or null (or omitted) to
     * use the default settings.
     * @see XML#toXMLString()
     * @see XML#setSettings()
     */
    public static function toXMLString (xml :XML, settings :Object = null) :String {
        return safeOp(function () :* {
            return xml.toXMLString();
        }, settings) as String;
    }

    /**
     * Perform an operation on XML that takes place using the specified settings, and
     * restores the XML settings to their previous values.
     *
     * @param fn a function to be called with no arguments.
     * @param settings an Object containing your desired XML settings, or null (or omitted) to
     * use the default settings.
     *
     * @return the return value of your function, if any.
     * @see XML#setSettings()
     * @see XML#settings()
     */
    public static function safeOp (fn :Function, settings :Object = null) :* {
        var oldSettings :Object = XML.settings();
        try {
            XML.setSettings(settings); // setting to null resets to all the defaults
            return fn();
        } finally {
            XML.setSettings(oldSettings);
        }
    }

    public static function hasChild (xml :XML, name :String) :Boolean {
        return xml.child(name).length() > 0;
    }

    public static function getSingleChild (xml :XML, name :String = "*",
        defaultValue :* = undefined) :XML {
        var children :XMLList = xml.elements(name);
        if (children.length() == 0 && undefined !== defaultValue) {
            return defaultValue;
        } else if (children.length() != 1) {
            throw new XmlReadError("There must be exactly 1 " +
                (name == "*" ? "" : "'" + name + "' ") +
                "child (found " + children.length() + ")",
                xml);
        }

        return children[0];
    }

    public static function map (xs :XMLList, f :Function) :Array {
        const result :Array = [];
        for each (var node :XML in xs) {
            result.push(f(node));
        }
        return result;
    }

    public static function hasAttr (xml :XML, name :String) :Boolean {
        return (null != xml.attribute(name)[0]);
    }

    public static function getUintAttr (xml :XML, name :String, defaultValue :* = undefined) :uint {
        return getAttr(xml, name, defaultValue, StringUtil.parseUnsignedInteger);
    }

    public static function getIntAttr (xml :XML, name :String, defaultValue :* = undefined) :int {
        return getAttr(xml, name, defaultValue, StringUtil.parseInteger);
    }

    public static function getNumberAttr (xml :XML, name :String,
        defaultValue :* = undefined) :Number {
        return getAttr(xml, name, defaultValue, StringUtil.parseNumber);
    }

    public static function getBooleanAttr (xml :XML, name :String,
        defaultValue :* = undefined) :Boolean {
        return getAttr(xml, name, defaultValue, StringUtil.parseBoolean);
    }

    public static function getStringAttr (xml :XML, name :String,
        defaultValue :* = undefined) :String {
        return getAttr(xml, name, defaultValue);
    }

    public static function getEnumAttr (
        xml :XML, name :String, enumClazz :Class, defaultValue :* = undefined) :* {
        return getAttr(xml, name, defaultValue,
            function (value :String) :Enum {
                return Enum.valueOf(enumClazz, value);
            });
    }

    /**
     * Parses a string in the form "FOO,BAR,MONKEY" into a Set of Enums
     */
    public static function getEnumSetAttr (xml :XML, name :String, enumType :Class,
        defaultValue :* = undefined) :Set {
        return getAttr(xml, name, defaultValue, function (value :String) :Set {
            return parseEnumSet(value, enumType);
        });
    }

    /**
     * Parses a string in the form "FOO,BAR,MONKEY" into an Array of Enums
     */
    public static function getEnumArrayAttr (xml :XML, name :String, enumType :Class,
        defaultValue :* = undefined) :Array {
        return getAttr(xml, name, defaultValue, function (value :String) :Array {
            return parseEnumArray(value, enumType);
        });
    }

    public static function getAttr (xml :XML, name :String, defaultValue :*,
        parseFunction :Function = null) :* {
        var value :*;

        // read the attribute; throw an error if it doesn't exist (unless we have a default value)
        var attr :XML = xml.attribute(name)[0];
        if (null == attr) {
            if (undefined !== defaultValue) {
                return defaultValue;
            } else {
                throw new XmlReadError(
                    "error reading attribute '" + name + "': attribute does not exist",
                    xml);
            }
        }

        // try to parse the attribute
        try {
            value = (null != parseFunction ? parseFunction(attr) : attr);
        } catch (e :ArgumentError) {
            throw new XmlReadError("error reading attribute '" + name + "'", xml).initCause(e);
        }

        return value;
    }

    /**
     * Returns the concatenation of all text children of the given node.
     * E.g.:
     * getText(<text/>) -> ""
     * getText(<text>some text</text>) -> "some text"
     * getText(<text>some <asdf/>more<asdf/> text</text>) -> "some more text"
     */
    public static function getText (xml :XML) :String {
        var text :String = "";
        for each (var textNode :XML in xml.text()) {
            text += textNode.toString();
        }
        return text;
    }

    /**
     * Returns the text content of the first child with the given name
     */
    public static function getSingleChildText (
        xml :XML, childName :String, defaultValue :* = undefined) :String
    {
        if (!hasChild(xml, childName) && defaultValue !== undefined) {
            return defaultValue;
        }
        return getText(getSingleChild(xml, childName));
    }

    /**
     * Parses a string in the form "FOO,BAR,MONKEY" into a Set of Enums
     */
    public static function parseEnumSet (value :String, enumType :Class) :Set {
        return Sets.newSetOf(enumType, parseEnumArray(value, enumType));
    }

    /**
     * Parses a string in the form "FOO,BAR,MONKEY" into a Set of Enums
     */
    public static function parseEnumArray (value :String, enumType :Class) :Array {
        var values :Array = [];

        // Since enums can't have 0-length enum names, an empty string means an empty array.
        if (value.length == 0) {
            return values;
        }

        for each (var enumName :String in value.split(",")) {
            values.push(Enum.valueOf(enumType, enumName));
        }
        return values;
    }
}
}
