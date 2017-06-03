package com.company.assembleegameclient.map {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a;
import com.company.util.BitmapUtil;

import flash.display.BitmapData;
import flash.utils.Dictionary;

public class LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5 {

      public static const propsLibrary_:Dictionary = new Dictionary();

      public static const xmlLibrary_:Dictionary = new Dictionary();

      private static var tileTypeColorDict_:Dictionary = new Dictionary();

      public static const typeToTextureData_:Dictionary = new Dictionary();

      public static var idToType_:Dictionary = new Dictionary();

      public static var defaultProps_:LOEBUILD_a8ee717b4dbde6fa2f5932b7421c41aa;

      public function LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5() {
         super();
      }

      public static function parseFromXML(param1:XML) : void {
         var _local2:XML = null;
         var _local3:int = 0;
         for each(_local2 in param1.Ground) {
            _local3 = int(_local2.@type);
            propsLibrary_[_local3] = new LOEBUILD_a8ee717b4dbde6fa2f5932b7421c41aa(_local2);
            xmlLibrary_[_local3] = _local2;
            typeToTextureData_[_local3] = new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(_local2);
            idToType_[String(_local2.@id)] = _local3;
         }
         defaultProps_ = propsLibrary_[255];
      }

      public static function getIdFromType(param1:int) : String {
         var _local2:LOEBUILD_a8ee717b4dbde6fa2f5932b7421c41aa = propsLibrary_[param1];
         if(_local2 == null) {
            return null;
         }
         return _local2.id_;
      }

      public static function getBitmapData(param1:int, param2:int = 0) : BitmapData {
         return typeToTextureData_[param1].getTexture(param2);
      }

      public static function getColor(param1:int) : uint {
         var _local2:XML = null;
         var _local3:uint = 0;
         var _local4:BitmapData = null;
         if(!tileTypeColorDict_.hasOwnProperty(param1)) {
            _local2 = xmlLibrary_[param1];
            if(_local2.hasOwnProperty("Color")) {
               _local3 = uint(_local2.Color);
            } else {
               _local4 = getBitmapData(param1);
               _local3 = BitmapUtil.mostCommonColor(_local4);
            }
            tileTypeColorDict_[param1] = _local3;
         }
         return tileTypeColorDict_[param1];
      }
   }
}
