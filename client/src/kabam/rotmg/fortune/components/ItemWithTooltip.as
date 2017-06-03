package kabam.rotmg.fortune.components {
import com.company.assembleegameclient.LOEBUILD_93fb40ec02c008121fa9199899b31202.LOEBUILD_420e0eb99409a66597f19d612d12594f;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

import org.osflash.signals.Signal;

public class ItemWithTooltip extends Sprite implements TooltipAble {

      private var itemId:int;

      public var hoverTooltipDelegate:HoverTooltipDelegate;

      private var tooltip:ToolTip;

      public var onMouseOver:Signal;

      public var onMouseOut:Signal;

      public var itemBitmap:Bitmap;

      public function ItemWithTooltip(param1:int, param2:int = 100, param3:Boolean = false) {
         this.hoverTooltipDelegate = new HoverTooltipDelegate();
         this.onMouseOver = new Signal();
         this.onMouseOut = new Signal();
         super();
         this.itemId = param1;
         var _local4:BitmapData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(param1,param2,true,false);
         var _local5:BitmapData = LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(param1,param2,true,false);
         this.itemBitmap = new Bitmap(_local5);
         addChild(this.itemBitmap);
         this.hoverTooltipDelegate.setDisplayObject(this);
         this.tooltip = new EquipmentToolTip(param1,null,-1,LOEBUILD_420e0eb99409a66597f19d612d12594f.NPC);
         this.tooltip.forcePostionLeft();
         this.hoverTooltipDelegate.tooltip = this.tooltip;
         if(param3) {
            addEventListener(Event.REMOVED_FROM_STAGE,this.onDestruct);
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         }
      }

      public function disableTooltip() : void {
         this.hoverTooltipDelegate.removeDisplayObject();
      }

      public function enableTooltip() : void {
         this.hoverTooltipDelegate.setDisplayObject(this);
      }

      private function onDestruct(param1:Event) : void {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onDestruct);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this.onMouseOver.removeAll();
         this.onMouseOut.removeAll();
      }

      private function onRollOver(param1:MouseEvent) : void {
         this.onMouseOver.dispatch();
      }

      private function onRollOut(param1:MouseEvent) : void {
         this.onMouseOut.dispatch();
      }

      public function setShowToolTipSignal(param1:ShowTooltipSignal) : void {
         this.hoverTooltipDelegate.setShowToolTipSignal(param1);
      }

      public function getShowToolTip() : ShowTooltipSignal {
         return this.hoverTooltipDelegate.getShowToolTip();
      }

      public function setHideToolTipsSignal(param1:HideTooltipsSignal) : void {
         this.hoverTooltipDelegate.setHideToolTipsSignal(param1);
      }

      public function getHideToolTips() : HideTooltipsSignal {
         return this.hoverTooltipDelegate.getHideToolTips();
      }

      public function setXPos(param1:Number) : void {
         this.x = param1 - this.width / 2;
      }

      public function setYPos(param1:Number) : void {
         this.y = param1 - this.height / 2;
      }

      public function getCenterX() : Number {
         return this.x + this.width / 2;
      }

      public function getCenterY() : Number {
         return this.y + this.height / 2;
      }
   }
}
