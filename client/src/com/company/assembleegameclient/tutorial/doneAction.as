package com.company.assembleegameclient.tutorial {
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1;

public function doneAction(param1:LOEBUILD_6615c4f9bea4fdaf620bf1ad513a54c1, param2:String) : void {
      if(param1.tutorial_ == null) {
         return;
      }
      param1.tutorial_.doneAction(param2);
   }
}
