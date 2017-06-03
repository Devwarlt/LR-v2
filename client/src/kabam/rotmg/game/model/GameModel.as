package kabam.rotmg.game.model {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import kabam.rotmg.assets.model.Player;

import flash.utils.Dictionary;

public class GameModel {

      public var player:Player;

      public var gameObjects:Dictionary;

      public function GameModel() {
         super();
      }

      public function getGameObject(param1:int) : GameObject {
         var _local2:GameObject = this.gameObjects[param1];
         if(!_local2 && this.player.objectId_ == param1) {
            _local2 = this.player;
         }
         return _local2;
      }
   }
}
