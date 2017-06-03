package kabam.rotmg.pets.view.dialogs {
import flash.display.DisplayObject;
import flash.events.MouseEvent;

import kabam.rotmg.pets.data.PetVO;

import org.osflash.signals.Signal;

public class PetPicker extends GridList implements ClearsPetSlots {

      [Inject]
      public var petIconFactory:PetItemFactory;

      public var petPicked:Signal;

      private var petItems:Vector.<PetItem>;

      private var petSize:int;

      private var items:Vector.<PetItem>;

      public var doDisableUsed:Boolean = true;

      public function PetPicker() {
         this.petPicked = new PetVOSignal();
         this.items = new Vector.<PetItem>();
         super();
      }

      private static function sortByFirstAbilityPoints(param1:PetItem, param2:PetItem) : int {
         var _local3:int = param1.getPetVO().abilityList[0].points;
         var _local4:int = param2.getPetVO().abilityList[0].points;
         return _local4 - _local3;
      }

      public function setPets(param1:Vector.<PetVO>) : void {
         this.makePetItems(param1);
         this.addToGridList();
         setItems(this.items);
         this.setCorners();
      }

      private function addToGridList() : void {
         var _local1:PetItem = null;
         for each(_local1 in this.petItems) {
            this.items.push(_local1);
         }
      }

      private function makePetItems(param1:Vector.<PetVO>) : void {
         var _local2:PetVO = null;
         this.petItems = new Vector.<PetItem>();
         for each(_local2 in param1) {
            this.addPet(_local2);
         }
         this.petItems.sort(sortByFirstAbilityPoints);
      }

      private function setCorners() : void {
         this.setPetItemState(getTopLeft(),PetItem.TOP_LEFT);
         this.setPetItemState(getTopRight(),PetItem.TOP_RIGHT);
         this.setPetItemState(getBottomLeft(),PetItem.BOTTOM_LEFT);
         this.setPetItemState(getBottomRight(),PetItem.BOTTOM_RIGHT);
      }

      private function setPetItemState(param1:DisplayObject, param2:String) : void {
         if(param1) {
            PetItem(param1).setBackground(param2);
         }
      }

      public function setPetSize(param1:int) : void {
         this.petSize = param1;
      }

      public function getPets() : Vector.<PetItem> {
         return this.petItems;
      }

      public function getPet(param1:int) : PetItem {
         return this.petItems[param1];
      }

      public function filterFusible(param1:PetVO) : void {
         var _local3:PetVO = null;
         var _local2:int = 0;
         while(_local2 < this.petItems.length) {
            _local3 = this.petItems[_local2].getPetVO();
            if(!this.isFusible(param1,_local3)) {
               this.petItems[_local2].disable();
            }
            _local2++;
         }
      }

      public function filterUsedPetVO(param1:PetVO) : void {
         var _local3:PetVO = null;
         var _local2:int = 0;
         while(_local2 < this.petItems.length) {
            _local3 = this.petItems[_local2].getPetVO();
            if(_local3.getID() == param1.getID()) {
               this.petItems[_local2].disable();
            }
            _local2++;
         }
      }

      private function isFusible(param1:PetVO, param2:PetVO) : Boolean {
         return param1.getFamily() == param2.getFamily() && param1.getRarity() == param2.getRarity();
      }

      private function addPet(param1:PetVO) : void {
         var pet:Disableable = null;
         var pet_clickHandler:Function = null;
         var petVO:PetVO = param1;
         pet_clickHandler = function(param1:MouseEvent):void {
            if(pet.isEnabled()) {
               petPicked.dispatch(petVO);
            }
         };
         pet = this.petIconFactory.create(petVO,this.petSize);
         this.petItems.push(pet);
         pet.addEventListener(MouseEvent.CLICK,pet_clickHandler);
      }
   }
}
