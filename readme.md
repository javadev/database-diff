Create new connection:

```
    private DatabaseProvider newDatabaseProvider(String string, Properties properties) {
        DatabaseProvider databaseProvider = new DatabaseProvider(string, properties);
        StorageWrapper storageWrapper = this.getWrapper();
        databaseProvider.setReferenceWorker(storageWrapper.getReferenceWorker());
        return databaseProvider;
    }

    public void addConnection(String string, Properties properties) throws ConnectionException {
        long l = System.currentTimeMillis();
        DatabaseProvider databaseProvider = this.newDatabaseProvider(string, properties);
        try {
            PerformanceLogger performanceLogger = PerformanceLogger.get();
            performanceLogger.startTiming("DatabaseConnections.addConnection");
            this.getWrapper().getDatabaseStorage().addConnection(string, (Referenceable)databaseProvider);
            performanceLogger.stopTiming("DatabaseConnections.addConnection", "bind of new connection to Storage", 500);
            this.fireConnectionAdded(new ConnectionsEvent(string, (Referenceable)databaseProvider));
        }
        catch (NameExistsException nameExistsException) {
            throw new ConnectionException(ConnBundle.format("DB_CONN_EXISTS", string));
        }
        catch (StorageException storageException) {
            throw new ConnectionException(ConnBundle.format("DB_CONN_CREATE_ERR", string, this.getMessage(storageException)), storageException);
        }
        this.logTiming("Total time for addConnection", l, new Object[0]);
    }
```
