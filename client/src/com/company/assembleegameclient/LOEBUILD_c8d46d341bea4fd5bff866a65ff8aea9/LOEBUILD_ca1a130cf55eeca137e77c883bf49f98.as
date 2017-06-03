package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9 {
import kabam.rotmg.messaging.impl.data.MoveRecord;

public class LOEBUILD_ca1a130cf55eeca137e77c883bf49f98 {

      public var lastClearTime_:int = -1;

      public var records_:Vector.<MoveRecord>;

      public function LOEBUILD_ca1a130cf55eeca137e77c883bf49f98() {
         this.records_ = new Vector.<MoveRecord>();
         super();
      }

      public function addRecord(param1:int, param2:Number, param3:Number) : void {
         if(this.lastClearTime_ < 0) {
            return;
         }
         var _local4:int = this.getId(param1);
         if(_local4 < 1 || _local4 > 10) {
            return;
         }
         if(this.records_.length == 0) {
            this.records_.push(new MoveRecord(param1,param2,param3));
            return;
         }
         var _local5:MoveRecord = this.records_[this.records_.length - 1];
         var _local6:int = this.getId(_local5.time_);
         if(_local4 != _local6) {
            this.records_.push(new MoveRecord(param1,param2,param3));
            return;
         }
         var _local7:int = this.getScore(_local4,param1);
         var _local8:int = this.getScore(_local4,_local5.time_);
         if(_local7 < _local8) {
            _local5.time_ = param1;
            _local5.x_ = param2;
            _local5.y_ = param3;
            return;
         }
      }

      private function getId(param1:int) : int {
         return (param1 - this.lastClearTime_ + 50) / 100;
      }

      private function getScore(param1:int, param2:int) : int {
         return Math.abs(param2 - this.lastClearTime_ - param1 * 100);
      }

      public function clear(param1:int) : void {
         this.records_.length = 0;
         this.lastClearTime_ = param1;
      }
   }
}
