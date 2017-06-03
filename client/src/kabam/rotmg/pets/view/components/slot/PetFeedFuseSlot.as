package kabam.rotmg.pets.view.components.slot {
import com.company.util.MoreColorUtil;

import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.pets.data.PetFamilyKeys;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.components.PetIcon;
import kabam.rotmg.pets.view.components.PetIconFactory;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;

import org.osflash.signals.Signal;

public class PetFeedFuseSlot extends FeedFuseSlot {

      public const openPetPicker:Signal = new Signal();

      public var showFamily:Boolean = false;

      public var processing:Boolean = false;

      private var petIconFactory:PetIconFactory;

      private var grayscaleMatrix:ColorMatrixFilter;

      public function PetFeedFuseSlot() {
         this.petIconFactory = new PetIconFactory();
         this.grayscaleMatrix = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
         super();
         addEventListener(MouseEvent.CLICK,this.onOpenPetPicker);
         this.updateTitle();
      }

      public function updateTitle() : void {
         if(!icon || Boolean(contains(icon))) {
            setTitle(TextKey.PETORFOODSLOT_FUSE_PET_TITLE,{});
         }
      }

      private function onOpenPetPicker(param1:MouseEvent) : void {
         if(!this.processing) {
            this.openPetPicker.dispatch();
         }
      }

      public function setPetIcon(param1:PetVO) : void {
         var _local2:PetIcon = this.petIconFactory.create(param1,48);
         setIcon(_local2);
      }

      public function setPet(param1:PetVO) : void {
         var _local2:AppendingLineBuilder = null;
         if(param1) {
            this.setPetIcon(param1);
            setTitle(TextKey.BLANK,{"data":param1.getName()});
            _local2 = new AppendingLineBuilder();
            _local2.pushParams(param1.getRarity());
            this.showFamily && _local2.pushParams(PetFamilyKeys.getTranslationKey(param1.getFamily()));
            setSubtitle(TextKey.BLANK,{"data":_local2});
         }
      }

      public function setProcessing(param1:Boolean) : void {
         var _local2:ColorTransform = null;
         if(this.processing != param1) {
            this.processing = param1;
            icon.filters = !!param1?[this.grayscaleMatrix]:[];
            _local2 = !!param1?MoreColorUtil.darkCT:new ColorTransform();
            icon.transform.colorTransform = _local2;
         }
      }
   }
}
