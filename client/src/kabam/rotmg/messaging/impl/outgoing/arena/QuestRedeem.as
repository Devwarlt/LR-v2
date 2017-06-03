// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.messaging.impl.outgoing.arena.QuestRedeem

package kabam.rotmg.messaging.impl.outgoing.arena
{
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;

public class QuestRedeem extends OutgoingMessage
    {

        public var slotObject:SlotObjectData;

        public function QuestRedeem(_arg1:uint, _arg2:Function)
        {
            this.slotObject = new SlotObjectData();
            super(_arg1, _arg2);
        }

        override public function writeToOutput(_arg1:IDataOutput):void
        {
            this.slotObject.writeToOutput(_arg1);
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing.arena

