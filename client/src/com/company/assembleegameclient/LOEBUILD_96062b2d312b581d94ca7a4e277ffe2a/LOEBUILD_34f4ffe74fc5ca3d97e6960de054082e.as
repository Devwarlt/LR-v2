package com.company.assembleegameclient.LOEBUILD_96062b2d312b581d94ca7a4e277ffe2a {
import com.company.assembleegameclient.editor.LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c;
import com.company.assembleegameclient.editor.LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99;
import com.company.assembleegameclient.editor.LOEBUILD_a001afe30b856ac454cdb0ebba01243c;
import com.company.assembleegameclient.map.LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5;
import com.company.assembleegameclient.map.LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.ui.dropdown.DropDown;
import com.company.util.IntPoint;
import com.company.util.SpriteUtil;
import com.hurlant.util.Base64;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.geom.Rectangle;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.utils.ByteArray;

import kabam.lib.json.JsonParser;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.ui.view.components.ScreenBase;

import com.company.util.Stats;

public class LOEBUILD_34f4ffe74fc5ca3d97e6960de054082e extends Sprite {

      private static const MAP_Y:int = 600 - LOEBUILD_d5569d48c9e4a976a51c625e3a800107.SIZE - 10;

      public static const stats_:Stats = new Stats();

      public var commandMenu_:LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0;

      private var commandQueue_:LOEBUILD_a001afe30b856ac454cdb0ebba01243c;

      public var meMap_:LOEBUILD_d5569d48c9e4a976a51c625e3a800107;

      public var infoPane_:LOEBUILD_55eb690301f900172cf05bb770b7e9a8;

      public var chooserDrowDown_:DropDown;

      public var groundChooser_:LOEBUILD_2e15ae9561c5eb6567aace438b1c4fcc;

      public var objChooser_:LOEBUILD_ead4523cc11ab3fa9d1e2395ae0ffeb0;

      public var regionChooser_:LOEBUILD_76cc4d28ed442118246cb495102d2243;

      public var chooser_:LOEBUILD_241f7212fc0a9d7d79ce54e77768ee0b;

      public var filename_:String = null;

      private var json:JsonParser;

      private var tilesBackup:Vector.<LOEBUILD_822148805b3866cb113421c05e57390d>;

      private var loadedFile_:FileReference = null;

      public function LOEBUILD_34f4ffe74fc5ca3d97e6960de054082e() {
         super();
         addChild(new ScreenBase());
         addChild(new AccountScreen());
         this.json = StaticInjectorContext.getInjector().getInstance(JsonParser);
         this.commandMenu_ = new LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0();
         this.commandMenu_.x = 15;
         this.commandMenu_.y = MAP_Y - 30;
         this.commandMenu_.addEventListener(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.UNDO_COMMAND_EVENT,this.onUndo);
         this.commandMenu_.addEventListener(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.REDO_COMMAND_EVENT,this.onRedo);
         this.commandMenu_.addEventListener(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.CLEAR_COMMAND_EVENT,this.onClear);
         this.commandMenu_.addEventListener(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.LOAD_COMMAND_EVENT,this.onLoad);
         this.commandMenu_.addEventListener(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.SAVE_COMMAND_EVENT,this.onSave);
         this.commandMenu_.addEventListener(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.TEST_COMMAND_EVENT,this.onTest);
         this.commandMenu_.addEventListener(LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c.SELECT_COMMAND_EVENT,this.onMenuSelect);
         addChild(this.commandMenu_);
         this.commandQueue_ = new LOEBUILD_a001afe30b856ac454cdb0ebba01243c();
         this.meMap_ = new LOEBUILD_d5569d48c9e4a976a51c625e3a800107();
         this.meMap_.addEventListener(LOEBUILD_9193e2fe6dbacd2489b5fbd9c60957b1.TILES_EVENT,this.onTilesEvent);
         this.meMap_.x = 800 / 2 - LOEBUILD_d5569d48c9e4a976a51c625e3a800107.SIZE / 2;
         this.meMap_.y = MAP_Y;
         addChild(this.meMap_);
         this.infoPane_ = new LOEBUILD_55eb690301f900172cf05bb770b7e9a8(this.meMap_);
         this.infoPane_.x = 4;
         this.infoPane_.y = 600 - LOEBUILD_55eb690301f900172cf05bb770b7e9a8.HEIGHT - 10;
         addChild(this.infoPane_);
         this.chooserDrowDown_ = new DropDown(new <String>["Ground","Objects","Regions"],LOEBUILD_241f7212fc0a9d7d79ce54e77768ee0b.WIDTH,26);
         this.chooserDrowDown_.x = this.meMap_.x + LOEBUILD_d5569d48c9e4a976a51c625e3a800107.SIZE + 4;
         this.chooserDrowDown_.y = MAP_Y;
         this.chooserDrowDown_.addEventListener(Event.CHANGE,this.onDropDownChange);
         addChild(this.chooserDrowDown_);
         this.groundChooser_ = new LOEBUILD_2e15ae9561c5eb6567aace438b1c4fcc();
         this.groundChooser_.x = this.chooserDrowDown_.x;
         this.groundChooser_.y = this.chooserDrowDown_.y + this.chooserDrowDown_.height + 4;
         this.chooser_ = this.groundChooser_;
         addChild(this.groundChooser_);
         this.objChooser_ = new LOEBUILD_ead4523cc11ab3fa9d1e2395ae0ffeb0();
         this.objChooser_.x = this.chooserDrowDown_.x;
         this.objChooser_.y = this.chooserDrowDown_.y + this.chooserDrowDown_.height + 4;
         this.regionChooser_ = new LOEBUILD_76cc4d28ed442118246cb495102d2243();
         this.regionChooser_.x = this.chooserDrowDown_.x;
         this.regionChooser_.y = this.chooserDrowDown_.y + this.chooserDrowDown_.height + 4;
      }

      private function onTilesEvent(param1:LOEBUILD_9193e2fe6dbacd2489b5fbd9c60957b1) : void {
         var _local2:IntPoint = null;
         var _local3:LOEBUILD_822148805b3866cb113421c05e57390d = null;
         var _local4:int = 0;
         var _local5:String = null;
         var _local6:LOEBUILD_ccbec8318fc2e342d17cbf37b8f8ab05 = null;
         var _local7:Vector.<LOEBUILD_822148805b3866cb113421c05e57390d> = null;
         _local2 = param1.tiles_[0];
         switch(this.commandMenu_.getCommand()) {
            case LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.DRAW_COMMAND:
               this.addModifyCommandList(param1.tiles_,this.chooser_.layer_,this.chooser_.selectedType());
               break;
            case LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.ERASE_COMMAND:
               this.addModifyCommandList(param1.tiles_,this.chooser_.layer_,-1);
               break;
            case LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.SAMPLE_COMMAND:
               _local4 = this.meMap_.getType(_local2.x_,_local2.y_,this.chooser_.layer_);
               if(_local4 == -1) {
                  return;
               }
               this.chooser_.setSelectedType(_local4);
               this.commandMenu_.setCommand(LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.DRAW_COMMAND);
               break;
            case LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.EDIT_COMMAND:
               _local5 = this.meMap_.getObjectName(_local2.x_,_local2.y_);
               _local6 = new LOEBUILD_ccbec8318fc2e342d17cbf37b8f8ab05(param1.tiles_,_local5);
               _local6.addEventListener(Event.COMPLETE,this.onEditComplete);
               addChild(_local6);
               break;
            case LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.CUT_COMMAND:
               this.tilesBackup = new Vector.<LOEBUILD_822148805b3866cb113421c05e57390d>();
               _local7 = new Vector.<LOEBUILD_822148805b3866cb113421c05e57390d>();
               for each(_local2 in param1.tiles_) {
                  _local3 = this.meMap_.getTile(_local2.x_,_local2.y_);
                  if(_local3 != null) {
                     _local3 = _local3.clone();
                  }
                  this.tilesBackup.push(_local3);
                  _local7.push(null);
               }
               this.addPasteCommandList(param1.tiles_,_local7);
               this.meMap_.freezeSelect();
               this.commandMenu_.setCommand(LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.PASTE_COMMAND);
               break;
            case LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.COPY_COMMAND:
               this.tilesBackup = new Vector.<LOEBUILD_822148805b3866cb113421c05e57390d>();
               for each(_local2 in param1.tiles_) {
                  _local3 = this.meMap_.getTile(_local2.x_,_local2.y_);
                  if(_local3 != null) {
                     _local3 = _local3.clone();
                  }
                  this.tilesBackup.push(_local3);
               }
               this.meMap_.freezeSelect();
               this.commandMenu_.setCommand(LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.PASTE_COMMAND);
               break;
            case LOEBUILD_1122f4dd86f4e8ec6effc2726d9965d0.PASTE_COMMAND:
               this.addPasteCommandList(param1.tiles_,this.tilesBackup);
         }
         this.meMap_.draw();
      }

      private function onEditComplete(param1:Event) : void {
         var _local2:LOEBUILD_ccbec8318fc2e342d17cbf37b8f8ab05 = param1.currentTarget as LOEBUILD_ccbec8318fc2e342d17cbf37b8f8ab05;
         this.addObjectNameCommandList(_local2.tiles_,_local2.getObjectName());
      }

      private function addModifyCommandList(param1:Vector.<IntPoint>, param2:int, param3:int) : void {
         var _local5:IntPoint = null;
         var _local6:int = 0;
         var _local4:LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99 = new LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99();
         for each(_local5 in param1) {
            _local6 = this.meMap_.getType(_local5.x_,_local5.y_,param2);
            if(_local6 != param3) {
               _local4.addCommand(new LOEBUILD_7c5347632b200e9d64e19d0924796c4d(this.meMap_,_local5.x_,_local5.y_,param2,_local6,param3));
            }
         }
         if(_local4.empty()) {
            return;
         }
         this.commandQueue_.addCommandList(_local4);
      }

      private function addPasteCommandList(param1:Vector.<IntPoint>, param2:Vector.<LOEBUILD_822148805b3866cb113421c05e57390d>) : void {
         var _local5:IntPoint = null;
         var _local6:LOEBUILD_822148805b3866cb113421c05e57390d = null;
         var _local3:LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99 = new LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99();
         var _local4:int = 0;
         for each(_local5 in param1) {
            if(_local4 >= param2.length) {
               break;
            }
            _local6 = this.meMap_.getTile(_local5.x_,_local5.y_);
            _local3.addCommand(new LOEBUILD_7759ec5be4042688da18250fd403c846(this.meMap_,_local5.x_,_local5.y_,_local6,param2[_local4]));
            _local4++;
         }
         if(_local3.empty()) {
            return;
         }
         this.commandQueue_.addCommandList(_local3);
      }

      private function addObjectNameCommandList(param1:Vector.<IntPoint>, param2:String) : void {
         var _local4:IntPoint = null;
         var _local5:String = null;
         var _local3:LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99 = new LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99();
         for each(_local4 in param1) {
            _local5 = this.meMap_.getObjectName(_local4.x_,_local4.y_);
            if(_local5 != param2) {
               _local3.addCommand(new LOEBUILD_83402ad6bf8945721f5f6fdce4f58c8b(this.meMap_,_local4.x_,_local4.y_,_local5,param2));
            }
         }
         if(_local3.empty()) {
            return;
         }
         this.commandQueue_.addCommandList(_local3);
      }

      private function onDropDownChange(param1:Event) : void {
         switch(this.chooserDrowDown_.getValue()) {
            case "Ground":
               SpriteUtil.safeAddChild(this,this.groundChooser_);
               SpriteUtil.safeRemoveChild(this,this.objChooser_);
               SpriteUtil.safeRemoveChild(this,this.regionChooser_);
               this.chooser_ = this.groundChooser_;
               break;
            case "Objects":
               SpriteUtil.safeRemoveChild(this,this.groundChooser_);
               SpriteUtil.safeAddChild(this,this.objChooser_);
               SpriteUtil.safeRemoveChild(this,this.regionChooser_);
               this.chooser_ = this.objChooser_;
               break;
            case "Regions":
               SpriteUtil.safeRemoveChild(this,this.groundChooser_);
               SpriteUtil.safeRemoveChild(this,this.objChooser_);
               SpriteUtil.safeAddChild(this,this.regionChooser_);
               this.chooser_ = this.regionChooser_;
         }
      }

      private function onUndo(param1:LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c) : void {
         this.commandQueue_.undo();
         this.meMap_.draw();
      }

      private function onRedo(param1:LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c) : void {
         this.commandQueue_.redo();
         this.meMap_.draw();
      }

      private function onClear(param1:LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c) : void {
         var _local4:IntPoint = null;
         var _local5:LOEBUILD_822148805b3866cb113421c05e57390d = null;
         var _local2:Vector.<IntPoint> = this.meMap_.getAllTiles();
         var _local3:LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99 = new LOEBUILD_92fef239e9a68d04805d90e9f8f8ae99();
         for each(_local4 in _local2) {
            _local5 = this.meMap_.getTile(_local4.x_,_local4.y_);
            if(_local5 != null) {
               _local3.addCommand(new LOEBUILD_e419003058acd0e76b9928f3f4a264d7(this.meMap_,_local4.x_,_local4.y_,_local5));
            }
         }
         if(_local3.empty()) {
            return;
         }
         this.commandQueue_.addCommandList(_local3);
         this.meMap_.draw();
         this.filename_ = null;
      }

      private function createMapJSON() : String {
         var _local7:int = 0;
         var _local8:LOEBUILD_822148805b3866cb113421c05e57390d = null;
         var _local9:Object = null;
         var _local10:String = null;
         var _local11:int = 0;
         var _local1:Rectangle = this.meMap_.getTileBounds();
         if(_local1 == null) {
            return null;
         }
         var _local2:Object = {};
         _local2["width"] = int(_local1.width);
         _local2["height"] = int(_local1.height);
         var _local3:Object = {};
         var _local4:Array = [];
         var _local5:ByteArray = new ByteArray();
         var _local6:int = _local1.y;
         while(_local6 < _local1.bottom) {
            _local7 = _local1.x;
            while(_local7 < _local1.right) {
               _local8 = this.meMap_.getTile(_local7,_local6);
               _local9 = this.getEntry(_local8);
               _local10 = this.json.stringify(_local9);
               if(!_local3.hasOwnProperty(_local10)) {
                  _local11 = _local4.length;
                  _local3[_local10] = _local11;
                  _local4.push(_local9);
               } else {
                  _local11 = _local3[_local10];
               }
               _local5.writeShort(_local11);
               _local7++;
            }
            _local6++;
         }
         _local2["dict"] = _local4;
         _local5.compress();
         _local2["data"] = Base64.encodeByteArray(_local5);
         return this.json.stringify(_local2);
      }

      private function onSave(param1:LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c) : void {
         var _local2:String = this.createMapJSON();
         if(_local2 == null) {
            return;
         }
         new FileReference().save(_local2,this.filename_ == null?"map.jm":this.filename_);
      }
      
      private function getEntry(param1:LOEBUILD_822148805b3866cb113421c05e57390d) : Object {
         var _local3:Vector.<int> = null;
         var _local4:String = null;
         var _local5:Object = null;
         var _local2:Object = {};
         if(param1 != null) {
            _local3 = param1.types_;
            if(_local3[LOEBUILD_359b71e88f40029251366609358a302f.GROUND] != -1) {
               _local4 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.getIdFromType(_local3[LOEBUILD_359b71e88f40029251366609358a302f.GROUND]);
               _local2["ground"] = _local4;
            }
            if(_local3[LOEBUILD_359b71e88f40029251366609358a302f.OBJECT] != -1) {
               _local4 = LOEBUILD_efda783509bc93eea698457c87bbee3f.getIdFromType(_local3[LOEBUILD_359b71e88f40029251366609358a302f.OBJECT]);
               _local5 = {"id":_local4};
               if(param1.objName_ != null) {
                  _local5["name"] = param1.objName_;
               }
               _local2["objs"] = [_local5];
            }
            if(_local3[LOEBUILD_359b71e88f40029251366609358a302f.REGION] != -1) {
               _local4 = LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4.getIdFromType(_local3[LOEBUILD_359b71e88f40029251366609358a302f.REGION]);
               _local2["regions"] = [{"id":_local4}];
            }
         }
         return _local2;
      }

      private function onLoad(param1:LOEBUILD_6d9ce8adb38c1693a419685e114d8b7c) : void {
         this.loadedFile_ = new FileReference();
         this.loadedFile_.addEventListener(Event.SELECT,this.onFileBrowseSelect);
         this.loadedFile_.browse([new FileFilter("JSON Map (*.jm)","*.jm")]);
      }

      private function onFileBrowseSelect(param1:Event) : void {
         var event:Event = param1;
         var loadedFile:FileReference = event.target as FileReference;
         loadedFile.addEventListener(Event.COMPLETE,this.onFileLoadComplete);
         loadedFile.addEventListener(IOErrorEvent.IO_ERROR,this.onFileLoadIOError);
         try {
            loadedFile.load();
            return;
         }
         catch(e:Error) {
            return;
         }
      }

      private function onFileLoadComplete(param1:Event) : void {
         var _local9:int = 0;
         var _local11:int = 0;
         var _local12:Object = null;
         var _local13:Array = null;
         var _local14:Array = null;
         var _local15:Object = null;
         var _local16:Object = null;
         var _local2:FileReference = param1.target as FileReference;
         this.filename_ = _local2.name;
         var _local3:Object = this.json.parse(_local2.data.toString());
         var _local4:int = _local3["width"];
         var _local5:int = _local3["height"];
         var _local6:Rectangle = new Rectangle(int(LOEBUILD_d5569d48c9e4a976a51c625e3a800107.NUM_SQUARES / 2 - _local4 / 2),int(LOEBUILD_d5569d48c9e4a976a51c625e3a800107.NUM_SQUARES / 2 - _local5 / 2),_local4,_local5);
         this.meMap_.clear();
         this.commandQueue_.clear();
         var _local7:Array = _local3["dict"];
         var _local8:ByteArray = Base64.decodeToByteArray(_local3["data"]);
         _local8.uncompress();
         var _local10:int = _local6.y;
         while(_local10 < _local6.bottom) {
            _local11 = _local6.x;
            while(_local11 < _local6.right) {
               _local12 = _local7[_local8.readShort()];
               if(_local12.hasOwnProperty("ground")) {
                  _local9 = LOEBUILD_0bd5afc531164aa9bf1c5f132d4a86a5.idToType_[_local12["ground"]];
                  this.meMap_.modifyTile(_local11,_local10,LOEBUILD_359b71e88f40029251366609358a302f.GROUND,_local9);
               }
               _local13 = _local12["objs"];
               if(_local13 != null) {
                  for each(_local15 in _local13) {
                     if(LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_.hasOwnProperty(_local15["id"])) {
                        _local9 = LOEBUILD_efda783509bc93eea698457c87bbee3f.idToType_[_local15["id"]];
                        this.meMap_.modifyTile(_local11,_local10,LOEBUILD_359b71e88f40029251366609358a302f.OBJECT,_local9);
                        if(_local15.hasOwnProperty("name")) {
                           this.meMap_.modifyObjectName(_local11,_local10,_local15["name"]);
                        }
                     }
                  }
               }
               _local14 = _local12["regions"];
               if(_local14 != null) {
                  for each(_local16 in _local14) {
                     _local9 = LOEBUILD_bc44e55f2b7833506dc8a2b0246803f4.idToType_[_local16["id"]];
                     this.meMap_.modifyTile(_local11,_local10,LOEBUILD_359b71e88f40029251366609358a302f.REGION,_local9);
                  }
               }
               _local11++;
            }
            _local10++;
         }
         this.meMap_.draw();
      }

      private function onFileLoadIOError(param1:Event) : void {
      }

      private function onTest(param1:Event) : void {
         dispatchEvent(new LOEBUILD_450e33d9168342a7d1649030f2d5b4e0(this.createMapJSON()));
      }

      private function onMenuSelect(param1:Event) : void {
         if(this.meMap_ != null) {
            this.meMap_.clearSelect();
         }
      }
   }
}
