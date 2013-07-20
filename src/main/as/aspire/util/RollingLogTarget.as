package aspire.util {

/**
 * A LogTarget that simply stores a configured number of logs and hands them off when requested. A
 * good way to keep around the last N logs to send along with crash/bug reports. Uses a
 * {@link RingBuffer} for log storage.
 */
public class RollingLogTarget implements LogTarget
{
    /**
     * Creates a RollingLogTarget.
     *
     * @param capacity The number of log entries to keep. Once the buffer has reached this size, the
     *               oldest entries are removed to make room for new ones.
     */
    public function RollingLogTarget (capacity :int) {
        _buffer = new RingBuffer(capacity);
    }

    public function log (msg :String) :void {
        _buffer.push(msg);
    }

    /**
     * Returns the internal buffer used to store logs. Most operations that need to access this
     * target's cached log entries will be more efficient by accessing this buffer directly.
     *
     * Modifying the buffer's capacity will overwrite this RollingLogTarget's initially configured
     * capacity.
     */
    public function get buffer () :RingBuffer {
        return _buffer;
    }

    /**
     * Returns a copy of the internal buffer. Consider accessing the buffer directly for non
     * destructive operations.
     */
    public function get logs () :Vector.<String> {
        var value :Vector.<String> = new <String>[];
        _buffer.forEach(F.argify(value.push, 1));
        return value;
    }

    protected var _buffer :RingBuffer;
}
}
