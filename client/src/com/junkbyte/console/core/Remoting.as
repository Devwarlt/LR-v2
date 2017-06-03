package com.junkbyte.console.core {
import com.junkbyte.console.Console;

import flash.events.AsyncErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.events.StatusEvent;
import flash.net.LocalConnection;
import flash.net.Socket;
import flash.system.Security;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class Remoting extends ConsoleCore {

      public static const NONE:uint = 0;

      public static const SENDER:uint = 1;

      public static const RECIEVER:uint = 2;

      private var _callbacks:Object;

      private var _mode:uint;

      private var _local:LocalConnection;

      private var _socket:Socket;

      private var _sendBuffer:ByteArray;

      private var _recBuffers:Object;

      private var _senders:Dictionary;

      private var _lastLogin:String = "";

      private var _loggedIn:Boolean;

      private var _sendID:String;

      private var _lastReciever:String;

      public function Remoting(param1:Console) {
         var m:Console = param1;
         this._callbacks = new Object();
         this._sendBuffer = new ByteArray();
         this._recBuffers = new Object();
         this._senders = new Dictionary();
         super(m);
         this.registerCallback("login",function(param1:ByteArray):void {
            login(param1.readUTF());
         });
         this.registerCallback("requestLogin",this.requestLogin);
         this.registerCallback("loginFail",this.loginFail);
         this.registerCallback("loginSuccess",this.loginSuccess);
      }

      public function update() : void {
         var _local1:* = null;
         var _local2:ByteArray = null;
         var _local3:String = null;
         var _local4:ByteArray = null;
         if(this._sendBuffer.length) {
            if(Boolean(this._socket) && Boolean(this._socket.connected)) {
               this._socket.writeBytes(this._sendBuffer);
               this._sendBuffer = new ByteArray();
            } else if(this._local) {
               this._sendBuffer.position = 0;
               if(this._sendBuffer.bytesAvailable < 38000) {
                  _local2 = this._sendBuffer;
                  this._sendBuffer = new ByteArray();
               } else {
                  _local2 = new ByteArray();
                  this._sendBuffer.readBytes(_local2,0,Math.min(38000,this._sendBuffer.bytesAvailable));
                  _local4 = new ByteArray();
                  this._sendBuffer.readBytes(_local4);
                  this._sendBuffer = _local4;
               }
               _local3 = config.remotingConnectionName + (this.remoting == Remoting.RECIEVER?SENDER:RECIEVER);
               this._local.send(_local3,"synchronize",this._sendID,_local2);
            } else {
               this._sendBuffer = new ByteArray();
            }
         }
         for(_local1 in this._recBuffers) {
            this.processRecBuffer(_local1);
         }
      }

      private function processRecBuffer(param1:String) : void {
         var pointer:uint = 0;
         var cmd:String = null;
         var arg:ByteArray = null;
         var callbackData:Object = null;
         var blen:uint = 0;
         var recbuffer:ByteArray = null;
         var id:String = param1;
         if(!this._senders[id]) {
            this._senders[id] = true;
            if(this._lastReciever) {
               report("Remote switched to new sender [" + id + "] as primary.",-2);
            }
            this._lastReciever = id;
         }
         var buffer:ByteArray = this._recBuffers[id];
         try {
            pointer = buffer.position = 0;
            while(buffer.bytesAvailable) {
               cmd = buffer.readUTF();
               arg = null;
               if(buffer.bytesAvailable == 0) {
                  break;
               }
               if(buffer.readBoolean()) {
                  if(buffer.bytesAvailable == 0) {
                     break;
                  }
                  blen = buffer.readUnsignedInt();
                  if(buffer.bytesAvailable < blen) {
                     break;
                  }
                  arg = new ByteArray();
                  buffer.readBytes(arg,0,blen);
               }
               callbackData = this._callbacks[cmd];
               if(!callbackData.latest || id == this._lastReciever) {
                  if(arg) {
                     callbackData.fun(arg);
                  } else {
                     callbackData.fun();
                  }
               }
               pointer = buffer.position;
            }
            if(pointer < buffer.length) {
               recbuffer = new ByteArray();
               recbuffer.writeBytes(buffer,pointer);
               this._recBuffers[id] = buffer = recbuffer;
            } else {
               delete this._recBuffers[id];
            }
            return;
         }
         catch(err:Error) {
            report("Remoting sync error: " + err,9);
            return;
         }
      }

      private function synchronize(param1:String, param2:Object) : void {
         if(!(param2 is ByteArray)) {
            report("Remoting sync error. Recieved non-ByteArray:" + param2,9);
            return;
         }
         var _local3:ByteArray = param2 as ByteArray;
         var _local4:ByteArray = this._recBuffers[param1];
         if(_local4) {
            _local4.position = _local4.length;
            _local4.writeBytes(_local3);
         } else {
            this._recBuffers[param1] = _local3;
         }
      }

      public function send(param1:String, param2:ByteArray = null) : Boolean {
         if(this._mode == NONE) {
            return false;
         }
         this._sendBuffer.position = this._sendBuffer.length;
         this._sendBuffer.writeUTF(param1);
         if(param2) {
            this._sendBuffer.writeBoolean(true);
            this._sendBuffer.writeUnsignedInt(param2.length);
            this._sendBuffer.writeBytes(param2);
         } else {
            this._sendBuffer.writeBoolean(false);
         }
         return true;
      }

      public function get remoting() : uint {
         return this._mode;
      }

      public function get canSend() : Boolean {
         return this._mode == SENDER && Boolean(this._loggedIn);
      }

      public function set remoting(param1:uint) : void {
         var _local2:String = null;
         if(param1 == this._mode) {
            return;
         }
         this._sendID = this.generateId();
         if(param1 == SENDER) {
            if(!this.startSharedConnection(SENDER)) {
               report("Could not create remoting client service. You will not be able to control this LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4 with remote.",10);
            }
            this._sendBuffer = new ByteArray();
            this._local.addEventListener(StatusEvent.STATUS,this.onSenderStatus,false,0,true);
            report("<b>Remoting started.</b> " + this.getInfo(),-1);
            this._loggedIn = this.checkLogin("");
            if(this._loggedIn) {
               this.sendLoginSuccess();
            } else {
               this.send("requestLogin");
            }
         } else if(param1 == RECIEVER) {
            if(this.startSharedConnection(RECIEVER)) {
               this._sendBuffer = new ByteArray();
               this._local.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.onRemoteAsyncError,false,0,true);
               this._local.addEventListener(StatusEvent.STATUS,this.onRecieverStatus,false,0,true);
               report("<b>Remote started.</b> " + this.getInfo(),-1);
               _local2 = Security.sandboxType;
               if(_local2 == Security.LOCAL_WITH_FILE || _local2 == Security.LOCAL_WITH_NETWORK) {
                  report("Untrusted local sandbox. You may not be able to listen for logs properly.",10);
                  this.printHowToGlobalSetting();
               }
               this.login(this._lastLogin);
            } else {
               report("Could not create remote service. You might have a LOEBUILD_bfafd813d7ea65ee4db1f09d7c8ffbf4 remote already running.",10);
            }
         } else {
            this.close();
         }
         console.panels.updateMenu();
      }

      public function remotingSocket(param1:String, param2:int = 0) : void {
         if(Boolean(this._socket) && Boolean(this._socket.connected)) {
            this._socket.close();
            this._socket = null;
         }
         if(Boolean(param1) && Boolean(param2)) {
            this.remoting = SENDER;
            report("Connecting to socket " + param1 + ":" + param2);
            this._socket = new Socket();
            this._socket.addEventListener(Event.CLOSE,this.socketCloseHandler);
            this._socket.addEventListener(Event.CONNECT,this.socketConnectHandler);
            this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.socketIOErrorHandler);
            this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.socketSecurityErrorHandler);
            this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.socketDataHandler);
            this._socket.connect(param1,param2);
         }
      }

      private function socketCloseHandler(param1:Event) : void {
         if(param1.currentTarget == this._socket) {
            this._socket = null;
         }
      }

      private function socketConnectHandler(param1:Event) : void {
         report("Remoting socket connected.",-1);
         this._sendBuffer = new ByteArray();
         if(Boolean(this._loggedIn) || Boolean(this.checkLogin(""))) {
            this.sendLoginSuccess();
         } else {
            this.send("requestLogin");
         }
      }

      private function socketIOErrorHandler(param1:Event) : void {
         report("Remoting socket error." + param1,9);
         this.remotingSocket(null);
      }

      private function socketSecurityErrorHandler(param1:Event) : void {
         report("Remoting security error." + param1,9);
         this.remotingSocket(null);
      }

      private function socketDataHandler(param1:Event) : void {
         this.handleSocket(param1.currentTarget as Socket);
      }

      public function handleSocket(param1:Socket) : void {
         if(!this._senders[param1]) {
            this._senders[param1] = this.generateId();
            this._socket = param1;
         }
         var _local2:ByteArray = new ByteArray();
         param1.readBytes(_local2);
         this.synchronize(this._senders[param1],_local2);
      }

      private function onSenderStatus(param1:StatusEvent) : void {
         if(param1.level == "error" && !(this._socket && this._socket.connected)) {
            this._loggedIn = false;
         }
      }

      private function onRecieverStatus(param1:StatusEvent) : void {
         if(this.remoting == Remoting.RECIEVER && param1.level == "error") {
            report("Problem communicating to client.",10);
         }
      }

      private function onRemotingSecurityError(param1:SecurityErrorEvent) : void {
         report("Remoting security error.",9);
         this.printHowToGlobalSetting();
      }

      private function onRemoteAsyncError(param1:AsyncErrorEvent) : void {
         report("Problem with remote sync. [<a href=\'event:remote\'>Click here</a>] to restart.",10);
         this.remoting = NONE;
      }

      private function getInfo() : String {
         return "<p4>channel:" + config.remotingConnectionName + " (" + Security.sandboxType + ")</p4>";
      }

      private function printHowToGlobalSetting() : void {
         report("Make sure your flash file is \'trusted\' in Global Security Settings.",-2);
         report("Go to Settings Manager [<a href=\'event:settings\'>click here</a>] &gt; \'Global Security Settings Panel\' (on left) &gt; add the location of the local flash (swf) file.",-2);
      }

      private function generateId() : String {
         return new Date().time + "." + Math.floor(Math.random() * 100000);
      }

      private function startSharedConnection(param1:uint) : Boolean {
         var targetmode:uint = param1;
         this.close();
         this._mode = targetmode;
         this._local = new LocalConnection();
         this._local.client = {"synchronize":this.synchronize};
         if(config.allowedRemoteDomain) {
            this._local.allowDomain(config.allowedRemoteDomain);
            this._local.allowInsecureDomain(config.allowedRemoteDomain);
         }
         this._local.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onRemotingSecurityError,false,0,true);
         try {
            this._local.connect(config.remotingConnectionName + this._mode);
         }
         catch(err:Error) {
            return false;
         }
         return true;
      }

      public function registerCallback(param1:String, param2:Function, param3:Boolean = false) : void {
         this._callbacks[param1] = {
            "fun":param2,
            "latest":param3
         };
      }

      private function loginFail() : void {
         if(this.remoting != Remoting.RECIEVER) {
            return;
         }
         report("Login Failed",10);
         console.panels.mainPanel.requestLogin();
      }

      private function sendLoginSuccess() : void {
         this._loggedIn = true;
         this.send("loginSuccess");
         dispatchEvent(new Event(Event.CONNECT));
      }

      private function loginSuccess() : void {
         console.setViewingChannels();
         report("Login Successful",-1);
      }

      private function requestLogin() : void {
         if(this.remoting != Remoting.RECIEVER) {
            return;
         }
         this._sendBuffer = new ByteArray();
         if(this._lastLogin) {
            this.login(this._lastLogin);
         } else {
            console.panels.mainPanel.requestLogin();
         }
      }

      public function login(param1:String = "") : void {
         var _local2:ByteArray = null;
         if(this.remoting == Remoting.RECIEVER) {
            this._lastLogin = param1;
            report("Attempting to login...",-1);
            _local2 = new ByteArray();
            _local2.writeUTF(param1);
            this.send("login",_local2);
         } else if(Boolean(this._loggedIn) || Boolean(this.checkLogin(param1))) {
            this.sendLoginSuccess();
         } else {
            this.send("loginFail");
         }
      }

      private function checkLogin(param1:String) : Boolean {
         return config.remotingPassword === null && config.keystrokePassword == param1 || config.remotingPassword === "" || config.remotingPassword == param1;
      }

      public function close() : void {
         if(this._local) {
            try {
               this._local.close();
            }
            catch(error:Error) {
               report("Remote.close: " + error,10);
            }
         }
         this._mode = NONE;
         this._sendBuffer = new ByteArray();
         this._local = null;
      }
   }
}
