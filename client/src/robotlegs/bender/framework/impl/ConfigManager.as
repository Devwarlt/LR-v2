package robotlegs.bender.framework.impl {
import flash.display.DisplayObject;
import flash.utils.Dictionary;

import org.hamcrest.Matcher;
import org.hamcrest.core.allOf;
import org.hamcrest.core.not;
import org.hamcrest.object.instanceOf;
import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.api.LifecycleEvent;

public class ConfigManager {

      private static const plainObjectMatcher:Matcher = allOf(instanceOf(Object),not(instanceOf(Class)),not(instanceOf(DisplayObject)));

      private const _uid:String = UID.create(ConfigManager);

      private const _objectProcessor:ObjectProcessor = new ObjectProcessor();

      private const _configs:Dictionary = new Dictionary();

      private const _queue:Array = [];

      private var _injector:Injector;

      private var _logger:ILogger;

      private var _initialized:Boolean;

      public function ConfigManager(param1:IContext) {
         super();
         this._injector = param1.injector;
         this._logger = param1.getLogger(this);
         this.addConfigHandler(instanceOf(Class),this.handleClass);
         this.addConfigHandler(plainObjectMatcher,this.handleObject);
         param1.lifecycle.addEventListener(LifecycleEvent.INITIALIZE,this.initialize,false,-100);
      }

      public function addConfig(param1:Object) : void {
         if(!this._configs[param1]) {
            this._configs[param1] = true;
            this._objectProcessor.processObject(param1);
         }
      }

      public function addConfigHandler(param1:Matcher, param2:Function) : void {
         this._objectProcessor.addObjectHandler(param1,param2);
      }

      public function toString() : String {
         return this._uid;
      }

      private function initialize(param1:LifecycleEvent) : void {
         if(!this._initialized) {
            this._initialized = true;
            this.processQueue();
         }
      }

      private function handleClass(param1:Class) : void {
         if(this._initialized) {
            this._logger.debug("Already initialized. Instantiating config class {0}",[param1]);
            this.processClass(param1);
         } else {
            this._logger.debug("Not yet initialized. Queuing config class {0}",[param1]);
            this._queue.push(param1);
         }
      }

      private function handleObject(param1:Object) : void {
         if(this._initialized) {
            this._logger.debug("Already initialized. Injecting into config object {0}",[param1]);
            this.processObject(param1);
         } else {
            this._logger.debug("Not yet initialized. Queuing config object {0}",[param1]);
            this._queue.push(param1);
         }
      }

      private function processQueue() : void {
         var _local1:Object = null;
         for each(_local1 in this._queue) {
            if(_local1 is Class) {
               this._logger.debug("Now initializing. Instantiating config class {0}",[_local1]);
               this.processClass(_local1 as Class);
            } else {
               this._logger.debug("Now initializing. Injecting into config object {0}",[_local1]);
               this.processObject(_local1);
            }
         }
         this._queue.length = 0;
      }

      private function processClass(param1:Class) : void {
         var _local2:IConfig = this._injector.getInstance(param1) as IConfig;
         _local2 && _local2.configure();
      }

      private function processObject(param1:Object) : void {
         this._injector.injectInto(param1);
         var _local2:IConfig = param1 as IConfig;
         _local2 && _local2.configure();
      }
   }
}
