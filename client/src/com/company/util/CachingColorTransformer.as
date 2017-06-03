package com.company.util {
import flash.display.BitmapData;
import flash.filters.BitmapFilter;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.utils.Dictionary;

public class CachingColorTransformer {

      private static var bds_:Dictionary = new Dictionary();

      public function CachingColorTransformer() {
         super();
      }

      public static function transformBitmapData(param1:BitmapData, param2:ColorTransform) : BitmapData {
         var _local3:BitmapData = null;
         var _local4:Object = bds_[param1];
         if(_local4 != null) {
            _local3 = _local4[param2];
         } else {
            _local4 = new Object();
            bds_[param1] = _local4;
         }
         if(_local3 == null) {
            _local3 = param1.clone();
            _local3.colorTransform(_local3.rect,param2);
            _local4[param2] = _local3;
         }
         return _local3;
      }

      public static function filterBitmapData(param1:BitmapData, param2:BitmapFilter) : BitmapData {
         var _local3:BitmapData = null;
         var _local4:Object = bds_[param1];
         if(_local4 != null) {
            _local3 = _local4[param2];
         } else {
            _local4 = new Object();
            bds_[param1] = _local4;
         }
         if(_local3 == null) {
            _local3 = param1.clone();
            _local3.applyFilter(_local3,_local3.rect,new Point(),param2);
            _local4[param2] = _local3;
         }
         return _local3;
      }

      public static function alphaBitmapData(param1:BitmapData, param2:Number) : BitmapData {
         var _local3:int = int(param2 * 100);
         var _local4:ColorTransform = new ColorTransform(1,1,1,_local3 / 100);
         return transformBitmapData(param1,_local4);
      }

      public static function clear() : void {
         var _local1:Object = null;
         var _local2:BitmapData = null;
         for each(_local1 in bds_) {
            for each(_local2 in _local1) {
               _local2.dispose();
            }
         }
         bds_ = new Dictionary();
      }
   }
}
