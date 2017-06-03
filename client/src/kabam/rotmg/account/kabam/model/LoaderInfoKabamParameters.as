package kabam.rotmg.account.kabam.model {
import flash.display.LoaderInfo;

import kabam.lib.json.Base64Decoder;
import kabam.lib.json.JsonParser;

import robotlegs.bender.framework.api.ILogger;

public class LoaderInfoKabamParameters implements KabamParameters {

      [Inject]
      public var info:LoaderInfo;

      [Inject]
      public var json:JsonParser;

      [Inject]
      public var decoder:Base64Decoder;

      [Inject]
      public var logger:ILogger;

      public function LoaderInfoKabamParameters() {
         super();
      }

      public function getSignedRequest() : String {
         return this.info.parameters.kabam_signed_request;
      }

      public function getUserSession() : Object {
         var signedRequest:String = null;
         var requestDetails:Array = null;
         var payload:String = null;
         var userSession:Object = null;
         signedRequest = this.getSignedRequest();
         try {
            requestDetails = signedRequest.split(".",2);
            if(requestDetails.length != 2) {
               throw new Error("Invalid signed request");
            }
            payload = this.base64UrlDecode(requestDetails[1]);
            userSession = this.json.parse(payload);
         }
         catch(error:Error) {
            logger.info("Failed to get user session: " + error.toString() + ", signed request: " + signedRequest);
            userSession = null;
         }
         return userSession;
      }

      protected function base64UrlDecode(param1:String) : String {
         var _local2:RegExp = new RegExp("-","g");
         var _local3:RegExp = new RegExp("_","g");
         var _local4:int = 4 - param1.length % 4;
         while(_local4--) {
            param1 = param1 + "=";
         }
         param1 = param1.replace(_local2,"+").replace(_local3,"/");
         return this.decoder.decode(param1);
      }
   }
}
