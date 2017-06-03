package kabam.rotmg.game.commands {
import kabam.rotmg.assets.model.Player;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.sound.SoundEffectLibrary;

import flash.utils.getTimer;

import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.model.UseBuyPotionVO;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.model.PotionModel;

import robotlegs.bender.framework.api.ILogger;

public class UseBuyPotionCommand {

      [Inject]
      public var vo:UseBuyPotionVO;

      [Inject]
      public var potInventoryModel:PotionInventoryModel;

      [Inject]
      public var hudModel:HUDModel;

      [Inject]
      public var logger:ILogger;

      private var gsc:GameServerConnection;

      private var player:Player;

      private var potionId:int;

      private var count:int;

      private var potion:PotionModel;

      public function UseBuyPotionCommand() {
         this.gsc = GameServerConnection.instance;
         super();
      }

      public function execute() : void {
         this.player = this.hudModel.gameSprite.map.player_;
         if(this.player == null || this.player.map_ == null) {
            return;
         }
         this.potionId = this.vo.objectId;
         this.count = this.player.getPotionCount(this.potionId);
         this.potion = this.potInventoryModel.getPotionModel(this.potionId);
         if(this.count > 0 || Boolean(this.canPurchasePotion())) {
            this.usePotionIfEffective();
         } else {
            this.logger.info("Not safe to purchase potion");
         }
      }

      private function canPurchasePotion() : Boolean {
         var _local1:* = this.player.credits_ >= this.potion.currentCost(this.player.getPotionCount(this.potionId));
         var _local2:Boolean = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.contextualPotionBuy;
         return Boolean(_local1) && Boolean(_local2);
      }

      private function usePotionIfEffective() : void {
         if(this.isPlayerStatMaxed()) {
            this.logger.info("UseBuyPotionCommand.execute: User has MAX of that attribute, not requesting a use/buy from server.");
         } else {
            this.sendServerRequest();
            SoundEffectLibrary.play("use_potion");
         }
      }

      private function isPlayerStatMaxed() : Boolean {
         if(this.potionId == PotionInventoryModel.HEALTH_POTION_ID) {
            return this.player.hp_ >= this.player.maxHP_;
         }
         if(this.potionId == PotionInventoryModel.MAGIC_POTION_ID) {
            return this.player.mp_ >= this.player.maxMP_;
         }
         return false;
      }

      private function sendServerRequest() : void {
         var _local1:int = PotionInventoryModel.getPotionSlot(this.vo.objectId);
         var _local2:int = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.contextualPotionBuy;
         this.gsc.useItem(getTimer(),this.player.objectId_,_local1,this.potionId,this.player.x_,this.player.y_,_local2);
         if(this.player.getPotionCount(this.vo.objectId) == 0) {
            this.potInventoryModel.getPotionModel(this.vo.objectId).purchasedPot();
         }
      }
   }
}
