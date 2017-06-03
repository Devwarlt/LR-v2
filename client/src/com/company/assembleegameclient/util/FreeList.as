package com.company.assembleegameclient.util {
import flash.utils.Dictionary;

public class FreeList {

      private static var dict_:Dictionary = new Dictionary();

      public function FreeList() {
         super();
      }

      public static function newObject(param1:Class) : Object {
         var _local2:Vector.<Object> = dict_[param1];
         if(_local2 == null) {
            _local2 = new Vector.<Object>();
            dict_[param1] = _local2;
         } else if(_local2.length > 0) {
            return _local2.pop();
         }
         return new param1();
      }

      public static function storeObject(param1:*, param2:Object) : void {
         var _local3:Vector.<Object> = dict_[param1];
         if(_local3 == null) {
            _local3 = new Vector.<Object>();
            dict_[param1] = _local3;
         }
         _local3.push(param2);
      }

      public static function getObject(param1:*) : Object {
         var _local2:Vector.<Object> = dict_[param1];
         if(_local2 != null && _local2.length > 0) {
            return _local2.pop();
         }
         return null;
      }

      public static function dump(param1:*) : void {
         delete dict_[param1];
      }

      public static function deleteObject(param1:Object) : void {
         var _local2:Class = Object(param1).constructor;
         var _local3:Vector.<Object> = dict_[_local2];
         if(_local3 == null) {
            _local3 = new Vector.<Object>();
            dict_[_local2] = _local3;
         }
         _local3.push(param1);
      }
   }
}
