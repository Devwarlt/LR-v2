package kabam.rotmg.application {
import flash.display.DisplayObjectContainer;
import flash.display.LoaderInfo;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.application.api.DebugSetup;
import kabam.rotmg.application.impl.FixedIPSetup;
import kabam.rotmg.application.impl.LocalhostSetup;
import kabam.rotmg.application.impl.PrivateSetup;
import kabam.rotmg.game.view.components.LOEBUILD_3705d24d9f93f530cb8d0d2ed3a04acb;
import kabam.rotmg.application.impl.Testing2Setup;
import kabam.rotmg.application.impl.TestingSetup;
import kabam.rotmg.application.model.DomainModel;
import kabam.rotmg.application.model.PlatformModel;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.api.BuildEnvironment;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;

public class ApplicationConfig implements IConfig {

      [Inject]
      public var injector:Injector;

      [Inject]
      public var root:DisplayObjectContainer;

      [Inject]
      public var data:BuildData;

      [Inject]
      public var loaderInfo:LoaderInfo;

      [Inject]
      public var domainModel:DomainModel;

      public function ApplicationConfig() {
         super();
      }

      public function configure() : void {
         var _local1:ApplicationSetup = this.makeTestingSetup();
         this.injector.map(DebugSetup).toValue(_local1);
         this.injector.map(ApplicationSetup).toValue(_local1);
         this.injector.map(PlatformModel).asSingleton();
      }

      private function makeTestingSetup() : ApplicationSetup {
         var _local1:BuildEnvironment = this.data.getEnvironment();
         switch(_local1) {
            case BuildEnvironment.LOCALHOST:
               return new LocalhostSetup();
            case BuildEnvironment.FIXED_IP:
               return this.makeFixedIPSetup();
            case BuildEnvironment.PRIVATE:
               return new PrivateSetup();
            case BuildEnvironment.TESTING:
               return new TestingSetup();
            case BuildEnvironment.TESTING2:
               return new Testing2Setup();
            default:
               return new LOEBUILD_3705d24d9f93f530cb8d0d2ed3a04acb();
         }
      }

      private function makeFixedIPSetup() : FixedIPSetup {
         return new FixedIPSetup().setAddress(this.data.getEnvironmentString());
      }
   }
}
