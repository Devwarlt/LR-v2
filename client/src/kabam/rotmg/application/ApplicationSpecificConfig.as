package kabam.rotmg.application {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_207dab0eef8e648701525f3b592d0d2a;
import kabam.rotmg.application.api.ApplicationSetup;

import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class ApplicationSpecificConfig implements IConfig {

      [Inject]
      public var context:IContext;

      [Inject]
      public var applicationSetup:ApplicationSetup;

      public function ApplicationSpecificConfig() {
         super();
      }

      public function configure() : void {
         if(this.applicationSetup.isDebug()) {
            this.context.extend(LOEBUILD_207dab0eef8e648701525f3b592d0d2a);
         }
      }
   }
}
