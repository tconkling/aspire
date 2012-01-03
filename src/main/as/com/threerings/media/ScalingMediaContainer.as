//
// aspirin library - Taking some of the pain out of Actionscript development.
// Copyright (C) 2007-2012 Three Rings Design, Inc., All Rights Reserved
// http://github.com/threerings/aspirin
//
// This library is free software; you can redistribute it and/or modify it
// under the terms of the GNU Lesser General Public License as published
// by the Free Software Foundation; either version 2.1 of the License, or
// (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package com.threerings.media {

import com.threerings.media.MediaContainer;

public class ScalingMediaContainer extends MediaContainer
{
    /** Publicly available, but do not change. */
    public var maxW :int;
    public var maxH :int;

    /**
     * @param center if true, the actual media will be centered within the maximum size if
     * it is smaller in either dimension.
     */
    public function ScalingMediaContainer (maxWidth :int, maxHeight :int, center :Boolean = true)
    {
        if (maxWidth == 0 || maxHeight == 0) {
            throw new Error("Requested scaling media container with invalid dimensions " +
                            maxWidth + "x" + maxHeight);
        }
        maxW = maxWidth;
        maxH = maxHeight;
        _center = center;
    }

    override public function getMediaScaleX () :Number
    {
        return _mediaScale;
    }

    override public function getMediaScaleY () :Number
    {
        return _mediaScale;
    }

    override protected function contentDimensionsUpdated () :void
    {
        super.contentDimensionsUpdated();

        _mediaScale = Math.min(1, Math.min(maxW / _w, maxH / _h));
        _media.scaleX = _mediaScale;
        _media.scaleY = _mediaScale;

        if (_center) {
            _media.x = (maxW - (_w * _mediaScale)) / 2;
            _media.y = (maxH - (_h * _mediaScale)) / 2;
        }
    }

    protected var _mediaScale :Number = 1;
    protected var _center :Boolean;
}
}
