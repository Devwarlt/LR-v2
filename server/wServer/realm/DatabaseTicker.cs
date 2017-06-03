using db;
using log4net;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace wServer.realm
{
    public class DatabaseTicker
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(DatabaseTicker));

        private readonly DatabaseCollection databases;

        public DatabaseTicker()
        {
            databases = new DatabaseCollection();
        }

        public Task DoActionAsync(Action<Database> callback)
        {
            return Task.Factory.StartNew(() =>
            {
                var db = databases.GetAvailableDatabase();
                try
                {
                    callback(db);
                }
                catch (Exception ex)
                {
                    log.Error(ex);
                }
                finally
                {
                    databases.FreeDatabase(db);
                }
            });
        }

        public class DatabaseCollection
        {
            private object requestLock;
            private Dictionary<Database, bool> databases;

            public DatabaseCollection()
            {
                requestLock = new object();
                databases = new Dictionary<Database, bool>();
            }

            public Database GetAvailableDatabase()
            {
                lock (requestLock)
                {
                    var db = getDatabase() ?? new Database();
                    if (!databases.ContainsKey(db))
                        databases.Add(db, false);
                    else
                        databases[db] = false;
                    return db;
                }
            }

            public void FreeDatabase(Database db)
            {
                lock (requestLock)
                {
                    databases[db] = true;
                }
            }

            private Database getDatabase() => databases.Where(_ => _.Value && _.Key.Connection.State == System.Data.ConnectionState.Open).Select(_ => _.Key).FirstOrDefault();
        }
    }
}