package com.company.assembleegameclient.LOEBUILD_c0a0ad5a20fa962e79dbafea298b8ea4 {
   public class LOEBUILD_4b3191ab11a28e125ff9a9624cfd674b {

      public var model_:LOEBUILD_1cd204050ec7f52020766f99b3129701;

      public var indicies_:Vector.<int>;

      public var useTexture_:Boolean;

      public function LOEBUILD_4b3191ab11a28e125ff9a9624cfd674b(param1:LOEBUILD_1cd204050ec7f52020766f99b3129701, param2:Vector.<int>, param3:Boolean) {
         super();
         this.model_ = param1;
         this.indicies_ = param2;
         this.useTexture_ = param3;
      }

      public static function compare(param1:LOEBUILD_4b3191ab11a28e125ff9a9624cfd674b, param2:LOEBUILD_4b3191ab11a28e125ff9a9624cfd674b) : Number {
         var _local3:Number = NaN;
         var _local4:int = 0;
         var _local5:Number = Number.MAX_VALUE;
         var _local6:Number = Number.MIN_VALUE;
         _local4 = 0;
         while(_local4 < param1.indicies_.length) {
            _local3 = param2.model_.vL_[param1.indicies_[_local4] * 3 + 2];
            _local5 = _local3 < _local5?Number(_local3):Number(_local5);
            _local6 = _local3 > _local6?Number(_local3):Number(_local6);
            _local4++;
         }
         var _local7:Number = Number.MAX_VALUE;
         var _local8:Number = Number.MIN_VALUE;
         _local4 = 0;
         while(_local4 < param2.indicies_.length) {
            _local3 = param2.model_.vL_[param2.indicies_[_local4] * 3 + 2];
            _local7 = _local3 < _local7?Number(_local3):Number(_local7);
            _local8 = _local3 > _local8?Number(_local3):Number(_local8);
            _local4++;
         }
         if(_local7 > _local5) {
            return -1;
         }
         if(_local7 < _local5) {
            return 1;
         }
         if(_local8 > _local6) {
            return -1;
         }
         if(_local8 < _local6) {
            return 1;
         }
         return 0;
      }
   }
}
