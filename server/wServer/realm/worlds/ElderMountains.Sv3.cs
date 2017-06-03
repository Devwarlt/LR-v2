namespace wServer.realm.worlds
{
    public class ElderMountainsSv3 : World
    {
        public ElderMountainsSv3()
        {
            Id = ELDER_MONTAINS_SV3;
            Name = "Elder Mountains (Server 3)";
            ClientWorldName = "Elder Mountains (Server 3)";
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