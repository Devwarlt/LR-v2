package kabam.rotmg.fame.service {
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
import com.company.util.DateFormatterReplacement;

import flash.events.TimerEvent;
import flash.utils.Timer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.assets.model.CharacterTemplate;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

public class RequestCharacterFameTask extends BaseTask {

      [Inject]
      public var client:AppEngineClient;

      [Inject]
      public var openDialog:OpenDialogSignal;

      [Inject]
      public var classes:ClassesModel;

      public var accountId:String;

      public var charId:int;

      public var xml:XML;

      public var name:String;

      public var level:int;

      public var type:int;

      public var deathDate:String;

      public var killer:String;

      public var totalFame:int;

      public var template:CharacterTemplate;

      public var texture1:int;

      public var texture2:int;

      public var timer:Timer;

      private var errorRetry:Boolean = false;

      public function RequestCharacterFameTask() {
         this.timer = new Timer(150);
         super();
      }

      override protected function startTask() : void {
         this.timer.addEventListener(TimerEvent.TIMER,this.sendFameRequest);
         this.timer.start();
      }

      private function sendFameRequest(param1:TimerEvent) : void {
         this.client.setMaxRetries(8);
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("char/fame",this.getDataPacket());
         this.timer.removeEventListener(TimerEvent.TIMER,this.sendFameRequest);
         this.timer.stop();
         this.timer = null;
      }

      private function getDataPacket() : Object {
         var _local1:Object = {};
         _local1.accountId = this.accountId;
         _local1.charId = this.accountId == ""?-1:this.charId;
         return _local1;
      }

      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.parseFameData(param2);
         } else {
            this.onFameError(param2);
         }
      }

      private function parseFameData(param1:String) : void {
         this.xml = new XML(param1);
         this.parseXML();
         completeTask(true);
      }

      private function parseXML() : void {
         var charXml:XML = null;
         var char:CharacterClass = null;
         var skin:CharacterSkin = null;
         charXml = this.xml.Char.(@id == charId)[0];
         this.name = charXml.Account.Name;
         this.level = charXml.Level;
         this.type = charXml.ObjectType;
         this.deathDate = this.getDeathDate();
         this.killer = this.xml.KilledBy || "";
         this.totalFame = this.xml.TotalFame;
         char = this.classes.getCharacterClass(charXml.ObjectType);
         skin = !!charXml.hasOwnProperty("Texture")?char.skins.getSkin(charXml.Texture):char.skins.getDefaultSkin();
         this.template = skin.template;
         this.texture1 = !!charXml.hasOwnProperty("Tex1")?int(charXml.Tex1):0;
         this.texture2 = !!charXml.hasOwnProperty("Tex2")?int(charXml.Tex2):0;
      }

      private function getDeathDate() : String {
         var _local1:Number = Number(this.xml.CreatedOn) * 1000;
         var _local2:Date = new Date(_local1);
         var _local3:DateFormatterReplacement = new DateFormatterReplacement();
         _local3.formatString = "MMMM D, YYYY";
         return _local3.format(_local2);
      }

      private function onFameError(param1:String) : void {
         if(this.errorRetry == false) {
            this.errorRetry = true;
            this.timer = new Timer(600);
            this.timer.addEventListener(TimerEvent.TIMER,this.sendFameRequest);
            this.timer.start();
         } else {
            this.errorRetry = false;
            this.openDialog.dispatch(new ErrorDialog(param1));
         }
      }
   }
}
