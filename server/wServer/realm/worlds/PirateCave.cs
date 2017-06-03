namespace wServer.realm.worlds
{
    public class PirateCave : World
    {
        public PirateCave()
        {
            Name = "Pirate Cave";
            ClientWorldName = "Pirate Cave";
            Background = 0;
            Dungeon = true;
            Difficulty = 1;
            AllowTeleport = true;
            SetMusic("piratecave");
        }

        protected override void Init()
        {
            LoadMap(GeneratorCache.NextPirateCave(Seed));
        }
    }
}
