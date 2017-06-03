package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.map.LOEBUILD_4a218ca1436fee34076fdca93698bac4.LOEBUILD_862a0e20385d01174a45beed4b836305;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;

import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class QueuedStatusText extends LOEBUILD_862a0e20385d01174a45beed4b836305 {

      public var list:QueuedStatusTextList;

      public var next:QueuedStatusText;

      public var stringBuilder:StringBuilder;

      public function QueuedStatusText(param1:GameObject, param2:StringBuilder, param3:uint, param4:int, param5:int = 0) {
         this.stringBuilder = param2;
         super(param1,param3,param4,param5);
         setStringBuilder(param2);
      }

      override public function dispose() : void {
         this.list.shift();
      }
   }
}
