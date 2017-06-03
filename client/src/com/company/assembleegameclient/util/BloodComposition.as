package com.company.assembleegameclient.util {
import flash.display.BitmapData;
import flash.utils.Dictionary;

public class BloodComposition {

      private static var idDict_:Dictionary = new Dictionary();

      private static var imageDict_:Dictionary = new Dictionary();

      public function BloodComposition() {
         super();
      }

      public static function getBloodComposition(param1:int, param2:BitmapData, param3:Number, param4:uint) : Vector.<uint> {
         var _local5:Vector.<uint> = idDict_[param1];
         if(_local5 != null) {
            return _local5;
         }
         _local5 = new Vector.<uint>();
         var _local6:Vector.<uint> = getColors(param2);
         var _local7:int = 0;
         while(_local7 < _local6.length) {
            if(Math.random() < param3) {
               _local5.push(param4);
            } else {
               _local5.push(_local6[int(_local6.length * Math.random())]);
            }
            _local7++;
         }
         return _local5;
      }

      public static function getColors(param1:BitmapData) : Vector.<uint> {
         var _local2:Vector.<uint> = imageDict_[param1];
         if(_local2 == null) {
            _local2 = buildColors(param1);
            imageDict_[param1] = _local2;
         }
         return _local2;
      }

      private static function buildColors(param1:BitmapData) : Vector.<uint> {
         var _local4:int = 0;
         var _local5:uint = 0;
         var _local2:Vector.<uint> = new Vector.<uint>();
         var _local3:int = 0;
         while(_local3 < param1.width) {
            _local4 = 0;
            while(_local4 < param1.height) {
               _local5 = param1.getPixel32(_local3,_local4);
               if((_local5 & 4278190080) != 0) {
                  _local2.push(_local5);
               }
               _local4++;
            }
            _local3++;
         }
         return _local2;
      }
   }
}
