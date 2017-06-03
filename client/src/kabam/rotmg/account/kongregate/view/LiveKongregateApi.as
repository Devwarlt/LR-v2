package kabam.rotmg.account.kongregate.view {
import com.google.analytics.utils.Variables;

import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.Security;

import kabam.rotmg.account.kongregate.services.KongregateSharedObject;
import kabam.rotmg.account.kongregate.signals.RelayApiLoginSignal;

import org.osflash.signals.Signal;

import robotlegs.bender.framework.api.ILogger;

public class LiveKongregateApi extends Sprite implements KongregateApi {

      [Inject]
      public var local:KongregateSharedObject;

      [Inject]
      public var apiLogin:RelayApiLoginSignal;

      [Inject]
      public var logger:ILogger;

      private var _loaded:Signal;

      private var _purchaseResponse:Signal;

      private var loader:Loader;

      private var api:Variables;

      public function LiveKongregateApi() {
         super();
         this._loaded = new Signal();
         this._purchaseResponse = new Signal(Object);
      }

      public function load(param1:String) : void {
         Security.allowDomain(param1);
         this.logger.info("kongregate api loading");
         addChild(this.loader = new Loader());
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onAPILoaded);
         this.loader.load(new URLRequest(param1));
      }

      private function onAPILoaded(param1:Event) : void {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onAPILoaded);
         this.api = param1.target.content;
         this.api.services.connect();
         this.addExternalLoginListenerForGuestUser();
         this.loaded.dispatch();
         this.logger.info("kongregate api loaded");
      }

      private function addExternalLoginListenerForGuestUser() : void {
         if(this.api.services.isGuest()) {
            this.logger.info("kongregate guest detected - listening for external login");
            this.api.services.addEventListener("login",this.onExternalLogin);
         }
      }

      private function onExternalLogin(param1:Event) : void {
         this.logger.info("external login from kongregate detected");
         this.apiLogin.dispatch();
      }

      public function get loaded() : Signal {
         return this._loaded;
      }

      public function showRegistrationDialog() : void {
         this.logger.info("showRegistrationBox request sent to kongregate");
         this.api.services.showRegistrationBox();
      }

      public function isGuest() : Boolean {
         return this.api.services.isGuest();
      }

      public function getAuthentication() : Object {
         var _local1:Object = {};
         _local1.userId = this.api.services.getUserId();
         _local1.username = this.api.services.getUsername();
         _local1.gameAuthToken = this.api.services.getGameAuthToken();
         return _local1;
      }

      public function reportStatistic(param1:String, param2:int) : void {
         this.api.stats.submit(param1,param2);
      }

      public function getUserName() : String {
         return this.api.services.getUsername();
      }

      public function getUserId() : String {
         return this.api.services.getUserId();
      }

      public function purchaseItems(param1:Object) : void {
         this.api.mtx.purchaseItems([param1],this.onPurchase);
      }

      private function onPurchase(param1:Object) : void {
         this._purchaseResponse.dispatch(param1);
      }

      public function get purchaseResponse() : Signal {
         return this._purchaseResponse;
      }
   }
}
