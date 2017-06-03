package kabam.rotmg.build.impl {
import kabam.rotmg.build.api.BuildEnvironment;

public final class BuildEnvironments {

      public static const LOCALHOST:String = "localhost";

      public static const PRIVATE:String = "private";

      public static const DEV:String = "dev";

      public static const TESTING:String = "testing";

      public static const TESTING2:String = "testing2";

      public static const PRODTEST:String = "prodtest";

      public static const PRODUCTION:String = "production";

      private static const IP_MATCHER:RegExp = new RegExp("[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}");

      public function BuildEnvironments() {
         super();
      }

      public function getEnvironment(param1:String) : BuildEnvironment {
         return !!this.isFixedIP(param1)?BuildEnvironment.FIXED_IP:this.getEnvironmentFromName(param1);
      }

      private function isFixedIP(param1:String) : Boolean {
         return param1.match(IP_MATCHER) != null;
      }

      private function getEnvironmentFromName(param1:String) : BuildEnvironment {
         switch(param1) {
            case LOCALHOST:
               return BuildEnvironment.LOCALHOST;
            case PRIVATE:
               return BuildEnvironment.PRIVATE;
            case DEV:
               return BuildEnvironment.DEV;
            case TESTING:
               return BuildEnvironment.TESTING;
            case TESTING2:
               return BuildEnvironment.TESTING2;
            case PRODTEST:
               return BuildEnvironment.PRODTEST;
            case PRODUCTION:
               return BuildEnvironment.PRODUCTION;
            default:
               return null;
         }
      }
   }
}
