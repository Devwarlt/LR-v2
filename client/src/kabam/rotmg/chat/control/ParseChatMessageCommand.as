package kabam.rotmg.chat.control {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.ui.model.HUDModel;

public class ParseChatMessageCommand {

      [Inject]
      public var data:String;

      [Inject]
      public var hudModel:HUDModel;

      [Inject]
      public var addTextLine:AddTextLineSignal;

      public function ParseChatMessageCommand() {
         super();
      }

      public function execute() : void {
         if(this.data == "/help") {
            this.addTextLine.dispatch(ChatMessage.make(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.HELP_CHAT_NAME,TextKey.HELP_COMMAND));
         } else {
            this.hudModel.gameSprite.gsc_.playerText(this.data);
         }
      }
   }
}
