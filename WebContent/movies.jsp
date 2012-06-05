<html>
<head>
<title>Couch Potato Movies</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.pack.js"></script>
<script type="text/JavaScript" src="scripts/cloud-carousel.1.0.5.js"></script>
<script type="text/JavaScript" src="scripts/jquery.mousewheel.js"></script>
</head>
<style type="text/css">
#content {
	border: 4px solid #83a2c2;
	-moz-border-radius: 20px;
    -webkit-border-radius: 20px;
    -khtml-border-radius: 20px;
    border-radius: 20px;
	background-color: #203042;
	width: 950px;
	height: 600px;
}

.round {
	margin: 0px -4px 0px -4px;
	border-bottom: 4px solid #83a2c2;
	border-right: 4px solid #83a2c2;
	border-left: 4px solid #83a2c2;
	-moz-border-radius: 0px 0px 50px 50px;
    -webkit-border-radius:0px 0px 50px 50px;
    -khtml-border-radius: 0px 0px 50px 50px;
    border-radius: 0px 0px 50px 50px;
    behavior: url(/img/border-radius.htc);
    float: top;
    behavior: url(/img/border-radius.htc);
    text-align: center;
    height:160px;
}

.button {
	border: 4px solid #83a2c2;
	-moz-border-radius: 20px;
    -webkit-border-radius: 20px;
    -khtml-border-radius: 0px 0px 20px 20px;
	width: 232px;
	margin: 0px 20px 0px 20px;
    background-color:#344e6c;
	-moz-border-radius: 20px;
    -webkit-border-radius: 20px;
    -khtml-border-radius: 20px;
    border-radius: 20px;
    behavior: url(/img/border-radius.htc);
    text-align: center;
    color: white;
    font-size: 20px;
    font-weight: bold;
    font-family: sans-serif;
}

.button:hover{
	background-color: #83a2c2;
	border: 4px solid white;
}

.sortBar {
	height: 40px;
	padding: 8px 50px 0px 50px;
	color: white;
	text-align: center;
	background-color:#344e6c;
	margin: 0px 20px 0px 20px;
	border-bottom: 4px solid #83a2c2;
	border-right: 4px solid #83a2c2;
	border-left: 4px solid #83a2c2;
	-moz-border-radius: 0px 0px 200px 200px;
    -webkit-border-radius:0px 0px 200px 200px;
    -khtml-border-radius: 0px 0px 200px 200px;
    border-radius: 0px 0px 200px 200px;
    behavior: url(/img/border-radius.htc);
    font-family: sans-serif;
}

h2 {
	margin-top:-10px;
	margin-bottom: -20px;
	text-align: center;
	color: white;
	font-family: sans-serif;
}

h3 {
	margin-top: 15px;
	margin-bottom: -5px;
	text-align: center;
	color: white;
	font-family: sans-serif;
}
</style>
<body style="background-color: black" align="CENTER">
<script>
$(document).ready(function(){
	var movies = <%@ include file="data/movies.json"%>
	for(var i in movies)
		if(movies[i].src)
			$("#carousel1").append('<img class = "cloudcarousel" alt="'+movies[i].director+'" title="'+movies[i].title+'" src="'+movies[i].src+'" width="100px" height="133px" onClick="showMovieInfo(this.title)"/>');
    $("#carousel1").CloudCarousel(
        {
        	xRadius: 540,
        	yRadius: 10,
            xPos: 475,
            yPos: -15,
            reflHeight: 40,
            minScale: .15,
            mouseWheel: true,
            bringToFront: true,
            altBox: $('#alt-text'),
            titleBox: $('#title-text')
        }
    );
});

function showMovieInfo(title){
	$("#movieInfoDiv").show();
	$("#movieTitle").text(title);
}
</script>
<div id="content">
<div class="sortBar" align="center">
	<div class="button" style="position:absolute; top: 20px; left:80px;">Filter</div>
	<div class="button" style="position:absolute; top: 20px; left:600px;">Sort</div>
	<div><h2 id="title-text"></h2><h3 id="alt-text"></h3></div>
</div>
<div id = "carousel1" class="round"></div>
<div id="movieInfoDiv" style="padding: 30px; color: white; font-size: 32px; font-family: sans-serif; display: none">
	<div style="float: left; padding: 0px 15px 15px 0px">
	<img id="picture" width="150px" height="200px" src="img/Avatar.jpg"/></div>
	<div style="position:absolute; top: 240px; left:600px;">
		<div class="button" onClick="alert('Watching Movie')">Watch Now</div>
		<div class="button" onClick="alert('Feature not implemented')" style="margin-top: 15px">Rate</div>
	</div>
	<b><span id="movieTitle">Avatar</span></b>
	<table style="color: white; font-size: 20px; font-family: sans-serif;">
		<tr><td>Genre:</td><td><span id="genre">Action</span></td></tr>
		<tr><td>Director: </td><td><span id="director">James Cameron</span></td></tr>
		<tr><td VALIGN="top">Starring: </td><td>Sam Worthington<br/>Zoe Saldana<br/>Sigourney Weaver</td></tr>
	</table>
	<div style="float: left; font-size: 20px; font-family: sans-serif;">A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.</div>
</div>
</div>
</body>
</html>