#region

using System.Collections.Generic;
using db;
using wServer.networking.cliPackets;
using wServer.networking.svrPackets;
using wServer.realm;
using wServer.realm.entities.player;

#endregion

namespace wServer.networking.handlers
{
    internal class EditAccountListHandler : PacketHandlerBase<EditAccountListPacket>
    {
        public override PacketID ID
        {
            get { return PacketID.EDITACCOUNTLIST; }
        }

        protected override void HandlePacket(Client client, EditAccountListPacket packet)
        {
            Player target;
            if(client.Player.Owner == null) return;
            client.Manager.Logic.AddPendingAction(t =>
            {
                using (Database db = new Database())
                {
                    target = client.Player.Owner.GetEntity(packet.ObjectId) is Player ? client.Player.Owner.GetEntity(packet.ObjectId) as Player : null;
                    if (target == null) return;
                    if(client.Account.AccountId == target.AccountId)
                    {
                        SendFailure("You cannot do that with yourself.");
                        return;
                    }
                    switch (packet.AccountListId)
                    {
                        case AccountListPacket.LOCKED_LIST_ID:
                            if (packet.Add)
                            {
                                db.AddLock(client.Account.AccountId, target.AccountId);
                                client.Player.Locked.Add(target.AccountId);
                            }
                            else
                            {
                                db.RemoveLock(client.Account.AccountId, target.AccountId);
                                client.Player.Locked.Remove(target.AccountId);
                            }
                            break;
                        case AccountListPacket.IGNORED_LIST_ID:
                            if (packet.Add)
                            {
                                db.AddIgnore(client.Account.AccountId, target.AccountId);
                                client.Player.Ignored.Add(target.AccountId);
                            }
                            else
                            {
                                db.RemoveIgnore(client.Account.AccountId, target.AccountId);
                                client.Player.Ignored.Remove(target.AccountId);
                            }
                            break;
                    }
                }
            }, PendingPriority.Normal);
        }
    }
}