package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.TextureData;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a;

public class LOEBUILD_d6e408b692f1e72c58127dbaed95ebe4 {

      public var time_:int;

      public var textureData_:TextureData;

      public function LOEBUILD_d6e408b692f1e72c58127dbaed95ebe4(param1:XML) {
         super();
         this.time_ = int(Number(param1.@time) * 1000);
         this.textureData_ = new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(param1);
      }
   }
}
