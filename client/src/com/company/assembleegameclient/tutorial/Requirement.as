package com.company.assembleegameclient.tutorial {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

public class Requirement {

      public var type_:String;

      public var slot_:int = -1;

      public var objectType_:int = -1;

      public var objectName_:String = "";

      public var radius_:Number = 1;

      public function Requirement(param1:XML) {
         super();
         this.type_ = String(param1);
         var _local2:String = String(param1.@objectId);
         if(_local2 != null && _local2 != "") {
            this.objectType_ = LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_[_local2];
         }
         this.objectName_ = String(param1.@objectName).replace("tutorial_script","tutorial");
         if(this.objectName_ == null) {
            this.objectName_ = "";
         }
         this.slot_ = int(param1.@slot);
         this.radius_ = Number(param1.@radius);
      }
   }
}
