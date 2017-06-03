package kabam.rotmg.classes.control {
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.model.ClassesModel;

import robotlegs.bender.framework.api.ILogger;

public class ParseCharListXmlCommand {

      [Inject]
      public var data:XML;

      [Inject]
      public var model:ClassesModel;

      [Inject]
      public var logger:ILogger;

      public function ParseCharListXmlCommand() {
         super();
      }

      public function execute() : void {
         this.parseMaxLevelsAchieved();
         this.parseItemCosts();
         this.parseOwnership();
      }

      private function parseMaxLevelsAchieved() : void {
         var _local2:XML = null;
         var _local3:CharacterClass = null;
         var _local1:XMLList = this.data.MaxClassLevelList.MaxClassLevel;
         for each(_local2 in _local1) {
            _local3 = this.model.getCharacterClass(_local2.@classType);
            _local3.setMaxLevelAchieved(_local2.@maxLevel);
         }
      }

      private function parseItemCosts() : void {
         var _local2:XML = null;
         var _local3:CharacterSkin = null;
         var _local1:XMLList = this.data.ItemCosts.ItemCost;
         for each(_local2 in _local1) {
            _local3 = this.model.getCharacterSkin(_local2.@type);
            if(_local3) {
               _local3.cost = int(_local2);
               _local3.limited = Boolean(int(_local2.@expires));
               if(!Boolean(int(_local2.@purchasable))) {
                  _local3.setState(CharacterSkinState.UNLISTED);
               }
            } else {
               this.logger.warn("Cannot set Character Skin cost: MsgType {0} not found",[_local2.@type]);
            }
         }
      }

      private function parseOwnership() : void {
         var _local2:int = 0;
         var _local3:CharacterSkin = null;
         var _local1:Array = !!this.data.OwnedSkins.length()?this.data.OwnedSkins.split(","):[];
         for each(_local2 in _local1) {
            _local3 = this.model.getCharacterSkin(_local2);
            if(_local3) {
               _local3.setState(CharacterSkinState.OWNED);
            } else {
               this.logger.warn("Cannot set Character Skin ownership: MsgType {0} not found",[_local2]);
            }
         }
      }
   }
}
