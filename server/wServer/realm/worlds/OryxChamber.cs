#region

using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class OryxChamber : World
    {
        public OryxChamber()
        {
            Name = "Oryx's Chamber";
            ClientWorldName = "Oryx's Chamber";
            Background = 0;
            Dungeon = true;
            AllowTeleport = false;
            SetMusic("oryxchamber");
        }

        public override bool NeedsPortalKey => true;

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.OryxChamberMap.jm", MapType.Json);
        }

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new OryxChamber());
        }
    }
}