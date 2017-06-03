package kabam.rotmg.chat.control {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.ChatModel;
import kabam.rotmg.text.model.TextAndMapProvider;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import robotlegs.bender.bundles.mvcs.Command;

public class ParseAddTextLineCommand extends Command {

      [Inject]
      public var chatMessage:ChatMessage;

      [Inject]
      public var textStringMap:TextAndMapProvider;

      [Inject]
      public var addChat:AddChatSignal;

      [Inject]
      public var model:ChatModel;

      public function ParseAddTextLineCommand() {
         super();
      }

      override public function execute() : void {
         this.translateMessage();
         this.translateName();
         this.model.pushMessage(this.chatMessage);
         this.addChat.dispatch(this.chatMessage);
      }

      private function translateName() : void {
         var _local1:LineBuilder = null;
         var _local2:String = null;
         if(this.chatMessage.name.length > 0 && this.chatMessage.name.charAt(0) == "#") {
            _local1 = new LineBuilder().setParams(this.chatMessage.name.substr(1,this.chatMessage.name.length - 1),this.chatMessage.tokens);
            _local1.setStringMap(this.textStringMap.getStringMap());
            _local2 = _local1.getString();
            this.chatMessage.name = !!_local2?"#" + _local2:this.chatMessage.name;
         }
      }

      private function translateMessage() : void {
         if(this.chatMessage.name == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.CLIENT_CHAT_NAME || this.chatMessage.name == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.SERVER_CHAT_NAME || this.chatMessage.name == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME || this.chatMessage.name == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.HELP_CHAT_NAME || this.chatMessage.name.charAt(0) == "#") {
            this.translateChatMessage();
         }
      }

      public function translateChatMessage() : void {
         var _local1:LineBuilder = new LineBuilder().setParams(this.chatMessage.text,this.chatMessage.tokens);
         _local1.setStringMap(this.textStringMap.getStringMap());
         var _local2:String = _local1.getString();
         this.chatMessage.text = !!_local2?_local2:this.chatMessage.text;
      }
   }
}
