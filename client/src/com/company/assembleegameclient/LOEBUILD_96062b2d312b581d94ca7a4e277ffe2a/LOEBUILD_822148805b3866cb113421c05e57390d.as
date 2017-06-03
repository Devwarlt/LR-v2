package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
   public class LOEBUILD_822148805b3866cb113421c05e57390d {

      public var types_:Vector.<int>;

      public var objName_:String = null;

      public function LOEBUILD_822148805b3866cb113421c05e57390d() {
         this.types_ = new <int>[-1,-1,-1];
         super();
      }

      public function clone() : LOEBUILD_822148805b3866cb113421c05e57390d {
         var _local1:LOEBUILD_822148805b3866cb113421c05e57390d = new LOEBUILD_822148805b3866cb113421c05e57390d();
         _local1.types_ = this.types_.concat();
         _local1.objName_ = this.objName_;
         return _local1;
      }

      public function isEmpty() : Boolean {
         var _local1:int = 0;
         while(_local1 < LOEBUILD_359b71e88f40029251366609358a302f.NUM_LAYERS) {
            if(this.types_[_local1] != -1) {
               return false;
            }
            _local1++;
         }
         return true;
      }
   }
}
