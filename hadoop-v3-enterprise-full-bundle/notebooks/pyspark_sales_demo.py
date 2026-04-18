from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("SalesDemo").getOrCreate()
df = spark.read.option("header", True).csv("/datasets/sales.csv", inferSchema=True)
df.groupBy("region").sum("total").show()
spark.stop()
