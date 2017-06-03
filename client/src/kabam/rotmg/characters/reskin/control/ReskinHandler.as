package kabam.rotmg.characters.reskin.control {
import kabam.rotmg.assets.model.Player;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.messaging.impl.outgoing.Reskin;

public class ReskinHandler {

      [Inject]
      public var model:GameModel;

      [Inject]
      public var classes:ClassesModel;

      [Inject]
      public var factory:CharacterFactory;

      public function ReskinHandler() {
         super();
      }

      public function execute(param1:Reskin) : void {
         var _local2:Player = null;
         var _local3:int = 0;
         var _local4:CharacterClass = null;
         _local2 = param1.player || this.model.player;
         _local3 = param1.skinID;
         _local4 = this.classes.getCharacterClass(_local2.objectType_);
         var _local5:CharacterSkin = _local4.skins.getSkin(_local3);
         _local2.skinId = _local3;
         _local2.skin = this.factory.makeCharacter(_local5.template);
         _local2.isDefaultAnimatedChar = false;
      }
   }
}
