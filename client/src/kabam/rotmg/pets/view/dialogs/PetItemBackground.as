package kabam.rotmg.pets.view.dialogs {
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;

public class PetItemBackground extends Sprite {

      private var backgroundFill_:GraphicsSolidFill;

      private var path_:GraphicsPath;

      public function PetItemBackground(param1:int, param2:Array) {
         this.backgroundFill_ = new GraphicsSolidFill(2368548);
         this.path_ = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());
         super();
         var _local3:Vector.<IGraphicsData> = new <IGraphicsData>[this.backgroundFill_,this.path_,GraphicsUtil.END_FILL];
         GraphicsUtil.drawCutEdgeRect(0,0,param1,param1,param1 / 12,param2,this.path_);
         graphics.drawGraphicsData(_local3);
      }
   }
}
