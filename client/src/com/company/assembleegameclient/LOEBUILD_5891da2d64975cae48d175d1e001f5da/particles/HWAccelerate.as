package com.company.assembleegameclient.LOEBUILD_5891da2d64975cae48d175d1e001f5da.particles {
    import flash.utils.Dictionary;
    import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
    import flash.display.GraphicsSolidFill;
    public class HWAccelerate {

        private static const _0N_L_:Vector.<Number> = Vector.<Number>([0,0,0,0]);

        private static var _groundBitmapFills:Dictionary = new Dictionary();

        private static var gndBmpFillCnt:uint = 0;

        private static var _098:Dictionary = new Dictionary();

        private static var _0yM_:uint = 0;

        private static var _1kP_:Dictionary = new Dictionary();

        private static var _0E_z:uint = 0;

        private static var _U_S_:Dictionary = new Dictionary();

        private static var _1S_J_:uint = 0;

        private static var _bitmapFills:Dictionary = new Dictionary();

        private static var bmpFillCnt:uint = 0;

        private static var _solidFills:Dictionary = new Dictionary();

        private static var solidFillCnt:uint = 0;

        private static var _M_R_:uint = 0;

        public function HWAccelerate()
        {
            super();
        }

        public static function addSolidFill(param1:GraphicsSolidFill, param2:Boolean) : void
        {
            if(!LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.hwAccel())
            {
                return;
            }
            if(_solidFills[param1] == null)
            {
                solidFillCnt++;
            }
            _solidFills[param1] = param2;
        }
    }
}
