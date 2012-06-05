<html>
<head>
<title>Couch Potato</title>
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
	border: 4px solid #83a2c2;
	-moz-border-radius: 20px;
    -webkit-border-radius: 20px;
    -khtml-border-radius: 20px;
    border-radius: 20px;
    margin: 20px 20px 0px 20px;
    behavior: url(/img/border-radius.htc);
    text-align: center;
    height:200px;
}

.button {
	border: 4px solid #83a2c2;
	-moz-border-radius: 20px;
    -webkit-border-radius: 20px;
    -khtml-border-radius: 20px;
	width: 232px;
	margin: 0px 20px 0px 20px;
	padding: 10px;
    background-color:#344e6c;
	-moz-border-radius: 20px;
    -webkit-border-radius: 20px;
    -khtml-border-radius: 20px;
    border-radius: 20px;
    behavior: url(/img/border-radius.htc);
    text-align: center;
    color: white;
    font-size: 24px;
    font-weight: bold;
    font-family: sans-serif;
}

.round:hover{
	background-color: #83a2c2;
	border: 4px solid white;
}

.button:hover{
	background-color: #83a2c2;
	border: 4px solid white;
}

h1 {
	margin: 0px 20px 0px 20px;
	border-bottom: 4px solid #83a2c2;
	border-right: 4px solid #83a2c2;
	border-left: 4px solid #83a2c2;
	color: white;
	text-align: center;
	background-color:#344e6c;
	-moz-border-radius: 0px 0px 200px 200px;
    -webkit-border-radius:0px 0px 200px 200px;
    -khtml-border-radius: 0px 0px 200px 200px;
    border-radius: 0px 0px 200px 200px;
    behavior: url(/img/border-radius.htc);
    font-family: sans-serif;
}

h2 {
	top: -55px;
	margin-bottom: -25px;
	position: relative;
	text-align: center;
	color: white;
	font-family: sans-serif;
}
</style>
<body style="background-color: black">
<script>
$(document).ready(function(){
	var movies = <%@ include file="data/movies.json"%>
	for(var i=0;i<20;i++)
		if(movies[i].src)
			$("#carousel1").append('<img class = "cloudcarousel" alt="'+movies[i].director+'" title="'+movies[i].title+'" src="'+movies[i].src+'" width="100px" height="133px"/>');
	
	for(var i=10;i<movies.length;i++)
		if(movies[i].src)
			$("#carousel2").append('<img class = "cloudcarousel" alt="'+movies[i].director+'" title="'+movies[i].title+'" src="'+movies[i].src+'" width="100px" height="133px"/>');
	
    $("#carousel1").CloudCarousel(
        {
        	autoRotate: 'left',
        	autoRotateDelay: 4000,
        	speed: .05,
        	xRadius: 480,
        	yRadius: 20,
            xPos: 449,
            yPos: 2,
            reflHeight: 40,
            minScale: .25,
            mouseWheel: true           
        }
    );
    
    $("#carousel2").CloudCarousel(
        {
        	autoRotate: 'left',
        	autoRotateDelay: 4000,
        	speed: .05,
        	xRadius: 480,
        	yRadius: 25,
            xPos: 449,
            yPos: 2,
            minScale: .25,
            reflHeight: 40,
            mouseWheel: true           
        }
    );
});
</script>
<form name="main" method="post" action="movies.jsp">
<div id="content">
<h1>Couch Potato</h1> 
<div id = "carousel1" class="round" onClick="document.main.submit();">
</div>
<h2>My Movies</h2>
<div id = "carousel2" class="round" style="margin-top: 0px" onClick="movies.jsp">
</div>
<h2>Recommendations</h2>
<table align="center">
	<tr>
		<td><div class="button">Friends</div></td>
		<td><div class="button">1 Request</div></td>
		<td><div class="button">Settings</div></td>
	</tr>
</table>
</div>
</form>
</body>
</html>