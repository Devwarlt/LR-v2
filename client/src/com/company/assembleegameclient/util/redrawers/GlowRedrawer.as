package com.company.assembleegameclient.util.redrawers {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.PointUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.display.GradientType;
import flash.display.Shape;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.utils.Dictionary;

public class GlowRedrawer {

    private static const GRADIENT_MAX_SUB:uint = 2631720;

    private static const GLOW_FILTER:GlowFilter = new GlowFilter(0, 0.3, 12, 12, 2, BitmapFilterQuality.LOW, false, false);

    private static const GLOW_FILTER_ALT:GlowFilter = new GlowFilter(0, 0.5, 16, 16, 3, BitmapFilterQuality.LOW, false, false);

    private static var tempMatrix_:Matrix = new Matrix();

    private static var gradient_:Shape = getGradient();

    private static var glowHashes:Dictionary = new Dictionary();

    public function GlowRedrawer() {
        super();
    }

    public static function outlineGlow(param1:BitmapData, param2:uint, param3:Number = 1.4, param4:Boolean = false):BitmapData {
        var _local5:String = getHash(param2, param3);
        if (Boolean(param4) && Boolean(isCached(param1, _local5))) {
            return glowHashes[param1][_local5];
        }
        var _local6:BitmapData = param1.clone();
        tempMatrix_.identity();
        tempMatrix_.scale(param1.width / 256, param1.height / 256);
        _local6.draw(gradient_, tempMatrix_, null, BlendMode.SUBTRACT);
        var _local7:Bitmap = new Bitmap(param1);
        _local6.draw(_local7, null, null, BlendMode.ALPHA);
        TextureRedrawer.OUTLINE_FILTER.blurX = param3;
        TextureRedrawer.OUTLINE_FILTER.blurY = param3;
        var _local8:uint = 0;
        TextureRedrawer.OUTLINE_FILTER.color = _local8;
        if (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.outline)
            _local6.applyFilter(_local6, _local6.rect, PointUtil.ORIGIN, TextureRedrawer.OUTLINE_FILTER);
        if (param2 != 4294967295) {
            if (Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) && param2 != 0) {
                GLOW_FILTER_ALT.color = param2;
                _local6.applyFilter(_local6, _local6.rect, PointUtil.ORIGIN, GLOW_FILTER_ALT);
            } else {
                GLOW_FILTER.color = param2;
                _local6.applyFilter(_local6, _local6.rect, PointUtil.ORIGIN, GLOW_FILTER);
            }
        }
        if (param4) {
            cache(param1, param2, param3, _local6);
        }
        return _local6;
    }

    private static function cache(param1:BitmapData, param2:uint, param3:Number, param4:BitmapData):void {
        var _local6:Object = null;
        var _local5:String = getHash(param2, param3);
        if (param1 in glowHashes) {
            glowHashes[param1][_local5] = param4;
        } else {
            _local6 = {};
            _local6[_local5] = param4;
            glowHashes[param1] = _local6;
        }
    }

    private static function isCached(param1:BitmapData, param2:String):Boolean {
        var _local3:Object = null;
        if (param1 in glowHashes) {
            _local3 = glowHashes[param1];
            if (param2 in _local3) {
                return true;
            }
        }
        return false;
    }

    private static function getHash(param1:uint, param2:Number):String {
        return int(param2 * 10).toString() + param1;
    }

    private static function getGradient():Shape {
        var _local1:Shape = new Shape();
        var _local2:Matrix = new Matrix();
        _local2.createGradientBox(256, 256, Math.PI / 2, 0, 0);
        _local1.graphics.beginGradientFill(GradientType.LINEAR, [0, GRADIENT_MAX_SUB], [1, 1], [127, 255], _local2);
        _local1.graphics.drawRect(0, 0, 256, 256);
        _local1.graphics.endFill();
        return _local1;
    }
}
}
