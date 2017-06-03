package kabam.rotmg.dialogs {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_792089f2c86929e9055971f0ebedbc08;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_e34dff622740a5e2d6ed9c41d3c49688.LOEBUILD_30f8be529d25601fb19719d7f866e0c6;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogNoModalSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.dialogs.control.PopDialogSignal;
import kabam.rotmg.dialogs.control.PushDialogSignal;
import kabam.rotmg.dialogs.control.ShowDialogBackgroundSignal;
import kabam.rotmg.dialogs.view.DialogsMediator;
import kabam.rotmg.dialogs.view.DialogsView;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;

public class DialogsConfig implements IConfig {

      [Inject]
      public var injector:Injector;

      [Inject]
      public var mediatorMap:IMediatorMap;

      [Inject]
      public var register:LOEBUILD_792089f2c86929e9055971f0ebedbc08;

      public function DialogsConfig() {
         super();
      }

      public function configure() : void {
         var _local1:LOEBUILD_30f8be529d25601fb19719d7f866e0c6 = null;
         this.injector.map(ShowDialogBackgroundSignal).asSingleton();
         this.injector.map(OpenDialogSignal).asSingleton();
         this.injector.map(OpenDialogNoModalSignal).asSingleton();
         this.injector.map(CloseDialogsSignal).asSingleton();
         this.injector.map(PushDialogSignal).asSingleton();
         this.injector.map(PopDialogSignal).asSingleton();
         this.mediatorMap.map(DialogsView).toMediator(DialogsMediator);
         _local1 = new LOEBUILD_30f8be529d25601fb19719d7f866e0c6();
         _local1.name = "closeDialogs";
         _local1.description = "closes all open dialogs";
         this.register.dispatch(_local1,this.injector.getInstance(CloseDialogsSignal));
      }
   }
}
