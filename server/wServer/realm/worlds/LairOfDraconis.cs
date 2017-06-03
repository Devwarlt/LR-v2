#region

using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class LairofDraconis : World
    {
        public LairofDraconis()
        {
            Name = "Lair of Draconis";
            ClientWorldName = "Lair of Draconis";
            Background = 0;
            Difficulty = 5;
            AllowTeleport = false;
            SetMusic("lairofdraconis");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.LoD.jm", MapType.Json);
        }

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new LairofDraconis());
        }
    }
}