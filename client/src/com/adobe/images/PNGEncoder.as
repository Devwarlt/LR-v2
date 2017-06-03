package com.adobe.images {
import flash.display.BitmapData;
import flash.utils.ByteArray;

public class PNGEncoder {

      private static var crcTable:Array;

      private static var crcTableComputed:Boolean = false;

      public function PNGEncoder() {
         super();
      }

      public static function encode(param1:BitmapData) : ByteArray {
         var _local6:uint = 0;
         var _local7:int = 0;
         var _local2:ByteArray = new ByteArray();
         _local2.writeUnsignedInt(2303741511);
         _local2.writeUnsignedInt(218765834);
         var _local3:ByteArray = new ByteArray();
         _local3.writeInt(param1.width);
         _local3.writeInt(param1.height);
         _local3.writeUnsignedInt(134610944);
         _local3.writeByte(0);
         writeChunk(_local2,1229472850,_local3);
         var _local4:ByteArray = new ByteArray();
         var _local5:int = 0;
         while(_local5 < param1.height) {
            _local4.writeByte(0);
            if(!param1.transparent) {
               _local7 = 0;
               while(_local7 < param1.width) {
                  _local6 = param1.getPixel(_local7,_local5);
                  _local4.writeUnsignedInt(uint((_local6 & 16777215) << 8 | 255));
                  _local7++;
               }
            } else {
               _local7 = 0;
               while(_local7 < param1.width) {
                  _local6 = param1.getPixel32(_local7,_local5);
                  _local4.writeUnsignedInt(uint((_local6 & 16777215) << 8 | _local6 >>> 24));
                  _local7++;
               }
            }
            _local5++;
         }
         _local4.compress();
         writeChunk(_local2,1229209940,_local4);
         writeChunk(_local2,1229278788,null);
         return _local2;
      }

      private static function writeChunk(param1:ByteArray, param2:uint, param3:ByteArray) : void {
         var _local8:uint = 0;
         var _local9:uint = 0;
         var _local10:uint = 0;
         if(!crcTableComputed) {
            crcTableComputed = true;
            crcTable = [];
            _local9 = 0;
            while(_local9 < 256) {
               _local8 = _local9;
               _local10 = 0;
               while(_local10 < 8) {
                  if(_local8 & 1) {
                     _local8 = uint(uint(3988292384) ^ uint(_local8 >>> 1));
                  } else {
                     _local8 = uint(_local8 >>> 1);
                  }
                  _local10++;
               }
               crcTable[_local9] = _local8;
               _local9++;
            }
         }
         var _local4:uint = 0;
         if(param3 != null) {
            _local4 = param3.length;
         }
         param1.writeUnsignedInt(_local4);
         var _local5:uint = param1.position;
         param1.writeUnsignedInt(param2);
         if(param3 != null) {
            param1.writeBytes(param3);
         }
         var _local6:uint = param1.position;
         param1.position = _local5;
         _local8 = 4294967295;
         var _local7:int = 0;
         while(_local7 < _local6 - _local5) {
            _local8 = uint(crcTable[(_local8 ^ param1.readUnsignedByte()) & uint(255)] ^ uint(_local8 >>> 8));
            _local7++;
         }
         _local8 = uint(_local8 ^ uint(4294967295));
         param1.position = _local6;
         param1.writeUnsignedInt(_local8);
      }
   }
}
