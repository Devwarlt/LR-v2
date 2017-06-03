package kabam.rotmg.game.commands
{
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.servers.api.ServerModel;
import kabam.rotmg.account.core.services.GetCharListTask;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.net.impl.SocketServerModel;
import com.company.assembleegameclient.LOEBUILD_1f4c42c309fe6bc45253d598cfdf9b99.LOEBUILD_7ebef6bdf3535c86294f666e62e89578;
import com.company.assembleegameclient.LOEBUILD_166e64f6c3677d0c513901242a3e702d.LOEBUILD_3225a10b07f1580f10dee4abc3779e6c;
import kabam.rotmg.servers.api.Server;
import flash.utils.ByteArray;
import com.company.assembleegameclient.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.GameSprite;

public class PlayGameCommand
{

    public static const RECONNECT_DELAY:int = 2000;

    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var data:GameInitData;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var petsModel:PetsModel;
    [Inject]
    public var servers:ServerModel;
    [Inject]
    public var task:GetCharListTask;
    [Inject]
    public var monitor:TaskMonitor;
    [Inject]
    public var socketServerModel:SocketServerModel;


    public function execute():void
    {
        if (!this.data.isNewGame){
            this.socketServerModel.connectDelayMS = PlayGameCommand.RECONNECT_DELAY;
        }
        this.recordCharacterUseInSharedObject();
        this.makeGameView();
        this.updatePet();
    }

    private function updatePet():void
    {
        var _local1:LOEBUILD_7ebef6bdf3535c86294f666e62e89578 = this.model.getCharacterById(this.model.currentCharId);
        if (_local1){
            this.petsModel.setActivePet(_local1.getPetVO());
        } else {
            if (((((this.model.currentCharId) && (this.petsModel.getActivePet()))) && (!(this.data.isNewGame)))){
                return;
            }
            this.petsModel.setActivePet(null);
        }
    }

    private function recordCharacterUseInSharedObject():void
    {
        LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.charIdUseMap[this.data.charId] = new Date().getTime();
        LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.save();
    }

    private function makeGameView():void
    {
        var _local1:Server = ((this.data.server) || (this.servers.getServer()));
        var _local2:int = ((this.data.isNewGame) ? this.getInitialGameId() : this.data.gameId);
        var _local3:Boolean = this.data.createCharacter;
        var _local4:int = this.data.charId;
        var _local5:int = ((this.data.isNewGame) ? -1 : this.data.keyTime);
        var _local6:ByteArray = this.data.key;
        this.model.currentCharId = _local4;
        this.setScreen.dispatch(new GameSprite(_local1, _local2, _local3, _local4, _local5, _local6, this.model, null, this.data.isFromArena));
    }

    private function getInitialGameId():int
    {
        var _local1:int;
        if (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.needsTutorial){
            _local1 = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.TUTORIAL_GAMEID;
        } else {
            if (LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.data_.needsRandomRealm){
                _local1 = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.RANDOM_REALM_GAMEID;
            } else {
                _local1 = LOEBUILD_3225a10b07f1580f10dee4abc3779e6c.NEXUS_GAMEID;
            }
        }
        return (_local1);
    }


}
}//package kabam.rotmg.LOEBUILD_c8d46d341bea4fd5bff866a65ff8aea9.commands