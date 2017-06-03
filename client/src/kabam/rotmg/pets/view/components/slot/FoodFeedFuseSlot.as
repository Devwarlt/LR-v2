package kabam.rotmg.pets.view.components.slot {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.util.DisplayHierarchy;
import com.company.util.MoreColorUtil;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.pets.view.FeedPetView;
import kabam.rotmg.pets.view.FusePetView;
import kabam.rotmg.questrewards.components.ModalItemSlot;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class FoodFeedFuseSlot extends FeedFuseSlot {

      public const foodLoaded:Signal = new Signal(int);

      public const foodUnloaded:Signal = new Signal();

      public var processing:Boolean = false;

      private var cancelCallback:Function;

      protected var grayscaleMatrix:ColorMatrixFilter;

      public var empty:Boolean = true;

      public function FoodFeedFuseSlot() {
         this.grayscaleMatrix = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
         super();
         itemSprite.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.updateTitle();
      }

      public function setProcessing(param1:Boolean) : void {
         var _local2:ColorTransform = null;
         if(this.processing != param1) {
            this.processing = param1;
            itemSprite.filters = !!param1?[this.grayscaleMatrix]:[];
            _local2 = !!param1?MoreColorUtil.darkCT:new ColorTransform();
            itemSprite.transform.colorTransform = _local2;
         }
      }

      override protected function onRemovedFromStage(param1:Event) : void {
         super.onRemovedFromStage(param1);
         this.clearAndCallCancel();
      }

      public function setItem(param1:int, param2:int, param3:int, param4:Function) : void {
         if(this.itemId != param1) {
            this.clearAndCallCancel();
            this.itemId = param1;
            this.slotId = param2;
            this.objectId = param3;
            itemBitmap.bitmapData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(param1,80,true);
            alignBitmapInBox();
            this.updateTitle();
            this.cancelCallback = param4;
         }
      }

      public function setItemPart2(param1:int) : void {
         this.foodLoaded.dispatch(param1);
      }

      public function updateTitle() : void {
         var _local1:XML = null;
         var _local2:String = null;
         if(Boolean(itemId) && itemId != -1) {
            setTitle(TextKey.PETORFOODSLOT_ITEM_POWER,{});
            _local1 = LOEBUILD_efda783509bc93eea698457c87bbee3f.getXMLfromId(LOEBUILD_efda783509bc93eea698457c87bbee3f.getIdFromType(itemId));
            _local2 = !!_local1.hasOwnProperty("feedPower")?_local1.feedPower:"0";
            setSubtitle(TextKey.BLANK,{"data":_local2});
         } else {
            setTitle(TextKey.PETORFOODSLOT_PLACE_ITEM,{});
            setSubtitle(TextKey.BLANK,{"data":""});
         }
      }

      public function setCancelCallback(param1:Function) : void {
         this.cancelCallback = param1;
      }

      public function clearItem() : void {
         this.clearAndCallCancel();
         itemId = ItemConstants.NO_ITEM;
         itemBitmap.bitmapData = null;
         slotId = -1;
         objectId = -1;
         this.updateTitle();
      }

      private function clearAndCallCancel() : void {
         this.cancelCallback && this.cancelCallback();
         this.cancelCallback = null;
      }

      private function alignBitmapOnMouse(param1:int, param2:int) : void {
         itemBitmap.x = -itemBitmap.width / 2;
         itemBitmap.y = -itemBitmap.height / 2;
         itemSprite.x = param1;
         itemSprite.y = param2;
      }

      private function onMouseDown(param1:MouseEvent) : void {
         if(!this.processing) {
            this.alignBitmapOnMouse(param1.stageX,param1.stageY);
            itemSprite.startDrag(true);
            itemSprite.addEventListener(MouseEvent.MOUSE_UP,this.endDrag);
            if(itemSprite.parent != null && itemSprite.parent != stage) {
               removeChild(itemSprite);
               stage.addChild(itemSprite);
            }
         }
      }

      private function endDrag(param1:MouseEvent) : void {
         itemSprite.stopDrag();
         itemSprite.removeEventListener(MouseEvent.MOUSE_UP,this.endDrag);
         stage.removeChild(itemSprite);
         addChild(itemSprite);
         alignBitmapInBox();
         var _local2:* = DisplayHierarchy.getParentWithTypeArray(itemSprite.dropTarget,FeedPetView,FusePetView,ModalItemSlot);
         if(!(_local2 is FeedPetView) && !(_local2 is FusePetView) && !(_local2 is ModalItemSlot && (_local2 as ModalItemSlot).interactable == true)) {
            this.empty = true;
            itemId = ItemConstants.NO_ITEM;
            itemBitmap.bitmapData = null;
            this.clearAndCallCancel();
            this.foodUnloaded.dispatch();
            this.updateTitle();
         }
      }
   }
}
