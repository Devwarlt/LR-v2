#region

using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class CDepths : World
    {
        public CDepths()
        {
            Name = "The Crawling Depths";
            ClientWorldName = "The Crawling Depths";
            Background = 0;
            Dungeon = true;
            Difficulty = 5;
            AllowTeleport = true;
            SetMusic("crawlingdepths");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.crawling.wmap", MapType.Wmap);
        }

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new CDepths());
        }
    }
}