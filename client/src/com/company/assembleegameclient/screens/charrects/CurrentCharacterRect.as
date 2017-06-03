package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;
import com.company.assembleegameclient.screens.events.DeleteCharacterEvent;
import com.company.assembleegameclient.ui.tooltip.MyPlayerToolTip;
import com.company.assembleegameclient.util.FameUtil;
import com.company.rotmg.graphics.DeleteXGraphic;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class CurrentCharacterRect extends CharacterRect {

      private static var toolTip_:MyPlayerToolTip = null;

      public const selected:Signal = new Signal();

      public const deleteCharacter:Signal = new Signal();

      public const showToolTip:Signal = new Signal(Sprite);

      public const hideTooltip:Signal = new Signal();

      public var charName:String;

      public var charStats:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;

      public var char:LOEBUILD_7ebef6bdf3535c86294f666e62e89578;

      public var myPlayerToolTipFactory:MyPlayerToolTipFactory;

      private var charType:CharacterClass;

      private var deleteButton:Sprite;

      private var icon:DisplayObject;

      public function CurrentCharacterRect(param1:String, param2:CharacterClass, param3:LOEBUILD_7ebef6bdf3535c86294f666e62e89578, param4:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c) {
         this.myPlayerToolTipFactory = new MyPlayerToolTipFactory();
         super();
         this.charName = param1;
         this.charType = param2;
         this.char = param3;
         this.charStats = param4;
         var _local5:String = param2.name;
         var _local6:int = param3.charXML_.Level;
         super.className = new LineBuilder().setParams(TextKey.CURRENT_CHARACTER_DESCRIPTION,{
            "className":_local5,
            "level":"- Lvl: " + _local6
         });
         super.color = 6052956;
         super.overColor = 8355711;
         super.init();
         this.makeTagline();
         this.makeDeleteButton();
         this.addEventListeners();
      }

      private function addEventListeners() : void {
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         selectContainer.addEventListener(MouseEvent.CLICK,this.onSelect);
         this.deleteButton.addEventListener(MouseEvent.CLICK,this.onDelete);
      }

      private function onSelect(param1:MouseEvent) : void {
         this.selected.dispatch(this.char);
      }

      private function onDelete(param1:MouseEvent) : void {
         this.deleteCharacter.dispatch(this.char);
      }

      public function setIcon(param1:DisplayObject) : void {
         this.icon && selectContainer.removeChild(this.icon);
         this.icon = param1;
         this.icon.x = CharacterRectConstants.ICON_POS_X;
         this.icon.y = CharacterRectConstants.ICON_POS_Y;
         this.icon && selectContainer.addChild(this.icon);
      }

    public function addComma(num:uint):String{
        if(num == 0) {
            return "0";
        }
        var str:String="";
        while(num>0){
            var tmp:uint=num%1000;
            str=(num>999?","+(tmp<100?(tmp<10?"00":"0"):""):"")+tmp+str;
            num=num/1000;
        }
        return str;
    }

      private function makeTagline() : void {
         //if(this.getNextStarFame() > 0) {
        super.makeTaglineIcon();
        super.makeTaglineText(new StaticStringBuilder(addComma(this.char.xp()) + " EXP / " + addComma(this.char.fame()) + " Fame"));
        taglineText.x = taglineText.x + taglineIcon.width;
             // update .32.451X
            /*super.makeTaglineText(new LineBuilder().setParams(TextKey.CURRENT_CHARACTER_TAGLINE,{
               "fame":this.char.fame(),
               "nextStarFame":this.getNextStarFame()
            }));*/
         //}
      }

      private function getNextStarFame() : int {
         return FameUtil.nextStarFame(this.charStats == null?0:int(this.charStats.bestFame()),this.char.fame());
      }

      private function makeDeleteButton() : void {
         this.deleteButton = new DeleteXGraphic();
         this.deleteButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onDeleteDown);
         this.deleteButton.x = WIDTH - 40;
         this.deleteButton.y = (HEIGHT - this.deleteButton.height) * 0.5;
         addChild(this.deleteButton);
      }

      override protected function onMouseOver(param1:MouseEvent) : void {
         super.onMouseOver(param1);
         this.removeToolTip();
         toolTip_ = this.myPlayerToolTipFactory.create(this.charName,this.char.charXML_,this.charStats);
         toolTip_.createUI();
         this.showToolTip.dispatch(toolTip_);
      }

      override protected function onRollOut(param1:MouseEvent) : void {
         super.onRollOut(param1);
         this.removeToolTip();
      }

      private function onRemovedFromStage(param1:Event) : void {
         this.removeToolTip();
      }

      private function removeToolTip() : void {
         this.hideTooltip.dispatch();
      }

      private function onDeleteDown(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         dispatchEvent(new DeleteCharacterEvent(this.char));
      }
   }
}
