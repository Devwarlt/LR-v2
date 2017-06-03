package kabam.rotmg.chat.view {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.util.FameUtil;
import com.company.assembleegameclient.util.StageProxy;

import kabam.rotmg.messaging.impl.incoming.IncomingMessage;

import kabam.rotmg.messaging.impl.incoming.Text;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.StageQuality;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.ChatModel;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.view.BitmapTextFactory;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ChatListItemFactory {

      private static const IDENTITY_MATRIX:Matrix = new Matrix();

      private static const SERVER:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.SERVER_CHAT_NAME;

      private static const CLIENT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.CLIENT_CHAT_NAME;

      private static const HELP:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.HELP_CHAT_NAME;

      private static const ERROR:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ERROR_CHAT_NAME;

      private static const GUILD:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.GUILD_CHAT_NAME;

    private static const LIGHTBLUE_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.LIGHTBLUE_STAR;

    private static const BLUE_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.BLUE_STAR;

    private static const RED_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.RED_STAR;

    private static const ORANGE_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ORANGE_STAR;

    private static const YELLOW_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.YELLOW_STAR;

    private static const WHITE_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.WHITE_STAR;

    private static const MOD_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.MODERATOR;

    private static const ADMIN_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.ADMINISTRATOR;

    private static const DEV_CHAT:String = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.DEVWARLT;

      private static const testField:TextField = makeTestTextField();

      [Inject]
      public var factory:BitmapTextFactory;

      [Inject]
      public var model:ChatModel;

      [Inject]
      public var fontModel:FontModel;

      [Inject]
      public var stageProxy:StageProxy;

      private var message:ChatMessage;

      private var buffer:Vector.<DisplayObject>;

      public function ChatListItemFactory() {
         super();
      }

      public static function isTradeMessage(param1:int, param2:int, param3:String) : Boolean {
         return (param1 == -1 || param2 == -1) && param3.search("/trade") != -1;
      }

      public static function isGuildMessage(param1:String) : Boolean {
         return param1 == GUILD;
      }

      private static function makeTestTextField() : TextField {
         var _local1:TextField = new TextField();
         var _local2:TextFormat = new TextFormat();
         _local2.size = 15;
         _local2.bold = true;
         _local1.defaultTextFormat = _local2;
         return _local1;
      }

      public function make(param1:ChatMessage, param2:Boolean = false) : ChatListItem {
         var _local5:int = 0;
         var _local7:String = null;
         var _local8:int = 0;
         this.message = param1;
         this.buffer = new Vector.<DisplayObject>();
         this.setTFonTestField();
         this.makeStarsIcon();
         this.makeWhisperText();
         this.makeNameText();
         this.makeMessageText();
         var _local3:Boolean = param1.numStars == -1 || param1.objectId == -1;
         var _local4:Boolean = false;
         var _local6:String = param1.name;
         if(Boolean(_local3) && (_local5 = param1.text.search("/trade ")) != -1) {
            _local5 = _local5 + 7;
            _local7 = "";
            _local8 = _local5;
            while(_local8 < _local5 + 10) {
               if(param1.text.charAt(_local8) == "\"") {
                  break;
               }
               _local7 = _local7 + param1.text.charAt(_local8);
               _local8++;
            }
            _local6 = _local7;
            _local4 = true;
         }
         return new ChatListItem(this.buffer,this.model.bounds.width,this.model.lineHeight,param2,param1.objectId,_local6,param1.recipient == GUILD,_local4);
      }

      private function makeStarsIcon() : void {
         var _local1:int = this.message.numStars;
         if(_local1 >= 0) {
            this.buffer.push(FameUtil.numStarsToIcon(_local1));
         }
      }

      private function makeWhisperText() : void {
         var _local1:StringBuilder = null;
         var _local2:BitmapData = null;
         if(Boolean(this.message.isWhisper) && !this.message.isToMe) {
            _local1 = new StaticStringBuilder("To: ");
            _local2 = this.getBitmapData(_local1,61695);
            this.buffer.push(new Bitmap(_local2));
         }
      }

      private function makeNameText() : void {
         if(!this.isSpecialMessageType()) {
            this.bufferNameText();
         }
      }

      private function isSpecialMessageType() : Boolean {
         var _local1:String = this.message.name;
         return _local1 == SERVER || _local1 == CLIENT || _local1 == HELP || _local1 == ERROR || _local1 == GUILD;
      }

      private function bufferNameText() : void {
         var _local1:StringBuilder = new StaticStringBuilder(this.processName());
         var _local2:BitmapData = this.getBitmapData(_local1,this.getNameColor());
         this.buffer.push(new Bitmap(_local2));
      }

      private function processName() : String {
          var _local11:String = this.message.recipient;
         var _local1:String = Boolean(this.message.isWhisper) && !this.message.isToMe?this.message.recipient:this.message.name;
         if(_local1.charAt(0) == "#" || _local1.charAt(0) == "@" || _local1.charAt(0) == "!" || _local1.charAt(0) == "$" || _local1.charAt(0) == "%" || _local1.charAt(0) == "+" || _local1.charAt(0) == "&" || _local1.charAt(0) == "-" || _local1.charAt(0) == ";" || _local1.charAt(0) == "=" || _local1.charAt(0) == "~") {
            _local1 = _local1.substr(1);
         }
          return "<" + _local1 + ">";

      }

      private function makeMessageText() : void {
         var _local2:int = 0;
         var _local1:Array = this.message.text.split("\n");
         if(_local1.length > 0) {
            this.makeNewLineFreeMessageText(_local1[0],true);
            _local2 = 1;
            while(_local2 < _local1.length) {
               this.makeNewLineFreeMessageText(_local1[_local2],false);
               _local2++;
            }
         }
      }

      private function makeNewLineFreeMessageText(param1:String, param2:Boolean) : void {
         var _local8:DisplayObject = null;
         var _local9:int = 0;
         var _local10:uint = 0;
         var _local11:int = 0;
         var _local12:int = 0;
         var _local3:String = param1;
         var _local4:int = 0;
         var _local5:int = this.fontModel.getFont().getXHeight(15);
         var _local6:int = 0;
         if(param2) {
            for each(_local8 in this.buffer) {
               _local4 = _local4 + _local8.width;
            }
            _local6 = _local3.length;
            testField.text = _local3;
            while(testField.textWidth >= this.model.bounds.width - _local4) {
               _local6 = _local6 - 10;
               testField.text = _local3.substr(0,_local6);
            }
            if(_local6 < _local3.length) {
               _local9 = _local3.substr(0,_local6).lastIndexOf(" ");
               _local6 = _local9 == 0 || _local9 == -1?int(_local6):int(_local9);
            }
            this.makeMessageLine(_local3.substr(0,_local6));
         }
         var _local7:int = _local3.length;
         if(_local7 > _local6) {
            _local10 = this.model.bounds.width / _local5;
            _local11 = _local6;
            while(_local11 < _local3.length) {
               testField.text = _local3.substr(_local11,_local10);
               while(testField.textWidth >= this.model.bounds.width - _local4) {
                  _local10 = _local10 - 5;
                  testField.text = _local3.substr(_local11,_local10);
               }
               _local12 = _local10;
               if(_local3.length > _local11 + _local10) {
                  _local12 = _local3.substr(_local11,_local10).lastIndexOf(" ");
                  _local12 = _local12 == 0 || _local12 == -1?int(_local10):int(_local12);
               }
               this.makeMessageLine(_local3.substr(_local11,_local12));
               _local11 = _local11 + _local12;
            }
         }
      }

      private function makeMessageLine(param1:String) : void {
         var _local2:StringBuilder = new StaticStringBuilder(param1);
         var _local3:BitmapData = this.getBitmapData(_local2,this.getTextColor());
         this.buffer.push(new Bitmap(_local3));
      }

        public function numStars() : int {
            return FameUtil.numStars(int(this.charStatsXML_.BestFame));
        }

        public var charStatsXML_:XML;

      private function getNameColor() : uint {
         if(this.message.name.charAt(0) == "@") {
            return 16776960;
         }
         if(this.message.recipient == GUILD) {
            return 10944349;
         }
         if(this.message.recipient != "") {
             return 61695;
         }
          if(this.message.name.charAt(0) == LIGHTBLUE_CHAT) {
              return 9017309;
          }
          if(this.message.name.charAt(0) == BLUE_CHAT) {
              return 3165402;
          }
          if(this.message.name.charAt(0) == RED_CHAT) {
              return 12592684;
          }
          if(this.message.name.charAt(0) == ORANGE_CHAT) {
              return 16159261;
          }
          if(this.message.name.charAt(0) == YELLOW_CHAT) {
              return 16776960;
          }
          if(this.message.name.charAt(0) == WHITE_CHAT) {
              return 16777215;
          }
          if(this.message.name.charAt(0) == MOD_CHAT) {
              return 9055202;
          }
          if(this.message.name.charAt(0) == ADMIN_CHAT) {
              return 64154;
          }
          if(this.message.name.charAt(0) == DEV_CHAT) {
              return 13639824;
          }
          if(this.message.recipient == "#") {
              return 16754688;
          }
         return 65280;
      }

      private function getTextColor() : uint {
         var _local1:String = this.message.name;
         if(_local1 == SERVER) {
            return 16776960;
         }
         if(_local1 == CLIENT) {
            return 255;
         }
         if(_local1 == HELP) {
            return 16734981;
         }
         if(_local1 == ERROR) {
            return 16711680;
         }
         if(_local1.charAt(0) == "@") {
            return 16776960;
         }
         if(this.message.recipient == GUILD) {
            return 10944349;
         }
         if(this.message.recipient != "") {
            return 61695;
         }
          /*if(this.message.name.charAt(0) == LIGHTBLUE_CHAT) {
              return 9017309;
          }
          if(this.message.name.charAt(0) == BLUE_CHAT) {
              return 3165402;
          }
          if(this.message.name.charAt(0) == RED_CHAT) {
              return 12592684;
          }
          if(this.message.name.charAt(0) == ORANGE_CHAT) {
              return 16159261;
          }
          if(this.message.name.charAt(0) == YELLOW_CHAT) {
              return 16776960;
          }
          if(this.message.name.charAt(0) == WHITE_CHAT) {
              return 16777215;
          }
          if(this.message.name.charAt(0) == MOD_CHAT) {
              return 9055202;
          }
          if(this.message.name.charAt(0) == ADMIN_CHAT) {
              return 64154;
          }
          if(this.message.name.charAt(0) == DEV_CHAT) {
              return 13639824;
          }*/
         return 16777215;
      }

      private function getBitmapData(param1:StringBuilder, param2:uint) : BitmapData {
         var _local3:String = this.stageProxy.getQuality();
         var _local4:Boolean = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_["forceChatQuality"];
         _local4 && this.stageProxy.setQuality(StageQuality.BEST);
         var _local5:BitmapData = this.factory.make(param1,12,param2,true,IDENTITY_MATRIX,true);
         _local4 && this.stageProxy.setQuality(_local3);
         return _local5;
      }

      private function setTFonTestField() : void {
         var _local1:TextFormat = testField.getTextFormat();
         _local1.font = this.fontModel.getFont().getName();
         testField.defaultTextFormat = _local1;
      }
   }
}
