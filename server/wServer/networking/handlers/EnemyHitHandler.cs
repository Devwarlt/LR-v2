#region

using wServer.networking.cliPackets;
using wServer.realm;
using wServer.realm.entities;

#endregion

namespace wServer.networking.handlers
{
    internal class EnemyHitHandler : PacketHandlerBase<EnemyHitPacket>
    {
        public override PacketID ID
        {
            get { return PacketID.ENEMYHIT; }
        }

        protected override void HandlePacket(Client client, EnemyHitPacket packet)
        {
            var realmtime = new RealmTime();
            if (client.Player.Owner == null) return;
            Entity entity = client.Player.Owner.GetEntity(packet.TargetId);
            if (entity != null)
            {
                Projectile prj = (client.Player as IProjectileOwner).Projectiles[packet.BulletId];
                if (prj != null)
                    prj.ForceHit(entity, realmtime);
            }
        }
    }
}