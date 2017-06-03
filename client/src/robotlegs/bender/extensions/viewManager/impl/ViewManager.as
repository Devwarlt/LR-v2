package robotlegs.bender.extensions.viewManager.impl {
import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;

import robotlegs.bender.extensions.viewManager.api.IViewHandler;
import robotlegs.bender.extensions.viewManager.api.IViewManager;

public class ViewManager extends EventDispatcher implements IViewManager {

      private const _containers:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();

      private const _handlers:Vector.<IViewHandler> = new Vector.<IViewHandler>();

      private var _registry:ContainerRegistry;

      public function ViewManager(param1:ContainerRegistry) {
         super();
         this._registry = param1;
      }

      public function get containers() : Vector.<DisplayObjectContainer> {
         return this._containers;
      }

      public function addContainer(param1:DisplayObjectContainer) : void {
         var _local2:IViewHandler = null;
         if(!this.validContainer(param1)) {
            return;
         }
         this._containers.push(param1);
         for each(_local2 in this._handlers) {
            this._registry.addContainer(param1).addHandler(_local2);
         }
         dispatchEvent(new ViewManagerEvent(ViewManagerEvent.CONTAINER_ADD,param1));
      }

      public function removeContainer(param1:DisplayObjectContainer) : void {
         var _local4:IViewHandler = null;
         var _local2:int = this._containers.indexOf(param1);
         if(_local2 == -1) {
            return;
         }
         this._containers.splice(_local2,1);
         var _local3:ContainerBinding = this._registry.getBinding(param1);
         for each(_local4 in this._handlers) {
            _local3.removeHandler(_local4);
         }
         dispatchEvent(new ViewManagerEvent(ViewManagerEvent.CONTAINER_REMOVE,param1));
      }

      public function addViewHandler(param1:IViewHandler) : void {
         var _local2:DisplayObjectContainer = null;
         if(this._handlers.indexOf(param1) != -1) {
            return;
         }
         this._handlers.push(param1);
         for each(_local2 in this._containers) {
            this._registry.addContainer(_local2).addHandler(param1);
         }
         dispatchEvent(new ViewManagerEvent(ViewManagerEvent.HANDLER_ADD,null,param1));
      }

      public function removeViewHandler(param1:IViewHandler) : void {
         var _local3:DisplayObjectContainer = null;
         var _local2:int = this._handlers.indexOf(param1);
         if(_local2 == -1) {
            return;
         }
         this._handlers.splice(_local2,1);
         for each(_local3 in this._containers) {
            this._registry.getBinding(_local3).removeHandler(param1);
         }
         dispatchEvent(new ViewManagerEvent(ViewManagerEvent.HANDLER_REMOVE,null,param1));
      }

      public function removeAllHandlers() : void {
         var _local1:DisplayObjectContainer = null;
         var _local2:ContainerBinding = null;
         var _local3:IViewHandler = null;
         for each(_local1 in this._containers) {
            _local2 = this._registry.getBinding(_local1);
            for each(_local3 in this._handlers) {
               _local2.removeHandler(_local3);
            }
         }
      }

      private function validContainer(param1:DisplayObjectContainer) : Boolean {
         var _local2:DisplayObjectContainer = null;
         for each(_local2 in this._containers) {
            if(param1 == _local2) {
               return false;
            }
            if(Boolean(_local2.contains(param1)) || Boolean(param1.contains(_local2))) {
               throw new Error("Containers can not be nested");
            }
         }
         return true;
      }
   }
}
