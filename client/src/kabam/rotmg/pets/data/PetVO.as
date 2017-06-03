package kabam.rotmg.pets.data {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import org.osflash.signals.Signal;

public class PetVO {

      private var staticData:XML;

      private var id:int;

      private var type:int;

      private var rarity:String;

      private var name:String;

      private var maxAbilityPower:int;

      public var abilityList:Array;

      private var skinID:int;

      private var skin:AnimatedChar;

      public const updated:Signal = new Signal();

      public function PetVO(param1:int = undefined) {
         this.abilityList = [new AbilityVO(),new AbilityVO(),new AbilityVO()];
         super();
         this.id = param1;
         this.staticData = <data/>;
         this.listenToAbilities();
      }

      private static function getPetDataDescription(param1:int) : String {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.getPetDataXMLByType(param1).Description;
      }

      private static function getPetDataDisplayId(param1:int) : String {
         return LOEBUILD_efda783509bc93eea698457c87bbee3f.getPetDataXMLByType(param1).DisplayId;
      }

      public static function clone(param1:PetVO) : PetVO {
         var _local2:PetVO = new PetVO(param1.id);
         return _local2;
      }

      private function listenToAbilities() : void {
         var _local1:AbilityVO = null;
         for each(_local1 in this.abilityList) {
            _local1.updated.add(this.onAbilityUpdate);
         }
      }

      public function maxedAllAbilities() : Boolean {
         var _local2:AbilityVO = null;
         var _local1:int = 0;
         for each(_local2 in this.abilityList) {
            if(_local2.level == 100) {
               _local1++;
            }
         }
         return _local1 == this.abilityList.length;
      }

      private function onAbilityUpdate(param1:AbilityVO) : void {
         this.updated.dispatch();
      }

      public function apply(param1:XML) : void {
         this.extractBasicData(param1);
         this.extractAbilityData(param1);
      }

      private function extractBasicData(param1:XML) : void {
         param1.@instanceId && this.setID(param1.@instanceId);
         param1.@type && this.setType(param1.@type);
         param1.@name && this.setName(param1.@name);
         param1.@skin && this.setSkin(param1.@skin);
         param1.@rarity && this.setRarity(param1.@rarity);
      }

      public function extractAbilityData(param1:XML) : void {
         var _local2:uint = 0;
         var _local4:AbilityVO = null;
         var _local5:int = 0;
         var _local3:uint = this.abilityList.length;
         _local2 = 0;
         while(_local2 < _local3) {
            _local4 = this.abilityList[_local2];
            _local5 = param1.Abilities.Ability[_local2].@type;
            _local4.name = getPetDataDisplayId(_local5);
            _local4.description = getPetDataDescription(_local5);
            _local4.level = param1.Abilities.Ability[_local2].@power;
            _local4.points = param1.Abilities.Ability[_local2].@points;
            _local2++;
         }
      }

      public function getFamily() : String {
         return this.staticData.Family;
      }

      public function setID(param1:int) : void {
         this.id = param1;
      }

      public function getID() : int {
         return this.id;
      }

      public function setType(param1:int) : void {
         this.type = param1;
         this.staticData = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[this.type];
      }

      public function getType() : int {
         return this.type;
      }

      public function setRarity(param1:uint) : void {
         this.rarity = PetRarityEnum.selectByOrdinal(param1).value;
         this.unlockAbilitiesBasedOnPetRarity(param1);
         this.updated.dispatch();
      }

      private function unlockAbilitiesBasedOnPetRarity(param1:uint) : void {
         this.abilityList[0].setUnlocked(true);
         this.abilityList[1].setUnlocked(param1 >= PetRarityEnum.UNCOMMON.ordinal);
         this.abilityList[2].setUnlocked(param1 >= PetRarityEnum.LEGENDARY.ordinal);
      }

      public function getRarity() : String {
         return this.rarity;
      }

      public function setName(param1:String) : void {
         this.name = param1;
         this.updated.dispatch();
      }

      public function getName() : String {
         return this.name;
      }

      public function setMaxAbilityPower(param1:int) : void {
         this.maxAbilityPower = param1;
         this.updated.dispatch();
      }

      public function getMaxAbilityPower() : int {
         return this.maxAbilityPower;
      }

      public function setSkin(param1:int) : void {
         this.skinID = param1;
         this.updated.dispatch();
      }

      public function getSkinID() : int {
         return this.skinID;
      }

      public function getSkin() : Bitmap {
         this.makeSkin();
         var _local1:MaskedImage = this.skin.imageFromAngle(0,AnimatedChar.STAND,0);
         var _local2:int = this.rarity == PetRarityEnum.DIVINE.value?40:80;
         var _local3:BitmapData = TextureRedrawer.resize(_local1.image_,_local1.mask_,_local2,true,0,0);
         _local3 = GlowRedrawer.outlineGlow(_local3,0);
         return new Bitmap(_local3);
      }

      public function getSkinMaskedImage() : MaskedImage {
         this.makeSkin();
         return !!this.skin?this.skin.imageFromAngle(0,AnimatedChar.STAND,0):null;
      }

      private function makeSkin() : void {
         var _local1:XML = LOEBUILD_efda783509bc93eea698457c87bbee3f.getXMLfromId(LOEBUILD_efda783509bc93eea698457c87bbee3f.getIdFromType(this.skinID));
         var _local2:String = _local1.AnimatedTexture.File;
         var _local3:int = _local1.AnimatedTexture.Index;
         this.skin = AnimatedChars.getAnimatedChar(_local2,_local3);
      }
   }
}
