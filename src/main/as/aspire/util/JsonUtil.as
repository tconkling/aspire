//
// aspire

package aspire.util {

public class JsonUtil
{
    public static function get (o :Object, name :String, type :Class, defaultVal :Object) :* {
        return getField(o, name, type, defaultVal);
    }

    public static function require (o :Object, name :String, type :Class) :* {
        return getField(o, name, type, undefined);
    }

    protected static function getField (o :Object, name :String, type :Class, defaultVal :*) :* {
        const result :* = o[name];
        if (result === undefined) {
            if (defaultVal !== undefined) {
                return defaultVal;
            } else {
                throw new Error(Joiner.pairs("Required field not present", "name", name,
                    "json", JSON.stringify(o)));
            }
        } else if (!(result is type)) {
            throw new Error(Joiner.pairs("Field is the wrong type", "name", name,
                "requiredType", type, "actualType", ClassUtil.tinyClassName(result),
                "json", JSON.stringify(o)));
        }
        return result;
    }
}
}
