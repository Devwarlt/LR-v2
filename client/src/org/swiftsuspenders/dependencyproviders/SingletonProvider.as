package org.swiftsuspenders.dependencyproviders {
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

import org.swiftsuspenders.Injector;
import org.swiftsuspenders.InjectorError;
import org.swiftsuspenders.typedescriptions.PreDestroyInjectionPoint;
import org.swiftsuspenders.typedescriptions.TypeDescription;
import org.swiftsuspenders.utils.SsInternal;

public class SingletonProvider implements DependencyProvider {

      private var _responseType:Class;

      private var _creatingInjector:Injector;

      private var _response:Object;

      private var _destroyed:Boolean;

      public function SingletonProvider(param1:Class, param2:Injector) {
         super();
         this._responseType = param1;
         this._creatingInjector = param2;
      }

      public function apply(param1:Class, param2:Injector, param3:Dictionary) : Object {
         return this._response = this._response || this.createResponse(this._creatingInjector);
      }

      private function createResponse(param1:Injector) : Object {
         if(this._destroyed) {
            throw new InjectorError("Forbidden usage of unmapped singleton provider for MsgType " + getQualifiedClassName(this._responseType));
         }
         return param1.SsInternal::instantiateUnmapped(this._responseType);
      }

      public function destroy() : void {
         this._destroyed = true;
         if(!this._response) {
            return;
         }
         var _local1:TypeDescription = this._creatingInjector.getTypeDescription(this._responseType);
         var _local2:PreDestroyInjectionPoint = _local1.preDestroyMethods;
         while(_local2) {
            _local2.applyInjection(this._response,this._responseType,this._creatingInjector);
            _local2 = PreDestroyInjectionPoint(_local2.next);
         }
         this._response = null;
      }
   }
}
