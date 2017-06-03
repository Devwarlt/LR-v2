package com.company.util {
import flash.display.BitmapData;

public class ImageSet {

      public var images_:Vector.<BitmapData>;

      public function ImageSet() {
         super();
         this.images_ = new Vector.<BitmapData>();
      }

      public function add(param1:BitmapData) : void {
         this.images_.push(param1);
      }

      public function random() : BitmapData {
         return this.images_[int(Math.random() * this.images_.length)];
      }

      public function addFromBitmapData(param1:BitmapData, param2:int, param3:int) : void {
         var _local7:int = 0;
         var _local4:int = param1.width / param2;
         var _local5:int = param1.height / param3;
         var _local6:int = 0;
         while(_local6 < _local5) {
            _local7 = 0;
            while(_local7 < _local4) {
               this.images_.push(BitmapUtil.cropToBitmapData(param1,_local7 * param2,_local6 * param3,param2,param3));
               _local7++;
            }
            _local6++;
         }
      }
   }
}
