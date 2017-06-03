package kabam.rotmg.game.model {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

public class ChatFilter {


    private static const LIGHTBLUE_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.LIGHTBLUE_STAR;

    private static const BLUE_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.BLUE_STAR;

    private static const RED_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.RED_STAR;

    private static const ORANGE_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ORANGE_STAR;

    private static const YELLOW_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.YELLOW_STAR;

    private static const WHITE_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.WHITE_STAR;

    private static const MOD_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.MODERATOR;

    private static const ADMIN_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ADMINISTRATOR;

    private static const DEV_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.DEVWARLT;

      public function ChatFilter() {
         super();
      }

      public function guestChatFilter(param1:String) : Boolean {
         var _local2:Boolean = false;
         if(param1 == null) {
            return true;
         }
         if(param1 == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.SERVER_CHAT_NAME || param1 == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.HELP_CHAT_NAME || param1 == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME || param1 == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.CLIENT_CHAT_NAME) {
            _local2 = true;
         }
         if(param1.charAt(0) == "#") {
            _local2 = true;
         }
         if(param1.charAt(0) == "@") {
            _local2 = true;
         }
          if(param1.charAt(0) == LIGHTBLUE_CHAT) {
              _local2 = true;
          }
          if(param1.charAt(0) == BLUE_CHAT) {
              _local2 = true;
          }
          if(param1.charAt(0) == RED_CHAT) {
              _local2 = true;
          }
          if(param1.charAt(0) == ORANGE_CHAT) {
              _local2 = true;
          }
          if(param1.charAt(0) == YELLOW_CHAT) {
              _local2 = true;
          }
          if(param1.charAt(0) == WHITE_CHAT) {
              _local2 = true;
          }
          if(param1.charAt(0) == MOD_CHAT) {
              _local2 = true;
          }
          if(param1.charAt(0) == ADMIN_CHAT) {
              _local2 = true;
          }
          if(param1.charAt(0) == DEV_CHAT) {
              _local2 = true;
          }
         return _local2;
      }
   }
}
