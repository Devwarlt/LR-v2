package robotlegs.bender.extensions.viewManager.impl {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public class ManualStageObserver {

      private var _registry:ContainerRegistry;

      public function ManualStageObserver(param1:ContainerRegistry) {
         var _local2:ContainerBinding = null;
         super();
         this._registry = param1;
         this._registry.addEventListener(ContainerRegistryEvent.CONTAINER_ADD,this.onContainerAdd);
         this._registry.addEventListener(ContainerRegistryEvent.CONTAINER_REMOVE,this.onContainerRemove);
         for each(_local2 in this._registry.bindings) {
            this.addContainerListener(_local2.container);
         }
      }

      public function destroy() : void {
         var _local1:ContainerBinding = null;
         this._registry.removeEventListener(ContainerRegistryEvent.CONTAINER_ADD,this.onContainerAdd);
         this._registry.removeEventListener(ContainerRegistryEvent.CONTAINER_REMOVE,this.onContainerRemove);
         for each(_local1 in this._registry.bindings) {
            this.removeContainerListener(_local1.container);
         }
      }

      private function onContainerAdd(param1:ContainerRegistryEvent) : void {
         this.addContainerListener(param1.container);
      }

      private function onContainerRemove(param1:ContainerRegistryEvent) : void {
         this.removeContainerListener(param1.container);
      }

      private function addContainerListener(param1:DisplayObjectContainer) : void {
         param1.addEventListener(ConfigureViewEvent.CONFIGURE_VIEW,this.onConfigureView);
      }

      private function removeContainerListener(param1:DisplayObjectContainer) : void {
         param1.removeEventListener(ConfigureViewEvent.CONFIGURE_VIEW,this.onConfigureView);
      }

      private function onConfigureView(param1:ConfigureViewEvent) : void {
         var _local3:DisplayObject = null;
         param1.stopImmediatePropagation();
         var _local2:DisplayObjectContainer = param1.currentTarget as DisplayObjectContainer;
         _local3 = param1.target as DisplayObject;
         var _local4:Class = _local3["constructor"];
         this._registry.getBinding(_local2).handleView(_local3,_local4);
      }
   }
}
