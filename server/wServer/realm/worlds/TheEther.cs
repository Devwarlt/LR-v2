namespace wServer.realm.worlds
{
    public class TheEther : World
    {
        public TheEther()
        {
            Name = "The Ether";
            ClientWorldName = "The Ether";
            Background = 0;
            Difficulty = 5;
            ShowDisplays = true;
            AllowTeleport = false;
            Dungeon = true;
            SetMusic("ether");
        }

        public override bool NeedsPortalKey => true;

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.ether.jm", MapType.Json);
        }
    }
}
