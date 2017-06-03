package kabam.rotmg.build.impl {
import flash.display.LoaderInfo;
import flash.net.LocalConnection;
import flash.system.Capabilities;

import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.api.BuildEnvironment;

public class CompileTimeBuildData implements BuildData {

      private static const DESKTOP:String = "Desktop";

      private static const ROTMG:String = "www.realmofthemadgod.com";

      private static const ROTMG_APPSPOT:String = "realmofthemadgodhrd.appspot.com";

      private static const ROTMG_TESTING:String = "rotmgtesting.appspot.com";

      private static const ROTMG_TESTING_MAP:String = "testing.realmofthemadgod.com";

      private static const ROTMG_TESTING2:String = "realmtesting2.appspot.com";

      private static const STEAM_PRODUCTION_CONFIG:String = "Production";

      [Inject]
      public var loaderInfo:LoaderInfo;

      [Inject]
      public var environments:BuildEnvironments;

      private var isParsed:Boolean = false;

      private var environment:BuildEnvironment;

      public function CompileTimeBuildData() {
         super();
      }

      public function getEnvironmentString() : String {
         return "production".toLowerCase();
      }

      public function getEnvironment() : BuildEnvironment {
         this.isParsed || this.parseEnvironment();
         return this.environment;
      }

      private function parseEnvironment() : void {
         this.isParsed = true;
         this.setEnvironmentValue(this.getEnvironmentString());
      }

      private function setEnvironmentValue(param1:String) : void {
         var _local3:LocalConnection = null;
         var _local2:Boolean = this.conditionsRequireTesting(param1);
         if(_local2) {
            _local3 = new LocalConnection();
            if(_local3.domain == ROTMG_TESTING || _local3.domain == ROTMG_TESTING_MAP) {
               this.environment = BuildEnvironment.TESTING;
            } else if(_local3.domain == ROTMG_TESTING2) {
               this.environment = BuildEnvironment.TESTING2;
            }
         } else {
            this.environment = this.environments.getEnvironment(param1);
         }
      }

      private function conditionsRequireTesting(param1:String) : Boolean {
         return param1 == BuildEnvironments.PRODUCTION && !this.isMarkedAsProductionRelease();
      }

      private function isMarkedAsProductionRelease() : Boolean {
         return !!this.isDesktopPlayer()?Boolean(this.isSteamProductionDeployment()):Boolean(this.isHostedOnProductionServers());
      }

      private function isDesktopPlayer() : Boolean {
         return Capabilities.playerType == DESKTOP;
      }

      private function isSteamProductionDeployment() : Boolean {
         var _local1:Object = this.loaderInfo.parameters;
         return _local1.deployment == STEAM_PRODUCTION_CONFIG;
      }

      private function isHostedOnProductionServers() : Boolean {
         var _local1:LocalConnection = new LocalConnection();
         return _local1.domain == ROTMG || _local1.domain == ROTMG_APPSPOT;
      }
   }
}
