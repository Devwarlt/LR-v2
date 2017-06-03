package kabam.rotmg.characters.reskin.control {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_792089f2c86929e9055971f0ebedbc08;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_e34dff622740a5e2d6ed9c41d3c49688.LOEBUILD_30f8be529d25601fb19719d7f866e0c6;

public class AddReskinConsoleActionCommand {

      [Inject]
      public var register:LOEBUILD_792089f2c86929e9055971f0ebedbc08;

      [Inject]
      public var openReskinDialogSignal:OpenReskinDialogSignal;

      public function AddReskinConsoleActionCommand() {
         super();
      }

      public function execute() : void {
         var _local1:LOEBUILD_30f8be529d25601fb19719d7f866e0c6 = null;
         _local1 = new LOEBUILD_30f8be529d25601fb19719d7f866e0c6();
         _local1.name = "reskin";
         _local1.description = "opens the reskin UI";
         this.register.dispatch(_local1,this.openReskinDialogSignal);
      }
   }
}
