<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style>

table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}

.oikealle{
	text-align: right;
}
</style>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th>Tunniste</th>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Email</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="tunniste" id="tunniste"></td>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td> 
				<td><input type="text" name="email" id="email"></td> 
				<td><input type="submit" id="tallenna" value="Hyväksy"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="vanhatunniste" id="vanhatunniste">	
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaamyynnit.jsp";
	});
	//Haetaan muutettavan auton tiedot. Kutsutaan backin GET-metodia ja välitetään kutsun mukana muutettavan tiedon id
	//GET /autot/haeyksi/rekno
	var tunniste = requestURLParam("tunniste"); //Funktio löytyy scripts/main.js 	
	$.ajax({url:"myynnit/haeyksi/"+tunniste, type:"GET", dataType:"json", success:function(result){	
		$("#vanhatunniste").val(result.tunniste);		
		$("#tunniste").val(result.tunniste);	
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#email").val(result.email);
    }});
	
	$("#tiedot").validate({						
		rules: {
			tunniste:  {
				required: true,
				minlength: 1				
			},	
			etunimi:  {
				required: true,
				minlength: 2				
			},
			sukunimi:  {
				required: true,
				minlength: 2
			},	
			puhelin:  {
				required: true,
				number: true,
				minlength: 4,
				maxlength: 9,
				
			},
			email:  {
				required: true,
				minlength: 2
			}
		},
		messages: {
			tunniste: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt"			
			},
			etunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puhelin: {
				required: "Puuttuu",
				number: "Ei kelpaa",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä",
				
			},
			email: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
		},			
		submitHandler: function(form) {	
			paivitaTiedot();
		}		
	}); 	
});
//funktio tietojen päivittämistä varten. Kutsutaan backin PUT-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä.
//PUT /autot/
function paivitaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"myynnit", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan päivittäminen epäonnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan päivittäminen onnistui.");
      	$("#tunniste", "#etunimi", "#sukunimi", "#puhelin", "#email").val("");
	  }
  }});	
}
</script>
</html>