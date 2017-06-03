package kabam.rotmg.classes.control {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

import kabam.rotmg.assets.EmbeddedData;
import kabam.rotmg.assets.model.CharacterTemplate;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;

public class ParseSkinsXmlCommand {

      [Inject]
      public var model:ClassesModel;

      public function ParseSkinsXmlCommand() {
         super();
      }

      private static function parseNodeEquipment(param1:XML) : void {
         var _local2:XMLList = null;
         var _local3:XML = null;
         var _local4:int = 0;
         var _local5:int = 0;
         _local2 = param1.children();
         for each(_local3 in _local2) {
            if(_local3.attribute("skinType").length() != 0) {
               _local4 = int(_local3.@skinType);
               _local5 = 16766720;
               if(_local3.attribute("color").length() != 0) {
                  _local5 = int(_local3.@color);
               }
               LOEBUILD_efda783509bc93eea698457c87bbee3f.skinSetXMLDataLibrary_[_local4] = _local3;
            }
         }
      }

      public function execute() : void {
         var _local1:XML = null;
         var _local2:XMLList = null;
         var _local3:XML = null;
         _local1 = EmbeddedData.skinsXML;
         _local2 = _local1.children();
         for each(_local3 in _local2) {
            this.parseNode(_local3);
         }
         _local1 = EmbeddedData.skinsEquipmentSetsXML;
         _local2 = _local1.children();
         for each(_local3 in _local2) {
            parseNodeEquipment(_local3);
         }
      }

      private function parseNode(param1:XML) : void {
         var _local2:String = param1.AnimatedTexture.File;
         var _local3:int = param1.AnimatedTexture.Index;
         var _local4:CharacterSkin = new CharacterSkin();
         _local4.id = param1.@type;
         _local4.name = param1.DisplayId;
         _local4.unlockLevel = param1.UnlockLevel;
         if(param1.hasOwnProperty("NoSkinSelect")) {
            _local4.skinSelectEnabled = false;
         }
         if(param1.hasOwnProperty("UnlockSpecial")) {
            _local4.unlockSpecial = param1.UnlockSpecial;
         }
         _local4.template = new CharacterTemplate(_local2,_local3);
         var _local5:CharacterClass = this.model.getCharacterClass(param1.PlayerClassType);
         _local5.skins.addSkin(_local4);
      }
   }
}
