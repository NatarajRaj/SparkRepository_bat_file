@echo off

REM Set environment variables
set SPARK_HOME=C:\spark\spark-3.5.3-bin-hadoop3
set KAFKA_HOME=C:\kafka_2.13-3.7.0
set JAR_PATH=C:\Users\system14\IdeaProjects\KafkaConsumerApplication\target\KafkaConsumerApplication-1.0-SNAPSHOT.jar
set JAVA_HOME=C:\Java\jdk11
set PATH=%JAVA_HOME%\bin;%SPARK_HOME%\bin;%KAFKA_HOME%\bin;%PATH%

REM Kafka parameters
set KAFKA_BROKER=localhost:9092
set CONSUMER_GROUP=my_consumer_group2
set TOPIC=spark_streaming_data1

REM Debugging paths and variables
echo JAVA_HOME=%JAVA_HOME%
echo SPARK_HOME=%SPARK_HOME%
echo KAFKA_HOME=%KAFKA_HOME%
echo JAR_PATH=%JAR_PATH%
echo KAFKA_BROKER=%KAFKA_BROKER%
echo CONSUMER_GROUP=%CONSUMER_GROUP%
echo TOPIC=%TOPIC%

REM Run the Kafka Consumer Application
"%SPARK_HOME%\bin\spark-submit" ^
  --class org.example.KafkaConsumerData ^
  --master local[2] ^
  --driver-memory 8g ^
  --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.0 ^
  "%JAR_PATH%" ^
  "%KAFKA_BROKER%" ^
  "%CONSUMER_GROUP%" ^
  "%TOPIC%"

pause
