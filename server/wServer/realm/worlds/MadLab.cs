namespace wServer.realm.worlds
{
    public class MadLab : World
    {
        public MadLab()
        {
            Name = "Mad Lab";
            ClientWorldName = "Mad Lab";
            Background = 0;
            Dungeon = true;
            Difficulty = 5;
            AllowTeleport = true;
            SetMusic("madlab");
        }

        protected override void Init()
        {
            LoadMap(GeneratorCache.NextLab(Seed));
        }
    }
}
