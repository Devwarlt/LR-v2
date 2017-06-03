namespace wServer.realm.worlds
{
    public class CandylandHuntingGrounds : World
    {
        public const string NEW_CANDYLAND = "wServer.realm.worlds.maps.loecland.jm";

        public CandylandHuntingGrounds()
        {
            Name = "Candyland Hunting Grounds";
            ClientWorldName = "Candyland Hunting Grounds";
            Background = 0;
            Difficulty = 3;
            AllowTeleport = true;
            Dungeon = true;
            SetMusic("candyland");
        }

        protected override void Init()
        {
            LoadMap(NEW_CANDYLAND, MapType.Json);
        }
    }
}
