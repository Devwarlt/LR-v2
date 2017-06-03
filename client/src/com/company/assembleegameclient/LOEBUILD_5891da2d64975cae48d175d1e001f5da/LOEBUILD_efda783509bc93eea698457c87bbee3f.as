package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_6f1c25ed1523962f1bbf9dee9be5092b.LOEBUILD_b98058c639863689a15a54bd69990a3b;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.ConversionUtil;

import flash.display.BitmapData;
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;

import kabam.rotmg.assets.model.Player;

import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.messaging.impl.data.StatData;

public class LOEBUILD_efda783509bc93eea698457c87bbee3f {

      public static var textureDataFactory:LOEBUILD_ba77498d0acb46a54b81ef939c904ceb = new LOEBUILD_ba77498d0acb46a54b81ef939c904ceb();

      public static const IMAGE_SET_NAME:String = "lofiObj3";

      public static const IMAGE_ID:int = 255;

      public static var playerChars_:Vector.<XML> = new Vector.<XML>();

      public static var hexTransforms_:Vector.<XML> = new Vector.<XML>();

      public static var playerClassAbbr_:Dictionary = new Dictionary();

      public static const propsLibrary_:Dictionary = new Dictionary();

      public static const xmlLibrary_:Dictionary = new Dictionary();

      public static const idToType_:Dictionary = new Dictionary();

      public static const typeToDisplayId_:Dictionary = new Dictionary();

      public static const typeToTextureData_:Dictionary = new Dictionary();

      public static const typeToTopTextureData_:Dictionary = new Dictionary();

      public static const typeToAnimationsData_:Dictionary = new Dictionary();

      public static const petXMLDataLibrary_:Dictionary = new Dictionary();

      public static const skinSetXMLDataLibrary_:Dictionary = new Dictionary();

      public static const defaultProps_:ObjectProperties = new ObjectProperties(null);

      public static const TYPE_MAP:Object = {
         "ArenaGuard":LOEBUILD_611cb033e5d3ea6d984d718609741245,
         "ArenaPortal":ArenaPortal,
         "CaveWall":LOEBUILD_8fc9c0a3433bb36a813632c6cf69c2d2,
         "Character":Character,
         "CharacterChanger":LOEBUILD_feac7d5fffef3606d7e1655b45dda9a0,
         "ClosedGiftChest":ClosedGiftChest,
         "ClosedVaultChest":ClosedVaultChest,
         "ConnectedWall":LOEBUILD_ab04ce74e60aca041a95de3600eac8f9,
         "Container":Container,
         "DoubleWall":LOEBUILD_d4e236b4dc33330927f0f2a1c19ba396,
         "FortuneGround":FortuneGround,
         "FortuneTeller":FortuneTeller,
         "GameObject":GameObject,
         "GuildBoard":LOEBUILD_5079b6b16b360f02dc404b7690fa1e24,
         "GuildChronicle":GuildChronicle,
         "GuildHallPortal":GuildHallPortal,
         "GuildMerchant":GuildMerchant,
         "GuildRegister":LOEBUILD_3affcea74ba98f4bd0f2886e81606097,
         "Merchant":Merchant,
         "MoneyChanger":LOEBUILD_5e160f7c9c065c795e42bf7272665236,
         "MysteryBoxGround":MysteryBoxGround,
         "NameChanger":LOEBUILD_83c7af17e580756c4c914e5fc723c63c,
         "ReskinVendor":LOEBUILD_cd4155f559d8edf0d39da702f8eea90c,
         "OneWayContainer":OneWayContainer,
         "Player":Player,
         "Portal":Portal,
         "Projectile":Projectile,
         "QuestRewards":QuestRewards,
         "Sign":Sign,
         "SpiderWeb":SpiderWeb,
         "Stalagmite":Stalagmite,
         "Wall":Wall,
         "Pet":Pet,
         "PetUpgrader":PetUpgrader,
         "YardUpgrader":LOEBUILD_a9b7aac80754896f0c3d4e27b5fd4b8f
      };

      public function LOEBUILD_efda783509bc93eea698457c87bbee3f() {
         super();
      }

      public static function parseFromXML(param1:XML) : void {
         var _local2:XML;
         var _local3:String;
         var _local4:String ;
         var _local5:int;
         var _local6:Boolean = false;
         var _local7:int;
         for each(_local2 in param1.Object) {
            _local3 = String(_local2.@id);
            _local4 = _local3;
            if(_local2.hasOwnProperty("DisplayId")) {
               _local4 = _local2.DisplayId;
            }
            if(_local2.hasOwnProperty("Group")) {
               if(_local2.Group == "Hexable") {
                  hexTransforms_.push(_local2);
               }
            }
            _local5 = int(_local2.@type);
            if(Boolean(_local2.hasOwnProperty("PetBehavior")) || Boolean(_local2.hasOwnProperty("PetAbility"))) {
               petXMLDataLibrary_[_local5] = _local2;
            } else {
               propsLibrary_[_local5] = new ObjectProperties(_local2);
               xmlLibrary_[_local5] = _local2;
               idToType_[_local3] = _local5;
               typeToDisplayId_[_local5] = _local4;
               if(String(_local2.Class) == "Player") {
                  playerClassAbbr_[_local5] = String(_local2.@id).substr(0,2);
                  _local6 = false;
                  _local7 = 0;
                  while(_local7 < playerChars_.length) {
                     if(int(playerChars_[_local7].@type) == _local5) {
                        playerChars_[_local7] = _local2;
                        _local6 = true;
                     }
                     _local7++;
                  }
                  if(!_local6) {
                     playerChars_.push(_local2);
                  }
               }
               typeToTextureData_[_local5] = textureDataFactory.create(_local2);
               if(_local2.hasOwnProperty("Top")) {
                  typeToTopTextureData_[_local5] = textureDataFactory.create(XML(_local2.Top));
               }
               if(_local2.hasOwnProperty("Animation")) {
                  typeToAnimationsData_[_local5] = new LOEBUILD_b98058c639863689a15a54bd69990a3b(_local2);
               }
            }
         }
      }

      public static function getIdFromType(param1:int) : String {
         var _local2:XML = xmlLibrary_[param1];
         if(_local2 == null) {
            return null;
         }
         return String(_local2.@id);
      }

      public static function getPropsFromId(param1:String) : ObjectProperties {
         var _local2:int = idToType_[param1];
         return propsLibrary_[_local2];
      }

      public static function getXMLfromId(param1:String) : XML {
         var _local2:int = idToType_[param1];
         return xmlLibrary_[_local2];
      }

      public static function getObjectFromType(param1:int) : GameObject {
         var _local2:XML = xmlLibrary_[param1];
         var _local3:String = _local2.Class;
         var _local4:Class = TYPE_MAP[_local3] || makeClass(_local3);
         return new _local4(_local2);
      }

      private static function makeClass(param1:String) : Class {
         var _local2:String = "com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da." + param1;
         return getDefinitionByName(_local2) as Class;
      }

      public static function getTextureFromType(param1:int) : BitmapData {
         var _local2:TextureData = typeToTextureData_[param1];
         if(_local2 == null) {
            return null;
         }
         return _local2.getTexture();
      }

      public static function getBitmapData(param1:int) : BitmapData {
         var _local2:TextureData = typeToTextureData_[param1];
         var _local3:BitmapData = !!_local2?_local2.getTexture():null;
         if(_local3) {
            return _local3;
         }
         return AssetLibrary.getImageFromSet(IMAGE_SET_NAME,IMAGE_ID);
      }

      public static function getRedrawnTextureFromType(param1:int, param2:int, param3:Boolean, param4:Boolean = true, param5:Number = 5) : BitmapData {
         var _local6:BitmapData = getBitmapData(param1);
         var _local7:TextureData = typeToTextureData_[param1];
         var _local8:BitmapData = !!_local7?_local7.mask_:null;
         if(_local8 == null) {
            return TextureRedrawer.redraw(_local6,param2,param3,0,param4,param5);
         }
         var _local9:XML = xmlLibrary_[param1];
         var _local10:int = !!_local9.hasOwnProperty("Tex1")?int(int(_local9.Tex1)):0;
         var _local11:int = !!_local9.hasOwnProperty("Tex2")?int(int(_local9.Tex2)):0;
         _local6 = TextureRedrawer.resize(_local6,_local8,param2,param3,_local10,_local11,param5);
         _local6 = GlowRedrawer.outlineGlow(_local6,0);
         return _local6;
      }

      public static function getSizeFromType(param1:int) : int {
         var _local2:XML = xmlLibrary_[param1];
         if(!_local2.hasOwnProperty("Size")) {
            return 100;
         }
         return int(_local2.Size);
      }

      public static function getSlotTypeFromType(param1:int) : int {
         var _local2:XML = xmlLibrary_[param1];
         if(!_local2.hasOwnProperty("SlotType")) {
            return -1;
         }
         return int(_local2.SlotType);
      }

      public static function isEquippableByPlayer(param1:int, param2:Player) : Boolean {
         if(param1 == ItemConstants.NO_ITEM) {
            return false;
         }
         var _local3:XML = xmlLibrary_[param1];
         var _local4:int = int(_local3.SlotType.toString());
         var _local5:uint = 0;
         while(_local5 < GeneralConstants.NUM_EQUIPMENT_SLOTS) {
            if(param2.slotTypes_[_local5] == _local4) {
               return true;
            }
            _local5++;
         }
         return false;
      }

      public static function getMatchingSlotIndex(param1:int, param2:Player) : int {
         var _local3:XML = null;
         var _local4:int = 0;
         var _local5:uint = 0;
         if(param1 != ItemConstants.NO_ITEM) {
            _local3 = xmlLibrary_[param1];
            _local4 = int(_local3.SlotType);
            _local5 = 0;
            while(_local5 < GeneralConstants.NUM_EQUIPMENT_SLOTS) {
               if(param2.slotTypes_[_local5] == _local4) {
                  return _local5;
               }
               _local5++;
            }
         }
         return -1;
      }

      public static function isUsableByPlayer(param1:int, param2:Player) : Boolean {
         if(param2 == null) {
            return true;
         }
         var _local3:XML = xmlLibrary_[param1];
         if(_local3 == null || !_local3.hasOwnProperty("SlotType")) {
            return false;
         }
         var _local4:int = _local3.SlotType;
         if(_local4 == ItemConstants.POTION_TYPE || _local4 == ItemConstants.EGG_TYPE) {
            return true;
         }
         var _local5:int = 0;
         while(_local5 < param2.slotTypes_.length) {
            if(param2.slotTypes_[_local5] == _local4) {
               return true;
            }
            _local5++;
         }
         return false;
      }

      public static function isSoulbound(param1:int) : Boolean {
         var _local2:XML = xmlLibrary_[param1];
         return _local2 != null && Boolean(_local2.hasOwnProperty("Soulbound"));
      }

      public static function usableBy(param1:int) : Vector.<String> {
         var _local5:XML = null;
         var _local6:Vector.<int> = null;
         var _local7:int = 0;
         var _local2:XML = xmlLibrary_[param1];
         if(_local2 == null || !_local2.hasOwnProperty("SlotType")) {
            return null;
         }
         var _local3:int = _local2.SlotType;
         if(_local3 == ItemConstants.POTION_TYPE || _local3 == ItemConstants.RING_TYPE || _local3 == ItemConstants.EGG_TYPE) {
            return null;
         }
         var _local4:Vector.<String> = new Vector.<String>();
         for each(_local5 in playerChars_) {
            _local6 = ConversionUtil.toIntVector(_local5.SlotTypes);
            _local7 = 0;
            while(_local7 < _local6.length) {
               if(_local6[_local7] == _local3) {
                  _local4.push(typeToDisplayId_[int(_local5.@type)]);
                  break;
               }
               _local7++;
            }
         }
         return _local4;
      }

      public static function playerMeetsRequirements(param1:int, param2:Player) : Boolean {
         var _local4:XML = null;
         if(param2 == null) {
            return true;
         }
         var _local3:XML = xmlLibrary_[param1];
         for each(_local4 in _local3.EquipRequirement) {
            if(!playerMeetsRequirement(_local4,param2)) {
               return false;
            }
         }
         return true;
      }

      public static function playerMeetsRequirement(param1:XML, param2:Player) : Boolean {
         var _local3:int = 0;
         if(param1.toString() == "Stat") {
            _local3 = int(param1.@value);
            switch(int(param1.@stat)) {
               case StatData.MAX_HP_STAT:
                  return param2.maxHP_ >= _local3;
               case StatData.MAX_MP_STAT:
                  return param2.maxMP_ >= _local3;
               case StatData.LEVEL_STAT:
                  return param2.level_ >= _local3;
               case StatData.ATTACK_STAT:
                  return param2.attack_ >= _local3;
               case StatData.DEFENSE_STAT:
                  return param2.defense_ >= _local3;
               case StatData.SPEED_STAT:
                  return param2.speed_ >= _local3;
               case StatData.VITALITY_STAT:
                  return param2.vitality_ >= _local3;
               case StatData.WISDOM_STAT:
                  return param2.wisdom_ >= _local3;
               case StatData.DEXTERITY_STAT:
                  return param2.dexterity_ >= _local3;
            }
         }
         return false;
      }

      public static function getPetDataXMLByType(param1:int) : XML {
         return petXMLDataLibrary_[param1];
      }
   }
}
