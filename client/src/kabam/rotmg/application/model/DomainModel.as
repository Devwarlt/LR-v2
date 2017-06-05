package kabam.rotmg.application.model {
import flash.net.LocalConnection;
import flash.system.Security;

import kabam.rotmg.errors.control.LOEBUILD_5c3fafb478917eee32f80d979a87cb36;

public class DomainModel {

    private const LOCALHOST:String = "www.loerealm.com";

    private const PRODUCTION_WHITELIST:Array = ["www.realmofthemadgod.com","realmofthemadgodhrd.appspot.com","realmofthemadgod.appspot.com"];

    private const TESTING_WHITELIST:Array = ["testing.realmofthemadgod.com","rotmgtesting.appspot.com","rotmghrdtesting.appspot.com"];

    private const TESTING2_WHITELIST:Array = ["realmtesting2.appspot.com"];

    private const TRANSLATION_WHITELIST:Array = ["xlate.kabam.com"];

    private const LOEBUILD_WHITELIST:Array = [LOEBUILD_5c3fafb478917eee32f80d979a87cb36.SERVER_IP];

    private const WHITELIST:Array = LOEBUILD_WHITELIST;
    //PRODUCTION_WHITELIST.concat(LOEBUILD_WHITELIST).concat(TESTING_WHITELIST).concat(TRANSLATION_WHITELIST).concat(TESTING2_WHITELIST);

    [Inject]
    public var client:PlatformModel;

    private var localDomain:String;

    public function DomainModel() {
        super();
    }

    public function applyDomainSecurity() : void {
        var _local1:String;
        for each(_local1 in this.WHITELIST) {
            Security.allowDomain(_local1);
        }
    }

    public function isLocalDomainValid() : Boolean {
        return Boolean(this.isLocalDomainInWhiteList());
    }

    //this.client.isDesktop() || Boolean(this.isLocalDomainInWhiteList())

    public function isLocalDomainProduction() : Boolean {
        var _local1:String = this.getLocalDomain();
        return this.PRODUCTION_WHITELIST.indexOf(_local1) != -1;
    }

    private function isLocalDomainInWhiteList() : Boolean {
        var _local3:String;
        var _local1:String = this.getLocalDomain();
        var _local2:* = _local1 == this.LOCALHOST;
        for each(_local3 in this.WHITELIST) {
            _local2 = Boolean(Boolean(_local2) || _local1 == _local3);
        }
        return _local2;
    }

    //_local2 = Boolean(Boolean(_local2) || _local1 == _local3);

    private function getLocalDomain() : String {
        return this.localDomain = this.localDomain || new LocalConnection().domain;
    }
}
}
