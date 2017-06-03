package kabam.rotmg.account.web.commands {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.web.WebAccount;

public class WebSetPaymentDataCommand {

      [Inject]
      public var characterListData:XML;

      [Inject]
      public var account:Account;

      public function WebSetPaymentDataCommand() {
         super();
      }

      public function execute() : void {
         var _local2:XML = null;
         var _local1:WebAccount = this.account as WebAccount;
         if(this.characterListData.hasOwnProperty("KabamPaymentInfo")) {
            _local2 = XML(this.characterListData.KabamPaymentInfo);
            _local1.signedRequest = _local2.signedRequest;
            _local1.kabamId = _local2.naid;
         }
      }
   }
}
