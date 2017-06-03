#region

using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class Ivory : World
    {
        public Ivory()
        {
            Name = "The Ivory Wyvern";
            ClientWorldName = "The Ivory Wyvern";
            Background = 0;
            Difficulty = 5;
            AllowTeleport = true;
            SetMusic("lairofdraconis");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.ivory.jm", MapType.Json);
        }

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new Ivory());
        }
    }
}