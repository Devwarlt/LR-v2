namespace wServer.realm.worlds
{
    public class ElderMountains : World
    {
        public ElderMountains()
        {
            Id = ELDER_MONTAINS;
            Name = "Elder Mountains Beholder";
            ClientWorldName = "Elder Mountains Beholder";
            Background = 0;
            AllowTeleport = true;
            Dungeon = true;
            Difficulty = 0;
            SetMusic("winecellar");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.eldermountains.jm", MapType.Json);
        }
    }
}