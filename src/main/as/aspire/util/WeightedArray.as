//
// aspire

package aspire.util {

public class WeightedArray
{
    public function clear () :void {
        _data.length = 0;
        _dataDirty = true;
    }

    public function push (data :Object, weight :Number) :void {
        if (weight <= 0) {
            throw new ArgumentError("weight must be > 0");
        }

        _data.push(new WeightedData(data, weight));
        _dataDirty = true;
    }

    public function pick (rands :Randoms) :* {
        updateData();

        if (_data.length == 0) {
            return undefined;
        }

        var max :Number = _data[_data.length - 1].max;
        var val :Number = rands.getNumber(max);

        // binary-search the set of WeightedData
        var loIdx :int = 0;
        var hiIdx :int = _data.length - 1;
        for (;;) {
            if (loIdx > hiIdx) {
                // something's broken
                break;
            }

            var idx :int = loIdx + ((hiIdx - loIdx) * 0.5);
            var wd :WeightedData = _data[idx];
            if (val < wd.min) {
                // too high
                hiIdx = idx - 1;
            } else if (val >= wd.max) {
                // too low
                loIdx = idx + 1;
            } else {
                // hit!
                return wd.data;
            }
        }

        // How did we get here?
        return undefined;
    }

    /** @return an Array view of all of the data in this WeightedArray. */
    public function getAll () :Array {
        var out :Array = [];
        for each (var wd :WeightedData in _data) {
            out.push(wd);
        }
        return out;
    }

    /**
     * The function argument should have the following signature:
     * function (item :*, relativeChance :Number) :void.
     * It will be called once per item in the array.
     */
    public function forEach (callback :Function) :void {
        _data.forEach(function (wd :WeightedData, ...ignored) :void {
            callback(wd.data, wd.weight);
        });
    }

    /**
     * @return the percentage chance - a value in [0, 1] - that the given data will be returned
     * from a call to getNextData(), given the relative chance of all other data in the array.
     */
    public function getAbsoluteChance (data :Object) :Number {
        updateData();

        if (_data.length == 0) {
            return 0;
        }

        var max :Number = _data[_data.length - 1].max;
        var dataChance :Number = 0;
        forEach(function (thisData :Object, relativeChance :Number) :void {
            if (thisData === data) {
                dataChance += relativeChance;
            }
        });

        return dataChance / max;
    }

    public function get length () :int {
        return _data.length;
    }

    protected function updateData () :void {
        if (_dataDirty) {
            var totalVal :Number = 0;
            for each (var wd :WeightedData in _data) {
                wd.min = totalVal;
                totalVal += wd.weight;
            }

            _dataDirty = false;
        }
    }

    protected var _dataDirty :Boolean;
    protected var _data :Vector.<WeightedData> = new <WeightedData>[];
}

}

class WeightedData
{
    public var data :*;
    public var weight :Number;
    public var min :Number;

    public function get max () :Number {
        return min + weight;
    }

    public function WeightedData (data :*, weight :Number) {
        this.data = data;
        this.weight = weight;
    }
}
