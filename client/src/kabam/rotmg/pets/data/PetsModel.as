package kabam.rotmg.pets.data {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;
import com.company.assembleegameclient.map.LOEBUILD_fa44c2f4ed610d0a29b25a8fff9d67e7;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.pets.controller.NotifyActivePetUpdated;

public class PetsModel {

      [Inject]
      public var notifyActivePetUpdated:NotifyActivePetUpdated;

      [Inject]
      public var playerModel:PlayerModel;

      private var hash:Object;

      private var pets:Vector.<PetVO>;

      private var yardXmlData:XML;

      private var type:int;

      private var activePet:PetVO;

      public function PetsModel() {
         this.hash = {};
         this.pets = new Vector.<PetVO>();
         super();
      }

      public function getPetVO(param1:int) : PetVO {
         var _local2:PetVO = null;
         if(this.hash[param1] != null) {
            return this.hash[param1];
         }
         _local2 = new PetVO(param1);
         this.pets.push(_local2);
         this.hash[param1] = _local2;
         return _local2;
      }

      public function getCachedVOOnly(param1:int) : PetVO {
         return this.hash[param1];
      }

      public function getAllPets() : Vector.<PetVO> {
         return this.pets;
      }

      public function addPet(param1:PetVO) : void {
         this.pets.push(param1);
      }

      public function setActivePet(param1:PetVO) : void {
         this.activePet = param1;
         var _local2:LOEBUILD_7ebef6bdf3535c86294f666e62e89578 = this.playerModel.getCharacterById(this.playerModel.currentCharId);
         if(_local2) {
            _local2.setPetVO(this.activePet);
         }
         this.notifyActivePetUpdated.dispatch();
      }

      public function getActivePet() : PetVO {
         return this.activePet;
      }

      public function removeActivePet() : void {
         var _local1:LOEBUILD_7ebef6bdf3535c86294f666e62e89578 = this.playerModel.getCharacterById(this.playerModel.currentCharId);
         if(_local1) {
            _local1.setPetVO(null);
         }
         this.activePet = null;
         this.notifyActivePetUpdated.dispatch();
      }

      public function getPet(param1:int) : PetVO {
         var _local2:int = this.getPetIndex(param1);
         if(_local2 == -1) {
            return null;
         }
         return this.pets[_local2];
      }

      private function getPetIndex(param1:int) : int {
         var _local2:PetVO = null;
         var _local3:uint = 0;
         while(_local3 < this.pets.length) {
            _local2 = this.pets[_local3];
            if(_local2.getID() == param1) {
               return _local3;
            }
            _local3++;
         }
         return -1;
      }

      public function setPetYardType(param1:int) : void {
         this.type = param1;
         this.yardXmlData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getXMLfromId(LOEBUILD_efda783509bc93eea698457c87bbee3f.getIdFromType(param1));
      }

      public function getPetYardRarity() : uint {
         return PetYardEnum.selectByValue(this.yardXmlData.@id).rarity.ordinal;
      }

      public function getPetYardType() : int {
         return !!this.yardXmlData?int(PetYardEnum.selectByValue(this.yardXmlData.@id).ordinal):1;
      }

      public function isMapNameYardName(param1:LOEBUILD_fa44c2f4ed610d0a29b25a8fff9d67e7) : Boolean {
         return Boolean(param1.name_) && param1.name_.substr(0,8) == "Pet Yard";
      }

      public function getPetYardUpgradeFamePrice() : int {
         return int(this.yardXmlData.Fame);
      }

      public function getPetYardUpgradeGoldPrice() : int {
         return int(this.yardXmlData.Price);
      }

      public function getPetYardObjectID() : int {
         return this.type;
      }

      public function deletePet(param1:int) : void {
         this.pets.splice(this.getPetIndex(param1),1);
      }

      public function clearPets() : void {
         this.hash = {};
         this.pets = new Vector.<PetVO>();
         this.removeActivePet();
      }
   }
}
