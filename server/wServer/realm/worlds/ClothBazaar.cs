namespace wServer.realm.worlds
{
    public class ClothBazaar : World
    {
        public ClothBazaar()
        {
            Id = MARKET;
            Name = "Cloth Bazaar";
            ClientWorldName = "Cloth Bazaar";
            Background = 2;
            AllowTeleport = false;
            Difficulty = 0;
            SetMusic("cloothbazaar");
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.bazzar.wmap", MapType.Wmap);
        }
    }
}