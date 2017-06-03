package robotlegs.bender.extensions.viewManager.impl {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

public class ContainerRegistry extends EventDispatcher {

      private const _bindings:Vector.<ContainerBinding> = new Vector.<ContainerBinding>();

      private const _rootBindings:Vector.<ContainerBinding> = new Vector.<ContainerBinding>();

      private const _bindingByContainer:Dictionary = new Dictionary();

      public function ContainerRegistry() {
         super();
      }

      public function get bindings() : Vector.<ContainerBinding> {
         return this._bindings;
      }

      public function get rootBindings() : Vector.<ContainerBinding> {
         return this._rootBindings;
      }

      public function addContainer(param1:DisplayObjectContainer) : ContainerBinding {
         return this._bindingByContainer[param1] = this._bindingByContainer[param1] || this.createBinding(param1);
      }

      public function removeContainer(param1:DisplayObjectContainer) : ContainerBinding {
         var _local2:ContainerBinding = this._bindingByContainer[param1];
         _local2 && this.removeBinding(_local2);
         return _local2;
      }

      public function findParentBinding(param1:DisplayObject) : ContainerBinding {
         var _local3:ContainerBinding = null;
         var _local2:DisplayObjectContainer = param1.parent;
         while(_local2) {
            _local3 = this._bindingByContainer[_local2];
            if(_local3) {
               return _local3;
            }
            _local2 = _local2.parent;
         }
         return null;
      }

      public function getBinding(param1:DisplayObjectContainer) : ContainerBinding {
         return this._bindingByContainer[param1];
      }

      private function createBinding(param1:DisplayObjectContainer) : ContainerBinding {
         var _local3:ContainerBinding = null;
         var _local2:ContainerBinding = new ContainerBinding(param1);
         this._bindings.push(_local2);
         _local2.addEventListener(ContainerBindingEvent.BINDING_EMPTY,this.onBindingEmpty);
         _local2.parent = this.findParentBinding(param1);
         if(_local2.parent == null) {
            this.addRootBinding(_local2);
         }
         for each(_local3 in this._bindingByContainer) {
            if(param1.contains(_local3.container)) {
               if(!_local3.parent) {
                  this.removeRootBinding(_local3);
                  _local3.parent = _local2;
               } else if(!param1.contains(_local3.parent.container)) {
                  _local3.parent = _local2;
               }
            }
         }
         dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.CONTAINER_ADD,_local2.container));
         return _local2;
      }

      private function removeBinding(param1:ContainerBinding) : void {
         var _local3:ContainerBinding = null;
         delete this._bindingByContainer[param1.container];
         var _local2:int = this._bindings.indexOf(param1);
         this._bindings.splice(_local2,1);
         param1.removeEventListener(ContainerBindingEvent.BINDING_EMPTY,this.onBindingEmpty);
         if(!param1.parent) {
            this.removeRootBinding(param1);
         }
         for each(_local3 in this._bindingByContainer) {
            if(_local3.parent == param1) {
               _local3.parent = param1.parent;
               if(!_local3.parent) {
                  this.addRootBinding(_local3);
               }
            }
         }
         dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.CONTAINER_REMOVE,param1.container));
      }

      private function addRootBinding(param1:ContainerBinding) : void {
         this._rootBindings.push(param1);
         dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.ROOT_CONTAINER_ADD,param1.container));
      }

      private function removeRootBinding(param1:ContainerBinding) : void {
         var _local2:int = this._rootBindings.indexOf(param1);
         this._rootBindings.splice(_local2,1);
         dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE,param1.container));
      }

      private function onBindingEmpty(param1:ContainerBindingEvent) : void {
         this.removeBinding(param1.target as ContainerBinding);
      }
   }
}
