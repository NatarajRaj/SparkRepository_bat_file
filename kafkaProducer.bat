@echo off

REM Set environment variables for Hadoop, Spark, and Kafka
set SPARK_HOME=C:\spark\spark-3.5.3-bin-hadoop3
set KAFKA_HOME=C:\kafka_2.13-3.7.0
set JAR_PATH=C:\Users\system14\IdeaProjects\SparkKafkaDBDataProcessing1\target\SparkKafkaDBDataProcessing1-1.0-SNAPSHOT.jar

REM Set default Kafka parameters
set PSQL_USER=postgres
set PSQL_PASSWORD=postgres
set KAFKA_BROKER=localhost:9092
set TOPIC=spark_streaming_data1

REM Set the local directory for Spark
set SPARK_LOCAL_DIR=C:\tmp\spark-checkpoints

REM Check if custom arguments are passed and override defaults if necessary
if "%1" NEQ "" set PSQL_USER=%1
if "%2" NEQ "" set PSQL_PASSWORD=%2
if "%3" NEQ "" set KAFKA_BROKER=%3
if "%4" NEQ "" set TOPIC=%4

REM Hadoop Configuration
set HADOOP_HOME=C:\hadoop
set HADOOP_NATIVE_LIBS=%HADOOP_HOME%\lib\native

REM Ensure JAVA_HOME is set correctly
set "JAVA_HOME=C:\Java\jdk11"
set "PATH=%JAVA_HOME%\bin;%SPARK_HOME%\bin;%KAFKA_HOME%\bin;%PATH%"

REM Debugging paths and variables
echo JAVA_HOME=%JAVA_HOME%
echo SPARK_HOME=%SPARK_HOME%
echo KAFKA_HOME=%KAFKA_HOME%
echo JAR_PATH=%JAR_PATH%
echo KAFKA_BROKER=%KAFKA_BROKER%
echo TOPIC=%TOPIC%
echo HADOOP_HOME=%HADOOP_HOME%
echo HADOOP_NATIVE_LIBS=%HADOOP_NATIVE_LIBS%

REM Wait a few seconds for Kafka producer to be ready before starting consumer
timeout /t 5

REM Run the Kafka Consumer Application with Spark-submit
echo Starting Spark Kafka Producer Application...

"%SPARK_HOME%\bin\spark-submit" ^
  --class org.example.KafkaProducerStreamDBData1 ^
  --master local[2] ^
  --conf spark.sql.streaming.checkpointLocation=%SPARK_LOCAL_DIR% ^
  --conf spark.hadoop.fs.native.io.disabled=true ^
  --conf spark.local.dir=%SPARK_LOCAL_DIR% ^
  --conf "spark.driver.extraClassPath=C:\Users\system14\.m2\repository\org\postgresql\postgresql\42.3.9\postgresql-42.3.9.jar" ^
  --conf "spark.executor.extraClassPath=C:\Users\system14\.m2\repository\org\postgresql\postgresql\42.3.9\postgresql-42.3.9.jar" ^
  --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.3 ^
  --jars "C:\Users\system14\.m2\repository\org\postgresql\postgresql\42.3.9\postgresql-42.3.9.jar" ^
  --verbose ^
  "%JAR_PATH%" ^
  "%PSQL_USER%" ^
  "%PSQL_PASSWORD%" ^
  "%KAFKA_BROKER%" ^
  "%TOPIC%"

pause
