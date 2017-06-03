package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_20f35e630daf44dbfa4c3f68f5399d8c {
   public class LOEBUILD_e7e0f08b17ea83c4787b003b9f4a9470 {

      private var stack:Vector.<String>;

      private var index:int;

      function LOEBUILD_e7e0f08b17ea83c4787b003b9f4a9470() {
         super();
         this.stack = new Vector.<String>();
         this.index = 0;
      }

      public function add(param1:String) : void {
         this.index = this.stack.push(param1);
      }

      public function get length() : int {
         return this.stack.length;
      }

      public function getPrevious() : String {
         return this.index > 0?this.stack[--this.index]:"";
      }

      public function getNext() : String {
         return this.index < this.stack.length - 1?this.stack[++this.index]:"";
      }
   }
}
