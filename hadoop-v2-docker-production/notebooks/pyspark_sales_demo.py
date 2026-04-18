from pyspark.sql import SparkSession

spark = (
    SparkSession.builder
    .appName("sales-demo")
    .master("spark://spark-master:7077")
    .enableHiveSupport()
    .getOrCreate()
)

df = spark.read.option("header", True).csv("hdfs://namenode:8020/input/sales.csv", inferSchema=True)
df.createOrReplaceTempView("sales")

result = spark.sql("""
    SELECT region, category, SUM(total_amount) AS revenue
    FROM sales
    GROUP BY region, category
    ORDER BY revenue DESC
""")

result.show()
spark.stop()
