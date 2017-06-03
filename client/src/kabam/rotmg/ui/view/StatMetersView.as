package kabam.rotmg.ui.view {
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.ui.ExperienceBoostTimerPopup;
import com.company.assembleegameclient.ui.StatusBar;

import flash.display.Sprite;
import flash.events.Event;

import kabam.rotmg.text.model.TextKey;

public class StatMetersView extends Sprite {

      private var expBar_:StatusBar;

      private var fameBar_:StatusBar;

      private var hpBar_:StatusBar;

      private var mpBar_:StatusBar;

      private var areTempXpListenersAdded:Boolean;

      private var curXPBoost:int;

      private var expTimer:ExperienceBoostTimerPopup;

    //EXP BAR
    private var expBarW:int = 176;
    private var expBarH:int = 16;
    private var expBarF:uint = 16711680; //5931045;
    private var expBarB:uint = 2368548;

    //FAME BAR
    private var fameBarW:int = 176;
    private var fameBarH:int = 16;
    private var fameBarF:uint = 16753920; //14835456;
    private var fameBarB:uint = 2368548;

    //HP BAR
    private var hpBarW:int = 176;
    private var hpBarH:int = 16;
    private var hpBarF:uint = 16737095; //TextKey.HUD_HP;
    private var hpBarB:uint = 2368548;

    //MP BAR
    private var mpBarW:int = 176;
    private var mpBarH:int = 16;
    private var mpBarF:uint = 49151; //TextKey.HUD_MP;
    private var mpBarB:uint = 2368548;

    //StatusBar(width, height, foreground, background, textkey)

      public function StatMetersView() {
         super();
         this.expBar_ = new StatusBar(this.expBarW,this.expBarH,this.expBarF,this.expBarB,TextKey.EXP_BAR_LEVEL);
         this.fameBar_ = new StatusBar(this.fameBarW,this.fameBarH,this.fameBarF,this.fameBarB,TextKey.CURRENCY_FAME);
         this.hpBar_ = new StatusBar(this.hpBarW,this.hpBarH,this.hpBarF,this.hpBarB,TextKey.STATUS_BAR_HEALTH_POINTS);
         this.mpBar_ = new StatusBar(this.mpBarW,this.mpBarH,this.mpBarF,this.mpBarB,TextKey.STATUS_BAR_MANA_POINTS);
         this.expBar_.y = 0;
         this.fameBar_.y = 17;
         this.hpBar_.y = 34;
         this.mpBar_.y = 51;
         this.expBar_.visible = true;
         this.fameBar_.visible = true;
         addChild(this.expBar_);
         addChild(this.fameBar_);
         addChild(this.hpBar_);
         addChild(this.mpBar_);
      }

      public function update(param1:Player) : void {
         this.expBar_.setLabelText(TextKey.EXP_BAR_LEVEL,{"level":param1.level_});
         if(param1.level_ != 20) {
            if(this.expTimer) {
               this.expTimer.update(param1.xpTimer);
            }
            if(!this.expBar_.visible) {
               this.expBar_.visible = true;
               this.fameBar_.visible = true;
            }
            if(this.curXPBoost != param1.xpBoost_) {
               this.curXPBoost = param1.xpBoost_;
               if(this.curXPBoost) {
                  this.expBar_.showMultiplierText();
               } else {
                  this.expBar_.hideMultiplierText();
               }
            }
            if(param1.xpTimer) {
               if(!this.areTempXpListenersAdded) {
                  this.expBar_.addEventListener("MULTIPLIER_OVER",this.onExpBarOver);
                  this.expBar_.addEventListener("MULTIPLIER_OUT",this.onExpBarOut);
                  this.areTempXpListenersAdded = true;
               }
            } else {
               if(this.areTempXpListenersAdded) {
                  this.expBar_.removeEventListener("MULTIPLIER_OVER",this.onExpBarOver);
                  this.expBar_.removeEventListener("MULTIPLIER_OUT",this.onExpBarOut);
                  this.areTempXpListenersAdded = false;
               }
               if(Boolean(this.expTimer) && Boolean(this.expTimer.parent)) {
                  removeChild(this.expTimer);
                  this.expTimer = null;
               }
            }
         } else {
            if(!this.fameBar_.visible) {
               this.fameBar_.visible = true;
               this.expBar_.visible = true;
            }
         }
         this.expBar_.draw(param1.exp_,param1.nextLevelExp_,0);
         this.fameBar_.draw(param1.currFame_,param1.nextClassQuestFame_,0);
         this.hpBar_.draw(param1.hp_,param1.maxHP_,param1.maxHPBoost_,param1.maxHPMax_);
         this.mpBar_.draw(param1.mp_,param1.maxMP_,param1.maxMPBoost_,param1.maxMPMax_);
      }

      private function onExpBarOver(param1:Event) : void {
         addChild(this.expTimer = new ExperienceBoostTimerPopup());
      }

      private function onExpBarOut(param1:Event) : void {
         if(Boolean(this.expTimer) && Boolean(this.expTimer.parent)) {
            removeChild(this.expTimer);
            this.expTimer = null;
         }
      }
   }
}
