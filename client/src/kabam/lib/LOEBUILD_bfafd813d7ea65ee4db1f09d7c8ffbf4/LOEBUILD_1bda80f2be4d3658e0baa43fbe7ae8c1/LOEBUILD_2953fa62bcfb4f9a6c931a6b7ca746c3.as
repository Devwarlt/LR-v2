package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_1bda80f2be4d3658e0baa43fbe7ae8c1 {
import flash.display.Sprite;

public final class LOEBUILD_2953fa62bcfb4f9a6c931a6b7ca746c3 extends Sprite {

      public var output:LOEBUILD_fa9ade1087f150c60fd066c273595b44;

      public var input:LOEBUILD_9a1afe308cb8a3976519f048fad72e19;

      public function LOEBUILD_2953fa62bcfb4f9a6c931a6b7ca746c3() {
         super();
         addChild(this.output = new LOEBUILD_fa9ade1087f150c60fd066c273595b44());
         addChild(this.input = new LOEBUILD_9a1afe308cb8a3976519f048fad72e19());
      }

      override public function set visible(param1:Boolean) : void {
         super.visible = param1;
         if(Boolean(param1) && Boolean(stage)) {
            stage.focus = this.input;
         }
      }
   }
}
