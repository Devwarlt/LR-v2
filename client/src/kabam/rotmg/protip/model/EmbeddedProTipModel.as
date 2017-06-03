package kabam.rotmg.protip.model {
   public class EmbeddedProTipModel implements IProTipModel {

      public static var protipsXML:Class = EmbeddedProTipModel_protipsXML;

      private var tips:Vector.<String>;

      private var indices:Vector.<int>;

      private var index:int;

      private var count:int;

      public function EmbeddedProTipModel() {
         super();
         this.index = 0;
         this.makeTipsVector();
         this.count = this.tips.length;
         this.makeRandomizedIndexVector();
      }

      public function getTip() : String {
         var _local1:int = this.indices[this.index++ % this.count];
         return this.tips[_local1];
      }

      private function makeTipsVector() : void {
         var _local2:XML = null;
         var _local1:XML = XML(new protipsXML());
         this.tips = new Vector.<String>(0);
         for each(_local2 in _local1.Protip) {
            this.tips.push(_local2.toString());
         }
         this.count = this.tips.length;
      }

      private function makeRandomizedIndexVector() : void {
         var _local1:Vector.<int> = new Vector.<int>(0);
         var _local2:int = 0;
         while(_local2 < this.count) {
            _local1.push(_local2);
            _local2++;
         }
         this.indices = new Vector.<int>(0);
         while(_local2 > 0) {
            this.indices.push(_local1.splice(Math.floor(Math.random() * _local2--),1)[0]);
         }
         this.indices.fixed = true;
      }
   }
}
