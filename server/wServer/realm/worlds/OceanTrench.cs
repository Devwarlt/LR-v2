#region

using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class OceanTrench : World
    {
        public OceanTrench()
        {
            Name = "Ocean Trench";
            ClientWorldName = "Ocean Trench";
            Dungeon = true;
            Background = 0;
            AllowTeleport = true;
            SetMusic("oceantrench");
        }

        protected override void Init()
        {
            // was oceantrench.wmap
            LoadMap("wServer.realm.worlds.maps.newot.jm", MapType.Json);
        }

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new OceanTrench());
        }
    }
}