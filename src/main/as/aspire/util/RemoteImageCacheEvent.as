//
// aspire

package aspire.util {

import flash.events.Event;

public class RemoteImageCacheEvent extends Event
{
    public static const LOAD_SUCCESS :String = "LoadSuccess";
    public static const LOAD_ERROR :String = "LoadError";

    public var url :String;

    public function RemoteImageCacheEvent (type :String, url :String)
    {
        super(type);
        this.url = url;
    }

    override public function clone () :Event
    {
        return new RemoteImageCacheEvent(type, url);
    }
}
}
