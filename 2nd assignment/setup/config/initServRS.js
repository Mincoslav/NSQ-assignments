config = {
    _id: "set1",
    configsvr: true,
    members: [
      { _id : 0, host : "localhost:27017" },
      { _id : 1, host : "localhost:27117" },
      { _id : 2, host : "localhost:27217" }
    ]
  }

rs.initiate(config)
rs.status()