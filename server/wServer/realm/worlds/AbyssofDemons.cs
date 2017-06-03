#region

using System.Threading;
using System.Threading.Tasks;
using DungeonGenerator;
using DungeonGenerator.Templates.Abyss;
using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class AbyssofDemons : World
    {
        public AbyssofDemons()
        {
            Name = "Abyss of Demons";
            ClientWorldName = "Abyss of Demons";
            Dungeon = true;
            Background = 0;
            AllowTeleport = true;
            SetMusic("abyss");
        }

        public override bool NeedsPortalKey => true;

        protected override void Init()
        {
            LoadMap(GeneratorCache.NextAbyss(Seed));
        }

        public override World GetInstance(Client psr) => Manager.AddWorld(new AbyssofDemons());
    }
}