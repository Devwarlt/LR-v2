package kabam.rotmg.mysterybox.components {
import com.company.assembleegameclient.util.Currency;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;
import flash.utils.getTimer;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;
import kabam.rotmg.util.components.UIAssetsHelper;

public class MysteryBoxSelectEntry extends Sprite {

    public static var redBarEmbed:Class = MysteryBoxSelectEntry_redBarEmbed;

    public var mbi:MysteryBoxInfo;

    private const buyButton:LegacyBuyButton = new LegacyBuyButton("", 16, 0, Currency.INVALID);

    private var leftNavSprite:Sprite;

    private var rightNavSprite:Sprite;

    private var iconImage:DisplayObject;

    private var infoImageBorder:PopupWindowBackground;

    private var infoImage:DisplayObject;

    private var newText:TextFieldDisplayConcrete;

    private var sale:TextFieldDisplayConcrete;

    private var hoverState:Boolean = false;

    private var descriptionShowing:Boolean = false;

    private var redbar:DisplayObject;

    private const newString:String = "MysteryBoxSelectEntry.newString";

    private const onSaleString:String = "MysteryBoxSelectEntry.onSaleString";

    private const saleEndString:String = "MysteryBoxSelectEntry.saleEndString";

    private var quantity_:int;

    public function MysteryBoxSelectEntry(param1:MysteryBoxInfo) {
        super();
        this.redbar = new redBarEmbed();
        this.redbar.y = -5;
        this.redbar.width = MysteryBoxSelectModal.modalWidth - 5;
        this.redbar.height = MysteryBoxSelectModal.aMysteryBoxHeight - 8;
        addChild(this.redbar);
        var _local2:DisplayObject = new redBarEmbed();
        _local2.y = 0;
        _local2.width = MysteryBoxSelectModal.modalWidth - 5;
        _local2.height = MysteryBoxSelectModal.aMysteryBoxHeight - 8 + 5;
        _local2.alpha = 0;
        addChild(_local2);
        this.mbi = param1;
        this.quantity_ = 1;
        var _local3:TextFieldDisplayConcrete = this.getText(this.mbi.title, 74, 18, 20, true);
        addChild(_local3);
        this.addNewText();
        this.addSaleText();
        if (this.mbi.isOnSale()) {
            this.buyButton.setPrice(this.mbi.saleAmount, this.mbi.saleCurrency);
        } else {
            this.buyButton.setPrice(this.mbi.priceAmount, this.mbi.priceCurrency);
        }
        this.buyButton.x = MysteryBoxSelectModal.modalWidth - 120;
        this.buyButton.y = 16;
        this.buyButton._width = 70;
        this.buyButton.addEventListener(MouseEvent.CLICK, this.onBoxBuy);
        addChild(this.buyButton);
        this.iconImage = this.mbi.iconImage;
        this.infoImage = this.mbi.infoImage;
        if (this.iconImage == null) {
            this.mbi.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onImageLoadComplete);
        } else {
            this.addIconImageChild();
        }
        if (this.infoImage == null) {
            this.mbi.infoImageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onInfoLoadComplete);
        } else {
            this.addInfoImageChild();
        }
        this.mbi.quantity = this.quantity_.toString();
        this.leftNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.LEFT_NEVIGATOR, 3);
        this.leftNavSprite.x = this.buyButton.x + this.buyButton.width + 45;
        this.leftNavSprite.y = this.buyButton.y + this.buyButton.height / 2 - 2;
        this.leftNavSprite.addEventListener(MouseEvent.CLICK, this.onClick);
        addChild(this.leftNavSprite);
        this.rightNavSprite = UIAssetsHelper.createLeftNevigatorIcon(UIAssetsHelper.RIGHT_NEVIGATOR, 3);
        this.rightNavSprite.x = this.buyButton.x + this.buyButton.width + 45;
        this.rightNavSprite.y = this.buyButton.y + this.buyButton.height / 2 - 16;
        this.rightNavSprite.addEventListener(MouseEvent.CLICK, this.onClick);
        addChild(this.rightNavSprite);
        addEventListener(MouseEvent.ROLL_OVER, this.onHover);
        addEventListener(MouseEvent.ROLL_OUT, this.onRemoveHover);
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onHover(param1:MouseEvent):void {
        this.hoverState = true;
        this.addInfoImageChild();
    }

    private function onRemoveHover(param1:MouseEvent):void {
        this.hoverState = false;
        this.removeInfoImageChild();
    }

    private function onClick(param1:MouseEvent):* {
        switch (param1.currentTarget) {
            case this.rightNavSprite:
                if (this.quantity_ == 1) {
                    this.quantity_ = this.quantity_ + 4;
                } else if (this.quantity_ < 10) {
                    this.quantity_ = this.quantity_ + 5;
                }
                break;
            case this.leftNavSprite:
                if (this.quantity_ == 10) {
                    this.quantity_ = this.quantity_ - 5;
                } else if (this.quantity_ > 1) {
                    this.quantity_ = this.quantity_ - 4;
                }
        }
        this.mbi.quantity = this.quantity_.toString();
        if (this.mbi.isOnSale()) {
            this.buyButton.setPrice(this.mbi.saleAmount * this.quantity_, this.mbi.saleCurrency);
        } else {
            this.buyButton.setPrice(this.mbi.priceAmount * this.quantity_, this.mbi.priceCurrency);
        }
    }

    private function addNewText():void {
        if (this.mbi.isNew()) {
            this.newText = this.getText(this.newString, 74, 0).setColor(16768512);
            addChild(this.newText);
        }
    }

    private function onEnterFrame(param1:Event):void {
        var _local2:Number = 1.05 + 0.05 * Math.sin(getTimer() / 200);
        if (this.newText) {
            this.newText.scaleX = _local2;
            this.newText.scaleY = _local2;
        }
        if (this.sale) {
            this.sale.scaleX = _local2;
            this.sale.scaleY = _local2;
        }
    }

    private function addSaleText():void {
        var _local1:LineBuilder = null;
        var _local2:TextFieldDisplayConcrete = null;
        if (this.mbi.isOnSale()) {
            this.sale = this.getText(this.onSaleString, int(320 * MysteryBoxSelectModal.modalWidth / 415), 0).setColor(65280);
            addChild(this.sale);
            _local1 = this.mbi.getSaleTimeLeftStringBuilder();
            _local2 = this.getText("", int(250 * MysteryBoxSelectModal.modalWidth / 415) - 32, 46).setColor(16711680);
            _local2.setStringBuilder(_local1);
            addChild(_local2);
        }
    }

    private function onImageLoadComplete(param1:Event):void {
        this.mbi.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onImageLoadComplete);
        this.iconImage = DisplayObject(this.mbi.loader);
        this.addIconImageChild();
    }

    private function onInfoLoadComplete(param1:Event):void {
        this.mbi.infoImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onInfoLoadComplete);
        this.infoImage = DisplayObject(this.mbi.infoImageLoader);
        this.addInfoImageChild();
    }

    public function getText(param1:String, param2:int, param3:int, param4:int = 12, param5:Boolean = false):TextFieldDisplayConcrete {
        var _local6:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(param4).setColor(16777215).setTextWidth(MysteryBoxSelectModal.modalWidth - 185);
        _local6.setBold(true);
        if (param5) {
            _local6.setStringBuilder(new StaticStringBuilder(param1));
        } else {
            _local6.setStringBuilder(new LineBuilder().setParams(param1));
        }
        _local6.setWordWrap(true);
        _local6.setMultiLine(true);
        _local6.setAutoSize(TextFieldAutoSize.LEFT);
        _local6.setHorizontalAlign(TextFormatAlign.LEFT);
        _local6.filters = [new DropShadowFilter(0, 0, 0)];
        _local6.x = param2;
        _local6.y = param3;
        return _local6;
    }

    private function addIconImageChild():void {
        if (this.iconImage == null) {
            return;
        }
        this.iconImage.width = 48;
        this.iconImage.height = 48;
        this.iconImage.x = 14;
        this.iconImage.y = 6;
        addChild(this.iconImage);
    }

    private function addInfoImageChild():void {
        var _local3:Array = null;
        var _local4:ColorMatrixFilter = null;
        if (this.infoImage == null) {
            return;
        }
        var _local1:int = 8;
        this.infoImage.width = 291 - _local1;
        this.infoImage.height = 598 - _local1 * 2 - 2;
        var _local2:Point = this.globalToLocal(new Point(MysteryBoxSelectModal.getRightBorderX() + 1 + 14, 2 + _local1));
        this.infoImage.x = _local2.x;
        this.infoImage.y = _local2.y;
        if (Boolean(this.hoverState) && !this.descriptionShowing) {
            this.descriptionShowing = true;
            addChild(this.infoImage);
            this.infoImageBorder = new PopupWindowBackground();
            this.infoImageBorder.draw(this.infoImage.width, this.infoImage.height + 2, PopupWindowBackground.TYPE_TRANSPARENT_WITHOUT_HEADER);
            this.infoImageBorder.x = this.infoImage.x;
            this.infoImageBorder.y = this.infoImage.y - 1;
            addChild(this.infoImageBorder);
            _local3 = [3.0742, -1.8282, -0.246, 0, 50, -0.9258, 2.1718, -0.246, 0, 50, -0.9258, -1.8282, 3.754, 0, 50, 0, 0, 0, 1, 0];
            _local4 = new ColorMatrixFilter(_local3);
            this.redbar.filters = [_local4];
        }
    }

    private function removeInfoImageChild():void {
        if (this.descriptionShowing) {
            removeChild(this.infoImageBorder);
            removeChild(this.infoImage);
            this.descriptionShowing = false;
            this.redbar.filters = [];
        }
    }

    private function onBoxBuy(param1:MouseEvent):void {
        var _local4:OpenDialogSignal = null;
        var _local2:MysteryBoxRollModal = new MysteryBoxRollModal(this.mbi, this.quantity_);
        var _local3:Boolean = _local2.moneyCheckPass();
        if (_local3) {
            _local2.parentSelectModal = MysteryBoxSelectModal(parent.parent);
            _local4 = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _local4.dispatch(_local2);
        }
    }
}
}
