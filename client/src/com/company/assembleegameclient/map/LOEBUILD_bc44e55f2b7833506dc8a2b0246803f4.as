package com.company.assembleegameclient.map {
import flash.utils.Dictionary;

public class LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4 {

      public static const xmlLibrary_:Dictionary = new Dictionary();

      public static var idToType_:Dictionary = new Dictionary();

      public function LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4() {
         super();
      }

      public static function parseFromXML(param1:XML) : void {
         var _local2:XML = null;
         var _local3:int = 0;
         for each(_local2 in param1.Region) {
            _local3 = int(_local2.@type);
            xmlLibrary_[_local3] = _local2;
            idToType_[String(_local2.@id)] = _local3;
         }
      }

      public static function getIdFromType(param1:int) : String {
         var _local2:XML = xmlLibrary_[param1];
         if(_local2 == null) {
            return null;
         }
         return String(_local2.@id);
      }

      public static function getColor(param1:int) : uint {
         var _local2:XML = xmlLibrary_[param1];
         if(_local2 == null) {
            return 0;
         }
         return uint(_local2.Color);
      }
   }
}
