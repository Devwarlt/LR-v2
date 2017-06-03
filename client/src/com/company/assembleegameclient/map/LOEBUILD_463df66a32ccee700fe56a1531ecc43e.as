package com.company.assembleegameclient.map {
   public class LOEBUILD_463df66a32ccee700fe56a1531ecc43e {

      public static const NO_ANIMATE:int = 0;

      public static const WAVE_ANIMATE:int = 1;

      public static const FLOW_ANIMATE:int = 2;

      public var type_:int = 0;

      public var dx_:Number = 0;

      public var dy_:Number = 0;

      public function LOEBUILD_463df66a32ccee700fe56a1531ecc43e() {
         super();
      }

      public function parseXML(param1:XML) : void {
         switch(String(param1)) {
            case "Wave":
               this.type_ = WAVE_ANIMATE;
               break;
            case "Flow":
               this.type_ = FLOW_ANIMATE;
         }
         this.dx_ = param1.@dx;
         this.dy_ = param1.@dy;
      }
   }
}
