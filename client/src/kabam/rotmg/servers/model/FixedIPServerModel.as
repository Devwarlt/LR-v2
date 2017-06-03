package kabam.rotmg.servers.model {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

public class FixedIPServerModel implements ServerModel {

      private var localhost:Server;

      public function FixedIPServerModel() {
         super();
         this.localhost = new Server().setName("localhost").setPort(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.PORT);
      }

      public function setIP(param1:String) : FixedIPServerModel {
         this.localhost.setAddress(param1);
         return this;
      }

      public function getServers() : Vector.<Server> {
         return new <Server>[this.localhost];
      }

      public function getServer() : Server {
         return this.localhost;
      }

      public function isServerAvailable() : Boolean {
         return true;
      }

      public function setServers(param1:Vector.<Server>) : void {
      }
   }
}
