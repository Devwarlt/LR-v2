package kabam.rotmg.ui.model {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

public class HUDModel {

      public var gameSprite:GameSprite;

      public function HUDModel() {
         super();
      }

      public function getPlayerName() : String {
         return !!this.gameSprite.model.getName()?this.gameSprite.model.getName():this.gameSprite.map.player_.name_;
      }

      public function getButtonType() : String {
         return this.gameSprite.gsc_.gameId_ == LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.NEXUS_GAMEID?"OPTIONS_BUTTON":"NEXUS_BUTTON";
      }
   }
}
