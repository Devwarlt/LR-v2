package kabam.rotmg.chat.control {
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.GameObject;
import com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.view.ConfirmEmailModal;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.TellModel;
import kabam.rotmg.chat.view.ChatListItemFactory;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.services.FortuneModel;
import kabam.rotmg.friends.model.FriendModel;
import kabam.rotmg.game.model.AddSpeechBalloonVO;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.messaging.impl.incoming.Text;
import kabam.rotmg.news.view.NewsTicker;
import kabam.rotmg.servers.api.ServerModel;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.model.HUDModel;

public class TextHandler {

      private const NORMAL_SPEECH_COLORS:TextColors = new TextColors(14802908,16777215,5526612);

      private const ENEMY_SPEECH_COLORS:TextColors = new TextColors(5644060,16549442,13484223);

      private const TELL_SPEECH_COLORS:TextColors = new TextColors(2493110,61695,13880567);

      private const GUILD_SPEECH_COLORS:TextColors = new TextColors(4098560,10944349,13891532);

    //private const CHATTYPE_SPEECH_COLORS:TextColors = new TextColors(dark,light,superlight);

    private const LIGHTBLUE_SPEECH_COLORS:TextColors = new TextColors(4018872,9017309,12896739);
    private const BLUE_SPEECH_COLORS:TextColors = new TextColors(2175623,3165402,6847190);
    private const RED_SPEECH_COLORS:TextColors = new TextColors(8002592,12592684,12935525);
    private const ORANGE_SPEECH_COLORS:TextColors = new TextColors(12546842,16159261,15379555);
    private const YELLOW_SPEECH_COLORS:TextColors = new TextColors(14079488,16776960,16777145);
    private const WHITE_SPEECH_COLORS:TextColors = new TextColors(0,3223857,16777215);
    private const MOD_SPEECH_COLORS:TextColors = new TextColors(5185404,9055202,12157676);
    private const ADMIN_SPEECH_COLORS:TextColors = new TextColors(45164,64154,9830358);
    private const DEV_SPEECH_COLORS:TextColors = new TextColors(8000084,13639824,15173060);

      [Inject]
      public var account:Account;

      [Inject]
      public var model:GameModel;

      [Inject]
      public var addTextLine:AddTextLineSignal;

      [Inject]
      public var addSpeechBalloon:AddSpeechBalloonSignal;

      [Inject]
      public var stringMap:StringMap;

      [Inject]
      public var tellModel:TellModel;

      [Inject]
      public var spamFilter:SpamFilter;

      [Inject]
      public var openDialogSignal:OpenDialogSignal;

      [Inject]
      public var hudModel:HUDModel;

      [Inject]
      public var friendModel:FriendModel;

      public function TextHandler() {
         super();
      }

      public function execute(param1:Text) : void {
         var _local3:String = null;
         var _local4:String = null;
         var _local5:String = null;
         var _local2:Boolean = param1.numStars_ == -1 || param1.objectId_ == -1;
         if(param1.numStars_ < LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.chatStarRequirement && param1.name_ != this.model.player.name_ && !_local2 && !this.isSpecialRecipientChat(param1.recipient_)) {
            return;
         }
         if(Boolean(param1.recipient_ != "") && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.chatFriend) && !this.friendModel.isMyFriend(param1.recipient_)) {
            return;
         }
         if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.chatAll && param1.name_ != this.model.player.name_ && !_local2 && !this.isSpecialRecipientChat(param1.recipient_)) {
            if(!(param1.recipient_ == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.GUILD_CHAT_NAME && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.chatGuild))) {
               if(!(param1.recipient_ != "" && Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.chatWhisper))) {
                  return;
               }
            }
         }
         if(this.useCleanString(param1)) {
            _local3 = param1.cleanText_;
            param1.cleanText_ = this.replaceIfSlashServerCommand(param1.cleanText_);
         } else {
            _local3 = param1.text_;
            param1.text_ = this.replaceIfSlashServerCommand(param1.text_);
         }
         if(Boolean(_local2) && Boolean(this.isToBeLocalized(_local3))) {
            _local3 = this.getLocalizedString(_local3);
         }
         if(!_local2 && Boolean(this.spamFilter.isSpam(_local3))) {
            if(param1.name_ == this.model.player.name_) {
               this.addTextLine.dispatch(ChatMessage.make(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME,"This message has been flagged as spam."));
            }
            return;
         }
         if(param1.recipient_) {
            if(param1.recipient_ != this.model.player.name_ && !this.isSpecialRecipientChat(param1.recipient_)) {
               this.tellModel.push(param1.recipient_);
               this.tellModel.resetRecipients();
            } else if(param1.recipient_ == this.model.player.name_) {
               this.tellModel.push(param1.name_);
               this.tellModel.resetRecipients();
            }
         }
         if(Boolean(_local2) && LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a.remoteTexturesUsed == true) {
            LOEBUILD_ccd59f4c6a3fda7951ac27373fffd93a.remoteTexturesUsed = false;
            _local4 = param1.name_;
            _local5 = param1.text_;
            param1.name_ = "";
            param1.text_ = "Remote Textures used in this build";
            this.addTextAsTextLine(param1);
            param1.name_ = _local4;
            param1.text_ = _local5;
         }
         if(_local2) {
            if(param1.text_ == "Please verify your email before chat" && this.hudModel != null && this.hudModel.gameSprite.map.name_ == "Nexus" && this.openDialogSignal != null) {
               this.openDialogSignal.dispatch(new ConfirmEmailModal());
            } else if(param1.name_ == "@ANNOUNCEMENT") {
               if(this.hudModel != null && this.hudModel.gameSprite != null && this.hudModel.gameSprite.newsTicker != null) {
                  this.hudModel.gameSprite.newsTicker.activateNewScrollText(param1.text_);
               } else {
                  NewsTicker.setPendingScrollText(param1.text_);
               }
            } else if(param1.name_ == "#{LOEBUILD_5891da2d64975cae48d175d1e001f5da.ft_shopkeep}" && !FortuneModel.HAS_FORTUNES) {
               return;
            }
         }
         if(param1.objectId_ >= 0) {
            this.showSpeechBaloon(param1,_local3);
         }
         if(Boolean(_local2) || Boolean(this.account.isRegistered()) && (!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["hidePlayerChat"] || Boolean(this.isSpecialRecipientChat(param1.name_)))) {
            this.addTextAsTextLine(param1);
         }
      }

      private function isSpecialRecipientChat(param1:String) : Boolean {
         return param1.length > 0 && (param1.charAt(0) == "#" || param1.charAt(0) == "*");
      }

      public function addTextAsTextLine(param1:Text) : void {
         var _local2:ChatMessage = new ChatMessage();
         _local2.name = param1.name_;
         _local2.objectId = param1.objectId_;
         _local2.numStars = param1.numStars_;
         _local2.recipient = param1.recipient_;
         _local2.isWhisper = Boolean(param1.recipient_) && !this.isSpecialRecipientChat(param1.recipient_);
         _local2.isToMe = param1.recipient_ == this.model.player.name_;
         this.addMessageText(param1,_local2);
         this.addTextLine.dispatch(_local2);
      }

      public function addMessageText(param1:Text, param2:ChatMessage) : void {
         var lb:LineBuilder = null;
         var text:Text = param1;
         var message:ChatMessage = param2;
         try {
            lb = LineBuilder.fromJSON(text.text_);
            message.text = lb.key;
            message.tokens = lb.tokens;
            return;
         }
         catch(error:Error) {
            message.text = !!useCleanString(text)?text.cleanText_:text.text_;
            return;
         }
      }

      private function replaceIfSlashServerCommand(param1:String) : String {
         var _local2:ServerModel = null;
         if(param1.substr(0,7) == "74026S9") {
            _local2 = StaticInjectorContext.getInjector().getInstance(ServerModel);
            if(Boolean(_local2) && Boolean(_local2.getServer())) {
               return param1.replace("74026S9",_local2.getServer().name + ", ");
            }
         }
         return param1;
      }

      private function isToBeLocalized(param1:String) : Boolean {
         return param1.charAt(0) == "{" && param1.charAt(param1.length - 1) == "}";
      }

      private function getLocalizedString(param1:String) : String {
         var _local2:LineBuilder = LineBuilder.fromJSON(param1);
         _local2.setStringMap(this.stringMap);
         return _local2.getString();
      }

      private function showSpeechBaloon(param1:Text, param2:String) : void {
         var _local4:TextColors = null;
         var _local5:Boolean = false;
         var _local6:Boolean = false;
         var _local7:AddSpeechBalloonVO = null;
         var _local3:GameObject = this.model.getGameObject(param1.objectId_);
         if(_local3 != null) {
            _local4 = this.getColors(param1,_local3);
            _local5 = ChatListItemFactory.isTradeMessage(param1.numStars_,param1.objectId_,param2);
            _local6 = ChatListItemFactory.isGuildMessage(param1.name_);
            _local7 = new AddSpeechBalloonVO(_local3,param2,param1.name_,_local5,_local6,_local4.back,1,_local4.outline,1,_local4.text,param1.bubbleTime_,false,true);
            this.addSpeechBalloon.dispatch(_local7);
         }
      }

      private function getColors(param1:Text, param2:GameObject) : TextColors {
         if(param2.props_.nm_) {
            return this.ENEMY_SPEECH_COLORS;
         }
         if(param1.recipient_ == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.GUILD_CHAT_NAME) {
            return this.GUILD_SPEECH_COLORS;
         }
         if(param1.recipient_ != "") {
            return this.TELL_SPEECH_COLORS;
         }
          if(param1.name_.charAt(0) == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.LIGHTBLUE_STAR) {
              return this.LIGHTBLUE_SPEECH_COLORS;
          }
          if(param1.name_.charAt(0) == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.BLUE_STAR) {
              return this.BLUE_SPEECH_COLORS;
          }
          if(param1.name_.charAt(0) == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.RED_STAR) {
              return this.RED_SPEECH_COLORS;
          }
          if(param1.name_.charAt(0) == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ORANGE_STAR) {
              return this.ORANGE_SPEECH_COLORS;
          }
          if(param1.name_.charAt(0) == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.YELLOW_STAR) {
              return this.YELLOW_SPEECH_COLORS;
          }
          if(param1.name_.charAt(0) == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.WHITE_STAR) {
              return this.WHITE_SPEECH_COLORS;
          }
          if(param1.name_.charAt(0) == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.MODERATOR) {
              return this.MOD_SPEECH_COLORS;
          }
          if(param1.name_.charAt(0) == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ADMINISTRATOR) {
              return this.ADMIN_SPEECH_COLORS;
          }
          if(param1.name_.charAt(0) == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.DEVWARLT) {
              return this.DEV_SPEECH_COLORS;
          }
         return this.NORMAL_SPEECH_COLORS;
      }

      private function useCleanString(param1:Text) : Boolean {
         return Boolean(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.filterLanguage) && param1.cleanText_.length > 0 && param1.objectId_ != this.model.player.objectId_;
      }
   }
}
