package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {

    import flash.display.GraphicsEndFill;
    import flash.display.GraphicsStroke;
    import flash.display.GraphicsPath;
    import flash.geom.Matrix;
    import flash.display.GraphicsPathCommand;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.GraphicsSolidFill;
    public class GraphicHelper {

        public static const END_FILL:GraphicsEndFill = new GraphicsEndFill();

        public static const RECT_PATH_COMMANDS:Vector.<int> = new <int>[GraphicsPathCommand.MOVE_TO,GraphicsPathCommand.LINE_TO,GraphicsPathCommand.LINE_TO,GraphicsPathCommand.LINE_TO];

        public static const _5v:GraphicsStroke = new GraphicsStroke(1,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,new GraphicsSolidFill(16711680));

        public static const _1yz:GraphicsStroke = new GraphicsStroke();

        private static const _cK_:Number = 2 * Math.PI;

        public static const _nw:Array = [true,true,true,true];


        public function GraphicHelper()
        {
            super();
        }

        public static function clearGraphicsPath(param1:GraphicsPath) : void
        {
            param1.commands.length = 0;
            param1.data.length = 0;
        }

        public static function getRectGPath(param1:int, param2:int, param3:int, param4:int) : GraphicsPath
        {
            return new GraphicsPath(RECT_PATH_COMMANDS,new <Number>[param1,param2,param1 + param3,param2,param1 + param3,param2 + param4,param1,param2 + param4]);
        }

        public static function getGradientMatrix(param1:Number, param2:Number, param3:Number = 0, param4:Number = 0, param5:Number = 0) : Matrix
        {
            var _loc6_:Matrix = new Matrix();
            _loc6_.createGradientBox(param1,param2,param3,param4,param5);
            return _loc6_;
        }

        public static function drawRect(param1:int, param2:int, param3:int, param4:int, param5:GraphicsPath) : void
        {
            param5.moveTo(param1,param2);
            param5.lineTo(param1 + param3,param2);
            param5.lineTo(param1 + param3,param2 + param4);
            param5.lineTo(param1,param2 + param4);
        }

        public static function drawCircle(param1:Number, param2:Number, param3:Number, param4:GraphicsPath, param5:int = 8) : void
        {
            var _loc6_:Number = NaN;
            var _loc7_:Number = NaN;
            var _loc8_:Number = NaN;
            var _loc9_:Number = NaN;
            var _loc10_:Number = NaN;
            var _loc11_:Number = NaN;
            var _loc12_:Number = 1 + 1 / (param5 * 1.75);
            param4.moveTo(param1 + param3,param2);
            var _loc13_:int = 1;
            while(_loc13_ <= param5)
            {
                _loc6_ = _cK_ * _loc13_ / param5;
                _loc7_ = _cK_ * (_loc13_ - 0.5) / param5;
                _loc8_ = param1 + param3 * Math.cos(_loc6_);
                _loc9_ = param2 + param3 * Math.sin(_loc6_);
                _loc10_ = param1 + param3 * _loc12_ * Math.cos(_loc7_);
                _loc11_ = param2 + param3 * _loc12_ * Math.sin(_loc7_);
                param4.curveTo(_loc10_,_loc11_,_loc8_,_loc9_);
                _loc13_++;
            }
        }

        public static function drawUi(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Array, param7:GraphicsPath) : void
        {
            if(param6[0] != 0)
            {
                param7.moveTo(param1,param2 + param5);
                param7.lineTo(param1 + param5,param2);
            }
            else
            {
                param7.moveTo(param1,param2);
            }
            if(param6[1] != 0)
            {
                param7.lineTo(param1 + param3 - param5,param2);
                param7.lineTo(param1 + param3,param2 + param5);
            }
            else
            {
                param7.lineTo(param1 + param3,param2);
            }
            if(param6[2] != 0)
            {
                param7.lineTo(param1 + param3,param2 + param4 - param5);
                param7.lineTo(param1 + param3 - param5,param2 + param4);
            }
            else
            {
                param7.lineTo(param1 + param3,param2 + param4);
            }
            if(param6[3] != 0)
            {
                param7.lineTo(param1 + param5,param2 + param4);
                param7.lineTo(param1,param2 + param4 - param5);
            }
            else
            {
                param7.lineTo(param1,param2 + param4);
            }
            if(param6[0] != 0)
            {
                param7.lineTo(param1,param2 + param5);
            }
            else
            {
                param7.lineTo(param1,param2);
            }
        }

        public static function _0j(param1:Number, param2:Number, param3:Number, param4:GraphicsPath) : void
        {
            param4.moveTo(param1,param2 - param3);
            param4.lineTo(param1 + param3,param2);
            param4.lineTo(param1,param2 + param3);
            param4.lineTo(param1 - param3,param2);
        }
    }
}
