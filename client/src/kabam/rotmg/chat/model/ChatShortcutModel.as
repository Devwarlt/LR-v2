package kabam.rotmg.chat.model {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.ui.options.Options;

public class ChatShortcutModel {

      private var commandShortcut:int = 191;

      private var chatShortcut:int = 13;

      private var tellShortcut:int = 9;

      private var guildShortcut:int = 71;

      private var scrollUp:uint = 33;

      private var scrollDown:uint = 34;

      public function ChatShortcutModel() {
         super();
      }

      public function getCommandShortcut() : int {
         return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[Options.CHAT_COMMAND];
      }

      public function getChatShortcut() : int {
         return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[Options.CHAT];
      }

      public function getTellShortcut() : int {
         return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[Options.TELL];
      }

      public function getGuildShortcut() : int {
         return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[Options.GUILD_CHAT];
      }

    public function getGlobalChatShortcut() : int {
        return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[Options.GLOBAL_CHAT];
    }

      public function getScrollUp() : uint {
         return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[Options.SCROLL_CHAT_UP];
      }

      public function getScrollDown() : uint {
         return LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_[Options.SCROLL_CHAT_DOWN];
      }
   }
}
