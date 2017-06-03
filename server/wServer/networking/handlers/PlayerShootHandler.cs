/*#region
using System;
using wServer.networking.cliPackets;
using wServer.networking.svrPackets;
using wServer.realm;
using wServer.realm.entities;
using wServer.realm.entities.player;


#endregion

namespace wServer.networking.handlers
{
    internal class PlayerShootPacketHandler : PacketHandlerBase<PlayerShootPacket>
    {
        public override PacketID ID
        {
            get { return PacketID.PLAYERSHOOT; }
        }

        protected override void HandlePacket(Client client, PlayerShootPacket packet)
        {
            //client.Manager.Logic.AddPendingAction(t =>{
                StatsManager statsMgr = new StatsManager(client.Player, 0);
                if (client.Player.Owner == null) return;
                client.Player.UpdateCount++;
                Random rnd = new Random();
                int critStat = statsMgr.GetStats(9);
                int critchance = rnd.Next(1, 100);
                Item item = client.Player.Manager.GameData.Items[(ushort)packet.ContainerType];
                Player playeEr = client.Player;
                int stype = 0;
                for (int i = 0; i < 4; i++)
                {
                    if (client.Player.Inventory[i]?.ObjectType == packet.ContainerType)
                    {
                        stype = i;
                        client.Player.UpdateCount++;
                        break;
                    }
                }

            
                
              
                if (client.Player.SlotTypes[stype] != item.SlotType && client.Account.Rank< 2)
                {
                    log.FatalFormat("{0} is trying to cheat (Weapon doesnt match the slot type)", client.Player.Name);
                    client.Player.SendError("This cheating attempt has beed logged and a message was send to all online admins.");
                    client.Player.SaveToCharacter();
                    client.Disconnect();
                    foreach (Player player in client.Player.Owner.Players.Values)
                        if (player.Client.Account.Rank >= 2)
                            player.SendInfo(String.Format("Player {0} is shooting with a weapon that doesnt match the class slot type.", client.Player.Name));
                    return;
                }
    ProjectileDesc prjDesc = item.Projectiles[0]; //Assume only one
    Projectile prj = client.Player.PlayerShootProjectile(
        packet.BulletId, prjDesc, item.ObjectType,
        packet.Time, packet.Position, packet.Angle);
    client.Player.Owner.EnterWorld(prj);
                CheckShootSpeed(playeEr, item);
    client.Player.BroadcastSync(new AllyShootPacket
                {
                    OwnerId = client.Player.Id,
                    Angle = packet.Angle,
                    ContainerType = packet.ContainerType,
                    BulletId = packet.BulletId,
                }, p => p != client.Player && client.Player.Dist(p) < 12);
                client.Player.FameCounter.Shoot(prj);
            //}, PendingPriority.Networking);
        }

        public void CheckShootSpeed(Player player, Item item)
{
    StatsManager statsMgr = new StatsManager(player, 0);
    player.shootCounter++;
    if (player.lastShootTime == -1)
    {
        player.lastShootTime = Environment.TickCount;
    }
    int tolerance = 60;
    float diff = (Environment.TickCount - player.lastShootTime) + tolerance;

    float APS = statsMgr.GetDex();

    if (diff < 670f / APS)
    {
        if (player.shootCounter > (item.NumProjectiles * item.RateOfFire))
        {
            player.shootCounter = 0;
            player.checkForDex++;
            player.Owner.Timers.Add(new WorldTimer(23500, (world, t) =>
            {
                player.checkForDex--;
                return;

            }));

        }
        if (player.checkForDex >= 9)
        {
            Client.Player.SaveToCharacter();
            Client.Disconnect();
            Console.WriteLine("{0} seems to be speedhacking, kicking the user. Dexterity Hack", player.Name);
        }

        if (player.checkForDex < 0)
        {
            player.checkForDex = 0;
        }
    }
    else
    {
        player.shootCounter = 0;
        player.lastShootTime = Environment.TickCount;
    }

}
    }
}*/

//ATUAL
#region

using System;
using wServer.networking.cliPackets;
using wServer.networking.svrPackets;
using wServer.realm;
using wServer.realm.entities;
using wServer.realm.entities.player;

#endregion

namespace wServer.networking.handlers
{
    internal class PlayerShootPacketHandler : PacketHandlerBase<PlayerShootPacket>
    {
        public override PacketID ID
        {
            get { return PacketID.PLAYERSHOOT; }
        }

        protected override void HandlePacket(Client client, PlayerShootPacket packet)
        {
            if (client.Player.Owner == null) return;

            Item item = client.Player.Manager.GameData.Items[(ushort)packet.ContainerType];
            int stype = 0;

            for (int i = 0; i < 4; i++)
            {
                if (client.Player.Inventory[i]?.ObjectType == packet.ContainerType)
                {
                    stype = i;
                    break;
                }
            }

            if (client.Player.SlotTypes[stype] != item.SlotType && client.Account.Rank < 2)
            {
                log.FatalFormat("{0} is trying to cheat (Weapon doesnt match the slot type)", client.Player.Name);
                client.Player.SendError("This cheating attempt has beed logged and a message was send to all online admins.");
                client.Disconnect();
                foreach (Player player in client.Player.Owner.Players.Values)
                    if (player.Client.Account.Rank >= 3)
                        player.SendInfo(String.Format("Player {0} is shooting with a weapon that doesnt match the class slot type.", client.Player.Name));
                return;
            }
            ProjectileDesc prjDesc = item.Projectiles[0]; //Assume only one
            Projectile prj = client.Player.PlayerShootProjectile(
                packet.BulletId, prjDesc, item.ObjectType,
                packet.Time, packet.Position, packet.Angle);
            client.Player.Owner.EnterWorld(prj);
            //client.Manager.Logic.AddPendingAction(t => {
                client.Player.BroadcastSync(new AllyShootPacket
                {
                    OwnerId = client.Player.Id,
                    Angle = packet.Angle,
                    ContainerType = packet.ContainerType,
                    BulletId = packet.BulletId,
                }, p => p != client.Player && client.Player.Dist(p) <= 8);
            //}, PendingPriority.Networking);
            client.Player.FameCounter.Shoot(prj);
        }
    }
}