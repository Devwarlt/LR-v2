package kabam.rotmg.util.components {
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import com.company.assembleegameclient.util.Currency;
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.ui.Mouse;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.ui.view.SignalWaiter;
import kabam.rotmg.util.components.api.BuyButton;

public class SimpleButton extends BuyButton {

      private static const BEVEL:int = 4;

      private static const PADDING:int = 2;

      public static const coin:BitmapData = IconFactory.makeCoin();

      public static const fortune:BitmapData = IconFactory.makeFortune();

      public static const fame:BitmapData = IconFactory.makeFame();

      public static const guildFame:BitmapData = IconFactory.makeGuildFame();

      private static const grayfilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);

      public var prefix:String;

      public var text:TextField;

      public var icon:Bitmap;

      public var price:int = -1;

      public var currency:int = -1;

      public var _width:int = -1;

      private const enabledFill:GraphicsSolidFill = new GraphicsSolidFill(16777215,1);

      private const disabledFill:GraphicsSolidFill = new GraphicsSolidFill(8355711,1);

      private const graphicsPath:GraphicsPath = new GraphicsPath(new Vector.<int>(),new Vector.<Number>());

      private var graphicsData:Vector.<IGraphicsData>;

      private const waiter:SignalWaiter = new SignalWaiter();

      private var withOutLine:Boolean = false;

      private var outLineColor:int = 2368548;

      private var fixedWidth:int = -1;

      private var fixedHeight:int = -1;

      private var textVertMargin:int = 4;

      public function SimpleButton(param1:String, param2:int = -1, param3:int = -1, param4:Boolean = false) {
         super();
         graphicsData = new <IGraphicsData>[enabledFill,graphicsPath,GraphicsUtil.END_FILL];
         this.prefix = param1;
         this.text = new TextField();
         var _local5:TextFormat = new TextFormat();
         _local5.size = 16;
         _local5.font = "Myriad Pro";
         _local5.bold = true;
         _local5.align = TextFormatAlign.LEFT;
         _local5.leftMargin = 0;
         _local5.indent = 0;
         _local5.leading = 0;
         this.text.textColor = 3552822;
         this.text.autoSize = TextFieldAutoSize.CENTER;
         this.text.selectable = false;
         this.text.defaultTextFormat = _local5;
         this.text.setTextFormat(_local5);
         this.waiter.complete.add(this.updateUI);
         this.waiter.complete.addOnce(this.readyForPlacementDispatch);
         addChild(this.text);
         this.icon = new Bitmap();
         addChild(this.icon);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         if(param2 != -1) {
            this.setPrice(param2,param3);
         } else {
            this.text.text = param1;
            this.updateUI();
         }
         this.withOutLine = param4;
      }

      override public function setPrice(param1:int, param2:int) : void {
         if(this.price != param1 || this.currency != param2) {
            this.price = param1;
            this.currency = param2;
            this.text.text = this.prefix + param1.toString();
            this.updateUI();
         }
      }

      public function getPrice() : int {
         return this.price;
      }

      public function setText(param1:String) : void {
         this.text.text = param1;
         this.updateUI();
      }

      override public function setEnabled(param1:Boolean) : void {
         if(param1 != mouseEnabled) {
            mouseEnabled = param1;
            filters = !!param1?[]:[grayfilter];
            this.draw();
         }
      }

      override public function setWidth(param1:int) : void {
         this._width = param1;
         this.updateUI();
      }

      private function updateUI() : void {
         this.updateText();
         this.updateIcon();
         this.updateBackground();
         this.draw();
      }

      private function readyForPlacementDispatch() : void {
         this.updateUI();
         readyForPlacement.dispatch();
      }

      private function updateIcon() : void {
         switch(this.currency) {
            case Currency.GOLD:
               this.icon.bitmapData = coin;
               break;
            case Currency.FAME:
               this.icon.bitmapData = fame;
               break;
            case Currency.GUILD_FAME:
               this.icon.bitmapData = guildFame;
               break;
            case Currency.FORTUNE:
               this.icon.bitmapData = fortune;
               break;
            default:
               this.icon.bitmapData = null;
         }
         this.updateIconPosition();
      }

      private function updateBackground() : void {
         GraphicsUtil.clearPath(this.graphicsPath);
         GraphicsUtil.drawCutEdgeRect(0,0,this.getWidth(),this.getHeight(),BEVEL,[1,1,1,1],this.graphicsPath);
      }

      private function updateText() : void {
         this.text.x = (this.getWidth() - this.icon.width - this.text.width - PADDING) * 0.5;
         this.text.y = this.textVertMargin;
      }

      private function updateIconPosition() : void {
         this.icon.x = this.text.x + this.text.width + PADDING;
         this.icon.y = (this.getHeight() - this.icon.height - 1) * 0.5;
      }

      private function onMouseOver(param1:MouseEvent) : void {
         Mouse.cursor = "button";
         this.enabledFill.color = 16768133;
         this.draw();
      }

      private function onRollOut(param1:MouseEvent) : void {
         Mouse.cursor = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.cursorSelect;
         this.enabledFill.color = 16777215;
         this.draw();
      }

      public function draw() : void {
         this.graphicsData[0] = !!mouseEnabled?this.enabledFill:this.disabledFill;
         graphics.clear();
         graphics.drawGraphicsData(this.graphicsData);
         if(this.withOutLine) {
            this.drawOutline(graphics);
         }
      }

      private function getWidth() : int {
         return this.fixedWidth != -1?int(this.fixedWidth):int(Math.max(this._width,this.text.width + this.icon.width + 3 * PADDING));
      }

      private function getHeight() : int {
         return this.fixedHeight != -1?int(this.fixedHeight):int(this.text.height + this.textVertMargin * 2);
      }

      public function freezeSize() : void {
         this.fixedHeight = this.getHeight();
         this.fixedWidth = this.getWidth();
      }

      public function unfreezeSize() : void {
         this.fixedHeight = -1;
         this.fixedWidth = -1;
      }

      public function scaleButtonWidth(param1:Number) : void {
         this.fixedWidth = this.getWidth() * param1;
         this.updateUI();
      }

      public function scaleButtonHeight(param1:Number) : void {
         this.textVertMargin = this.textVertMargin * param1;
         this.updateUI();
      }

      public function setOutLineColor(param1:int) : void {
         this.outLineColor = param1;
      }

      private function drawOutline(param1:Graphics) : void {
         var _local2:GraphicsSolidFill = new GraphicsSolidFill(0,0.01);
         var _local3:GraphicsSolidFill = new GraphicsSolidFill(this.outLineColor,0.6);
         var _local4:GraphicsStroke = new GraphicsStroke(4,false,LineScaleMode.NORMAL,CapsStyle.NONE,JointStyle.ROUND,3,_local3);
         var _local5:GraphicsPath = new GraphicsPath();
         GraphicsUtil.drawCutEdgeRect(0,0,this.getWidth(),this.getHeight(),4,GraphicsUtil.ALL_CUTS,_local5);
         var _local6:Vector.<IGraphicsData> = new <IGraphicsData>[_local4,_local2,_local5,GraphicsUtil.END_FILL,GraphicsUtil.END_STROKE];
         param1.drawGraphicsData(_local6);
      }
   }
}
