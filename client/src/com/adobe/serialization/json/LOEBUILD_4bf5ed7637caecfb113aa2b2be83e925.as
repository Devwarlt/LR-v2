package com.adobe.serialization.json {
   public class LOEBUILD_4bf5ed7637caecfb113aa2b2be83e925 {

      private var obj:Object;

      private var jsonString:String;

      private var loc:int;

      private var ch:String;

      public function LOEBUILD_4bf5ed7637caecfb113aa2b2be83e925(param1:String) {
         super();
         this.jsonString = param1;
         this.loc = 0;
         this.nextChar();
      }

      public function getNextToken() : LOEBUILD_715e545dec433554068d9ff07ec390ec {
         var _local2:String = null;
         var _local3:String = null;
         var _local4:String = null;
         var _local1:LOEBUILD_715e545dec433554068d9ff07ec390ec = new LOEBUILD_715e545dec433554068d9ff07ec390ec();
         this.skipIgnored();
         switch(this.ch) {
            case "{":
               _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.LEFT_BRACE;
               _local1.value = "{";
               this.nextChar();
               break;
            case "}":
               _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.RIGHT_BRACE;
               _local1.value = "}";
               this.nextChar();
               break;
            case "[":
               _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.LEFT_BRACKET;
               _local1.value = "[";
               this.nextChar();
               break;
            case "]":
               _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.RIGHT_BRACKET;
               _local1.value = "]";
               this.nextChar();
               break;
            case ",":
               _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.COMMA;
               _local1.value = ",";
               this.nextChar();
               break;
            case ":":
               _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.COLON;
               _local1.value = ":";
               this.nextChar();
               break;
            case "t":
               _local2 = "t" + this.nextChar() + this.nextChar() + this.nextChar();
               if(_local2 == "true") {
                  _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.TRUE;
                  _local1.value = true;
                  this.nextChar();
               } else {
                  this.parseError("Expecting \'true\' but found " + _local2);
               }
               break;
            case "f":
               _local3 = "f" + this.nextChar() + this.nextChar() + this.nextChar() + this.nextChar();
               if(_local3 == "false") {
                  _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.FALSE;
                  _local1.value = false;
                  this.nextChar();
               } else {
                  this.parseError("Expecting \'false\' but found " + _local3);
               }
               break;
            case "n":
               _local4 = "n" + this.nextChar() + this.nextChar() + this.nextChar();
               if(_local4 == "null") {
                  _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.NULL;
                  _local1.value = null;
                  this.nextChar();
               } else {
                  this.parseError("Expecting \'null\' but found " + _local4);
               }
               break;
            case "\"":
               _local1 = this.readString();
               break;
            default:
               if(Boolean(this.isDigit(this.ch)) || this.ch == "-") {
                  _local1 = this.readNumber();
               } else {
                  if(this.ch == "") {
                     return null;
                  }
                  this.parseError("Unexpected " + this.ch + " encountered");
               }
         }
         return _local1;
      }

      private function readString() : LOEBUILD_715e545dec433554068d9ff07ec390ec {
         var _local3:String = null;
         var _local4:int = 0;
         var _local1:LOEBUILD_715e545dec433554068d9ff07ec390ec = new LOEBUILD_715e545dec433554068d9ff07ec390ec();
         _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.STRING;
         var _local2:* = "";
         this.nextChar();
         while(this.ch != "\"" && this.ch != "") {
            if(this.ch == "\\") {
               this.nextChar();
               switch(this.ch) {
                  case "\"":
                     _local2 = _local2 + "\"";
                     break;
                  case "/":
                     _local2 = _local2 + "/";
                     break;
                  case "\\":
                     _local2 = _local2 + "\\";
                     break;
                  case "b":
                     _local2 = _local2 + "\b";
                     break;
                  case "f":
                     _local2 = _local2 + "\f";
                     break;
                  case "n":
                     _local2 = _local2 + "\n";
                     break;
                  case "r":
                     _local2 = _local2 + "\r";
                     break;
                  case "t":
                     _local2 = _local2 + "\t";
                     break;
                  case "u":
                     _local3 = "";
                     _local4 = 0;
                     while(_local4 < 4) {
                        if(!this.isHexDigit(this.nextChar())) {
                           this.parseError(" Excepted a hex digit, but found: " + this.ch);
                        }
                        _local3 = _local3 + this.ch;
                        _local4++;
                     }
                     _local2 = _local2 + String.fromCharCode(parseInt(_local3,16));
                     break;
                  default:
                     _local2 = _local2 + ("\\" + this.ch);
               }
            } else {
               _local2 = _local2 + this.ch;
            }
            this.nextChar();
         }
         if(this.ch == "") {
            this.parseError("Unterminated string literal");
         }
         this.nextChar();
         _local1.value = _local2;
         return _local1;
      }

      private function readNumber() : LOEBUILD_715e545dec433554068d9ff07ec390ec {
         var _local1:LOEBUILD_715e545dec433554068d9ff07ec390ec = new LOEBUILD_715e545dec433554068d9ff07ec390ec();
         _local1.type = LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.NUMBER;
         var _local2:* = "";
         if(this.ch == "-") {
            _local2 = _local2 + "-";
            this.nextChar();
         }
         if(!this.isDigit(this.ch)) {
            this.parseError("Expecting a digit");
         }
         if(this.ch == "0") {
            _local2 = _local2 + this.ch;
            this.nextChar();
            if(this.isDigit(this.ch)) {
               this.parseError("A digit cannot immediately follow 0");
            }
         } else {
            while(this.isDigit(this.ch)) {
               _local2 = _local2 + this.ch;
               this.nextChar();
            }
         }
         if(this.ch == ".") {
            _local2 = _local2 + ".";
            this.nextChar();
            if(!this.isDigit(this.ch)) {
               this.parseError("Expecting a digit");
            }
            while(this.isDigit(this.ch)) {
               _local2 = _local2 + this.ch;
               this.nextChar();
            }
         }
         if(this.ch == "e" || this.ch == "E") {
            _local2 = _local2 + "e";
            this.nextChar();
            if(this.ch == "+" || this.ch == "-") {
               _local2 = _local2 + this.ch;
               this.nextChar();
            }
            if(!this.isDigit(this.ch)) {
               this.parseError("Scientific notation number needs exponent value");
            }
            while(this.isDigit(this.ch)) {
               _local2 = _local2 + this.ch;
               this.nextChar();
            }
         }
         var _local3:Number = Number(_local2);
         if(Boolean(isFinite(_local3)) && !isNaN(_local3)) {
            _local1.value = _local3;
            return _local1;
         }
         this.parseError("Number " + _local3 + " is not valid!");
         return null;
      }

      private function nextChar() : String {
         return this.ch = this.jsonString.charAt(this.loc++);
      }

      private function skipIgnored() : void {
         var _local1:int = 0;
         do {
            _local1 = this.loc;
            this.skipWhite();
            this.skipComments();
         }
         while(_local1 != this.loc);

      }

      private function skipComments() : void {
         if(this.ch == "/") {
            this.nextChar();
            switch(this.ch) {
               case "/":
                  do {
                     this.nextChar();
                  }
                  while(this.ch != "\n" && this.ch != "");

                  this.nextChar();
                  break;
               case "*":
                  this.nextChar();
                  while(true) {
                     if(this.ch == "*") {
                        this.nextChar();
                        if(this.ch == "/") {
                           break;
                        }
                     } else {
                        this.nextChar();
                     }
                     if(this.ch == "") {
                        this.parseError("Multi-line comment not closed");
                     }
                  }
                  this.nextChar();
                  break;
               default:
                  this.parseError("Unexpected " + this.ch + " encountered (expecting \'/\' or \'*\' )");
            }
         }
      }

      private function skipWhite() : void {
         while(this.isWhiteSpace(this.ch)) {
            this.nextChar();
         }
      }

      private function isWhiteSpace(param1:String) : Boolean {
         return param1 == " " || param1 == "\t" || param1 == "\n" || param1 == "\r";
      }

      private function isDigit(param1:String) : Boolean {
         return param1 >= "0" && param1 <= "9";
      }

      private function isHexDigit(param1:String) : Boolean {
         var _local2:String = param1.toUpperCase();
         return Boolean(this.isDigit(param1)) || _local2 >= "A" && _local2 <= "F";
      }

      public function parseError(param1:String) : void {
         throw new JSONParseError(param1,this.loc,this.jsonString);
      }
   }
}
