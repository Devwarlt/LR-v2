package robotlegs.bender.extensions.mediatorMap.impl {
import flash.display.DisplayObject;
import flash.utils.Dictionary;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorViewHandler;

public class MediatorViewHandler implements IMediatorViewHandler {

      private const _mappings:Array = [];

      private var _knownMappings:Dictionary;

      private var _factory:IMediatorFactory;

      public function MediatorViewHandler(param1:IMediatorFactory) {
         this._knownMappings = new Dictionary(true);
         super();
         this._factory = param1;
      }

      public function addMapping(param1:IMediatorMapping) : void {
         var _local2:int = this._mappings.indexOf(param1);
         if(_local2 > -1) {
            return;
         }
         this._mappings.push(param1);
         this.flushCache();
      }

      public function removeMapping(param1:IMediatorMapping) : void {
         var _local2:int = this._mappings.indexOf(param1);
         if(_local2 == -1) {
            return;
         }
         this._mappings.splice(_local2,1);
         this.flushCache();
      }

      public function handleView(param1:DisplayObject, param2:Class) : void {
         var _local3:Array = this.getInterestedMappingsFor(param1,param2);
         if(_local3) {
            this._factory.createMediators(param1,param2,_local3);
         }
      }

      public function handleItem(param1:Object, param2:Class) : void {
         var _local3:Array = this.getInterestedMappingsFor(param1,param2);
         if(_local3) {
            this._factory.createMediators(param1,param2,_local3);
         }
      }

      private function flushCache() : void {
         this._knownMappings = new Dictionary(true);
      }

      private function getInterestedMappingsFor(param1:Object, param2:Class) : Array {
         var _local3:IMediatorMapping = null;
         if(this._knownMappings[param2] === false) {
            return null;
         }
         if(this._knownMappings[param2] == undefined) {
            this._knownMappings[param2] = false;
            for each(_local3 in this._mappings) {
               _local3.validate();
               if(_local3.matcher.matches(param1)) {
                  this._knownMappings[param2] = this._knownMappings[param2] || [];
                  this._knownMappings[param2].push(_local3);
               }
            }
            if(this._knownMappings[param2] === false) {
               return null;
            }
         }
         return this._knownMappings[param2] as Array;
      }
   }
}
