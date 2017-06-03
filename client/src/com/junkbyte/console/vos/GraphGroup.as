package com.junkbyte.console.vos {
import flash.geom.Rectangle;
import flash.utils.ByteArray;

public class GraphGroup {

      public static const FPS:uint = 1;

      public static const MEM:uint = 2;

      public var type:uint;

      public var name:String;

      public var freq:int = 1;

      public var low:Number;

      public var hi:Number;

      public var fixed:Boolean;

      public var averaging:uint;

      public var inv:Boolean;

      public var interests:Array;

      public var rect:Rectangle;

      public var idle:int;

      public function GraphGroup(param1:String) {
         this.interests = [];
         super();
         this.name = param1;
      }

      public static function FromBytes(param1:ByteArray) : GraphGroup {
         var _local2:GraphGroup = new GraphGroup(param1.readUTF());
         _local2.type = param1.readUnsignedInt();
         _local2.idle = param1.readUnsignedInt();
         _local2.low = param1.readDouble();
         _local2.hi = param1.readDouble();
         _local2.inv = param1.readBoolean();
         var _local3:uint = param1.readUnsignedInt();
         while(_local3) {
            _local2.interests.push(GraphInterest.FromBytes(param1));
            _local3--;
         }
         return _local2;
      }

      public function updateMinMax(param1:Number) : void {
         if(!isNaN(param1) && !this.fixed) {
            if(isNaN(this.low)) {
               this.low = param1;
               this.hi = param1;
            }
            if(param1 > this.hi) {
               this.hi = param1;
            }
            if(param1 < this.low) {
               this.low = param1;
            }
         }
      }

      public function toBytes(param1:ByteArray) : void {
         var _local2:GraphInterest = null;
         param1.writeUTF(this.name);
         param1.writeUnsignedInt(this.type);
         param1.writeUnsignedInt(this.idle);
         param1.writeDouble(this.low);
         param1.writeDouble(this.hi);
         param1.writeBoolean(this.inv);
         param1.writeUnsignedInt(this.interests.length);
         for each(_local2 in this.interests) {
            _local2.toBytes(param1);
         }
      }
   }
}
