package kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_594c103f2c6e04c3d8ab059f031e0c1a {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_dab203a4f7329bd82e535c4398bb2f8d;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_ff5ec2a325f6d3ae2ab72452213469a8;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_4dfcea9e8a933b9d21914d324a0a1bdb;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_792089f2c86929e9055971f0ebedbc08;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_14610e3ed07565b22f1716c951cb036c;
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_e34dff622740a5e2d6ed9c41d3c49688.LOEBUILD_30f8be529d25601fb19719d7f866e0c6;

public class LOEBUILD_e875ecd8ac32eee370afb6ac967958c3 {

      [Inject]
      public var register:LOEBUILD_792089f2c86929e9055971f0ebedbc08;

      [Inject]
      public var listActions:LOEBUILD_4dfcea9e8a933b9d21914d324a0a1bdb;

      [Inject]
      public var clearConsole:LOEBUILD_dab203a4f7329bd82e535c4398bb2f8d;

      [Inject]
      public var removeConsole:LOEBUILD_14610e3ed07565b22f1716c951cb036c;

      [Inject]
      public var copyConsoleText:LOEBUILD_ff5ec2a325f6d3ae2ab72452213469a8;

      public function LOEBUILD_e875ecd8ac32eee370afb6ac967958c3() {
         super();
      }

      public function execute() : void {
         var _local1:LOEBUILD_30f8be529d25601fb19719d7f866e0c6 = null;
         _local1 = new LOEBUILD_30f8be529d25601fb19719d7f866e0c6();
         _local1.name = "list";
         _local1.description = "lists available LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4 commands";
         var _local2:LOEBUILD_30f8be529d25601fb19719d7f866e0c6 = new LOEBUILD_30f8be529d25601fb19719d7f866e0c6();
         _local2.name = "clear";
         _local2.description = "clears the LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4";
         var _local3:LOEBUILD_30f8be529d25601fb19719d7f866e0c6 = new LOEBUILD_30f8be529d25601fb19719d7f866e0c6();
         _local3.name = "exit";
         _local3.description = "closes the LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4";
         var _local4:LOEBUILD_30f8be529d25601fb19719d7f866e0c6 = new LOEBUILD_30f8be529d25601fb19719d7f866e0c6();
         _local4.name = "copy";
         _local4.description = "copies the contents of the LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4 to the clipboard";
         this.register.dispatch(_local1,this.listActions);
         this.register.dispatch(_local2,this.clearConsole);
         this.register.dispatch(_local3,this.removeConsole);
         this.register.dispatch(_local4,this.copyConsoleText);
      }
   }
}
