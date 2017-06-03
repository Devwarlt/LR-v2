#region

using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class UndeadLair : World
    {
        public UndeadLair()
        {
            Name = "Undead Lair";
            ClientWorldName = "Undead Lair";
            Dungeon = true;
            Background = 3;
            AllowTeleport = true;
            SetMusic("undeadlair");
        }

        public override bool NeedsPortalKey => true;

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.UDL2.wmap", MapType.Wmap);
        }

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new UndeadLair());
        }
    }
}