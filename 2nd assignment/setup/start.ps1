
mongod --port 27017 --config config/configServ1.cfg --dbpath config/data1 
mongod --port 27117 --config config/configServ2.cfg --dbpath config/data2
mongod --port 27217 --config config/configServ3.cfg --dbpath config/data3

mongosh --host localhost --port 27017
# in mongo shell 
rs.initiate(
    {
      _id: "set1",
      configsvr: true,
      members: [
        { _id : 0, host : "localhost:27017" },
        { _id : 1, host : "localhost:27117" },
        { _id : 2, host : "localhost:27217" }
      ]
    }
  )


mongod --port 27016 --config SH1/config1.cfg --dbpath SH1/data1 
mongod --port 27116 --config SH1/config2.cfg --dbpath SH1/data2
mongod --port 27216 --config SH1/config3.cfg --dbpath SH1/data3

mongosh --host localhost --port 27016
# in mongo shell
rs.initiate(
    {
      _id: "set2",
      members: [
        { _id : 0, host : "localhost:27016" },
        { _id : 1, host : "localhost:27116" },
        { _id : 2, host : "localhost:27216" }
      ]
    }
  )

  mongos --port 27015 --config mongosConfig.cfg

  mongosh --host localhost --port 27015
# in mongo shell
# NOTE the configuration replica set can not be added as shard since it is configuration server. (It is already specified in mongos config file)
sh.addShard( "set2/localhost:27016,localhost:27116,localhost:27216")

