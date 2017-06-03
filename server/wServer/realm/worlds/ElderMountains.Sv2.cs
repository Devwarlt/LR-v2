namespace wServer.realm.worlds
{
    public class ElderMountainsSv2 : World
    {
        public ElderMountainsSv2()
        {
            Id = ELDER_MONTAINS_SV2;
            Name = "Elder Mountains (Server 2)";
            ClientWorldName = "Elder Mountains (Server 2)";
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