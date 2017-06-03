package kabam.rotmg.ui.signals {
import kabam.rotmg.assets.model.Player;

import org.osflash.signals.Signal;

public class UpdateHUDSignal extends Signal {

      public function UpdateHUDSignal() {
         super(Player);
      }
   }
}
