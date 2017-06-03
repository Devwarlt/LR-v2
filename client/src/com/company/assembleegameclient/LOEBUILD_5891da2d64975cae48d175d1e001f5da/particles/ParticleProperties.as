package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.TextureData;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b.LOEBUILD_b98058c639863689a15a54bd69990a3b;

public class ParticleProperties {

      public var id_:String;

      public var textureData_:TextureData;

      public var size_:int = 100;

      public var z_:Number = 0.0;

      public var duration_:Number = 0.0;

      public var animationsData_:LOEBUILD_b98058c639863689a15a54bd69990a3b = null;

      public function ParticleProperties(param1:XML) {
         super();
         this.id_ = param1.@id;
         this.textureData_ = new LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a(param1);
         if(param1.hasOwnProperty("Size")) {
            this.size_ = Number(param1.Size);
         }
         if(param1.hasOwnProperty("Z")) {
            this.z_ = Number(param1.Z);
         }
         if(param1.hasOwnProperty("Duration")) {
            this.duration_ = Number(param1.Duration);
         }
         if(param1.hasOwnProperty("Animation")) {
            this.animationsData_ = new LOEBUILD_b98058c639863689a15a54bd69990a3b(param1);
         }
      }
   }
}
