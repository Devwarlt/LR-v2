#region

using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class LairofShaitan : World
    {
        public LairofShaitan()
        {
            Name = "Lair of Shaitan";
            ClientWorldName = "Lair of Shaitan";
            Background = 0;
            Difficulty = 5;
            AllowTeleport = true;
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.shaitan.jm", MapType.Json);
        }

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new LairofShaitan());
        }
    }
}