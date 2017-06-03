package com.company.assembleegameclient.util {
import flash.display.BitmapData;
import flash.utils.Dictionary;

public class AnimatedChars {

      private static var nameMap_:Dictionary = new Dictionary();

      public function AnimatedChars() {
         super();
      }

      public static function getAnimatedChar(param1:String, param2:int) : AnimatedChar {
         var _local3:Vector.<AnimatedChar> = nameMap_[param1];
         if(_local3 == null || param2 >= _local3.length) {
            return null;
         }
         return _local3[param2];
      }

      public static function add(param1:String, param2:BitmapData, param3:BitmapData, param4:int, param5:int, param6:int, param7:int, param8:int) : void {
         var _local11:MaskedImage = null;
         var _local9:Vector.<AnimatedChar> = new Vector.<AnimatedChar>();
         var _local10:MaskedImageSet = new MaskedImageSet();
         _local10.addFromBitmapData(param2,param3,param6,param7);
         for each(_local11 in _local10.images_) {
            _local9.push(new AnimatedChar(_local11,param4,param5,param8));
         }
         nameMap_[param1] = _local9;
      }
   }
}
