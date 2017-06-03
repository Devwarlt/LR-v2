namespace wServer.realm.worlds
{
    public class Beachzone : World
    {
        public Beachzone()
        {
            Name = "Beachzone";
            ClientWorldName = "Beachzone";
            Background = 0;
            Difficulty = 0;
            ShowDisplays = true;
            AllowTeleport = false;
            SetMusic("beachzone");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.beachzone.wmap", MapType.Wmap);
        }
    }
}
