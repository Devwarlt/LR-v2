package com.adobe.serialization.json {
   public class LOEBUILD_fae39bd0456c4d9aa7f5fd7a496e2ad0 {

      private var value:*;

      private var tokenizer:LOEBUILD_4bf5ed7637caecfb113aa2b2be83e925;

      private var token:LOEBUILD_715e545dec433554068d9ff07ec390ec;

      public function LOEBUILD_fae39bd0456c4d9aa7f5fd7a496e2ad0(param1:String) {
         super();
         this.tokenizer = new LOEBUILD_4bf5ed7637caecfb113aa2b2be83e925(param1);
         this.nextToken();
         this.value = this.parseValue();
      }

      public function getValue() : * {
         return this.value;
      }

      private function nextToken() : LOEBUILD_715e545dec433554068d9ff07ec390ec {
         return this.token = this.tokenizer.getNextToken();
      }

      private function parseArray() : Array {
         var _local1:Array = new Array();
         this.nextToken();
         if(this.token.type == LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.RIGHT_BRACKET) {
            return _local1;
         }
         while(true) {
            _local1.push(this.parseValue());
            this.nextToken();
            if(this.token.type == LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.RIGHT_BRACKET) {
               break;
            }
            if(this.token.type == LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.COMMA) {
               this.nextToken();
            } else {
               this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
            }
         }
         return _local1;
      }

      private function parseObject() : Object {
         var _local2:String = null;
         var _local1:Object = new Object();
         this.nextToken();
         if(this.token.type == LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.RIGHT_BRACE) {
            return _local1;
         }
         while(true) {
            if(this.token.type == LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.STRING) {
               _local2 = String(this.token.value);
               this.nextToken();
               if(this.token.type == LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.COLON) {
                  this.nextToken();
                  _local1[_local2] = this.parseValue();
                  this.nextToken();
                  if(this.token.type == LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.RIGHT_BRACE) {
                     break;
                  }
                  if(this.token.type == LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.COMMA) {
                     this.nextToken();
                  } else {
                     this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
                  }
               } else {
                  this.tokenizer.parseError("Expecting : but found " + this.token.value);
               }
            } else {
               this.tokenizer.parseError("Expecting string but found " + this.token.value);
            }
         }
         return _local1;
      }

      private function parseValue() : Object {
         if(this.token == null) {
            this.tokenizer.parseError("Unexpected end of input");
         }
         switch(this.token.type) {
            case LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.LEFT_BRACE:
               return this.parseObject();
            case LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.LEFT_BRACKET:
               return this.parseArray();
            case LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.STRING:
            case LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.NUMBER:
            case LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.TRUE:
            case LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.FALSE:
            case LOEBUILD_c41f92adcfea3dc5c7e4f02685094289.NULL:
               return this.token.value;
            default:
               this.tokenizer.parseError("Unexpected " + this.token.value);
               return null;
         }
      }
   }
}
