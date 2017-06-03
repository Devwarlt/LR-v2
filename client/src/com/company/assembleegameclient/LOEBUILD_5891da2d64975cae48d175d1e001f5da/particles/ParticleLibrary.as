package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
   public class ParticleLibrary {

      public static const propsLibrary_:Object = {};

      public function ParticleLibrary() {
         super();
      }

      public static function parseFromXML(param1:XML) : void {
         var _local2:XML = null;
         for each(_local2 in param1.Particle) {
            propsLibrary_[_local2.@id] = new ParticleProperties(_local2);
         }
      }
   }
}
