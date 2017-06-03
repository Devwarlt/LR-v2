package kabam.rotmg.pets.view.dialogs {
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.components.PetIcon;
import kabam.rotmg.pets.view.components.PetIconFactory;

public class PetItemFactory {

      [Inject]
      public var petIconFactory:PetIconFactory;

      public function PetItemFactory() {
         super();
      }

      public function create(param1:PetVO, param2:int) : PetItem {
         var _local3:PetItem = new PetItem();
         var _local4:PetIcon = this.petIconFactory.create(param1,param2);
         _local3.setPetIcon(_local4);
         _local3.setSize(param2);
         _local3.setBackground(PetItem.REGULAR);
         return _local3;
      }
   }
}
