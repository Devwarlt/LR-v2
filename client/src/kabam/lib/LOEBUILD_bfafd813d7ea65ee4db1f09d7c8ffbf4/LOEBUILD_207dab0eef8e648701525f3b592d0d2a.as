package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4 {
import flash.display.DisplayObjectContainer;

import kabam.lib.resizing.ResizeExtension;

import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;

public class LOEBUILD_207dab0eef8e648701525f3b592d0d2a implements IExtension {

      [Inject]
      public var contextView:DisplayObjectContainer;

      public function LOEBUILD_207dab0eef8e648701525f3b592d0d2a() {
         super();
      }

      public function extend(param1:IContext) : void {
         param1.extend(SignalCommandMapExtension).extend(ResizeExtension).configure(LOEBUILD_eab77a9821a551ed3cd846464da6647a);
      }
   }
}
