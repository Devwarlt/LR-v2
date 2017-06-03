package robotlegs.bender.extensions.commandCenter.impl {
import robotlegs.bender.extensions.commandCenter.api.ICommandMapping;

public class CommandMappingList {

      protected var _head:ICommandMapping;

      public function CommandMappingList() {
         super();
      }

      public function get head() : ICommandMapping {
         return this._head;
      }

      public function set head(param1:ICommandMapping) : void {
         if(param1 !== this._head) {
            this._head = param1;
         }
      }

      public function get tail() : ICommandMapping {
         if(!this._head) {
            return null;
         }
         var _local1:ICommandMapping = this._head;
         while(_local1.next) {
            _local1 = _local1.next;
         }
         return _local1;
      }

      public function remove(param1:ICommandMapping) : void {
         var _local2:ICommandMapping = this._head;
         if(_local2 == param1) {
            this._head = param1.next;
         }
         while(_local2) {
            if(_local2.next == param1) {
               _local2.next = param1.next;
            }
            _local2 = _local2.next;
         }
      }
   }
}
