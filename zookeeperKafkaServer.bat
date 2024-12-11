@echo off

echo Starting Zookeeper...
start cmd /k "C:\kafka_2.13-3.7.0\bin\windows\zookeeper-server-start.bat C:\kafka_2.13-3.7.0\config\zookeeper.properties"
timeout 10

echo Starting Kafka Broker...
start cmd /k "C:\kafka_2.13-3.7.0\bin\windows\kafka-server-start.bat C:\kafka_2.13-3.7.0\config\server.properties"
timeout 10



echo Starting Kafka Consumer...
start cmd /k "C:\Users\system14\Documents\SparkApplication\SparkKafkaStreamingDB\kafkaConsumer.bat"   @echo off

:: Optionally start the Kafka Producer and Consumer
echo Starting Kafka Producer...
start cmd /k "C:\Users\system14\Documents\SparkApplication\SparkKafkaStreamingDB\kafkaProducer.bat"