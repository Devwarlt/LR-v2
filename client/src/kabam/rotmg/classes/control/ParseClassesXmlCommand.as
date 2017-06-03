package kabam.rotmg.classes.control {
import kabam.rotmg.assets.model.CharacterTemplate;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterClassStat;
import kabam.rotmg.classes.model.CharacterClassUnlock;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.text.model.TextKey;

public class ParseClassesXmlCommand {

      [Inject]
      public var data:XML;

      [Inject]
      public var classes:ClassesModel;

      public function ParseClassesXmlCommand() {
         super();
      }

      public function execute() : void {
         var _local2:XML = null;
         var _local1:XMLList = this.data.Object;
         for each(_local2 in _local1) {
            this.parseCharacterClass(_local2);
         }
      }

      private function parseCharacterClass(param1:XML) : void {
         var _local2:int = param1.@type;
         var _local3:CharacterClass = this.classes.getCharacterClass(_local2);
         this.populateCharacter(_local3,param1);
      }

      private function populateCharacter(param1:CharacterClass, param2:XML) : void {
         var _local3:XML = null;
         param1.id = param2.@type;
         param1.name = param2.DisplayId;
         param1.description = param2.Description;
         param1.hitSound = param2.HitSound;
         param1.deathSound = param2.DeathSound;
         param1.bloodProb = param2.BloodProb;
         param1.slotTypes = this.parseIntList(param2.SlotTypes);
         param1.defaultEquipment = this.parseIntList(param2.Equipment);
         param1.hp = this.parseCharacterStat(param2,"MaxHitPoints");
         param1.mp = this.parseCharacterStat(param2,"MaxMagicPoints");
         param1.attack = this.parseCharacterStat(param2,"Attack");
         param1.defense = this.parseCharacterStat(param2,"Defense");
         param1.speed = this.parseCharacterStat(param2,"Speed");
         param1.dexterity = this.parseCharacterStat(param2,"Dexterity");
         param1.hpRegeneration = this.parseCharacterStat(param2,"HpRegen");
         param1.mpRegeneration = this.parseCharacterStat(param2,"MpRegen");
         param1.unlockCost = param2.UnlockCost;
         for each(_local3 in param2.UnlockLevel) {
            param1.unlocks.push(this.parseUnlock(_local3));
         }
         param1.skins.addSkin(this.makeDefaultSkin(param2),true);
      }

      private function makeDefaultSkin(param1:XML) : CharacterSkin {
         var _local2:String = param1.AnimatedTexture.File;
         var _local3:int = param1.AnimatedTexture.Index;
         var _local4:CharacterSkin = new CharacterSkin();
         _local4.id = 0;
         _local4.name = TextKey.CLASSIC_SKIN;
         _local4.template = new CharacterTemplate(_local2,_local3);
         _local4.setState(CharacterSkinState.OWNED);
         _local4.setIsSelected(true);
         return _local4;
      }

      private function parseUnlock(param1:XML) : CharacterClassUnlock {
         var _local2:CharacterClassUnlock = new CharacterClassUnlock();
         _local2.level = param1.@level;
         _local2.character = this.classes.getCharacterClass(param1.@type);
         return _local2;
      }

      private function parseCharacterStat(param1:XML, param2:String) : CharacterClassStat {
         var _local4:XML = null;
         var _local5:XML = null;
         var _local6:CharacterClassStat = null;
         var _local3:XML = param1[param2][0];
         for each(_local5 in param1.LevelIncrease) {
            if(_local5.text() == param2) {
               _local4 = _local5;
            }
         }
         _local6 = new CharacterClassStat();
         _local6.initial = int(_local3.toString());
         _local6.max = _local3.@max;
         _local6.rampMin = !!_local4?int(_local4.@min):0;
         _local6.rampMax = !!_local4?int(_local4.@max):0;
         return _local6;
      }

      private function parseIntList(param1:String) : Vector.<int> {
         var _local2:Array = param1.split(",");
         var _local3:int = _local2.length;
         var _local4:Vector.<int> = new Vector.<int>(_local3,true);
         var _local5:int = 0;
         while(_local5 < _local3) {
            _local4[_local5] = int(_local2[_local5]);
            _local5++;
         }
         return _local4;
      }
   }
}
