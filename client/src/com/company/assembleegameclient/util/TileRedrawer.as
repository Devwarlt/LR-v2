package com.company.assembleegameclient.util {
import com.company.assembleegameclient.map.LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5;
import com.company.assembleegameclient.map.LOEBUILD_a8ee717b4dbde6fa2f5932b7421c41aa;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;
import com.company.util.ImageSet;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;

public class TileRedrawer {

      private static const rect0:Rectangle = new Rectangle(0,0,4,4);

      private static const p0:Point = new Point(0,0);

      private static const rect1:Rectangle = new Rectangle(4,0,4,4);

      private static const p1:Point = new Point(4,0);

      private static const rect2:Rectangle = new Rectangle(0,4,4,4);

      private static const p2:Point = new Point(0,4);

      private static const rect3:Rectangle = new Rectangle(4,4,4,4);

      private static const p3:Point = new Point(4,4);

      private static const INNER:int = 0;

      private static const SIDE0:int = 1;

      private static const SIDE1:int = 2;

      private static const OUTER:int = 3;

      private static const INNERP1:int = 4;

      private static const INNERP2:int = 5;

      private static const mlist_:Vector.<Vector.<ImageSet>> = getMasks();

      private static var cache_:Vector.<Object> = new <Object>[null,new Object()];

      private static const RECT01:Rectangle = new Rectangle(0,0,8,4);

      private static const RECT13:Rectangle = new Rectangle(4,0,4,8);

      private static const RECT23:Rectangle = new Rectangle(0,4,8,4);

      private static const RECT02:Rectangle = new Rectangle(0,0,4,8);

      private static const RECT0:Rectangle = new Rectangle(0,0,4,4);

      private static const RECT1:Rectangle = new Rectangle(4,0,4,4);

      private static const RECT2:Rectangle = new Rectangle(0,4,4,4);

      private static const RECT3:Rectangle = new Rectangle(4,4,4,4);

      private static const POINT0:Point = new Point(0,0);

      private static const POINT1:Point = new Point(4,0);

      private static const POINT2:Point = new Point(0,4);

      private static const POINT3:Point = new Point(4,4);

      public function TileRedrawer() {
         super();
      }

      public static function redraw(param1:Square, param2:Boolean) : BitmapData {
         var _local3:ByteArray = null;
         var _local5:BitmapData = null;
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.blendType_ == 0) {
            return null;
         }
         if(param1.tileType_ == 253) {
            _local3 = getCompositeSig(param1);
         } else if(param1.props_.hasEdge_) {
            _local3 = getEdgeSig(param1);
         } else {
            _local3 = getSig(param1);
         }
         if(_local3 == null) {
            return null;
         }
         var _local4:Object = cache_[LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.blendType_];
         if(_local4.hasOwnProperty(String(_local3))) {
            return _local4[_local3];
         }
         if(param1.tileType_ == 253) {
            _local5 = buildComposite(_local3);
            _local4[_local3] = _local5;
            return _local5;
         }
         if(param1.props_.hasEdge_) {
            _local5 = drawEdges(_local3);
            _local4[_local3] = _local5;
            return _local5;
         }
         var _local6:Boolean = false;
         var _local7:Boolean = false;
         var _local8:Boolean = false;
         var _local9:Boolean = false;
         if(_local3[1] != _local3[4]) {
            _local6 = true;
            _local7 = true;
         }
         if(_local3[3] != _local3[4]) {
            _local6 = true;
            _local8 = true;
         }
         if(_local3[5] != _local3[4]) {
            _local7 = true;
            _local9 = true;
         }
         if(_local3[7] != _local3[4]) {
            _local8 = true;
            _local9 = true;
         }
         if(!_local6 && _local3[0] != _local3[4]) {
            _local6 = true;
         }
         if(!_local7 && _local3[2] != _local3[4]) {
            _local7 = true;
         }
         if(!_local8 && _local3[6] != _local3[4]) {
            _local8 = true;
         }
         if(!_local9 && _local3[8] != _local3[4]) {
            _local9 = true;
         }
         if(!_local6 && !_local7 && !_local8 && !_local9) {
            _local4[_local3] = null;
            return null;
         }
         var _local10:BitmapData = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param1.tileType_);
         if(param2) {
            _local5 = _local10.clone();
         } else {
            _local5 = new BitmapDataSpy(_local10.width,_local10.height,true,0);
         }
         if(_local6) {
            redrawRect(_local5,rect0,p0,mlist_[0],_local3[4],_local3[3],_local3[0],_local3[1]);
         }
         if(_local7) {
            redrawRect(_local5,rect1,p1,mlist_[1],_local3[4],_local3[1],_local3[2],_local3[5]);
         }
         if(_local8) {
            redrawRect(_local5,rect2,p2,mlist_[2],_local3[4],_local3[7],_local3[6],_local3[3]);
         }
         if(_local9) {
            redrawRect(_local5,rect3,p3,mlist_[3],_local3[4],_local3[5],_local3[8],_local3[7]);
         }
         _local4[_local3] = _local5;
         return _local5;
      }

      private static function redrawRect(param1:BitmapData, param2:Rectangle, param3:Point, param4:Vector.<ImageSet>, param5:uint, param6:uint, param7:uint, param8:uint) : void {
         var _local9:BitmapData = null;
         var _local10:BitmapData = null;
         if(param5 == param6 && param5 == param8) {
            _local10 = param4[OUTER].random();
            _local9 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param7);
         } else if(param5 != param6 && param5 != param8) {
            if(param6 != param8) {
               param1.copyPixels(LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param6),param2,param3,param4[INNERP1].random(),p0,true);
               param1.copyPixels(LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param8),param2,param3,param4[INNERP2].random(),p0,true);
               return;
            }
            _local10 = param4[INNER].random();
            _local9 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param6);
         } else if(param5 != param6) {
            _local10 = param4[SIDE0].random();
            _local9 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param6);
         } else {
            _local10 = param4[SIDE1].random();
            _local9 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param8);
         }
         param1.copyPixels(_local9,param2,param3,_local10,p0,true);
      }

      private static function getSig(param1:Square) : ByteArray {
         var _local6:int = 0;
         var _local7:Square = null;
         var _local2:ByteArray = new ByteArray();
         var _local3:Map = param1.map_;
         var _local4:uint = param1.tileType_;
         var _local5:int = param1.y_ - 1;
         while(_local5 <= param1.y_ + 1) {
            _local6 = param1.x_ - 1;
            while(_local6 <= param1.x_ + 1) {
               if(_local6 < 0 || _local6 >= _local3.width_ || _local5 < 0 || _local5 >= _local3.height_ || _local6 == param1.x_ && _local5 == param1.y_) {
                  _local2.writeByte(_local4);
               } else {
                  _local7 = _local3.squares_[_local6 + _local5 * _local3.width_];
                  if(_local7 == null || _local7.props_.blendPriority_ <= param1.props_.blendPriority_) {
                     _local2.writeByte(_local4);
                  } else {
                     _local2.writeByte(_local7.tileType_);
                  }
               }
               _local6++;
            }
            _local5++;
         }
         return _local2;
      }

      private static function getMasks() : Vector.<Vector.<ImageSet>> {
         var _local1:Vector.<Vector.<ImageSet>> = new Vector.<Vector.<ImageSet>>();
         addMasks(_local1,AssetLibrary.getImageSet("inner_mask"),AssetLibrary.getImageSet("sides_mask"),AssetLibrary.getImageSet("outer_mask"),AssetLibrary.getImageSet("innerP1_mask"),AssetLibrary.getImageSet("innerP2_mask"));
         return _local1;
      }

      private static function addMasks(param1:Vector.<Vector.<ImageSet>>, param2:ImageSet, param3:ImageSet, param4:ImageSet, param5:ImageSet, param6:ImageSet) : void {
         var _local7:int = 0;
         for each(_local7 in [-1,0,2,1]) {
            param1.push(new <ImageSet>[rotateImageSet(param2,_local7),rotateImageSet(param3,_local7 - 1),rotateImageSet(param3,_local7),rotateImageSet(param4,_local7),rotateImageSet(param5,_local7),rotateImageSet(param6,_local7)]);
         }
      }

      private static function rotateImageSet(param1:ImageSet, param2:int) : ImageSet {
         var _local4:BitmapData = null;
         var _local3:ImageSet = new ImageSet();
         for each(_local4 in param1.images_) {
            _local3.add(BitmapUtil.rotateBitmapData(_local4,param2));
         }
         return _local3;
      }

      private static function getCompositeSig(param1:Square) : ByteArray {
         var _local14:Square = null;
         var _local15:Square = null;
         var _local16:Square = null;
         var _local17:Square = null;
         var _local2:ByteArray = new ByteArray();
         _local2.length = 4;
         var _local3:Map = param1.map_;
         var _local4:int = param1.x_;
         var _local5:int = param1.y_;
         var _local6:Square = _local3.lookupSquare(_local4,_local5 - 1);
         var _local7:Square = _local3.lookupSquare(_local4 - 1,_local5);
         var _local8:Square = _local3.lookupSquare(_local4 + 1,_local5);
         var _local9:Square = _local3.lookupSquare(_local4,_local5 + 1);
         var _local10:int = _local6 != null?int(_local6.props_.compositePriority_):-1;
         var _local11:int = _local7 != null?int(_local7.props_.compositePriority_):-1;
         var _local12:int = _local8 != null?int(_local8.props_.compositePriority_):-1;
         var _local13:int = _local9 != null?int(_local9.props_.compositePriority_):-1;
         if(_local10 < 0 && _local11 < 0) {
            _local14 = _local3.lookupSquare(_local4 - 1,_local5 - 1);
            _local2[0] = _local14 == null || _local14.props_.compositePriority_ < 0?255:_local14.tileType_;
         } else if(_local10 < _local11) {
            _local2[0] = _local7.tileType_;
         } else {
            _local2[0] = _local6.tileType_;
         }
         if(_local10 < 0 && _local12 < 0) {
            _local15 = _local3.lookupSquare(_local4 + 1,_local5 - 1);
            _local2[1] = _local15 == null || _local15.props_.compositePriority_ < 0?255:_local15.tileType_;
         } else if(_local10 < _local12) {
            _local2[1] = _local8.tileType_;
         } else {
            _local2[1] = _local6.tileType_;
         }
         if(_local11 < 0 && _local13 < 0) {
            _local16 = _local3.lookupSquare(_local4 - 1,_local5 + 1);
            _local2[2] = _local16 == null || _local16.props_.compositePriority_ < 0?255:_local16.tileType_;
         } else if(_local11 < _local13) {
            _local2[2] = _local9.tileType_;
         } else {
            _local2[2] = _local7.tileType_;
         }
         if(_local12 < 0 && _local13 < 0) {
            _local17 = _local3.lookupSquare(_local4 + 1,_local5 + 1);
            _local2[3] = _local17 == null || _local17.props_.compositePriority_ < 0?255:_local17.tileType_;
         } else if(_local12 < _local13) {
            _local2[3] = _local9.tileType_;
         } else {
            _local2[3] = _local8.tileType_;
         }
         return _local2;
      }

      private static function buildComposite(param1:ByteArray) : BitmapData {
         var _local3:BitmapData = null;
         var _local2:BitmapData = new BitmapDataSpy(8,8,false,0);
         if(param1[0] != 255) {
            _local3 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param1[0]);
            _local2.copyPixels(_local3,RECT0,POINT0);
         }
         if(param1[1] != 255) {
            _local3 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param1[1]);
            _local2.copyPixels(_local3,RECT1,POINT1);
         }
         if(param1[2] != 255) {
            _local3 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param1[2]);
            _local2.copyPixels(_local3,RECT2,POINT2);
         }
         if(param1[3] != 255) {
            _local3 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param1[3]);
            _local2.copyPixels(_local3,RECT3,POINT3);
         }
         return _local2;
      }

      private static function getEdgeSig(param1:Square) : ByteArray {
         var _local7:int = 0;
         var _local8:Square = null;
         var _local9:Boolean = false;
         var _local2:ByteArray = new ByteArray();
         var _local3:Map = param1.map_;
         var _local4:Boolean = false;
         var _local5:Boolean = param1.props_.sameTypeEdgeMode_;
         var _local6:int = param1.y_ - 1;
         while(_local6 <= param1.y_ + 1) {
            _local7 = param1.x_ - 1;
            while(_local7 <= param1.x_ + 1) {
               _local8 = _local3.lookupSquare(_local7,_local6);
               if(_local7 == param1.x_ && _local6 == param1.y_) {
                  _local2.writeByte(_local8.tileType_);
               } else {
                  if(_local5) {
                     _local9 = _local8 == null || _local8.tileType_ == param1.tileType_;
                  } else {
                     _local9 = _local8 == null || _local8.tileType_ != 255;
                  }
                  _local2.writeBoolean(_local9);
                  _local4 = Boolean(_local4) || !_local9;
               }
               _local7++;
            }
            _local6++;
         }
         return !!_local4?_local2:null;
      }

      private static function drawEdges(param1:ByteArray) : BitmapData {
         var _local2:BitmapData = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getBitmapData(param1[4]);
         var _local3:BitmapData = _local2.clone();
         var _local4:LOEBUILD_a8ee717b4dbde6fa2f5932b7421c41aa = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.propsLibrary_[param1[4]];
         var _local5:Vector.<BitmapData> = _local4.getEdges();
         var _local6:Vector.<BitmapData> = _local4.getInnerCorners();
         var _local7:int = 1;
         while(_local7 < 8) {
            if(!param1[_local7]) {
               _local3.copyPixels(_local5[_local7],_local5[_local7].rect,PointUtil.ORIGIN,null,null,true);
            }
            _local7 = _local7 + 2;
         }
         if(_local5[0] != null) {
            if(Boolean(param1[3]) && Boolean(param1[1]) && !param1[0]) {
               _local3.copyPixels(_local5[0],_local5[0].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(Boolean(param1[1]) && Boolean(param1[5]) && !param1[2]) {
               _local3.copyPixels(_local5[2],_local5[2].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(Boolean(param1[5]) && Boolean(param1[7]) && !param1[8]) {
               _local3.copyPixels(_local5[8],_local5[8].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(Boolean(param1[3]) && Boolean(param1[7]) && !param1[6]) {
               _local3.copyPixels(_local5[6],_local5[6].rect,PointUtil.ORIGIN,null,null,true);
            }
         }
         if(_local6 != null) {
            if(!param1[3] && !param1[1]) {
               _local3.copyPixels(_local6[0],_local6[0].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(!param1[1] && !param1[5]) {
               _local3.copyPixels(_local6[2],_local6[2].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(!param1[5] && !param1[7]) {
               _local3.copyPixels(_local6[8],_local6[8].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(!param1[3] && !param1[7]) {
               _local3.copyPixels(_local6[6],_local6[6].rect,PointUtil.ORIGIN,null,null,true);
            }
         }
         return _local3;
      }
   }
}
