var express = require('express');
var mysql = require('mysql');
var router = express.Router();

var pool = mysql.createPool({
  connectionLimit: 3,
  host: 'localhost',
  user: 'root',
  database: 'hw3',
  password: 'mkmk'
});


/* GET home page. */
router.get('/', function(req, res, next) {
pool.getConnection(function (err, connection) {
	
connection.query('SELECT * From log ',function(err,rows){
      if (err) throw err;

      if(rows.length!= 0)
       {
        for(var i=0; i<rows.length; i++ )
        {
          console.log(rows[i]);
        }

	  }
      else
       console.log("없음");

    });
});

});

router.post('/log',function(req,res,next){

var log_data=req.body;
console.log(log_data);

pool.getConnection(function (err, connection) {
 connection.query('INSERT INTO log VALUES(?,?,?)' ,[req.body.date,req.body.latitude,req.body.longitude],function(err,rows) {
                if (err) throw err;
              });

});
});

router.post('/all_log',function(req,res,next)
{
 var all_log_data='';
 pool.getConnection(function (err, connection) {
 connection.query('SELECT * FROM log',function(err,rows) {
                if (err) throw err;
		
		 if(rows.length!= 0)
                {
		for(var i=0; i<rows.length; i++ )
		  all_log_data+=rows[i];
		}
		else
		console.log('없음!');
		 

              });

});
res.end(all_log_data);
});

router.post('/latest_log',function(req,res,next)
{
 var resObj={latitude:'',longitude:'' };
 pool.getConnection(function (err, connection) {
connection.query('SELECT * FROM log',function(err,rows) {
                if (err) throw err;

                 if(rows.length!= 0)
                {
                  resObj.latitude=rows[rows.length-1].latitude;
		  resObj.longitude=rows[rows.length-1].longitude;
                  res.end(JSON.stringify(resObj));
		}
                else
                console.log('없음!');
 
              });
});
});



module.exports = router;
