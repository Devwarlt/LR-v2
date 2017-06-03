package com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99 {
import com.company.assembleegameclient.util.BitmapDataSpy;

import flash.display.BitmapData;
import flash.net.URLLoaderDataFormat;
import flash.utils.ByteArray;

import com.company.util.PNGDecoder;

import kabam.rotmg.appengine.api.RetryLoader;
import kabam.rotmg.appengine.impl.AppEngineRetryLoader;
import kabam.rotmg.core.StaticInjectorContext;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.ILogger;

public class RemoteTexture {

      private static const URL_PATTERN:String = "http://{DOMAIN}/picture/get";

      private static const ERROR_PATTERN:String = "Remote Texture Error: {ERROR} (id:{ID}, instance:{INSTANCE})";

      private static const START_TIME:int = int(new Date().getTime());

      public var id_:String;

      public var instance_:String;

      public var callback_:Function;

      private var logger:ILogger;

      public function RemoteTexture(param1:String, param2:String, param3:Function) {
         super();
         this.id_ = param1;
         this.instance_ = param2;
         this.callback_ = param3;
         var _local4:Injector = StaticInjectorContext.getInjector();
         this.logger = _local4.getInstance(ILogger);
      }

      public function run() : void {
         var _local1:String = this.instance_ == "testing"?"rotmgtesting.appspot.com":"realmofthemadgod.appspot.com";
         var _local2:String = URL_PATTERN.replace("{DOMAIN}",_local1);
         var _local3:Object = {};
         _local3.id = this.id_;
         _local3.time = START_TIME;
         var _local4:RetryLoader = new AppEngineRetryLoader();
         _local4.setDataFormat(URLLoaderDataFormat.BINARY);
         _local4.complete.addOnce(this.onComplete);
         _local4.sendRequest(_local2,_local3);
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.makeTexture(param2);
         } else {
            this.reportError(param2);
         }
      }

      public function makeTexture(param1:ByteArray) : void {
         var _local2:BitmapData = PNGDecoder.decodeImage(param1);
         this.callback_(_local2);
      }

      public function reportError(param1:String) : void {
         param1 = ERROR_PATTERN.replace("{ERROR}",param1).replace("{ID}",this.id_).replace("{INSTANCE}",this.instance_);
         this.logger.warn("RemoteTexture.reportError: {0}",[param1]);
         var _local2:BitmapData = new BitmapDataSpy(1,1);
         this.callback_(_local2);
      }
   }
}
