package kabam.rotmg.fame.view {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_efda783509bc93eea698457c87bbee3f;
import com.company.assembleegameclient.screens.ScoreTextLine;
import com.company.assembleegameclient.screens.ScoringBox;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.util.FameUtil;
import com.company.rotmg.graphics.FameIconBackgroundDesign;
import com.company.rotmg.graphics.ScreenGraphic;
import com.company.util.BitmapUtil;
import com.company.util.GTween;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class FameView extends Sprite {

      public var closed:Signal;

      private var infoContainer:DisplayObjectContainer;

      private var overlayContainer:Bitmap;

      private var title:TextFieldDisplayConcrete;

      private var date:TextFieldDisplayConcrete;

      private var scoringBox:ScoringBox;

      private var finalLine:ScoreTextLine;

      private var continueBtn:TitleMenuOption;

      private var isAnimation:Boolean;

      private var isFadeComplete:Boolean;

      private var isDataPopulated:Boolean;

      public function FameView() {
         super();
         addChild(new ScreenBase());
         addChild(this.infoContainer = new Sprite());
         addChild(this.overlayContainer = new Bitmap());
         this.continueBtn = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON,36,false);
         this.continueBtn.setAutoSize(TextFieldAutoSize.CENTER);
         this.continueBtn.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
         this.closed = new NativeMappedSignal(this.continueBtn,MouseEvent.CLICK);
      }

      public function setIsAnimation(param1:Boolean) : void {
         this.isAnimation = param1;
      }

      public function setBackground(param1:BitmapData) : void {
         this.overlayContainer.bitmapData = param1;
         var _local2:GTween = new GTween(this.overlayContainer,2,{"alpha":0});
         _local2.onComplete = this.onFadeComplete;
         SoundEffectLibrary.play("death_screen");
      }

      public function clearBackground() : void {
         this.overlayContainer.bitmapData = null;
      }

      private function onFadeComplete(param1:GTween) : void {
         removeChild(this.overlayContainer);
         this.isFadeComplete = true;
         if(this.isDataPopulated) {
            this.makeContinueButton();
         }
      }

      public function setCharacterInfo(param1:String, param2:int, param3:int) : void {
         this.title = new TextFieldDisplayConcrete().setSize(38).setColor(13421772);
         this.title.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
         this.title.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         var _local4:String = LOEBUILD_efda783509bc93eea698457c87bbee3f.typeToDisplayId_[param3];
         this.title.setStringBuilder(new LineBuilder().setParams(TextKey.CHARACTER_INFO,{
            "name":param1,
            "level":param2,
            "type":_local4
         }));
         this.title.x = stage.stageWidth / 2;
         this.title.y = 225;
         this.infoContainer.addChild(this.title);
      }

      public function setDeathInfo(param1:String, param2:String) : void {
         this.date = new TextFieldDisplayConcrete().setSize(24).setColor(13421772);
         this.date.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
         this.date.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         var _local3:LineBuilder = new LineBuilder();
         if(param2) {
            _local3.setParams(TextKey.DEATH_INFO_LONG,{
               "date":param1,
               "killer":param2
            });
         } else {
            _local3.setParams(TextKey.DEATH_INFO_SHORT,{"date":this.date});
         }
         this.date.setStringBuilder(_local3);
         this.date.x = stage.stageWidth / 2;
         this.date.y = 272;
         this.infoContainer.addChild(this.date);
      }

      public function setIcon(param1:BitmapData) : void {
         var _local2:Sprite = null;
         var _local4:Bitmap = null;
         _local2 = new Sprite();
         var _local3:Sprite = new FameIconBackgroundDesign();
         _local3.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         _local2.addChild(_local3);
         _local4 = new Bitmap(param1);
         _local4.x = _local2.width / 2 - _local4.width / 2;
         _local4.y = _local2.height / 2 - _local4.height / 2;
         _local2.addChild(_local4);
         _local2.y = 20;
         _local2.x = stage.stageWidth / 2 - _local2.width / 2;
         this.infoContainer.addChild(_local2);
      }

      public function setScore(param1:int, param2:XML) : void {
         this.scoringBox = new ScoringBox(new Rectangle(0,0,784,150),param2);
         this.scoringBox.x = 8;
         this.scoringBox.y = 316;
         addChild(this.scoringBox);
         this.infoContainer.addChild(this.scoringBox);
         var _local3:BitmapData = FameUtil.getFameIcon();
         _local3 = BitmapUtil.cropToBitmapData(_local3,6,6,_local3.width - 12,_local3.height - 12);
         this.finalLine = new ScoreTextLine(24,13421772,16762880,TextKey.FAMEVIEW_TOTAL_FAME_EARNED,null,0,param1,"","",new Bitmap(_local3));
         this.finalLine.x = 10;
         this.finalLine.y = 470;
         this.infoContainer.addChild(this.finalLine);
         this.isDataPopulated = true;
         if(!this.isAnimation || Boolean(this.isFadeComplete)) {
            this.makeContinueButton();
         }
      }

      private function makeContinueButton() : void {
         this.infoContainer.addChild(new ScreenGraphic());
         this.continueBtn.x = stage.stageWidth / 2;
         this.continueBtn.y = 550;
         this.infoContainer.addChild(this.continueBtn);
         if(this.isAnimation) {
            this.scoringBox.animateScore();
         } else {
            this.scoringBox.showScore();
         }
      }
   }
}
