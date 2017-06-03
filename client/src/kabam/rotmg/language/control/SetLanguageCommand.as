package kabam.rotmg.language.control {
import kabam.lib.LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4.LOEBUILD_a8420f8bebd6d9578b405b6bbaa813d9.LOEBUILD_088c13bb3ec60be2dbf0d6fb5453c1be;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.language.service.GetLanguageService;
import kabam.rotmg.ui.signals.ShowLoadingUISignal;

import org.swiftsuspenders.Injector;

public class SetLanguageCommand {

      [Inject]
      public var language:String;

      [Inject]
      public var model:LanguageModel;

      [Inject]
      public var loading:ShowLoadingUISignal;

      [Inject]
      public var injector:Injector;

      [Inject]
      public var task:GetLanguageService;

      [Inject]
      public var reload:ReloadCurrentScreenSignal;

      [Inject]
      public var hideConsole:LOEBUILD_088c13bb3ec60be2dbf0d6fb5453c1be;

      [Inject]
      public var monitor:TaskMonitor;

      public function SetLanguageCommand() {
         super();
      }

      public function execute() : void {
         this.model.setLanguage(this.language);
         this.loading.dispatch();
         var _local1:TaskSequence = new TaskSequence();
         _local1.add(this.task);
         _local1.add(new DispatchSignalTask(this.reload));
         _local1.add(new DispatchSignalTask(this.hideConsole));
         this.monitor.add(_local1);
         _local1.start();
      }
   }
}
