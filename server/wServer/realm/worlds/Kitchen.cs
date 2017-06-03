namespace wServer.realm.worlds
{
    public class Kitchen : World
    {
        public Kitchen()
        {
            Name = "Kitchen";
            ClientWorldName = "Kitchen";
            Background = 0;
            Dungeon = true;
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.kitchen.wmap", MapType.Wmap);
        }
    }
}