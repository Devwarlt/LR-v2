package com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9 {
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.tutorial.Tutorial;
import com.company.assembleegameclient.tutorial.doneAction;
import com.company.assembleegameclient.ui.options.Options;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.KeyCodes;

import flash.display.Stage;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.system.Capabilities;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.constants.GeneralConstants;
import kabam.rotmg.constants.UseType;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.view.FriendListView;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.model.UseBuyPotionVO;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.game.signals.GiftStatusUpdateSignal;
import kabam.rotmg.game.signals.SetTextBoxVisibilitySignal;
import kabam.rotmg.game.signals.UseBuyPotionSignal;
import kabam.rotmg.game.view.components.StatsTabHotKeyInputSignal;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.minimap.control.MiniMapZoomSignal;
import kabam.rotmg.pets.controller.reskin.ReskinPetFlowStartSignal;
import kabam.rotmg.ui.model.TabStripModel;

import com.company.util.Stats;

import org.swiftsuspenders.Injector;

public class LOEBUILD_e5f69906f41a111ba59048ec6958248a {

      private static var stats_:Stats = new Stats();

      private static const MOUSE_DOWN_WAIT_PERIOD:uint = 175;

      private static var arrowWarning_:Boolean = false;

      public var gs_:GameSprite;

      private var moveLeft_:Boolean = false;

      private var moveRight_:Boolean = false;

      private var moveUp_:Boolean = false;

      private var moveDown_:Boolean = false;

      private var rotateLeft_:Boolean = false;

      private var rotateRight_:Boolean = false;

      private var mouseDown_:Boolean = false;

      private var autofire_:Boolean = false;

      private var specialKeyDown_:Boolean = false;

      private var enablePlayerInput_:Boolean = true;

      private var giftStatusUpdateSignal:GiftStatusUpdateSignal;

      private var addTextLine:AddTextLineSignal;

      private var setTextBoxVisibility:SetTextBoxVisibilitySignal;

      private var statsTabHotKeyInputSignal:StatsTabHotKeyInputSignal;

      private var miniMapZoom:MiniMapZoomSignal;

      private var useBuyPotionSignal:UseBuyPotionSignal;

      private var potionInventoryModel:PotionInventoryModel;

      private var openDialogSignal:OpenDialogSignal;

      private var closeDialogSignal:CloseDialogsSignal;

      private var tabStripModel:TabStripModel;

      private var layers:Layers;

      private var exitGame:ExitGameSignal;

      private var areFKeysAvailable:Boolean;

      private var reskinPetFlowStart:ReskinPetFlowStartSignal;

      public function LOEBUILD_e5f69906f41a111ba59048ec6958248a(param1:GameSprite) {
         super();
         this.gs_ = param1;
         this.gs_.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.gs_.addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         var _local2:Injector = StaticInjectorContext.getInjector();
         this.giftStatusUpdateSignal = _local2.getInstance(GiftStatusUpdateSignal);
         this.reskinPetFlowStart = _local2.getInstance(ReskinPetFlowStartSignal);
         this.addTextLine = _local2.getInstance(AddTextLineSignal);
         this.setTextBoxVisibility = _local2.getInstance(SetTextBoxVisibilitySignal);
         this.miniMapZoom = _local2.getInstance(MiniMapZoomSignal);
         this.useBuyPotionSignal = _local2.getInstance(UseBuyPotionSignal);
         this.potionInventoryModel = _local2.getInstance(PotionInventoryModel);
         this.tabStripModel = _local2.getInstance(TabStripModel);
         this.layers = _local2.getInstance(Layers);
         this.statsTabHotKeyInputSignal = _local2.getInstance(StatsTabHotKeyInputSignal);
         this.exitGame = _local2.getInstance(ExitGameSignal);
         this.openDialogSignal = _local2.getInstance(OpenDialogSignal);
         this.closeDialogSignal = _local2.getInstance(CloseDialogsSignal);
         var _local3:ApplicationSetup = _local2.getInstance(ApplicationSetup);
         this.areFKeysAvailable = _local3.areDeveloperHotkeysEnabled();
         this.gs_.map.signalRenderSwitch.add(this.onRenderSwitch);
      }

      public function onRenderSwitch(param1:Boolean) : void {
         if(param1) {
            this.gs_.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.gs_.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
            this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.gs_.map.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         } else {
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
            this.gs_.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.gs_.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
      }

      public function clearInput() : void {
         this.moveLeft_ = false;
         this.moveRight_ = false;
         this.moveUp_ = false;
         this.moveDown_ = false;
         this.rotateLeft_ = false;
         this.rotateRight_ = false;
         this.mouseDown_ = false;
         this.autofire_ = false;
         this.setPlayerMovement();
      }

      public function setEnablePlayerInput(param1:Boolean) : void {
         if(this.enablePlayerInput_ != param1) {
            this.enablePlayerInput_ = param1;
            this.clearInput();
         }
      }

      private function onAddedToStage(param1:Event) : void {
         var _local2:Stage = this.gs_.stage;
         _local2.addEventListener(Event.ACTIVATE,this.onActivate);
         _local2.addEventListener(Event.DEACTIVATE,this.onDeactivate);
         _local2.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         _local2.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         _local2.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            _local2.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            _local2.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         } else {
            this.gs_.map.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.gs_.map.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
         _local2.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         _local2.addEventListener(MouseEvent.RIGHT_CLICK,this.disableRightClick);
      }

      public function disableRightClick(param1:MouseEvent) : void {
      }

      private function onRemovedFromStage(param1:Event) : void {
         var _local2:Stage = this.gs_.stage;
         _local2.removeEventListener(Event.ACTIVATE,this.onActivate);
         _local2.removeEventListener(Event.DEACTIVATE,this.onDeactivate);
         _local2.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         _local2.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         _local2.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            _local2.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            _local2.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         } else {
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this.gs_.map.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
         _local2.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         _local2.removeEventListener(MouseEvent.RIGHT_CLICK,this.disableRightClick);
      }

      private function onActivate(param1:Event) : void {
      }

      private function onDeactivate(param1:Event) : void {
         this.clearInput();
      }

      public function onMouseDown(param1:MouseEvent) : void {
         var _local3:Number = NaN;
         var _local4:int = 0;
         var _local5:XML = null;
         var _local6:Number = NaN;
         var _local7:Number = NaN;
         var _local2:Player = this.gs_.map.player_;
         if(_local2 == null) {
            return;
         }
         if(!this.enablePlayerInput_) {
            return;
         }
         if(param1.shiftKey) {
            _local4 = _local2.equipment_[1];
            if(_local4 == -1) {
               return;
            }
            _local5 = LOEBUILD_efda783509bc93eea698457c87bbee3f.xmlLibrary_[_local4];
            if(_local5 == null || Boolean(_local5.hasOwnProperty("EndMpCost"))) {
               return;
            }
            if(_local2.isUnstable()) {
               _local6 = Math.random() * 600 - 300;
               _local7 = Math.random() * 600 - 325;
            } else {
               _local6 = this.gs_.map.mouseX;
               _local7 = this.gs_.map.mouseY;
            }
            if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
               if(param1.currentTarget == param1.target || param1.target == this.gs_.map || param1.target == this.gs_) {
                  _local2.useAltWeapon(_local6,_local7,UseType.START_USE);
               }
            } else {
               _local2.useAltWeapon(_local6,_local7,UseType.START_USE);
            }
            return;
         }
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.isGpuRender()) {
            if(param1.currentTarget == param1.target || param1.target == this.gs_.map || param1.target == this.gs_ || param1.currentTarget == this.gs_.chatBox_.list) {
               _local3 = Math.atan2(this.gs_.map.mouseY,this.gs_.map.mouseX);
            } else {
               return;
            }
         } else {
            _local3 = Math.atan2(this.gs_.map.mouseY,this.gs_.map.mouseX);
         }
         doneAction(this.gs_,Tutorial.ATTACK_ACTION);
         if(_local2.isUnstable()) {
            _local2.attemptAttackAngle(Math.random() * 360);
         } else {
            _local2.attemptAttackAngle(_local3);
         }
         this.mouseDown_ = true;
      }

      public function onMouseUp(param1:MouseEvent) : void {
         this.mouseDown_ = false;
         var _local2:Player = this.gs_.map.player_;
         if(_local2 == null) {
            return;
         }
         _local2.isShooting = false;
      }

      private function onMouseWheel(param1:MouseEvent) : void {
         if(param1.delta > 0) {
            this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
         } else {
            this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
         }
      }

      private function onEnterFrame(param1:Event) : void {
         var _local2:Player = null;
         var _local3:Number = NaN;
         doneAction(this.gs_,Tutorial.UPDATE_ACTION);
         if(Boolean(this.enablePlayerInput_) && (Boolean(this.mouseDown_) || Boolean(this.autofire_))) {
            _local2 = this.gs_.map.player_;
            if(_local2 != null) {
               if(_local2.isUnstable()) {
                  _local2.attemptAttackAngle(Math.random() * 360);
               } else {
                  _local3 = Math.atan2(this.gs_.map.mouseY,this.gs_.map.mouseX);
                  _local2.attemptAttackAngle(_local3);
               }
            }
         }
      }

      private function onKeyDown(param1:KeyboardEvent) : void {
         var _local4:GameObject = null;
         var _local5:Number = NaN;
         var _local6:Number = NaN;
         var _local7:Boolean = false;
         var _local8:Square = null;
         var _local2:Stage = this.gs_.stage;
         switch(param1.keyCode) {
            case KeyCodes.F1:
            case KeyCodes.F2:
            case KeyCodes.F3:
            case KeyCodes.F4:
            case KeyCodes.F5:
            case KeyCodes.F6:
            case KeyCodes.F7:
            case KeyCodes.F8:
            case KeyCodes.F9:
            case KeyCodes.F10:
            case KeyCodes.F11:
            case KeyCodes.F12:
            case KeyCodes.INSERT:
            case KeyCodes.ALTERNATE:
               break;
            default:
               if(_local2.focus != null) {
                  return;
               }
               break;
         }
         var _local3:Player = this.gs_.map.player_;
         switch(param1.keyCode) {
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.moveUp:
               doneAction(this.gs_,Tutorial.MOVE_FORWARD_ACTION);
               this.moveUp_ = true;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.moveDown:
               doneAction(this.gs_,Tutorial.MOVE_BACKWARD_ACTION);
               this.moveDown_ = true;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.moveLeft:
               doneAction(this.gs_,Tutorial.MOVE_LEFT_ACTION);
               this.moveLeft_ = true;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.moveRight:
               doneAction(this.gs_,Tutorial.MOVE_RIGHT_ACTION);
               this.moveRight_ = true;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.rotateLeft:
               if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.allowRotation) {
                  break;
               }
               doneAction(this.gs_,Tutorial.ROTATE_LEFT_ACTION);
               this.rotateLeft_ = true;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.rotateRight:
               if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.allowRotation) {
                  break;
               }
               doneAction(this.gs_,Tutorial.ROTATE_RIGHT_ACTION);
               this.rotateRight_ = true;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.resetToDefaultCameraAngle:
               LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cameraAngle = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.defaultCameraAngle;
               LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useSpecial:
               _local4 = this.gs_.map.player_;
               if(_local4 == null) {
                  break;
               }
               if(!this.specialKeyDown_) {
                  if(_local3.isUnstable()) {
                     _local5 = Math.random() * 600 - 300;
                     _local6 = Math.random() * 600 - 325;
                  } else {
                     _local5 = this.gs_.map.mouseX;
                     _local6 = this.gs_.map.mouseY;
                  }
                  _local7 = _local3.useAltWeapon(_local5,_local6,UseType.START_USE);
                  if(_local7) {
                     this.specialKeyDown_ = true;
                  }
               }
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.autofireToggle:
               this.gs_.map.player_.isShooting = this.autofire_ = !this.autofire_;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.toggleHPBar:
               LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.HPBar = !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.HPBar;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useInvSlot1:
               this.useItem(4);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useInvSlot2:
               this.useItem(5);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useInvSlot3:
               this.useItem(6);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useInvSlot4:
               this.useItem(7);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useInvSlot5:
               this.useItem(8);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useInvSlot6:
               this.useItem(9);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useInvSlot7:
               this.useItem(10);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useInvSlot8:
               this.useItem(11);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useHealthPotion:
               if(this.potionInventoryModel.getPotionModel(PotionInventoryModel.HEALTH_POTION_ID).available) {
                  this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.HEALTH_POTION_ID,UseBuyPotionVO.CONTEXTBUY));
               }
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.GPURenderToggle:
               LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.GPURender = !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.GPURender;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useMagicPotion:
               if(this.potionInventoryModel.getPotionModel(PotionInventoryModel.MAGIC_POTION_ID).available) {
                  this.useBuyPotionSignal.dispatch(new UseBuyPotionVO(PotionInventoryModel.MAGIC_POTION_ID,UseBuyPotionVO.CONTEXTBUY));
               }
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.miniMapZoomOut:
               this.miniMapZoom.dispatch(MiniMapZoomSignal.OUT);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.miniMapZoomIn:
               this.miniMapZoom.dispatch(MiniMapZoomSignal.IN);
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.togglePerformanceStats:
               this.togglePerformanceStats();
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.escapeToNexus:
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.escapeToNexus2:
               this.exitGame.dispatch();
               this.gs_.gsc_.escape();
               LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.needsRandomRealm = false;
               LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.friendList:
               LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.friendListDisplayFlag = !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.friendListDisplayFlag;
               if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.friendListDisplayFlag) {
                  this.openDialogSignal.dispatch(new FriendListView());
               } else {
                  this.closeDialogSignal.dispatch();
               }
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.options:
               this.clearInput();
               this.layers.overlay.addChild(new Options(this.gs_));
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.toggleCentering:
               LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.centerOnPlayer = !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.centerOnPlayer;
               LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.toggleFullscreen:
               if(Capabilities.playerType == "Desktop") {
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.fullscreenMode = !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.fullscreenMode;
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
                  _local2.displayState = !!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.fullscreenMode?"fullScreenInteractive":StageDisplayState.NORMAL;
               }
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.switchTabs:
               this.statsTabHotKeyInputSignal.dispatch();
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.testOne:
         }
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ALLOW_SCREENSHOT_MODE) {
            switch(param1.keyCode) {
               case KeyCodes.F2:
                  this.toggleScreenShotMode();
                  break;
               case KeyCodes.F3:
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.screenShotSlimMode_ = !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.screenShotSlimMode_;
                  break;
               case KeyCodes.F4:
                  this.gs_.map.mapOverlay_.visible = !this.gs_.map.mapOverlay_.visible;
                  this.gs_.map.partyOverlay_.visible = !this.gs_.map.partyOverlay_.visible;
            }
         }
         if(this.areFKeysAvailable) {
            switch(param1.keyCode) {
               case KeyCodes.F6:
                  TextureRedrawer.clearCache();
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.projColorType_ = (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.projColorType_ + 1) % 7;
                  this.addTextLine.dispatch(ChatMessage.make(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME,"Projectile Color Type: " + LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.projColorType_));
                  break;
               case KeyCodes.F7:
                  for each(_local8 in this.gs_.map.squares_) {
                     if(_local8 != null) {
                        _local8.faces_.length = 0;
                     }
                  }
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.blendType_ = (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.blendType_ + 1) % 2;
                  this.addTextLine.dispatch(ChatMessage.make(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.CLIENT_CHAT_NAME,"Blend MsgType: " + LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.blendType_));
                  break;
               case KeyCodes.F8:
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.surveyDate = 0;
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.needsSurvey = true;
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.playTimeLeftTillSurvey = 5;
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.surveyGroup = "testing";
                  break;
               case KeyCodes.F9:
                  LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.drawProj_ = !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.drawProj_;
            }
         }
         this.setPlayerMovement();
      }

      private function onKeyUp(param1:KeyboardEvent) : void {
         var _local2:Number = NaN;
         var _local3:Number = NaN;
         switch(param1.keyCode) {
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.moveUp:
               this.moveUp_ = false;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.moveDown:
               this.moveDown_ = false;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.moveLeft:
               this.moveLeft_ = false;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.moveRight:
               this.moveRight_ = false;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.rotateLeft:
               this.rotateLeft_ = false;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.rotateRight:
               this.rotateRight_ = false;
               break;
            case LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.useSpecial:
               if(this.specialKeyDown_) {
                  this.specialKeyDown_ = false;
                  if(this.gs_.map.player_.isUnstable()) {
                     _local2 = Math.random() * 600 - 300;
                     _local3 = Math.random() * 600 - 325;
                  } else {
                     _local2 = this.gs_.map.mouseX;
                     _local3 = this.gs_.map.mouseY;
                  }
                  this.gs_.map.player_.useAltWeapon(this.gs_.map.mouseX,this.gs_.map.mouseY,UseType.END_USE);
               }
         }
         this.setPlayerMovement();
      }

      private function setPlayerMovement() : void {
         var _local1:Player = this.gs_.map.player_;
         if(_local1 != null) {
            if(this.enablePlayerInput_) {
               _local1.setRelativeMovement((!!this.rotateRight_?1:0) - (!!this.rotateLeft_?1:0),(!!this.moveRight_?1:0) - (!!this.moveLeft_?1:0),(!!this.moveDown_?1:0) - (!!this.moveUp_?1:0));
            } else {
               _local1.setRelativeMovement(0,0,0);
            }
         }
      }

      private function useItem(param1:int) : void {
         if(this.tabStripModel.currentSelection == TabStripModel.BACKPACK) {
            param1 = param1 + GeneralConstants.NUM_INVENTORY_SLOTS;
         }
         GameServerConnection.instance.useItem_new(this.gs_.map.player_,param1);
      }

      private function togglePerformanceStats() : void {
         if(this.gs_.contains(stats_)) {
            this.gs_.removeChild(stats_);
            this.gs_.removeChild(this.gs_.gsc_.jitterWatcher_);
            this.gs_.gsc_.disableJitterWatcher();
         } else {
            this.gs_.addChild(stats_);
            this.gs_.gsc_.enableJitterWatcher();
            this.gs_.gsc_.jitterWatcher_.y = stats_.height;
            this.gs_.addChild(this.gs_.gsc_.jitterWatcher_);
         }
      }

      private function toggleScreenShotMode() : void {
         LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.screenShotMode_ = !LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.screenShotMode_;
         if(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.screenShotMode_) {
            this.gs_.hudView.visible = false;
            this.setTextBoxVisibility.dispatch(false);
         } else {
            this.gs_.hudView.visible = true;
            this.setTextBoxVisibility.dispatch(true);
         }
      }
   }
}
