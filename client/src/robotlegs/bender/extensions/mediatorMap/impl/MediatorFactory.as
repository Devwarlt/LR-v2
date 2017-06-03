package robotlegs.bender.extensions.mediatorMap.impl {
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatorMap.api.MediatorFactoryEvent;
import robotlegs.bender.framework.impl.applyHooks;
import robotlegs.bender.framework.impl.guardsApprove;

public class MediatorFactory extends EventDispatcher implements IMediatorFactory {

      private const _mediators:Dictionary = new Dictionary();

      private var _injector:Injector;

      public function MediatorFactory(param1:Injector) {
         super();
         this._injector = param1;
      }

      public function getMediator(param1:Object, param2:IMediatorMapping) : Object {
         return !!this._mediators[param1]?this._mediators[param1][param2]:null;
      }

      public function createMediators(param1:Object, param2:Class, param3:Array) : Array {
         var _local5:ITypeFilter = null;
         var _local6:Object = null;
         var _local7:IMediatorMapping = null;
         var _local4:Array = [];
         for each(_local7 in param3) {
            _local6 = this.getMediator(param1,_local7);
            if(!_local6) {
               _local5 = _local7.matcher;
               this.mapTypeForFilterBinding(_local5,param2,param1);
               _local6 = this.createMediator(param1,_local7);
               this.unmapTypeForFilterBinding(_local5,param2,param1);
            }
            if(_local6) {
               _local4.push(_local6);
            }
         }
         return _local4;
      }

      public function removeMediators(param1:Object) : void {
         var _local3:* = null;
         var _local2:Dictionary = this._mediators[param1];
         if(!_local2) {
            return;
         }
         if(hasEventListener(MediatorFactoryEvent.MEDIATOR_REMOVE)) {
            for(_local3 in _local2) {
               dispatchEvent(new MediatorFactoryEvent(MediatorFactoryEvent.MEDIATOR_REMOVE,_local2[_local3],param1,_local3 as IMediatorMapping,this));
            }
         }
         delete this._mediators[param1];
      }

      public function removeAllMediators() : void {
         var _local1:* = null;
         for(_local1 in this._mediators) {
            this.removeMediators(_local1);
         }
      }

      private function createMediator(param1:Object, param2:IMediatorMapping) : Object {
         var _local3:Object = this.getMediator(param1,param2);
         if(_local3) {
            return _local3;
         }
         if(guardsApprove(param2.guards,this._injector)) {
            _local3 = this._injector.getInstance(param2.mediatorClass);
            this._injector.map(param2.mediatorClass).toValue(_local3);
            applyHooks(param2.hooks,this._injector);
            this._injector.unmap(param2.mediatorClass);
            this.addMediator(_local3,param1,param2);
         }
         return _local3;
      }

      private function addMediator(param1:Object, param2:Object, param3:IMediatorMapping) : void {
         this._mediators[param2] = this._mediators[param2] || new Dictionary();
         this._mediators[param2][param3] = param1;
         if(hasEventListener(MediatorFactoryEvent.MEDIATOR_CREATE)) {
            dispatchEvent(new MediatorFactoryEvent(MediatorFactoryEvent.MEDIATOR_CREATE,param1,param2,param3,this));
         }
      }

      private function mapTypeForFilterBinding(param1:ITypeFilter, param2:Class, param3:Object) : void {
         var _local4:Class = null;
         var _local5:Vector.<Class> = this.requiredTypesFor(param1,param2);
         for each(_local4 in _local5) {
            this._injector.map(_local4).toValue(param3);
         }
      }

      private function unmapTypeForFilterBinding(param1:ITypeFilter, param2:Class, param3:Object) : void {
         var _local4:Class = null;
         var _local5:Vector.<Class> = this.requiredTypesFor(param1,param2);
         for each(_local4 in _local5) {
            if(this._injector.satisfiesDirectly(_local4)) {
               this._injector.unmap(_local4);
            }
         }
      }

      private function requiredTypesFor(param1:ITypeFilter, param2:Class) : Vector.<Class> {
         var _local3:Vector.<Class> = param1.allOfTypes.concat(param1.anyOfTypes);
         if(_local3.indexOf(param2) == -1) {
            _local3.push(param2);
         }
         return _local3;
      }
   }
}
