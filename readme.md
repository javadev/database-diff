Create new connection:

```java
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

```java
ExtractListModel model = new ExtractListModel();
model.setSourceConnName(sourceConnection.getText());
```

```
Exception in thread "AWT-EventQueue-0" java.lang.ExceptionInInitializerError
        at oracle.jdevimpl.db.adapter.StorageWrapper.getDefaultWrapper(StorageWrapper.java:69)
        at oracle.jdeveloper.db.DatabaseConnections.getWrapper(DatabaseConnections.java:114)
        at oracle.jdeveloper.db.DatabaseConnections.listConnectionsImpl(DatabaseConnections.java:393)
        at oracle.jdeveloper.db.DatabaseConnections.listConnections(DatabaseConnections.java:382)
        at oracle.dbtools.raptor.utils.Connections$Store.<init>(Connections.java:486)
        at oracle.dbtools.raptor.utils.Connections.registerConnectionStore(Connections.java:1900)
        at oracle.dbtools.raptor.utils.Connections.getStores(Connections.java:1294)
        at oracle.dbtools.raptor.utils.Connections.getStore(Connections.java:1325)
        at oracle.dbtools.raptor.utils.Connections.findConnectionInfo(Connections.java:1100)
        at oracle.dbtools.raptor.utils.Connections.isOracle(Connections.java:1725)
        at oracle.dbtools.raptor.extract.models.ExtractListModel.setSourceConnectionProperties(ExtractListModel.java:2038)
        at oracle.dbtools.raptor.extract.models.ExtractListModel.setSourceConnName(ExtractListModel.java:348)
        at com.mycompany.databasediff.DatabaseDiff.runDiffButtonActionPerformed(DatabaseDiff.java:259)
```

