package kabam.rotmg.ui.model {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;

public class UpdateGameObjectTileVO {

      public var tileX:int;

      public var tileY:int;

      public var gameObject:GameObject;

      public function UpdateGameObjectTileVO(param1:int, param2:int, param3:GameObject) {
         super();
         this.tileX = param1;
         this.tileY = param2;
         this.gameObject = param3;
      }
   }
}
