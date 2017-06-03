package kabam.rotmg.mysterybox.components {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
import kabam.rotmg.mysterybox.services.MysteryBoxModel;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.swiftsuspenders.Injector;

public class MysteryBoxSelectModal extends Sprite {

      public static var modalWidth:int;

      public static var modalHeight:int;

      public static var aMysteryBoxHeight:int;

      public static const TEXT_MARGIN:int = 20;

      public static var open:Boolean;

      public static var backgroundImageEmbed:Class = MysteryBoxSelectModal_backgroundImageEmbed;

      private var closeButton:DialogCloseButton;

      private var box_:Sprite;

      private var mysteryData:Object;

      private var titleString:String = "MysteryBoxSelectModal.titleString";

      public function MysteryBoxSelectModal() {
         this.box_ = new Sprite();
         super();
         modalWidth = 385;
         modalHeight = 60;
         aMysteryBoxHeight = 77;
         var _local1:Injector = StaticInjectorContext.getInjector();
         var _local2:MysteryBoxModel = _local1.getInstance(MysteryBoxModel);
         this.mysteryData = _local2.getBoxesOrderByWeight();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         addChild(this.box_);
         this.addBoxChildren();
         this.positionAndStuff();
         open = true;
      }

      public static function getRightBorderX() : int {
         return 300 + modalWidth / 2;
      }

      private static function makeModalBackground(param1:int, param2:int) : PopupWindowBackground {
         var _local3:PopupWindowBackground = new PopupWindowBackground();
         _local3.draw(param1,param2,PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
         return _local3;
      }

      public function getText(param1:String, param2:int, param3:int) : TextFieldDisplayConcrete {
         var _local4:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(modalWidth - TEXT_MARGIN * 2);
         _local4.setBold(true);
         _local4.setStringBuilder(new LineBuilder().setParams(param1));
         _local4.setWordWrap(true);
         _local4.setMultiLine(true);
         _local4.setAutoSize(TextFieldAutoSize.CENTER);
         _local4.setHorizontalAlign(TextFormatAlign.CENTER);
         _local4.filters = [new DropShadowFilter(0,0,0)];
         _local4.x = param2;
         _local4.y = param3;
         return _local4;
      }

      private function positionAndStuff() : void {
         this.box_.x = 500 / 2 - modalWidth / 2;
         this.box_.y = 600 / 2 - modalHeight / 2;
      }

      private function addBoxChildren() : void {
         var _local1:MysteryBoxInfo = null;
         var _local2:DisplayObject = null;
         var _local5:int = 0;
         var _local6:MysteryBoxSelectEntry = null;
         for each(_local1 in this.mysteryData) {
            modalHeight = modalHeight + aMysteryBoxHeight;
         }
         _local2 = new backgroundImageEmbed();
         _local2.width = modalWidth + 1;
         _local2.height = modalHeight - 25;
         _local2.y = 27;
         _local2.alpha = 0.95;
         this.box_.addChild(_local2);
         this.box_.addChild(makeModalBackground(modalWidth,modalHeight));
         this.closeButton = PetsViewAssetFactory.returnCloseButton(modalWidth);
         this.box_.addChild(this.closeButton);
         this.box_.addChild(this.getText(this.titleString,TEXT_MARGIN,6).setSize(18));
         var _local3:Number = 20;
         var _local4:Number = 50;
         _local5 = 0;
         for each(_local1 in this.mysteryData) {
            if(_local5 == 6) {
               break;
            }
            _local6 = new MysteryBoxSelectEntry(_local1);
            _local6.x = x + _local3;
            _local6.y = y + _local4;
            _local4 = _local4 + aMysteryBoxHeight;
            this.box_.addChild(_local6);
            _local5++;
         }
      }

      private function onRemovedFromStage(param1:Event) : void {
         open = false;
      }
   }
}
