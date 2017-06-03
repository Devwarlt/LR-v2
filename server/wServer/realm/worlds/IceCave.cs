namespace wServer.realm.worlds
{
    public class IceCave : World
    {
        public IceCave()
        {
            Name = "Ice Cave";
            ClientWorldName = "Ice Cave";
            Background = 0;
            Difficulty = 5;
            Dungeon = true;
            ShowDisplays = true;
            AllowTeleport = true;
            SetMusic("icecave");
        }

        public override bool NeedsPortalKey => true;

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.icecave.wmap", MapType.Wmap);
        }
    }
}
