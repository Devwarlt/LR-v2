package robotlegs.bender.extensions.mediatorMap.impl {
import flash.utils.Dictionary;

import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorViewHandler;
import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMapper;
import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMappingConfig;
import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMappingFinder;
import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorUnmapper;

public class MediatorMapper implements IMediatorMapper, IMediatorMappingFinder, IMediatorUnmapper {

      private const _mappings:Dictionary = new Dictionary();

      private var _matcher:ITypeFilter;

      private var _handler:IMediatorViewHandler;

      public function MediatorMapper(param1:ITypeFilter, param2:IMediatorViewHandler) {
         super();
         this._matcher = param1;
         this._handler = param2;
      }

      public function toMediator(param1:Class) : IMediatorMappingConfig {
         return this.lockedMappingFor(param1) || this.createMapping(param1);
      }

      public function forMediator(param1:Class) : IMediatorMapping {
         return this._mappings[param1];
      }

      public function fromMediator(param1:Class) : void {
         var _local2:IMediatorMapping = this._mappings[param1];
         delete this._mappings[param1];
         this._handler.removeMapping(_local2);
      }

      public function fromMediators() : void {
         var _local1:IMediatorMapping = null;
         for each(_local1 in this._mappings) {
            delete this._mappings[_local1.mediatorClass];
            this._handler.removeMapping(_local1);
         }
      }

      private function createMapping(param1:Class) : MediatorMapping {
         var _local2:MediatorMapping = new MediatorMapping(this._matcher,param1);
         this._handler.addMapping(_local2);
         this._mappings[param1] = _local2;
         return _local2;
      }

      private function lockedMappingFor(param1:Class) : MediatorMapping {
         var _local2:MediatorMapping = this._mappings[param1];
         if(_local2) {
            _local2.invalidate();
         }
         return _local2;
      }
   }
}
