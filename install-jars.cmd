start /wait mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=lib/oracle.sqldeveloper.jar -DgroupId=com.oracle -DartifactId=sqldeveloper -Dversion=1.0 -Dpackaging=jar -DgeneratePom=true
start /wait mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=lib/dbapi.jar -DgroupId=com.oracle -DartifactId=dbapi -Dversion=1.0 -Dpackaging=jar -DgeneratePom=true


