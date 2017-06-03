package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c;
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class CharacterRectList extends Sprite {

      private var classes:ClassesModel;

      private var model:PlayerModel;

      private var assetFactory:CharacterFactory;

      public var newCharacter:Signal;

      public var buyCharacterSlot:Signal;

      public function CharacterRectList() {
         var _local5:LOEBUILD_7ebef6bdf3535c86294f666e62e89578 = null;
         var _local6:BuyCharacterRect = null;
         var _local7:CharacterClass = null;
         var _local8:LOEBUILD_9ef2cbbbd6e1617e4401a08c93ad0f9c = null;
         var _local9:CurrentCharacterRect = null;
         var _local10:int = 0;
         var _local11:CreateNewCharacterRect = null;
         super();
         var _local1:Injector = StaticInjectorContext.getInjector();
         this.classes = _local1.getInstance(ClassesModel);
         this.model = _local1.getInstance(PlayerModel);
         this.assetFactory = _local1.getInstance(CharacterFactory);
         this.newCharacter = new Signal();
         this.buyCharacterSlot = new Signal();
         var _local2:String = this.model.getName();
         var _local3:int = 4;
         var _local4:Vector.<LOEBUILD_7ebef6bdf3535c86294f666e62e89578> = this.model.getSavedCharacters();
         for each(_local5 in _local4) {
            _local7 = this.classes.getCharacterClass(_local5.objectType());
            _local8 = this.model.getCharStats()[_local5.objectType()];
            _local9 = new CurrentCharacterRect(_local2,_local7,_local5,_local8);
            _local9.setIcon(this.getIcon(_local5));
            _local9.y = _local3;
            addChild(_local9);
            _local3 = _local3 + (CharacterRect.HEIGHT + 4);
         }
         if(this.model.hasAvailableCharSlot()) {
            _local10 = 0;
            while(_local10 < this.model.getAvailableCharSlots()) {
               _local11 = new CreateNewCharacterRect(this.model);
               _local11.addEventListener(MouseEvent.MOUSE_DOWN,this.onNewChar);
               _local11.y = _local3;
               addChild(_local11);
               _local3 = _local3 + (CharacterRect.HEIGHT + 4);
               _local10++;
            }
         }
         _local6 = new BuyCharacterRect(this.model);
         _local6.addEventListener(MouseEvent.MOUSE_DOWN,this.onBuyCharSlot);
         _local6.y = _local3;
         addChild(_local6);
      }

      private function getIcon(param1:LOEBUILD_7ebef6bdf3535c86294f666e62e89578) : DisplayObject {
         var _local2:CharacterClass = this.classes.getCharacterClass(param1.objectType());
         var _local3:CharacterSkin = _local2.skins.getSkin(param1.skinType()) || _local2.skins.getDefaultSkin();
         var _local4:BitmapData = this.assetFactory.makeIcon(_local3.template,100,param1.tex1(),param1.tex2());
         return new Bitmap(_local4);
      }

      private function onNewChar(param1:Event) : void {
         this.newCharacter.dispatch();
      }

      private function onBuyCharSlot(param1:Event) : void {
         this.buyCharacterSlot.dispatch(this.model.getNextCharSlotPrice());
      }
   }
}
