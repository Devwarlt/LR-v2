namespace wServer.realm.worlds
{
    public class ElderMountainsSv1 : World
    {
        public ElderMountainsSv1()
        {
            Id = ELDER_MONTAINS_SV1;
            Name = "Elder Mountains (Server 1)";
            ClientWorldName = "Elder Mountains (Server 1)";
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