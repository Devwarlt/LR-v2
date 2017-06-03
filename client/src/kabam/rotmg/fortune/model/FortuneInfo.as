package kabam.rotmg.fortune.model {
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import kabam.display.Loader.LoaderProxy;
import kabam.display.Loader.LoaderProxyConcrete;

public class FortuneInfo {

      public static var chestImageEmbed:Class = FortuneInfo_chestImageEmbed;

      public var _id:String;

      public var _title:String;

      private var _description:String;

      public var _weight:String;

      public var _contents:String;

      private var _priceFirstInGold:String;

      private var _priceFirstInToken:String;

      private var _priceSecondInGold:String;

      public var _iconImageUrl:String;

      private var _iconImage:DisplayObject;

      public var _infoImageUrl:String;

      private var _infoImage:DisplayObject;

      public var _startTime:Date;

      public var _endTime:Date;

      private var _loader:LoaderProxy;

      private var _infoImageLoader:LoaderProxy;

      public var _rollsWithContents:Vector.<Vector.<int>>;

      public var _rollsWithContentsUnique:Vector.<int>;

      public function FortuneInfo() {
         this._loader = new LoaderProxyConcrete();
         this._infoImageLoader = new LoaderProxyConcrete();
         this._rollsWithContents = new Vector.<Vector.<int>>();
         this._rollsWithContentsUnique = new Vector.<int>();
         super();
      }

      public function get id() : * {
         return this._id;
      }

      public function set id(param1:String) : void {
         this._id = param1;
      }

      public function get title() : * {
         return this._title;
      }

      public function set title(param1:String) : void {
         this._title = param1;
      }

      public function get description() : * {
         return this._description;
      }

      public function set description(param1:String) : void {
         this._description = param1;
      }

      public function get weight() : * {
         return this._weight;
      }

      public function set weight(param1:String) : void {
         this._weight = param1;
      }

      public function get contents() : * {
         return this._contents;
      }

      public function set contents(param1:String) : void {
         this._contents = param1;
      }

      public function get priceFirstInGold() : String {
         return this._priceFirstInGold;
      }

      public function set priceFirstInGold(param1:String) : void {
         this._priceFirstInGold = param1;
      }

      public function get priceFirstInToken() : String {
         return this._priceFirstInToken;
      }

      public function set priceFirstInToken(param1:String) : void {
         this._priceFirstInToken = param1;
      }

      public function get priceSecondInGold() : String {
         return this._priceSecondInGold;
      }

      public function set priceSecondInGold(param1:String) : void {
         this._priceSecondInGold = param1;
      }

      public function get iconImageUrl() : * {
         return this._iconImageUrl;
      }

      public function set iconImageUrl(param1:String) : void {
         this._iconImageUrl = param1;
         this.loadIconImageFromUrl(this._iconImageUrl);
      }

      private function loadIconImageFromUrl(param1:String) : void {
         this._loader && this._loader.unload();
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR,this.onError);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR,this.onError);
         this._loader.load(new URLRequest(param1));
      }

      private function onError(param1:IOErrorEvent) : void {
         this._iconImage = new chestImageEmbed();
      }

      private function onComplete(param1:Event) : void {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onComplete);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.DISK_ERROR,this.onError);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR,this.onError);
         this._iconImage = DisplayObject(this._loader);
      }

      public function get iconImage() : DisplayObject {
         return this._iconImage;
      }

      public function get infoImageUrl() : * {
         return this._infoImageUrl;
      }

      public function set infoImageUrl(param1:String) : void {
         this._infoImageUrl = param1;
         this.loadInfomageFromUrl(this._infoImageUrl);
      }

      private function loadInfomageFromUrl(param1:String) : void {
         this.loadImageFromUrl(param1,this._infoImageLoader);
      }

      private function loadImageFromUrl(param1:String, param2:LoaderProxy) : void {
         param2 && param2.unload();
         param2.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onInfoComplete);
         param2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onInfoError);
         param2.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR,this.onInfoError);
         param2.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR,this.onInfoError);
         param2.load(new URLRequest(param1));
      }

      private function onInfoError(param1:IOErrorEvent) : void {
      }

      private function onInfoComplete(param1:Event) : void {
         this._infoImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onInfoComplete);
         this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onInfoError);
         this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.DISK_ERROR,this.onInfoError);
         this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR,this.onInfoError);
         this._infoImage = DisplayObject(this._infoImageLoader);
      }

      public function get startTime() : * {
         return this._startTime;
      }

      public function set startTime(param1:Date) : void {
         this._startTime = param1;
      }

      public function get endTime() : * {
         return this._endTime;
      }

      public function set endTime(param1:Date) : void {
         this._endTime = param1;
      }

      public function parseContents() : void {
         var _local3:String = null;
         var _local4:Vector.<int> = null;
         var _local5:Array = null;
         var _local6:String = null;
         var _local1:Array = this._contents.split(";");
         var _local2:Dictionary = new Dictionary();
         for each(_local3 in _local1) {
            _local4 = new Vector.<int>();
            _local5 = _local3.split(",");
            for each(_local6 in _local5) {
               if(_local2[int(_local6)] == null) {
                  _local2[int(_local6)] = true;
                  this._rollsWithContentsUnique.push(int(_local6));
               }
               _local4.push(int(_local6));
            }
            this._rollsWithContents.push(_local4);
         }
      }

      public function get infoImage() : DisplayObject {
         return this._infoImage;
      }

      public function set infoImage(param1:DisplayObject) : void {
         this._infoImage = param1;
      }

      public function get loader() : LoaderProxy {
         return this._loader;
      }

      public function set loader(param1:LoaderProxy) : void {
         this._loader = param1;
      }

      public function get infoImageLoader() : LoaderProxy {
         return this._infoImageLoader;
      }

      public function set infoImageLoader(param1:LoaderProxy) : void {
         this._infoImageLoader = param1;
      }
   }
}
