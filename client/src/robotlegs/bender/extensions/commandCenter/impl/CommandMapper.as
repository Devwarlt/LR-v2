package robotlegs.bender.extensions.commandCenter.impl {
import flash.utils.Dictionary;

import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;
import robotlegs.bender.extensions.commandCenter.api.ICommandTrigger;
import robotlegs.bender.extensions.commandCenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandCenter.dsl.ICommandMappingConfig;
import robotlegs.bender.extensions.commandCenter.dsl.ICommandUnmapper;

public class CommandMapper implements ICommandMapper, ICommandUnmapper {

      private const _mappings:Dictionary = new Dictionary();

      private var _trigger:ICommandTrigger;

      public function CommandMapper(param1:ICommandTrigger) {
         super();
         this._trigger = param1;
      }

      public function toCommand(param1:Class) : ICommandMappingConfig {
         return this.locked(this._mappings[param1]) || this.createMapping(param1);
      }

      public function fromCommand(param1:Class) : void {
         var _local2:ICommandMapping = this._mappings[param1];
         _local2 && this._trigger.removeMapping(_local2);
         delete this._mappings[param1];
      }

      public function fromAll() : void {
         var _local1:ICommandMapping = null;
         for each(_local1 in this._mappings) {
            this._trigger.removeMapping(_local1);
            delete this._mappings[_local1.commandClass];
         }
      }

      private function createMapping(param1:Class) : CommandMapping {
         var _local2:CommandMapping = new CommandMapping(param1);
         this._trigger.addMapping(_local2);
         this._mappings[param1] = _local2;
         return _local2;
      }

      private function locked(param1:CommandMapping) : CommandMapping {
         if(!param1) {
            return null;
         }
         param1.invalidate();
         return param1;
      }
   }
}
