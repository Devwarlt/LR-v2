#region

using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class Tutorial : World
    {
        private readonly bool isLimbo;

        public Tutorial(bool isLimbo)
        {
            Id = TUT_ID;
            Name = "Tutorial";
            ClientWorldName = "Tutorial";
            Background = 0;
            Dungeon = true;
            this.isLimbo = isLimbo;
        }

        protected override void Init()
        {
            if (!(IsLimbo = isLimbo))
            {
                LoadMap("wServer.realm.worlds.maps.tutorial.wmap", MapType.Wmap);
            }
        }

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new Tutorial(false));
        }
    }
}