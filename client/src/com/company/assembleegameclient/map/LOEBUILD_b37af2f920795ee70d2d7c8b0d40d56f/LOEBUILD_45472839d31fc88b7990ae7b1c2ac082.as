package com.company.assembleegameclient.map.LOEBUILD_b37af2f920795ee70d2d7c8b0d40d56f {
import com.company.assembleegameclient.map.LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.BasicObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.util.IntPoint;
import com.hurlant.util.Base64;

import flash.utils.ByteArray;

import kabam.lib.json.JsonParser;
import kabam.rotmg.core.StaticInjectorContext;

public class LOEBUILD_45472839d31fc88b7990ae7b1c2ac082 {

      public function LOEBUILD_45472839d31fc88b7990ae7b1c2ac082() {
         super();
      }

      private static function get json() : JsonParser {
         return StaticInjectorContext.getInjector().getInstance(JsonParser);
      }

      public static function decodeMap(param1:String) : Map {
         var _local2:Object = json.parse(param1);
         var _local3:Map = new Map(null);
         _local3.setProps(_local2["width"],_local2["height"],_local2["name"],_local2["back"],false,false,"main");
         _local3.initialize();
         writeMapInternal(_local2,_local3,0,0);
         return _local3;
      }

      public static function writeMap(param1:String, param2:Map, param3:int, param4:int) : void {
         var _local5:Object = json.parse(param1);
         writeMapInternal(_local5,param2,param3,param4);
      }

      public static function getSize(param1:String) : IntPoint {
         var _local2:Object = json.parse(param1);
         return new IntPoint(_local2["width"],_local2["height"]);
      }

      private static function writeMapInternal(param1:Object, param2:Map, param3:int, param4:int) : void {
         var _local7:int = 0;
         var _local8:int = 0;
         var _local9:Object = null;
         var _local10:Array = null;
         var _local11:int = 0;
         var _local12:Object = null;
         var _local13:GameObject = null;
         var _local5:ByteArray = Base64.decodeToByteArray(param1["data"]);
         _local5.uncompress();
         var _local6:Array = param1["dict"];
         _local7 = param4;
         while(_local7 < param4 + param1["height"]) {
            _local8 = param3;
            while(_local8 < param3 + param1["width"]) {
               _local9 = _local6[_local5.readShort()];
               if(!(_local8 < 0 || _local8 >= param2.width_ || _local7 < 0 || _local7 >= param2.height_)) {
                  if(_local9.hasOwnProperty("ground")) {
                     _local11 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.idToType_[_local9["ground"]];
                     param2.setGroundTile(_local8,_local7,_local11);
                  }
                  _local10 = _local9["objs"];
                  if(_local10 != null) {
                     for each(_local12 in _local10) {
                        _local13 = getGameObject(_local12);
                        _local13.objectId_ = BasicObject.getNextFakeObjectId();
                        param2.addObj(_local13,_local8 + 0.5,_local7 + 0.5);
                     }
                  }
               }
               _local8++;
            }
            _local7++;
         }
      }

      public static function getGameObject(param1:Object) : GameObject {
         var _local2:int = LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_[param1["id"]];
         var _local3:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[_local2];
         var _local4:GameObject = LOEBUILD_efda783509bc93eea698457c87bbee3f.getObjectFromType(_local2);
         _local4.size_ = !!param1.hasOwnProperty("size")?int(param1["size"]):int(_local4.props_.getSize());
         return _local4;
      }
   }
}
