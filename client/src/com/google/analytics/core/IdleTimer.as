package com.google.analytics.core {
import com.google.analytics.debug.DebugConfiguration;
import com.google.analytics.debug.VisualDebugMode;
import com.google.analytics.v4.Configuration;

import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.getTimer;

public class IdleTimer {

      private var _stage:Stage;

      private var _loop:Timer;

      private var _lastMove:int;

      private var _inactivity:Number;

      private var _debug:DebugConfiguration;

      private var _session:Timer;

      private var _buffer:Buffer;

      public function IdleTimer(param1:Configuration, param2:DebugConfiguration, param3:DisplayObject, param4:Buffer) {
         super();
         var _local5:Number = param1.idleLoop;
         var _local6:Number = param1.idleTimeout;
         var _local7:Number = param1.sessionTimeout;
         _loop = new Timer(_local5 * 1000);
         _session = new Timer(_local7 * 1000,1);
         _debug = param2;
         _stage = param3.stage;
         _buffer = param4;
         _lastMove = getTimer();
         _inactivity = _local6 * 1000;
         _loop.addEventListener(TimerEvent.TIMER,checkForIdle);
         _session.addEventListener(TimerEvent.TIMER_COMPLETE,endSession);
         _stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
         _debug.info("delay: " + _local5 + "sec , inactivity: " + _local6 + "sec, sessionTimeout: " + _local7,VisualDebugMode.geek);
         _loop.start();
      }

      private function onMouseMove(param1:MouseEvent) : void {
         _lastMove = getTimer();
         if(_session.running) {
            _debug.info("session timer reset",VisualDebugMode.geek);
            _session.reset();
         }
      }

      public function endSession(param1:TimerEvent) : void {
         _session.removeEventListener(TimerEvent.TIMER_COMPLETE,endSession);
         _debug.info("session timer end session",VisualDebugMode.geek);
         _session.reset();
         _buffer.resetCurrentSession();
         _debug.info(_buffer.utmb.toString(),VisualDebugMode.geek);
         _debug.info(_buffer.utmc.toString(),VisualDebugMode.geek);
         _session.addEventListener(TimerEvent.TIMER_COMPLETE,endSession);
      }

      public function checkForIdle(param1:TimerEvent) : void {
         var _local2:int = getTimer();
         if(_local2 - _lastMove >= _inactivity) {
            if(!_session.running) {
               _debug.info("session timer start",VisualDebugMode.geek);
               _session.start();
            }
         }
      }
   }
}
