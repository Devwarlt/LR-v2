package com.google.analytics.ecommerce
{
    import com.company.assembleegameclient.screens.VersionedLoader;
    //import com.junkbyte.console.core.CommandLine;

    //import flash.display.LoaderInfo;
    //import flash.events.TimerEvent;
    //import flash.external.ExternalInterface;
    import flash.net.LocalConnection;
    import flash.system.fscommand;
    //import flash.utils.Timer;

    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.application.model.DomainModel;
    import robotlegs.bender.framework.api.ILogger;
    //import com.company.assembleegameclient.screens.AccountLoadingScreen;
    import com.google.analytics.v4.LOEBUILD_9e66824be5912020ae4304d695ae300a;

    public class LOEBUILD_0d284c1a945e7f9811176ffdbf9091e6
    {

        [Inject]
        public var setScreen:SetScreenSignal;

        [Inject]
        public var domain:DomainModel;

        [Inject]
        public var logger:ILogger;

        public function LOEBUILD_0d284c1a945e7f9811176ffdbf9091e6()
        {
            super();
        }

        private function AGCLoEBuildLauncher() : void
        {
            this.setScreen.dispatch(new VersionedLoader("AssembleeGameClient"));
        }

        private function openBadDomainView() : void
        {
            this.logger.debug("bad domain, deny");
            this.setScreen.dispatch(new LOEBUILD_9e66824be5912020ae4304d695ae300a());
        }

        //private const PRODUCTION_WHITELIST:Array = ["www.realmofthemadgod.com","realmofthemadgodhrd.appspot.com","realmofthemadgod.appspot.com"];

        //private const TESTING_WHITELIST:Array = ["testing.realmofthemadgod.com","rotmgtesting.appspot.com","rotmghrdtesting.appspot.com"];

        //private const TESTING2_WHITELIST:Array = ["realmtesting2.appspot.com"];

        //private const TRANSLATION_WHITELIST:Array = ["xlate.kabam.com"];

        private const WHITELISTED:String = "www.loerealm.com";

        private const LOEBUILD_WHITELIST:Array = ["www.loerealm.com", "devwarlt.github.io", "216.107.151.109"];

        private const WHITELIST:Array = LOEBUILD_WHITELIST;

        private var localDomain:String;

        private function isLocalDomainInWhiteList() : Boolean {
            var _local3:String;
            var _local1:String = this.getLocalDomain();
            var _local2:* = _local1 == this.WHITELISTED;
            for each(_local3 in this.WHITELIST) {
                _local2 = Boolean(Boolean(_local2) || _local1 == _local3);
            }
            return _local2;
        }

        private function getLocalDomain() : String {
            return this.localDomain = this.localDomain || new LocalConnection().domain;
        }

        public function isLocalDomainValid() : Boolean {
            return Boolean(this.isLocalDomainInWhiteList());
        }

        public function execute() : void
        {
            this.AGCLoEBuildLauncher();
            /*if(this.isLocalDomainValid())
            {
                //this.showLoadingScreen();
                this.AGCLoEBuildLauncher();
            }
            else
            {
                this.openBadDomainView();
                fscommand("quit");
                //var tmr:Timer = new Timer(15000);
                //tmr.start();
                //tmr.addEventListener(TimerEvent.TIMER, this.quitApp());
            }*/
        }

        /*/
        var getURL:String
            = ExternalInterface.call(
                "window.location.href.toString"
            );
        if(
            (!this.domain.isLocalDomainValid())
            ||
            (getURL == "http://loerealm.no-ip.org/
            AGCLoEBuild.swf?
            server=
            e139d5cdbc18f23a522f86dd40490eaa")
            )
        /*/

        /*private function quitApp(){
            var _local1:CommandLine;
            _local1 = fscommand("quit");
            return _local1;
        }*/
    }
}
