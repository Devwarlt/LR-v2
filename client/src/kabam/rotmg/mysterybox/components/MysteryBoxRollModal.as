package kabam.rotmg.mysterybox.components {
import com.company.assembleegameclient.map.LOEBUILD_e381592941e087d5644194bd1995159f;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.ui.dialogs.NotEnoughFameDialog;
import com.company.assembleegameclient.util.Currency;
import com.company.util.GTween;
import com.company.util.Sine;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.filters.DropShadowFilter;
import flash.filters.GlowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import flash.utils.Timer;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.assets.EmbeddedAssets;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.components.ItemWithTooltip;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.pets.view.dialogs.evolving.Spinner;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.view.NotEnoughGoldDialog;
import kabam.rotmg.util.components.LegacyBuyButton;
import kabam.rotmg.util.components.UIAssetsHelper;

import org.swiftsuspenders.Injector;

public class MysteryBoxRollModal extends Sprite {

      public static const WIDTH:int = 415;

      public static const HEIGHT:int = 400;

      public static const TEXT_MARGIN:int = 20;

      public static var open:Boolean;

      private const ROLL_STATE:int = 1;

      private const IDLE_STATE:int = 0;

      private const iconSize:Number = 160;

      public var client:AppEngineClient;

      public var account:Account;

      public var parentSelectModal:MysteryBoxSelectModal;

      private var state:int;

      private var isShowReward:Boolean = false;

      private var rollCount:int = 0;

      private var rollTarget:int = 0;

      private var quantity_:int = 0;

      private var mbi:MysteryBoxInfo;

      private var spinners:Sprite;

      private var itemBitmaps:Vector.<Bitmap>;

      private var rewardsArray:Vector.<ItemWithTooltip>;

      private var closeButton:DialogCloseButton;

      private var particleModalMap:LOEBUILD_e381592941e087d5644194bd1995159f;

      private const playAgainString:String = "MysteryBoxRollModal.playAgainString";

      private const playAgainXTimesString:String = "Raise your chance!";

      private const youWonString:String = "MysteryBoxRollModal.youWonString";

      private const rewardsInVaultString:String = "MysteryBoxRollModal.rewardsInVaultString";

      private var minusNavSprite:Sprite;

      private var plusNavSprite:Sprite;

      private var boxButton:LegacyBuyButton;

      private var titleText:TextFieldDisplayConcrete;

      private var infoText:TextFieldDisplayConcrete;

      private var descTexts:Vector.<TextFieldDisplayConcrete>;

      private var swapImageTimer:Timer;

      private var totalRollTimer:Timer;

      private var nextRollTimer:Timer;

      private var indexInRolls:Vector.<int>;

      private var lastReward:String = "";

      private var requestComplete:Boolean = false;

      private var timerComplete:Boolean = false;

      private var goldBackground:DisplayObject;

      private var goldBackgroundMask:DisplayObject;

      public function MysteryBoxRollModal(param1:MysteryBoxInfo, param2:int) {
         this.spinners = new Sprite();
         this.itemBitmaps = new Vector.<Bitmap>();
         this.rewardsArray = new Vector.<ItemWithTooltip>();
         this.closeButton = PetsViewAssetFactory.returnCloseButton(WIDTH);
         this.boxButton = new LegacyBuyButton(this.playAgainString,16,0,Currency.INVALID);
         this.descTexts = new Vector.<TextFieldDisplayConcrete>();
         this.swapImageTimer = new Timer(50);
         this.totalRollTimer = new Timer(2000);
         this.nextRollTimer = new Timer(800);
         this.indexInRolls = new Vector.<int>();
         this.goldBackground = new EmbeddedAssets.EvolveBackground();
         this.goldBackgroundMask = new EmbeddedAssets.EvolveBackground();
         super();
         this.mbi = param1;
         this.closeButton.disableLegacyCloseBehavior();
         this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseClick);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.infoText = this.getText(this.rewardsInVaultString,TEXT_MARGIN,220).setSize(20).setColor(0);
         this.infoText.y = 40;
         this.infoText.filters = [];
         this.addComponemts();
         open = true;
         this.boxButton.x = this.boxButton.x + (WIDTH / 2 - 100);
         this.boxButton.y = this.boxButton.y + (HEIGHT - 43);
         this.boxButton._width = 200;
         this.boxButton.addEventListener(MouseEvent.CLICK,this.onRollClick);
         this.minusNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.LEFT_NEVIGATOR,3);
         this.minusNavSprite.addEventListener(MouseEvent.CLICK,this.onNavClick);
         this.minusNavSprite.filters = [new GlowFilter(0,1,2,2,10,1)];
         this.minusNavSprite.x = WIDTH / 2 + 110;
         this.minusNavSprite.y = HEIGHT - 35;
         this.minusNavSprite.alpha = 0;
         addChild(this.minusNavSprite);
         this.plusNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.RIGHT_NEVIGATOR,3);
         this.plusNavSprite.addEventListener(MouseEvent.CLICK,this.onNavClick);
         this.plusNavSprite.filters = [new GlowFilter(0,1,2,2,10,1)];
         this.plusNavSprite.x = WIDTH / 2 + 110;
         this.plusNavSprite.y = HEIGHT - 50;
         this.plusNavSprite.alpha = 0;
         addChild(this.plusNavSprite);
         var _local3:Injector = StaticInjectorContext.getInjector();
         this.client = _local3.getInstance(AppEngineClient);
         this.account = _local3.getInstance(Account);
         var _local4:uint = 0;
         while(_local4 < this.mbi._rollsWithContents.length) {
            this.indexInRolls.push(0);
            _local4++;
         }
         this.centerModal();
         this.configureRollByQuantity(param2);
         this.sendRollRequest();
      }

      private static function makeModalBackground(param1:int, param2:int) : PopupWindowBackground {
         var _local3:PopupWindowBackground = new PopupWindowBackground();
         _local3.draw(param1,param2,PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
         return _local3;
      }

      private function configureRollByQuantity(param1:*) : * {
         var _local2:int = 0;
         var _local3:int = 0;
         this.quantity_ = param1;
         switch(param1) {
            case 1:
               this.rollCount = 1;
               this.rollTarget = 1;
               this.swapImageTimer.delay = 50;
               this.totalRollTimer.delay = 2000;
               break;
            case 5:
               this.rollCount = 0;
               this.rollTarget = 4;
               this.swapImageTimer.delay = 50;
               this.totalRollTimer.delay = 1000;
               break;
            case 10:
               this.rollCount = 0;
               this.rollTarget = 9;
               this.swapImageTimer.delay = 50;
               this.totalRollTimer.delay = 1000;
               break;
            default:
               this.rollCount = 1;
               this.rollTarget = 1;
               this.swapImageTimer.delay = 50;
               this.totalRollTimer.delay = 2000;
         }
         if(this.mbi.isOnSale()) {
            _local2 = this.mbi.saleAmount * this.quantity_;
            _local3 = this.mbi.saleCurrency;
         } else {
            _local2 = this.mbi.priceAmount * this.quantity_;
            _local3 = this.mbi.priceCurrency;
         }
         if(this.quantity_ == 1) {
            this.boxButton.setPrice(_local2,this.mbi.priceCurrency);
         } else {
            this.boxButton.currency = _local3;
            this.boxButton.price = _local2;
            this.boxButton.setStringBuilder(new LineBuilder().setParams(this.playAgainXTimesString,{
               "cost":_local2.toString(),
               "repeat":this.quantity_.toString()
            }));
         }
      }

      public function getText(param1:String, param2:int, param3:int, param4:Boolean = false) : TextFieldDisplayConcrete {
         var _local5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(WIDTH - TEXT_MARGIN * 2);
         _local5.setBold(true);
         if(param4) {
            _local5.setStringBuilder(new StaticStringBuilder(param1));
         } else {
            _local5.setStringBuilder(new LineBuilder().setParams(param1));
         }
         _local5.setWordWrap(true);
         _local5.setMultiLine(true);
         _local5.setAutoSize(TextFieldAutoSize.CENTER);
         _local5.setHorizontalAlign(TextFormatAlign.CENTER);
         _local5.filters = [new DropShadowFilter(0,0,0)];
         _local5.x = param2;
         _local5.y = param3;
         return _local5;
      }

      private function addComponemts() : void {
         var _local1:int = 27;
         var _local2:int = 28;
         this.goldBackgroundMask.y = this.goldBackground.y = _local1;
         this.goldBackgroundMask.x = this.goldBackground.x = 1;
         this.goldBackgroundMask.width = this.goldBackground.width = WIDTH - 1;
         this.goldBackgroundMask.height = this.goldBackground.height = HEIGHT - _local2;
         addChild(this.goldBackground);
         addChild(this.goldBackgroundMask);
         var _local3:Spinner = new Spinner();
         var _local4:Spinner = new Spinner();
         _local3.degreesPerSecond = 50;
         _local4.degreesPerSecond = _local3.degreesPerSecond * 1.5;
         var _local5:Number = 0.7;
         _local4.width = _local3.width * _local5;
         _local4.height = _local3.height * _local5;
         _local4.alpha = _local3.alpha = 0.7;
         this.spinners.addChild(_local3);
         this.spinners.addChild(_local4);
         this.spinners.mask = this.goldBackgroundMask;
         this.spinners.x = WIDTH / 2;
         this.spinners.y = (HEIGHT - 30) / 3 + 50;
         this.spinners.alpha = 0;
         addChild(this.spinners);
         addChild(makeModalBackground(WIDTH,HEIGHT));
         addChild(this.closeButton);
         this.particleModalMap = new LOEBUILD_e381592941e087d5644194bd1995159f(LOEBUILD_e381592941e087d5644194bd1995159f.MODE_AUTO_UPDATE);
         addChild(this.particleModalMap);
      }

      private function sendRollRequest() : void {
         if(!this.moneyCheckPass()) {
            return;
         }
         this.state = this.ROLL_STATE;
         this.closeButton.visible = false;
         var _local1:Object = this.account.getCredentials();
         _local1.boxId = this.mbi.id;
         if(this.mbi.isOnSale()) {
            _local1.quantity = this.mbi._quantity;
            _local1.price = this.mbi._saleAmount;
            _local1.currency = this.mbi._saleCurrency;
         } else {
            _local1.quantity = this.mbi._quantity;
            _local1.price = this.mbi._priceAmount;
            _local1.currency = this.mbi._priceCurrency;
         }
         this.client.sendRequest("/account/purchaseMysteryBox",_local1);
         this.titleText = this.getText(this.mbi._title,TEXT_MARGIN,6,true).setSize(18);
         this.titleText.setColor(16768512);
         addChild(this.titleText);
         addChild(this.infoText);
         this.playRollAnimation();
         this.lastReward = "";
         this.requestComplete = false;
         this.timerComplete = false;
         this.totalRollTimer.addEventListener(TimerEvent.TIMER,this.onTotalRollTimeComplete);
         this.totalRollTimer.start();
         this.client.complete.addOnce(this.onComplete);
      }

      private function playRollAnimation() : void {
         var _local2:Bitmap = null;
         var _local1:int = 0;
         while(_local1 < this.mbi._rollsWithContents.length) {
            _local2 = new Bitmap(LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(this.mbi._rollsWithContentsUnique[this.indexInRolls[_local1]],this.iconSize,true));
            this.itemBitmaps.push(_local2);
            _local1++;
         }
         this.displayItems(this.itemBitmaps);
         this.swapImageTimer.addEventListener(TimerEvent.TIMER,this.swapItemImage);
         this.swapImageTimer.start();
      }

      private function onTotalRollTimeComplete(param1:TimerEvent) : void {
         this.totalRollTimer.stop();
         this.timerComplete = true;
         if(this.requestComplete) {
            this.showReward(this.lastReward);
         }
         this.totalRollTimer.removeEventListener(TimerEvent.TIMER,this.onTotalRollTimeComplete);
      }

      private function onNextRollTimerComplete(param1:TimerEvent) : void {
         this.nextRollTimer.stop();
         this.nextRollTimer.removeEventListener(TimerEvent.TIMER,this.onNextRollTimerComplete);
         this.shelveReward();
         this.clearReward();
         this.rollCount++;
         this.sendRollRequest();
      }

      private function swapItemImage(param1:TimerEvent) : void {
         this.swapImageTimer.stop();
         var _local2:uint = 0;
         while(_local2 < this.indexInRolls.length) {
            if(this.indexInRolls[_local2] < this.mbi._rollsWithContentsUnique.length - 1) {
               this.indexInRolls[_local2]++;
            } else {
               this.indexInRolls[_local2] = 0;
            }
            this.itemBitmaps[_local2].bitmapData = new Bitmap(LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(this.mbi._rollsWithContentsUnique[this.indexInRolls[_local2]],this.iconSize,true)).bitmapData;
            _local2++;
         }
         this.swapImageTimer.start();
      }

      private function displayItems(param1:Vector.<Bitmap>) : void {
         var _local2:Bitmap = null;
         switch(param1.length) {
            case 1:
               param1[0].x = param1[0].x + (WIDTH / 2 - 40);
               param1[0].y = param1[0].y + HEIGHT / 3;
               break;
            case 2:
               param1[0].x = param1[0].x + (WIDTH / 2 + 20);
               param1[0].y = param1[0].y + HEIGHT / 3;
               param1[1].x = param1[1].x + (WIDTH / 2 - 100);
               param1[1].y = param1[1].y + HEIGHT / 3;
               break;
            case 3:
               param1[0].x = param1[0].x + (WIDTH / 2 - 140);
               param1[0].y = param1[0].y + HEIGHT / 3;
               param1[1].x = param1[1].x + (WIDTH / 2 - 40);
               param1[1].y = param1[1].y + HEIGHT / 3;
               param1[2].x = param1[2].x + (WIDTH / 2 + 60);
               param1[2].y = param1[2].y + HEIGHT / 3;
         }
         for each(_local2 in param1) {
            addChild(_local2);
         }
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         var _local3:XML = null;
         var _local4:Player = null;
         var _local5:PlayerModel = null;
         var _local6:OpenDialogSignal = null;
         var _local7:Dialog = null;
         var _local8:Injector = null;
         var _local9:GetMysteryBoxesTask = null;
         this.requestComplete = true;
         if(param1) {
            _local3 = new XML(param2);
            this.lastReward = _local3.Awards;
            if(this.timerComplete) {
               this.showReward(_local3.Awards);
            }
            _local4 = StaticInjectorContext.getInjector().getInstance(GameModel).player;
            if(_local4 != null) {
               if(_local3.hasOwnProperty("Gold")) {
                  _local4.setCredits(int(_local3.Gold));
               } else if(_local3.hasOwnProperty("Fame")) {
                  _local4.fame_ = _local3.Fame;
               }
            } else {
               _local5 = StaticInjectorContext.getInjector().getInstance(PlayerModel);
               if(_local5 != null) {
                  if(_local3.hasOwnProperty("Gold")) {
                     _local5.setCredits(int(_local3.Gold));
                  } else if(_local3.hasOwnProperty("Fame")) {
                     _local5.setFame(int(_local3.Fame));
                  }
               }
            }
         } else {
            _local6 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _local7 = new Dialog("MysteryBoxRollModal.purchaseFailedString","MysteryBoxRollModal.pleaseTryAgainString","MysteryBoxRollModal.okString",null,null);
            _local7.addEventListener(Dialog.LEFT_BUTTON,this.onErrorOk);
            _local6.dispatch(_local7);
            _local8 = StaticInjectorContext.getInjector();
            _local9 = _local8.getInstance(GetMysteryBoxesTask);
            _local9.clearLastRanBlock();
            _local9.start();
            this.close(true);
         }
      }

      private function onErrorOk(param1:Event) : void {
         var _local2:OpenDialogSignal = null;
         _local2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
         _local2.dispatch(new MysteryBoxSelectModal());
      }

      public function moneyCheckPass() : Boolean {
         var _local1:int = 0;
         var _local2:int = 0;
         var _local7:OpenDialogSignal = null;
         var _local8:PlayerModel = null;
         if(Boolean(this.mbi.isOnSale()) && this.mbi.saleAmount != "") {
            _local1 = int(this.mbi.saleCurrency);
            _local2 = int(this.mbi.saleAmount) * this.quantity_;
         } else {
            _local1 = int(this.mbi.priceCurrency);
            _local2 = int(this.mbi.priceAmount) * this.quantity_;
         }
         var _local3:Boolean = true;
         var _local4:int = 0;
         var _local5:int = 0;
         var _local6:Player = StaticInjectorContext.getInjector().getInstance(GameModel).player;
         if(_local6 != null) {
            _local5 = _local6.credits_;
            _local4 = _local6.fame_;
         } else {
            _local8 = StaticInjectorContext.getInjector().getInstance(PlayerModel);
            if(_local8 != null) {
               _local5 = _local8.getCredits();
               _local4 = _local8.getFame();
            }
         }
         if(_local1 == Currency.GOLD && _local5 < _local2) {
            _local7 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _local7.dispatch(new NotEnoughGoldDialog());
            _local3 = false;
         } else if(_local1 == Currency.FAME && _local4 < _local2) {
            _local7 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _local7.dispatch(new NotEnoughFameDialog());
            _local3 = false;
         }
         return _local3;
      }

      public function onCloseClick(param1:MouseEvent) : void {
         this.close();
      }

      private function close(param1:Boolean = false) : void {
         var _local2:OpenDialogSignal = null;
         if(this.state == this.ROLL_STATE) {
            return;
         }
         if(!param1) {
            _local2 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            if(this.parentSelectModal != null) {
               _local2.dispatch(this.parentSelectModal);
            } else {
               _local2.dispatch(new MysteryBoxSelectModal());
            }
         }
         open = false;
      }

      private function onRemovedFromStage(param1:Event) : void {
         open = false;
      }

      private function showReward(param1:String) : void {
         var _local4:String = null;
         var _local5:uint = 0;
         var _local6:TextFieldDisplayConcrete = null;
         this.swapImageTimer.removeEventListener(TimerEvent.TIMER,this.swapItemImage);
         this.swapImageTimer.stop();
         this.state = this.IDLE_STATE;
         if(this.rollCount < this.rollTarget) {
            this.nextRollTimer.addEventListener(TimerEvent.TIMER,this.onNextRollTimerComplete);
            this.nextRollTimer.start();
         }
         this.closeButton.visible = true;
         var _local2:Array = param1.split(",");
         removeChild(this.infoText);
         this.titleText.setStringBuilder(new LineBuilder().setParams(this.youWonString));
         this.titleText.setColor(16768512);
         var _local3:int = 40;
         for each(_local4 in _local2) {
            _local6 = this.getText(LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[_local4],TEXT_MARGIN,_local3).setSize(16).setColor(0);
            _local6.filters = [];
            _local6.setSize(18);
            _local6.x = 20;
            addChild(_local6);
            this.descTexts.push(_local6);
            _local3 = _local3 + 25;
         }
         _local5 = 0;
         while(_local5 < _local2.length) {
            if(_local5 < this.itemBitmaps.length) {
               this.itemBitmaps[_local5].bitmapData = new Bitmap(LOEBUILD_efda783509bc93eea698457c87bbee3f.getRedrawnTextureFromType(int(_local2[_local5]),this.iconSize,true)).bitmapData;
            }
            _local5++;
         }
         _local5 = 0;
         while(_local5 < this.itemBitmaps.length) {
            this.doEaseInAnimation(this.itemBitmaps[_local5],{
               "scaleX":1.25,
               "scaleY":1.25
            },{
               "scaleX":1,
               "scaleY":1
            });
            _local5++;
         }
         this.boxButton.alpha = 0;
         addChild(this.boxButton);
         if(this.rollCount == this.rollTarget) {
            this.doEaseInAnimation(this.boxButton,{"alpha":0},{"alpha":1});
            this.doEaseInAnimation(this.minusNavSprite,{"alpha":0},{"alpha":1});
            this.doEaseInAnimation(this.plusNavSprite,{"alpha":0},{"alpha":1});
         }
         this.doEaseInAnimation(this.spinners,{"alpha":0},{"alpha":1});
         this.isShowReward = true;
      }

      private function doEaseInAnimation(param1:DisplayObject, param2:Object = null, param3:Object = null) : void {
         var _local4:GTween = new GTween(param1,0.5 * 1,param2,{"ease":Sine.easeOut});
         _local4.nextTween = new GTween(param1,0.5 * 1,param3,{"ease":Sine.easeIn});
         _local4.nextTween.paused = true;
      }

      private function shelveReward() : void {
         var _local2:ItemWithTooltip = null;
         var _local3:int = 0;
         var _local4:int = 0;
         var _local5:int = 0;
         var _local6:int = 0;
         var _local7:int = 0;
         var _local8:int = 0;
         var _local1:Array = this.lastReward.split(",");
         if(_local1.length > 0) {
            _local2 = new ItemWithTooltip(int(_local1[0]),64);
            _local3 = HEIGHT / 6 - 10;
            _local4 = WIDTH - 65;
            _local2.x = 5 + _local4 * int(this.rollCount / 5);
            _local2.y = 80 + _local3 * (this.rollCount % 5);
            _local5 = WIDTH / 2 - 40 + this.itemBitmaps[0].width * 0.5;
            _local6 = HEIGHT / 3 + this.itemBitmaps[0].height * 0.5;
            _local7 = _local2.x + _local2.height * 0.5;
            _local8 = 100 + _local3 * (this.rollCount % 5) + 0.5 * (HEIGHT / 6 - 20);
            this.particleModalMap.doLightning(_local5,_local6,_local7,_local8,115,15787660,0.2);
            addChild(_local2);
            this.rewardsArray.push(_local2);
         }
      }

      private function clearReward() : void {
         var _local1:TextFieldDisplayConcrete = null;
         var _local2:Bitmap = null;
         this.spinners.alpha = 0;
         this.minusNavSprite.alpha = 0;
         this.plusNavSprite.alpha = 0;
         removeChild(this.titleText);
         for each(_local1 in this.descTexts) {
            removeChild(_local1);
         }
         while(this.descTexts.length > 0) {
            this.descTexts.pop();
         }
         removeChild(this.boxButton);
         for each(_local2 in this.itemBitmaps) {
            removeChild(_local2);
         }
         while(this.itemBitmaps.length > 0) {
            this.itemBitmaps.pop();
         }
      }

      private function clearShelveReward() : void {
         var _local1:ItemWithTooltip = null;
         for each(_local1 in this.rewardsArray) {
            removeChild(_local1);
         }
         while(this.rewardsArray.length > 0) {
            this.rewardsArray.pop();
         }
      }

      private function centerModal() : void {
         x = 800 / 2 - WIDTH / 2;
         y = 600 / 2 - HEIGHT / 2;
      }

      private function onNavClick(param1:MouseEvent) : void {
         if(param1.currentTarget == this.minusNavSprite) {
            switch(this.quantity_) {
               case 5:
                  this.configureRollByQuantity(1);
                  break;
               case 10:
                  this.configureRollByQuantity(5);
            }
         } else if(param1.currentTarget == this.plusNavSprite) {
            switch(this.quantity_) {
               case 1:
                  this.configureRollByQuantity(5);
                  break;
               case 5:
                  this.configureRollByQuantity(10);
            }
         }
      }

      private function onRollClick(param1:MouseEvent) : void {
         this.configureRollByQuantity(this.quantity_);
         this.clearReward();
         this.clearShelveReward();
         this.sendRollRequest();
      }
   }
}
