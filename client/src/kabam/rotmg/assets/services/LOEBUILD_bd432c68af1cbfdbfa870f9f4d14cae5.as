package kabam.rotmg.assets.services {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;

import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

public class LOEBUILD_bd432c68af1cbfdbfa870f9f4d14cae5 {

      [Inject]
      public var servers:ServerModel;

      [Inject]
      public var data:XML;

      public function LOEBUILD_bd432c68af1cbfdbfa870f9f4d14cae5() {
         super();
      }

      public function execute() : void {
         this.servers.setServers(this.makeListOfServers());
      }

      private function makeListOfServers() : Vector.<Server> {
         var _local3:XML;
         var _local1:XMLList = this.data.child("Servers").child("Server");
         var _local2:Vector.<Server> = new Vector.<Server>(0);
          //_local2.push(new Server().setName("Main Server").setAddress("127.0.0.1").setPort(LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.PORT).setLatLong(Number("1337"), Number("1337")).setUsage(0).setIsAdminOnly(1));
         for each(_local3 in _local1) {
            _local2.push(makeServer(_local3));
         }
         return _local2;
      }

      private static function makeServer(param1:XML) : Server {
         return new Server().setName(param1.Name).setAddress(param1.DNS).setPort(2889).setLatLong(Number(param1.Lat),Number(param1.Long)).setUsage(param1.Usage).setIsAdminOnly(param1.hasOwnProperty("AdminOnly"));
      }
   }
}
