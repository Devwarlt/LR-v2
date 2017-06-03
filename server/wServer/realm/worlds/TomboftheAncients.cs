namespace wServer.realm.worlds
{
    public class TomboftheAncients : World
    {
        public TomboftheAncients()
        {
            Name = "Tomb of the Ancients";
            ClientWorldName = "Tomb of the Ancients";
            Dungeon = true;
            Background = 0;
            Difficulty = 5;
            AllowTeleport = true;
            SetMusic("tombs");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.tomb.wmap", MapType.Wmap);
        }
    }
}