<!--
  Copyright (c) 2006-2013, JGraph Ltd
  
  Hello, World! example for mxGraph. This example demonstrates using
  a DOM node to create a graph and adding vertices and edges.
-->
<% String contextPath = request.getContextPath();%>
<html>
<head>
	<title>AppConnect</title>

	<!-- Loads and initializes the library -->
	<script type="text/javascript" src="<%=contextPath%>/js/mxClient.js"></script>
	<script src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>
	<script src="<%=contextPath%>/js/jquery-ui-1.11.1.min.js"></script>
	<script src="<%=contextPath%>/js/jquery.blockUI.js"></script>
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/ui-lightness/jquery-ui.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/jgraph.css" media="screen" />

	<!-- Example code -->
	<script type="text/javascript">
	var applications = ${applicationsMessage};
	var businessProcess = ${businessProcessMessage};
	var appGroupsMessage = ${appGroupsMessage};
	var hosts = ${hostsMessage};
	var fromRows = [];
	var toRows = [];
	var applicationLobs = [];
	var investmentStrategys = [];
	var states = [];
	var applicationDevelopedBy = [];
	var cafCriticals = [];
	var technologyGroupOwners = [];
	var appNames = [];
	var appIds = [];
	var appGroupNames = ["Global Prime Brokerage"];
	var hostNames = ["pbcrl11b3"];
	var appGroups = [];
	var hostProcesses = [];
	var memoryCapacity = [], numberOfProcessors = [], serverRole = [], serverMake = [], serverBuilding = [];
	var contextPath = '<%=request.getContextPath()%>';
	$(document).ready(function() {
		var showFilter = false;
		$('#filterToggle').hide();
		$('#filterToggle').click(function() {
			showFilter = !showFilter;
			if(showFilter) {
				$('#filterToggle').animate({'float':'none','left':'20%','margin-left':'-110px'});
				$("#filter").animate({'width' : '20%'});
				$("#graphContainer").animate({'left' : '20%','width':'80%'});	
			}
			else {
				$('#filterToggle').animate({'float':'left','left':'0%','margin-left':'0px'});
				$("#filter").animate({'width' : '0%'});
				$("#graphContainer").animate({'left' : '0%','width':'100%'});	
			}
		});
		$.each(applications, function(index, application) {
			appNames.push(application.appName);
			appIds.push(application.applicationId);
		});
		
		hosts.sort(function(a,b) {
			var a1 = a.hostName.toLowerCase(), b1 = b.hostName.toLowerCase();
			if (a1<b1) return -1;
			if (a1>b1) return 1;
			return 0;
		});
		
		$("#filter").on('mouseenter','p .envgroup-filter,p .applicationLob-filter,p .investmentStrategys-filter,p .states-filter,p .applicationDevelopedBy-filter,p .cafCritical-filter,p .technologyGroupOwners-filter,p .environment-filter,p .memoryCapacity-filter,p .numberOfProcessors-filter,p .serverRole-filter, p .serverMake-filter,p .serverBuilding-filter',function() {
			$(this).addClass("ui-state-hover");
		});
		
		$("#filter").on('mouseleave','p .envgroup-filter,p .applicationLob-filter,p .investmentStrategys-filter,p .states-filter,p .applicationDevelopedBy-filter,p .cafCritical-filter,p .technologyGroupOwners-filter,p .environment-filter,p .memoryCapacity-filter,p .numberOfProcessors-filter,p .serverRole-filter, p .serverMake-filter,p .serverBuilding-filter',function() {
			$(this).removeClass("ui-state-hover");
		});
		
		$('#filterToggle').hover(function() {
			$(this).addClass('hover');
		});
			
		$('#filter').delegate('p .envgroup-filter','click',function() {
			if($('#envgroup').hasClass('ui-icon-circle-plus')) {
				$('#envgroup').removeClass('ui-icon-circle-plus');
				$('#envgroup').addClass('ui-icon-circle-minus');
				var appGroupName = $('#search').val();
				var appGroupId = '';
				$.each(appGroupsMessage, function(i, appGroup) {
					if(appGroup.appGroupName == appGroupName) {
						appGroupId = appGroup.appGroupId;
					}
				});
				var dataVal = {
						'appGroupId':appGroupId
				};
				$.ajax({
					url:contextPath+"/app/users/getEnvGroupFilter",
					type:"GET",
					data: dataVal,
					success:function(data) {
						var json = $.parseJSON(data);
						$.each(json.envgroups, function(i, envgroup) {
							$('#envgroup-options').append('<li id="example"><a href="#" id="filterOptions">'+envgroup.envGroupName+'</a></li>');
						});
					},
					error:function(msg) {
						alert("ERROR: " + msg);
					}
				});
			}
			else {
				$('#envgroup').removeClass('ui-icon-circle-minus');
				$('#envgroup').addClass('ui-icon-circle-plus');
				$('#envgroup-options > li').remove();
			}
		});
		
		$('#filter').delegate('p .environment-filter','click',function() {
			if($('#environment').hasClass('ui-icon-circle-plus')) {
				$('#environment').removeClass('ui-icon-circle-plus');
				$('#environment').addClass('ui-icon-circle-minus');
				var applicationId = $('#search').val();
				var dataVal = {
						'applicationId':applicationId
				};
				$.ajax({
					url:contextPath+"/app/users/getEnvFilter",
					type:"GET",
					data: dataVal,
					success:function(data) {
						var json = $.parseJSON(data);
						$.each(json.environments, function(i, environment) {
							$('#environment-options').append('<li id="example"><a href="#" id="filterOptions">'+environment.environmentName+'</a></li>');
						});
					},
					error:function(msg) {
						alert("ERROR: " + msg);
					}
				});
			}
			else {
				$('#environment').removeClass('ui-icon-circle-minus');
				$('#environment').addClass('ui-icon-circle-plus');
				$('#environment-options > li').remove();
			}
		});
		
		$('#filter').delegate('p .applicationLob-filter','click',function() {
			var duplicates = [];
			if($('#applicationLob').hasClass('ui-icon-circle-plus')) {
				$('#applicationLob').removeClass('ui-icon-circle-plus');
				$('#applicationLob').addClass('ui-icon-circle-minus');
				for(var i = 0; i < applicationLobs.length; i++) {
					var appLob = applicationLobs[i];
					if(duplicates.indexOf(appLob) < 0) {
						$('#applicationLob-options').append('<li id="example"><a href="#" id="filterOptions">'+appLob+'</a><span></span></li>');			
						duplicates.push(appLob);
					}
				}
			}
			else {
				$('#applicationLob').removeClass('ui-icon-circle-minus');
				$('#applicationLob').addClass('ui-icon-circle-plus');
				$('#applicationLob-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .states-filter','click',function() {
			var duplicates = [];
			if($('#states').hasClass('ui-icon-circle-plus')) {
				$('#states').removeClass('ui-icon-circle-plus');
				$('#states').addClass('ui-icon-circle-minus');
				for(var i = 0; i < states.length; i++) {
					var state = states[i];
					if(duplicates.indexOf(state) < 0) {
						$('#states-options').append('<li id="example"><a href="#" id="filterOptions">'+state+'</a><span></span></li>');			
						duplicates.push(appLob);
					}
				}
			}
			else {
				$('#states').removeClass('ui-icon-circle-minus');
				$('#states').addClass('ui-icon-circle-plus');
				$('#states-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .applicationDevelopedBy-filter','click',function() {
			var duplicates = [];
			if($('#applicationDevelopedBy').hasClass('ui-icon-circle-plus')) {
				$('#applicationDevelopedBy').removeClass('ui-icon-circle-plus');
				$('#applicationDevelopedBy').addClass('ui-icon-circle-minus');
				for(var i = 0; i < applicationDevelopedBy.length; i++) {
					var appDevelopedBy = applicationDevelopedBy[i];
					if(duplicates.indexOf(state) < 0) {
						$('#applicationDevelopedBy-options').append('<li id="example"><a href="#" id="filterOptions">'+appDevelopedBy+'</a><span></span></li>');			
						duplicates.push(appLob);
					}
				}
			}
			else {
				$('#applicationDevelopedBy').removeClass('ui-icon-circle-minus');
				$('#applicationDevelopedBy').addClass('ui-icon-circle-plus');
				$('#applicationDevelopedBy-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .investmentStrategys-filter','click',function() {
			var duplicates = [];
			if($('#investmentStrategys').hasClass('ui-icon-circle-plus')) {
				$('#investmentStrategys').removeClass('ui-icon-circle-plus');
				$('#investmentStrategys').addClass('ui-icon-circle-minus');
				for(var i = 0; i < investmentStrategys.length; i++) {
					var investmentStrategy = investmentStrategys[i];
					if(duplicates.indexOf(investmentStrategy) < 0) {
						$('#investmentStrategys-options').append('<li id="example"><a href="#" id="filterOptions">'+investmentStrategy+'</a><span></span></li>');			
						duplicates.push(investmentStrategy);
					}
				}
			}
			else {
				$('#investmentStrategys').removeClass('ui-icon-circle-minus');
				$('#investmentStrategys').addClass('ui-icon-circle-plus');
				$('#investmentStrategys-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .cafCritical-filter','click',function() {
			var duplicates = [];
			if($('#cafCritical').hasClass('ui-icon-circle-plus')) {
				$('#cafCritical').removeClass('ui-icon-circle-plus');
				$('#cafCritical').addClass('ui-icon-circle-minus');
				for(var i = 0; i < cafCriticals.length; i++) {
					var cafCritical = cafCriticals[i];
					if(duplicates.indexOf(cafCritical) < 0) {
						$('#cafCritical-options').append('<li id="example"><a href="#" id="filterOptions">'+cafCritical+'</a><span></span></li>');			
						duplicates.push(cafCritical);
					}
				}
			}
			else {
				$('#cafCritical').removeClass('ui-icon-circle-minus');
				$('#cafCritical').addClass('ui-icon-circle-plus');
				$('#cafCritical-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .technologyGroupOwners-filter','click',function() {
			var duplicates = [];
			if($('#technologyGroupOwners').hasClass('ui-icon-circle-plus')) {
				$('#technologyGroupOwners').removeClass('ui-icon-circle-plus');
				$('#technologyGroupOwners').addClass('ui-icon-circle-minus');
				for(var i = 0; i < technologyGroupOwners.length; i++) {
					var technologyGroupOwner = technologyGroupOwners[i];
					if(duplicates.indexOf(technologyGroupOwner) < 0) {
						$('#technologyGroupOwners-options').append('<li id="example"><a href="#" id="filterOptions">'+technologyGroupOwner+'</a><span></span></li>');			
						duplicates.push(technologyGroupOwner);
					}
				}
			}
			else {
				$('#technologyGroupOwners').removeClass('ui-icon-circle-minus');
				$('#technologyGroupOwners').addClass('ui-icon-circle-plus');
				$('#technologyGroupOwners-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .memoryCapacity-filter','click',function() {
			var duplicates = [];
			if($('#memoryCapacityList').hasClass('ui-icon-circle-plus')) {
				$('#memoryCapacityList').removeClass('ui-icon-circle-plus');
				$('#memoryCapacityList').addClass('ui-icon-circle-minus');
				for(var i = 0; i < memoryCapacity.length; i++) {
					var memCapacity = memoryCapacity[i];
					if(duplicates.indexOf(memCapacity) < 0) {
						$('#memoryCapacity-options').append('<li id="example"><a href="#" id="filterOptions">'+memCapacity+'</a><span></span></li>');			
						duplicates.push(memCapacity);
					}
				}
			}
			else {
				$('#memoryCapacityList').removeClass('ui-icon-circle-minus');
				$('#memoryCapacityList').addClass('ui-icon-circle-plus');
				$('#memoryCapacity-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .numberOfProcessors-filter','click',function() {
			var duplicates = [];
			if($('#numberOfProcessorsList').hasClass('ui-icon-circle-plus')) {
				$('#numberOfProcessorsList').removeClass('ui-icon-circle-plus');
				$('#numberOfProcessorsList').addClass('ui-icon-circle-minus');
				for(var i = 0; i < numberOfProcessors.length; i++) {
					var numOfProcessors = numberOfProcessors[i];
					if(duplicates.indexOf(numOfProcessors) < 0) {
						$('#numberOfProcessors-options').append('<li id="example"><a href="#" id="filterOptions">'+numOfProcessors+'</a><span></span></li>');			
						duplicates.push(numOfProcessors);
					}
				}
			}
			else {
				$('#numberOfProcessorsList').removeClass('ui-icon-circle-minus');
				$('#numberOfProcessorsList').addClass('ui-icon-circle-plus');
				$('#numberOfProcessors-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .serverRole-filter','click',function() {
			var duplicates = [];
			if($('#serverRoleList').hasClass('ui-icon-circle-plus')) {
				$('#serverRoleList').removeClass('ui-icon-circle-plus');
				$('#serverRoleList').addClass('ui-icon-circle-minus');
				for(var i = 0; i < serverRole.length; i++) {
					var sRole = serverRole[i];
					if(duplicates.indexOf(sRole) < 0) {
						$('#serverRole-options').append('<li id="example"><a href="#" id="filterOptions">'+sRole+'</a><span></span></li>');			
						duplicates.push(sRole);
					}
				}
			}
			else {
				$('#serverRoleList').removeClass('ui-icon-circle-minus');
				$('#serverRoleList').addClass('ui-icon-circle-plus');
				$('#serverRole-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .serverMake-filter','click',function() {
			var duplicates = [];
			if($('#serverMakeList').hasClass('ui-icon-circle-plus')) {
				$('#serverMakeList').removeClass('ui-icon-circle-plus');
				$('#serverMakeList').addClass('ui-icon-circle-minus');
				for(var i = 0; i < serverMake.length; i++) {
					var sMake= serverMake[i];
					if(duplicates.indexOf(sMake) < 0) {
						$('#serverMake-options').append('<li id="example"><a href="#" id="filterOptions">'+sMake+'</a><span></span></li>');			
						duplicates.push(sMake);
					}
				}
			}
			else {
				$('#serverMakeList').removeClass('ui-icon-circle-minus');
				$('#serverMakeList').addClass('ui-icon-circle-plus');
				$('#serverMake-options > li').remove();
			} 
		});
		
		$('#filter').delegate('p .serverBuilding-filter','click',function() {
			var duplicates = [];
			if($('#serverBuildingList').hasClass('ui-icon-circle-plus')) {
				$('#serverBuildingList').removeClass('ui-icon-circle-plus');
				$('#serverBuildingList').addClass('ui-icon-circle-minus');
				for(var i = 0; i < serverBuilding.length; i++) {
					var sBuilding= serverBuilding[i];
					if(duplicates.indexOf(sBuilding) < 0) {
						$('#serverBuilding-options').append('<li id="example"><a href="#" id="filterOptions">'+sBuilding+'</a><span></span></li>');			
						duplicates.push(sBuilding);
					}
				}
			}
			else {
				$('#serverBuildingList').removeClass('ui-icon-circle-minus');
				$('#serverBuildingList').addClass('ui-icon-circle-plus');
				$('#serverBuilding-options > li').remove();
			} 
		});
		
		/* $("#hostList > option").remove();
		$("#hostList").append('<option disabled selected>Select Host</option>');
		$("#hostList").append('<option>pbcrl11b3</option>');
		$.each(hosts, function(index, host) {
			$("#hostList").append('<option>'+host.hostName+'</option>');
		});
		
		$('#hostSubmit').click(function() {
			$('#graphContainer').empty();
			loadingBlockMask('#graphContainer','Loading graph. Please wait.');
				var children = [];
				var hostName = $('#hostList').val();
				var dataVal = {
						'hostName':hostName
				};
				$.ajax({
					url:contextPath+"/app/users/getHostProcesses",
					type:"GET",
					data: dataVal,
					success:function(data) {
						alert(data);
						var json = $.parseJSON(data);
						$.each(json.servers, function(i, host) {
							children.push(host.hostName);
						});
					},
					error:function(msg) {
						alert("ERROR: " + msg);
					}
				}).done(function() {
					main3(document.getElementById('graphContainer'),hostName,children);
				});
		}); */
		
		
		$("#type > option").remove();
		$("#type").append('<option disabled selected>Select Type</option>');
		$("#type").append('<option>Application Name</option>');
		$("#type").append('<option>Application ID</option>');
		$("#type").append('<option>Application Group Name</option>');
		$("#type").append('<option>Host Name</option>');
		
		$("#graphType").append('<option disabled selected>Select Type</option>');
		$("#graphType").append('<option>Interface</option>');
		$("#graphType").append('<option>Infra</option>');
			
		$("#l1ProcessList > option").remove();
		$("#l1ProcessList").append('<option disabled selected>Select Process</option>');
		$("#l1ProcessList").append('<option>Margin and collateral management</option>');
		
		$('#l1ProcessList').change(function() {
			var l1ProcessName = $('#l1ProcessList').val();
			$("#l2ProcessList > option").remove();
			$("#l2ProcessList").append('<option disabled selected>Select Process</option>');
			var list = [];
			var dataVal = {
					'processId':'2',
					'processName':l1ProcessName
			};
			$.ajax({
				url:contextPath+"/app/users/getProcesses",
				type:"GET",
				data: dataVal,
				success:function(data) {
					var json  = $.parseJSON(data);
					$.each(json.data, function(i, item){
						$.each(item.row,function(i, row) {
							if(row.name == "L2BusinessProcess") {
								if(list.indexOf(row.value) < 0) {
									$("#l2ProcessList").append('<option>'+row.value+'</option>');
									list.push(row.value);
								}
							}
						});
					});
				},
				error:function(msg) {
					alert("ERROR: " + msg);
				}
			});
			//$.each(businessProcess.data, function(i, item){
			//	$.each(item.row,function(i, row) {
			//		if(row.name == "L2BusinessProcess") {
			//			if(list.indexOf(row.value) < 0) {
			//				$("#l2ProcessList").append('<option>'+row.value+'</option>');
			//				list.push(row.value);
			//			}
			//		}
			//	});
			//});
		});
		
		$('#l2ProcessList').change(function() {
			var l2ProcessName = $('#l2ProcessList').val();
			$("#l3ProcessList > option").remove();
			$("#l3ProcessList").append('<option disabled selected>Select Process</option>');
			var list = [];
			var dataVal = {
					'processId':'2',
					'processName':l2ProcessName
			};
			$.ajax({
				url:contextPath+"/app/users/getProcesses",
				type:"GET",
				data: dataVal,
				success:function(data) {
					var json  = $.parseJSON(data);
					$.each(json.data, function(i, item){
						$.each(item.row,function(i, row) {
							if(row.name == "L3BusinessProcess") {
								if(list.indexOf(row.value) < 0) {
									$("#l3ProcessList").append('<option>'+row.value+'</option>');
									list.push(row.value);
								}
							}
						});
					});
				},
				error:function(msg) {
					alert("ERROR: " + msg);
				}
			});
		});
		
		$('#processSubmit').click(function() {
			$('#graphContainer').empty();
			loadingBlockMask('#graphContainer','Loading graph. Please wait.');
			var list = [];
			if($('#l1ProcessList').val() == null || $('#l2ProcessList').val() == null || $('#l3ProcessList').val() == null) {
				alert("Please choose a value for each business process before submiting.");
			}
			else {
				appGroups.length = 0;
				var l3ProcessName = $('#l3ProcessList').val();
				var dataVal = {
						'processId':'3',
						'processName':l3ProcessName
				};
				$.ajax({
					url:contextPath+"/app/users/getProcesses",
					type:"GET",
					data: dataVal,
					success:function(data) {
						var json  = $.parseJSON(data);
						$.each(json.data, function(i, item){
							$.each(item.row,function(i, row) {
								if(row.name == "ApplicationId") {
									if(list.indexOf(row.value) < 0) {
										appGroups.push(row.value);
										list.push(row.value);
									}
								}
							});
						});
					},
					error:function(msg) {
						alert("ERROR: " + msg);
					}
				}).done(function() {
					for(var i = 0; i < appGroups.length; i++) {
						alert(appGroups[i]);
					}
					main2(document.getElementById('graphContainer'));
				});
			}
		});
		
		$("#type").change(function() {
			$('#search').val('');
			var searchType =  $.trim($('#type').val());
			if(searchType == "Application Name") {
				$("#search").autocomplete({
					source: appNames
				});
			}
			else if(searchType == "Application ID") {
				$("#search").autocomplete({
					source: appIds
				});
			}
			else if(searchType == "Application Group Name") {
				$("#search").autocomplete({
					source: appGroupNames
				});
			}
			else if(searchType == "Host Name") {
				$("#search").autocomplete({
					source: hostNames
				});
			}
		});
		$('#submit').click(function() {
			$('#graphContainer').empty();
			$('#filter > p').remove();
			var type = $.trim($('#type').val());
			var graphType = $.trim($('#graphType').val());
			fromRows.length = 0;
			toRows.length = 0;
			appGroups.length = 0;
			hostProcesses.length = 0;
			var id = $.trim($('#search').val());
			if((type == "Application Name" && appNames.indexOf(id) < 0) 
					|| (type == "Application ID" && appIds.indexOf(id) < 0)
					|| (type == "Application Group Name" && appGroupNames.indexOf(id) < 0)
					|| type == "Host Name" && hostNames.indexOf(id) < 0) {
				alert("Not a valid " + type +". Please input a valid entry.");
			}
			else if(type == "") {
				alert("Please select a search type.");
			}
			else if(type == "Application Group Name") {
				var appGroupId;
				$('#filterToggle').show();
				loadingBlockMask('#graphContainer','Loading graph. Please wait.');
				$('#filter').append('<p><span id="envgroup" class="ui-icon ui-icon-circle-plus envgroup-filter"></span>'
			    		+'<ui id="envgroup-options"><font size="+1">Environment Group</font></ui></p>');
				$('#filter').append('<p><span id="applicationLob" class="ui-icon ui-icon-circle-plus applicationLob-filter"></span>'
			    		+'<ui id="applicationLob-options"><font size="+1">Application LOB</font></ui></p>');
				$('#filter').append('<p><span id="investmentStrategys" class="ui-icon ui-icon-circle-plus investmentStrategys-filter"></span>'
			    		+'<ui id="investmentStrategys-options"><font size="+1">Investment Strategy</font></ui></p>');
				$('#filter').append('<p><span id="states" class="ui-icon ui-icon-circle-plus states-filter"></span>'
			    		+'<ui id="states-options"><font size="+1">States</font></ui></p>');
				$('#filter').append('<p><span id="applicationDevelopedBy" class="ui-icon ui-icon-circle-plus applicationDevelopedBy-filter"></span>'
			    		+'<ui id="applicationDevelopedBy-options"><font size="+1">Application Developed By</font></ui></p>');
				$('#filter').append('<p><span id="cafCritical" class="ui-icon ui-icon-circle-plus cafCritical-filter"></span>'
			    		+'<ui id="cafCritical-options"><font size="+1">CAF Critical</font></ui></p>');
				$('#filter').append('<p><span id="technologyGroupOwners" class="ui-icon ui-icon-circle-plus technologyGroupOwners-filter"></span>'
			    		+'<ui id="technologyGroupOwners-options"><font size="+1">Technology Group Owner</font></ui></p>');
				$.each(appGroupsMessage, function(i, appGroup) {
					if(appGroup.appGroupName == id) {
						appGroupId = appGroup.appGroupId;
					}
				});
				$.each(applications, function(i, application) {
					if(application.appGroupId == appGroupId) {
						appGroups.push(application.applicationId);
					}
				});
				main2(document.getElementById('graphContainer'));
			}
			else if(type == "Application ID" && graphType == "Infra") {
				$('#filterToggle').show();
				$('#filter').append('<p><span id="memoryCapacityList" class="ui-icon ui-icon-circle-plus memoryCapacity-filter"></span>'
			    		+'<ui id="memoryCapacity-options"><font size="+1">Memory Capacity</font></ui></p>');
				$('#filter').append('<p><span id="numberOfProcessorsList" class="ui-icon ui-icon-circle-plus numberOfProcessors-filter"></span>'
			    		+'<ui id="numberOfProcessors-options"><font size="+1">Number of Processors</font></ui></p>');
				$('#filter').append('<p><span id="serverRoleList" class="ui-icon ui-icon-circle-plus serverRole-filter"></span>'
			    		+'<ui id="serverRole-options"><font size="+1">Server Role</font></ui></p>');
				$('#filter').append('<p><span id="serverMakeList" class="ui-icon ui-icon-circle-plus serverMake-filter"></span>'
			    		+'<ui id="serverMake-options"><font size="+1">Server Make</font></ui></p>');
				$('#filter').append('<p><span id="serverBuildingList" class="ui-icon ui-icon-circle-plus serverBuilding-filter"></span>'
			    		+'<ui id="serverBuilding-options"><font size="+1">Server Building</font></ui></p>');
				loadingBlockMask('#graphContainer','Loading graph. Please wait.');
				serverHardware(document.getElementById('graphContainer'));
			}
			else if(type == "Application ID") {
				$('#filterToggle').show();
				loadingBlockMask('#graphContainer','Loading graph. Please wait.');
				$('#filter').append('<p><span id="environment" class="ui-icon ui-icon-circle-plus environment-filter"></span>'
			    		+'<ui id="environment-options"><font size="+1">Environment</font></ui></p>');
				$('#filter').append('<p><span id="applicationLob" class="ui-icon ui-icon-circle-plus applicationLob-filter"></span>'
			    		+'<ui id="applicationLob-options"><font size="+1">Application LOB</font></ui></p>');
				$('#filter').append('<p><span id="investmentStrategys" class="ui-icon ui-icon-circle-plus investmentStrategys-filter"></span>'
			    		+'<ui id="investmentStrategys-options"><font size="+1">Investment Strategy</font></ui></p>');
				$('#filter').append('<p><span id="states" class="ui-icon ui-icon-circle-plus states-filter"></span>'
			    		+'<ui id="states-options"><font size="+1">States</font></ui></p>');
				$('#filter').append('<p><span id="applicationDevelopedBy" class="ui-icon ui-icon-circle-plus applicationDevelopedBy-filter"></span>'
			    		+'<ui id="applicationDevelopedBy-options"><font size="+1">Application Developed By</font></ui></p>');
				$('#filter').append('<p><span id="cafCritical" class="ui-icon ui-icon-circle-plus cafCritical-filter"></span>'
			    		+'<ui id="cafCritical-options"><font size="+1">CAF Critical</font></ui></p>');
				$('#filter').append('<p><span id="technologyGroupOwners" class="ui-icon ui-icon-circle-plus technologyGroupOwners-filter"></span>'
			    		+'<ui id="technologyGroupOwners-options"><font size="+1">Technology Group Owner</font></ui></p>');
				var dataVal = {
					'id':id,
					'direction': type == "Application Name"?'FromName':'FromId'
				};
				$.ajax({
					url:contextPath+"/app/users/getJSON",
					type:"GET",
					data: dataVal,
					success:function(data) {
						var json  = $.parseJSON(data);
						$.each(json.data, function(i, item){
							var rowData = item.row;
							fromRows.push(rowData);
						});
					},
					error:function(msg) {
						alert("ERROR: " + msg);
					}
				}).done(function() {
					var dataVal = {
							'id':id,
							'direction': type == "Application Name"?'ToName':'ToId'
					};
					$.ajax({
						url:contextPath+"/app/users/getJSON",
						type:"GET",
						data: dataVal,
						success:function(data) {
							var json  = $.parseJSON(data);
							$.each(json.data, function(i, item){
								var rowData = item.row;
								toRows.push(rowData);
							});
						},
						error:function(msg) {
							alert("ERROR: " + msg);
						}
					}).done(function() {
						main(document.getElementById('graphContainer'));
					});
				});
			}
			else if(type == "Host Name") {
				loadingBlockMask('#graphContainer','Loading graph. Please wait.');
				var children = [];
				var hostName = $('#search').val();
				var dataVal = {
						'hostName':hostName
				};
				$.ajax({
					url:contextPath+"/app/users/getHostProcesses",
					type:"GET",
					data: dataVal,
					success:function(data) {
						var json = $.parseJSON(data);
						$.each(json.servers, function(i, host) {
							children.push(host.hostName);
						});
					},
					error:function(msg) {
						alert("ERROR: " + msg);
					}
				}).done(function() {
					main3(document.getElementById('graphContainer'),hostName,children);
				});
			}
		});
		
		
		$('#dialogAppInfo').hide();
		eventsForAppInfo();
		
		$('#dialogHostInfo').hide();
		eventsForHostInfo();
		
		$('dialogTransportInfo').hide();
		eventsForTransportInfo();
		
		$('#dialogProcessInfo').hide();
		eventsForProcessInfo();
		
	});
	

	
		// Program starts here. Creates a sample graph in the
		// DOM node with the specified ID. This function is invoked
		// from the onLoad event handler of the document (see below).
		function main(container)
		{
			$('#graphContainer').empty();
			// Checks if the browser is supported
			if (!mxClient.isBrowserSupported())
			{
				// Displays an error message if the browser is not supported.
				mxUtils.error('Browser is not supported!', 200, false);
			}
			else
			{
				// Disables the built-in context menu
				mxEvent.disableContextMenu(container);
				
				// Creates the graph inside the given container
				var graph = new mxGraph(container);
				graph.removeCells(graph.getChildVertices(graph.getDefaultParent()));
				// Enables rubberband selection
				new mxRubberband(graph);
				
				// Gets the default parent for inserting new cells. This
				// is normally the first child of the root (ie. layer 0).
				var layout = new mxHierarchicalLayout(graph);
				//graph.gridSize = 400;
				//layout.forceConstant = 250;
				//layout.minDistanceLimit = 500;
				graph.setPanning(true);
				graph.panningHandler.useLeftButtonForPanning = true;
				graph.setAllowDanglingEdges(false);
				var parent = graph.getDefaultParent();
				mxCompactTreeLayout.prototype.maintainParentLocation = true;				
				// Adds cells to the model in a single step
				//graph.setEnabled(false);
				graph.getModel().beginUpdate();
				graph.setHtmlLabels(true);
				graph.getView().updateStyle = true;
				//var width = $('#graphContainer').width()/2 + $('#graphContainer').offset().left;
				//var height = $('#graphContainer').height()/2 + $('#graphContainer').offset().top;
				//alert("width: "+width+". height: "+height);
				var s = graph.view.scale;
				var c = graph.container;
				var w = 100;
				var h = 80;
				var x = (c.scrollLeft + c.clientWidth / 2) / s - w / 2;
				var y = ((c.scrollTop + c.clientHeight / 2) / s - h / 2) - 100;
				var vertices = [];
				var map = new Object();
				var idMap = new Object();
				var edgeMap = [];
				var appDataMap = [];
				var parentName;
				var cellChanges = [];
				var appNameMap = [];
				var parentId = $('#search').val();
				applicationLobs.length = 0;
				investmentStrategys.length = 0;
				states.length = 0;
				applicationDevelopedBy.length = 0;
				cafCriticals.length = 0;
				technologyGroupOwners.length = 0;
				try
				{
					var v1, v2, e1;
					var fromName, toName, edgeName, parentNode,toId,fromId,parentId;
					for(var i = 0; i < fromRows.length; i++) {
						fromName = '', toName = '', edgeName = '',toId = '';
						$.each(fromRows[i],function(i, row) {
							if(row.name == "FromName") {
								fromName = row.value;
								parentName = row.value;
							}
							else if(row.name == "FromId") {
								idMap[fromName] = row.value;
							}
							else if(row.name == "ToName") {
								toName = row.value;
							}
							else if(row.name == "TransportMechanism") {
								edgeName = row.value;
							}
							else if(row.name == "ToId") {
								idMap[toName] = row.value;
								toId = row.value;
							}
						});
						if(parentNode == null) {
							parentNode = graph.insertVertex(parent, null, fromName, x, y, w, h, 'whiteSpace=wrap;');
							vertices.push(parentNode);
							idMap[parentName] = parentId;
							appNameMap[parentNode.id] = parentNode.value;
						}
						//v1 = graph.insertVertex(parent, null, fromName, x, y, w, h, 'whiteSpace=wrap;');
						//parentNode = parent;
						v2 = graph.insertVertex(parent, null, toName, 0, 0, w, h, 'whiteSpace=wrap;');
						appNameMap[v2.id] = v2.value;
						map[toName] = v2;
						e1 = graph.insertEdge(parent, null, edgeName, parentNode, v2, 'whiteSpace=wrap;');
						edgeMap[e1.id] = ["FromId",toId];
						vertices.push(v2);
					}
					
					for(var i = 0; i < toRows.length; i++) {
						fromName = '', toName = '', edgeName = '', fromId = '';
						$.each(toRows[i],function(i, row) {
							if(row.name == "FromName") {
								fromName = row.value;
							}
							else if(row.name == "FromId") {
								idMap[fromName] = row.value;
								fromId = row.value;
							}
							else if(row.name == "ToName") {
								toName = row.value;
							}
							else if(row.name == "TransportMechanism") {
								edgeName = row.value;
							}
						});
						var hasKey = false;
						//for (var k in map) {
						//    if (map.hasOwnProperty(k)) {
						//    	if(k == fromName) {
						//    		v1 = map[k];
						//    		hasKey = true;
						//    	}
						//    }
						//}
						if(!hasKey) {
							v1 = graph.insertVertex(parent, null, fromName, 0, 0, w, h, 'whiteSpace=wrap;');
							appNameMap[v1.id] = v1.value;
							vertices.push(v1);
						}
						if(parentNode == null) {
							parentNode = graph.insertVertex(parent, null, toName, x, y, w, h, 'whiteSpace=wrap;');
							vertices.push(parentNode);
							idMap[parentNode.value] = parentId;
							appNameMap[parentNode.id] = parentNode.value;
						}
						e1 = graph.insertEdge(parent, null, edgeName, v1, parentNode, 'whiteSpace=wrap;');
						edgeMap[e1.id] = ["ToId",fromId];
						//vertices.push(v1);
					}
					
					for(var i = 0; i < vertices.length; i++) {
						var id = idMap[vertices[i].value];
						var appInfo = [];
						var dataVal = {
								'id':id
						}
						$.ajax({
							url:contextPath+"/app/users/getAppData",
							type:"GET",
							data:dataVal,
							async:false,
							success:function(data) {
								var json  = $.parseJSON(data);
								$.each(json.data, function(i, item){
									var rowData = item.row;
									appDataMap[id] = rowData;
									appInfo.push(rowData);
								});
							},
							error:function(msg) {
								alert("ERROR: " + msg);
							}
						}).done(function() {
							for(var i = 0; i < appInfo.length; i++) {
								$.each(appInfo[i],function(i, row) {
									if(row.name == "ApplicationLOB") {
										 applicationLobs.push(row.value);
									}
									else if(row.name == "InvestmentStrategy") {
										investmentStrategys.push(row.value);
									}
									else if(row.name == "State") {
										 states.push(row.value);
									}
									else if(row.name == "ApplicationDevelopedBy") {
										 applicationDevelopedBy.push(row.value);
									}
									else if(row.name == "CAF_Critical") {
										 cafCriticals.push(row.value);
									}
									else if(row.name == "TechnologyGroupOwner") {
										 technologyGroupOwners.push(row.value);
									}
								});
							}
						});
					}
					
					$('#applicationLob-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var appLob = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var id = idMap[vertices[i].value];
							var appData = appDataMap[id];
							$.each(appData,function(i, row) {
								if(row.name == "ApplicationLOB" && row.value == appLob) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					// reset filter
					$('#reset').click(function() {
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var id = vertex.id;
							var appName = appNameMap[id];
							graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
							graph.labelChanged(vertex,appName);
							
						}
					});
					
					$('#environment-options').delegate('li','click',function() {
						var verticesChanged = [];
						var envName = $(this).text();
						var toAppId = '';
						for(var i = 0; i < fromRows.length; i++) {
							$.each(fromRows[i],function(i, row) {
								if(row.name == "ToId") {
									toAppId = row.value;
								}
							});
							var dataVal = {
									'fromEnvName':envName,
									'toAppId':toAppId
							};
							$.ajax({
								url:contextPath+"/app/users/getToEnvIfFilter",
								type:"GET",
								data: dataVal,
								async:false,
								success:function(data) {
									var json = $.parseJSON(data);
									if(json.toEnvName != null) {
										var toEnvName = json.toEnvName;
										for(var i = 0; i < vertices.length; i++) {
											var vertex = vertices[i];
											if(idMap[vertex.value] == toAppId) {
												verticesChanged.push(vertex)
												//filterMap[environment.environmentName] = vertex.value;
												graph.labelChanged(vertex,toEnvName);
												idMap[toEnvName] = toAppId;
												graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
											}
										}
									}							
								},
								error:function(msg) {
									alert("ERROR: " + msg);
								}
							});
						}
						var fromAppId = '';
						for(var i = 0; i < toRows.length; i++) {
							$.each(toRows[i],function(i, row) {
								if(row.name == "FromId") {
									fromAppId = row.value;
								}
							});
							var dataVal = {
									'toEnvName':envName,
									'fromAppId':fromAppId
							};
							$.ajax({
								url:contextPath+"/app/users/getFromEnvIfFilter",
								type:"GET",
								data: dataVal,
								async:false,
								success:function(data) {
									var json = $.parseJSON(data);
									if(json.fromEnvName != null) {
										var fromEnvName = json.fromEnvName;
										for(var i = 0; i < vertices.length; i++) {
											var vertex = vertices[i];
											if(idMap[vertex.value] == fromAppId) {
												verticesChanged.push(vertex)
												//filterMap[environment.environmentName] = vertex.value;
												graph.labelChanged(vertex,fromEnvName);
												idMap[fromEnvName] = toAppId;
												graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
											}
										}
									}				
								},
								error:function(msg) {
									alert("ERROR: " + msg);
								}
							});
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					$('#investmentStrategys-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var investmentStrategy = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var id = idMap[vertices[i].value];
							var appData = appDataMap[id];
							$.each(appData,function(i, row) {
								if(row.name == "InvestmentStrategy" && row.value == investmentStrategy) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					$('#applicationDevelopedBy-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var applicationDevelopedBy = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var id = idMap[vertices[i].value];
							var appData = appDataMap[id];
							$.each(appData,function(i, row) {
								if(row.name == "ApplicationDevelopedBy" && row.value == applicationDevelopedBy) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					$('#states-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var state = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var id = idMap[vertices[i].value];
							var appData = appDataMap[id];
							$.each(appData,function(i, row) {
								if(row.name == "State" && row.value == state) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					$('#cafCritical-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var cafCritical = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var id = idMap[vertices[i].value];
							var appData = appDataMap[id];
							$.each(appData,function(i, row) {
								if(row.name == "CAF_Critical" && row.value == cafCritical) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					$('#technologyGroupOwners-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var technologyGroupOwner = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var id = idMap[vertices[i].value];
							var appData = appDataMap[id];
							$.each(appData,function(i, row) {
								if(row.name == "TechnologyGroupOwner" && row.value == technologyGroupOwner) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					
					var highlight = new mxCellTracker(graph, '#00FF00');
					graph.addListener(mxEvent.CLICK, function(source, evt) {
						var cell = evt.getProperty('cell');
						if (cell != null) {
							if(graph.getModel().isEdge(cell)) {
								var edgeName = cell.value;
								if(edgeName == null || edgeName == "") {
									alert("No information found.");
									//var edges = graph.getChildCells(parent, true, true);
									//for(var i = 0; i < edges.length; i++) {
										//alert(edges[i].value);
										//var points = graph.getView().getState(edges[i]);
										//var id = points.cell.id;
										//alert(id);
										//for(var j = 0; j < points.length; j++) {
										//	alert(points[j].value);
										//}
									//}
								}
								else {
									var info = edgeMap[cell.id];
									var direction = info[0];
									var id = info[1];
									var appInfo = [];
									var dataVal = {
											'id':parentId,
											'direction': direction
									};
									$.ajax({
										url:contextPath+"/app/users/getJSON",
										type:"GET",
										data: dataVal,
										success:function(data) {
											var json  = $.parseJSON(data);
											$.each(json.data, function(i, item){
												var rowData = item.row;
												appInfo.push(rowData);
											});
										},
										error:function(msg) {
											alert("ERROR: " + msg);
										}
									}).done(function() {
										var feedName, frequency, dataContent, transportMechanism;
										direction = (direction=="FromId"?"ToId":"FromId");
										for(var i = 0; i < appInfo.length; i++) {
											var match = false;
											$.each(appInfo[i],function(i, row) {
												if(row.name == direction && row.value == id) {
													match = true;
												}
												else if(row.name == "FeedName") {
													feedName = row.value;
												}
												else if(row.name == "Frequency") {
													frequency = row.value;
												}
												else if(row.name == "DataContent") {
													dataContent = row.value;
												}
												else if(row.name == "TransportMechanism") {
													transportMechanism = row.value;
												}
											});
											if(match) {
												$('#feedName').val(feedName);
												$('#frequency').val(frequency);
												$('#dataContent').val(dataContent);
												$('#transportMechanism').val(transportMechanism);
											}
										}
										$("#dialogTransportInfo").dialog("open");	
									});
								}
							}
							else {
								for (var k in idMap) {
								    if (idMap.hasOwnProperty(k)) {
								    	if(k == cell.value) {
								    		var id = idMap[k];
								    		//$("#dialogAppInfo :input").prop("disabled", true);
											var appInfo = [];
											var dataVal = {
													'id':id
											}
											$.ajax({
												url:contextPath+"/app/users/getAppData",
												type:"GET",
												data:dataVal,
												success:function(data) {
													var json  = $.parseJSON(data);
													$.each(json.data, function(i, item){
														var rowData = item.row;
														appInfo.push(rowData);
													});
												},
												error:function(msg) {
													alert("ERROR: " + msg);
												}
											}).done(function() {
												for(var i = 0; i < appInfo.length; i++) {
													$.each(appInfo[i],function(i, row) {
														if(row.name == "ApplicationName") {
															 $('#applicationName').val(row.value);
														}
														else if(row.name == "PreviousName") {
															 $('#previousName').val(row.value);
														}
														else if(row.name == "ApplicationId") {
															 $('#applicationId').val(row.value);
														}
														else if(row.name == "ApplicationLOB") {
															 $('#applicationLOB').val(row.value);
														}
														else if(row.name == "ApplicationAcronym") {
															 $('#applicationAcronym').val(row.value);
														}
														else if(row.name == "ApplicationCreationDate") {
															 $('#applicationCreationDate').val(row.value);
														}
														else if(row.name == "Description") {
															 $('#description').val(row.value);
														}
														else if(row.name == "ApplicationURL") {
															 $('#applicationURL').val(row.value);
														}
														else if(row.name == "InvestmentStrategy") {
															 $('#investmentStrategy').val(row.value);
														}
														else if(row.name == "State") {
															 $('#state').val(row.value);
														}
														else if(row.name == "TechnologyGroupOwner") {
															 $('#technologyGroupOwner').val(row.value);
														}
													});
												}
												if(appInfo.length == 0) {
													alert("Application Information Not Found.");
												}
												else {
													$("#dialogAppInfo").dialog("open");	
												}
											});
								    	}
								    }
								}
							}
						}
					});
					$('#zoomIn').click(function() {
						graph.zoomIn();
					});
					$('#zoomOut').click(function() {
						graph.zoomOut();
					});				
				}
				finally
				{
					layout.execute(parent);
					//load(graph, parentNode, x, y, vertices);
					graph.getModel().endUpdate();
				}
			}
		};
		
		
		// Program starts here. Creates a sample graph in the
		// DOM node with the specified ID. This function is invoked
		// from the onLoad event handler of the document (see below).
		function main2(container)
		{
	
			$('#graphContainer').empty();
			// Checks if the browser is supported
			if (!mxClient.isBrowserSupported())
			{
				// Displays an error message if the browser is not supported.
				mxUtils.error('Browser is not supported!', 200, false);
			}
			else
			{
				// Disables the built-in context menu
				mxEvent.disableContextMenu(container);
				
				// Creates the graph inside the given container
				var graph = new mxGraph(container);
				graph.setPanning(true);
				graph.panningHandler.useLeftButtonForPanning = true;
				graph.setAllowDanglingEdges(false);
				graph.removeCells(graph.getChildVertices(graph.getDefaultParent()));
				// Enables rubberband selection
				new mxRubberband(graph);
				// Gets the default parent for inserting new cells. This
				// is normally the first child of the root (ie. layer 0).
				var parent = graph.getDefaultParent();
				//var first = new mxFastOrganicLayout(graph);
				//var second = new mxParallelEdgeLayout(graph);
				//var layout = new mxFastOrganicLayout(graph, [first, second], first);
				var layout = new mxFastOrganicLayout(graph);
				//layout.minDistanceLimit = 30;
				//graph.gridSize = 400;
				//layout.forceConstant = 250;
				// Adds cells to the model in a single step
				//graph.setEnabled(false);
				graph.getModel().beginUpdate();
				graph.setHtmlLabels(true);
				//var width = $('#graphContainer').width()/2 + $('#graphContainer').offset().left;
				//var height = $('#graphContainer').height()/2 + $('#graphContainer').offset().top;
				//alert("width: "+width+". height: "+height);
				var s = graph.view.scale;
				var c = graph.container;
				var w = 100;
				var h = 80;
				var x = (c.scrollLeft + c.clientWidth / 2) / s - w / 2;
				var y = ((c.scrollTop + c.clientHeight / 2) / s - h / 2) - 100;
				var vertices = [];
				var idMap = new Object();
				var appNameMap = [];
				var edgeMap = [];
				var appDataMap = [];
				var parentNode, node;
				applicationLobs.length = 0;
				investmentStrategys.length = 0;
				states.length = 0;
				applicationDevelopedBy.length = 0;
				cafCriticals.length = 0;
				technologyGroupOwners.length = 0;
				try
				{
					
					for(var i = 0; i < appGroups.length; i++) {
						var id = appGroups[i];
						var appInfo = [];
						var dataVal = {
								'id':id
						}
						$.ajax({
							url:contextPath+"/app/users/getAppData",
							type:"GET",
							data:dataVal,
							async:false,
							success:function(data) {
								var json  = $.parseJSON(data);
								$.each(json.data, function(i, item){
									var rowData = item.row;
									appDataMap[id] = rowData;
									appInfo.push(rowData);
								});
							},
							error:function(msg) {
								alert("ERROR: " + msg);
							}
						}).done(function() {
							for(var i = 0; i < appInfo.length; i++) {
								$.each(appInfo[i],function(i, row) {
									if(row.name == "ApplicationLOB") {
										 applicationLobs.push(row.value);
									}
									else if(row.name == "InvestmentStrategy") {
										investmentStrategys.push(row.value);
									}
									else if(row.name == "State") {
										 states.push(row.value);
									}
									else if(row.name == "ApplicationDevelopedBy") {
										 applicationDevelopedBy.push(row.value);
									}
									else if(row.name == "CAF_Critical") {
										 cafCriticals.push(row.value);
									}
									else if(row.name == "TechnologyGroupOwner") {
										 technologyGroupOwners.push(row.value);
									}
								});
							}
						});
						$.each(applications, function(index,application) {					
							if(application.applicationId == id) {
								var appName = application.appName;
								idMap[appName] = id;
								node =  graph.insertVertex(parent, null, appName, 0, 0, w, h, 'whiteSpace=wrap;');
								appNameMap[node.id] = appName;
								vertices.push(node);
							}
						});
					}
					
			
					for(var i = 0; i < vertices.length; i++) {
						var id;
						parentNode = vertices[i];					
						id = idMap[parentNode.value];
									
						var dataVal = {
								'id':id,
								'direction': 'FromId'
						};
						
						$.ajax({
							url:contextPath+"/app/users/getJSON",
							type:"GET",
							data: dataVal,
							async: false,
							success:function(data) {
								var json  = $.parseJSON(data);
								$.each(json.data, function(i, item){
									var rowData = item.row;
									fromRows.push(rowData);
								});
							},
							error:function(msg) {
								alert("ERROR: " + msg);
							}
						}).always(function() {
							
							var dataVal = {
									'id':id,
									'direction': 'ToId'
							};
							
							$.ajax({
								url:contextPath+"/app/users/getJSON",
								type:"GET",
								data: dataVal,
								async: false,
								success:function(data) {
									var json  = $.parseJSON(data);
									$.each(json.data, function(i, item){
										var rowData = item.row;
										toRows.push(rowData);
									});
								},
								error:function(msg) {
									alert("ERROR: " + msg);
								}
							}).always(function() {
								var match = false;
								var match2 = false;
								var edgeName = '';
								var toId,json,fromId,parentId;
								for(var j = i+1; j < vertices.length; j++) {
									match = false;
									for(var k = 0; k < fromRows.length; k++) {
										edgeName = '', match = false, match2 = false, toId = '', parentId = '', node = null;
										$.each(fromRows[k],function(index, row) {
											if(row.name == "FromId" && row.value == idMap[parentNode.value]) {
												parentId = row.value;
												match2 = true;
											}
											else if(row.name == "ToId" && row.value == idMap[vertices[j].value]) {
												toId = row.value;
												node = vertices[j];
												match = true;
												toId = row.value;
											}
											else if(row.name == "TransportMechanism") {
												edgeName = row.value;
											}	
										});
										
										if(match && match2) {
											var e1 = graph.insertEdge(parent, null, edgeName, parentNode, node, 'whiteSpace=wrap;');
											edgeMap[e1.id] = ["FromId",idMap[node.value],parentId];
										}
									}
									
									for(var k = 0; k < toRows.length; k++) {
										edgeName = '', match = false, match2 = false,fromId = '', parentId = '', node = null;
										$.each(toRows[k],function(index, row) {
											if(row.name == "ToId" && row.value == idMap[parentNode.value]) {
												parentId = row.value;
												match2 = true;
											}
											if(row.name == "FromId" && row.value == idMap[vertices[j].value]) {
												fromId == row.value;
												node = vertices[j];
												match = true;
											}
											else if(row.name == "TransportMechanism") {
												edgeName = row.value;
											}	
										});
										
										if(match && match2) {
											var e1 = graph.insertEdge(parent, null, edgeName, node, parentNode, 'whiteSpace=wrap;');
											edgeMap[e1.id] = ["ToId",idMap[node.value],parentId];
										}
									}
								}
							})
							
						});
						
					}
					
					
					
		/*			var fromName, toName, edgeName, match, i, e1;
					for(i = 0; i < appGroups.length; i++) { 
						var id = appGroups[i];
						fromRows.length = 0;
						toRows.length = 0;
						$.each(applications, function(index, application) {
							if(application.appquestId == id) {
							//	var hasKey = false;
								var name = application.appName;
							//	for (var k in map) {
							//	    if (map.hasOwnProperty(k)) {
							//	    	if(k == name) {
							//	    		parentNode = map[k];
							//	    		hasKey = true;
							//	    	}
							//	    }
							//	}
							//	if(!hasKey) {
									parentNode = graph.insertVertex(parent, null, name, 0, 0, w, h, 'whiteSpace=wrap;');
							//		map[name] = parentNode;
									vertices.push(parentNode);
							//	}
							}
						});
						
						var dataVal = {
								'id':id,
								'direction': 'FromId'
						};
						
						$.ajax({
							url:contextPath+"/app/users/getJSON",
							type:"GET",
							data: dataVal,
							async: false,
							success:function(data) {
								var json  = $.parseJSON(data);
								$.each(json.data, function(i, item){
									var rowData = item.row;
									fromRows.push(rowData);
								});
							},
							error:function(msg) {
								alert("ERROR: " + msg);
							}
						}).done(function() { 
							var dataVal = {
									'id':id,
									'direction': 'ToId'
							};
							
							$.ajax({
								url:contextPath+"/app/users/getJSON",
								type:"GET",
								data: dataVal,
								async: false,
								success:function(data) {
									var json  = $.parseJSON(data);
									$.each(json.data, function(i, item){
										var rowData = item.row;
										toRows.push(rowData);
									});
								},
								error:function(msg) {
									alert("ERROR: " + msg);
								}
							}).done(function() {								
								for(var j = i+1; j < appGroups.length; j++) {
									fromName = '', toName = '', edgeName = '', match = false;
									for(var k = 0; k < fromRows.length; k++) {
										$.each(fromRows[k],function(index, row) {
											if(row.name == "FromName") {
												fromName = row.value;
												parentName = row.value;
											}
											else if(row.name == "FromId") {
												idMap[fromName] = row.value;
											}
											else if(row.name == "ToName") {
												toName = row.value;
											}
											else if(row.name == "TransportMechanism") {
												edgeName = row.value;
											}
											else if(row.name == "ToId" && row.value == appGroups[j]) {
												match = true;
												idMap[toName] = row.value;
											}
										});
								
										if(match) {
											var hasKey = false;
											for (var k in map) {
											    if (map.hasOwnProperty(k)) {
											    	if(k == toName) {
											    		node = map[k];
											    		hasKey = true;
											    	}
											    }
											}
											if(!hasKey) {
												node = graph.insertVertex(parent, null, toName, 0, 0, w, h, 'whiteSpace=wrap;');
												vertices.push(node);
												map[toName] = node;
											}
																	
											e1 = graph.insertEdge(parent, null, edgeName, parentNode, node, 'whiteSpace=wrap;');
										}
									}
									
									for(var k = 0; k < toRows.length; k++) {
										fromName = '', toName = '', edgeName = '', match = false;
										$.each(toRows[k],function(index, row) {
											if(row.name == "FromName") {
												fromName = row.value;
												parentName = row.value;
											}
											else if(row.name == "FromId" && row.value == appGroups[j]) {
												match = true;
												idMap[fromName] = row.value;
											}
											else if(row.name == "ToName") {
												toName = row.value;
											}
											else if(row.name == "TransportMechanism") {
												edgeName = row.value;
											}
											else if(row.name == "ToId") {
												idMap[toName] = row.value;
											}
										});
									
										if(match) {
											var hasKey = false;
											for (var c in map) {
											    if (map.hasOwnProperty(c)) {
											    	if(c == fromName) {
											    		node = map[c];
											    		hasKey = true;
											    	}
											    }
											}
											if(!hasKey) {
												node = graph.insertVertex(parent, null, fromName, 0, 0, w, h, 'whiteSpace=wrap;');
												vertices.push(node);
												map[fromName] = fromName;
											}										
											e1 = graph.insertEdge(parent, null, edgeName, node, parentNode, 'whiteSpace=wrap;');										
										}
									}
								}
							});
						});
					}
		*/			
		
		// reset filter
		$('#reset').click(function() {
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				var id = vertex.id;
				var appName = appNameMap[id];
				graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
				graph.labelChanged(vertex,appName);
				
			}
		});
		
		$('#applicationLob-options').delegate('li','click',function() {
			var appLob = $(this).text();
			var verticesChanged = [];
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				var id = idMap[vertices[i].value];
				var appData = appDataMap[id];
				$.each(appData,function(i, row) {
					if(row.name == "ApplicationLOB" && row.value == appLob) {
						verticesChanged.push(vertex);
						graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
					}
				});								
			}
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				if(verticesChanged.indexOf(vertex) < 0) {
					var appName = appNameMap[vertex.id];
					graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
					graph.labelChanged(vertex,appName);
				}					
			}	
		});
		
		$('#investmentStrategys-options').delegate('li','click',function() {
			var investmentStrategy = $(this).text();
			var verticesChanged = [];
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				var id = idMap[vertices[i].value];
				var appData = appDataMap[id];
				$.each(appData,function(i, row) {
					if(row.name == "InvestmentStrategy" && row.value == investmentStrategy) {
						verticesChanged.push(vertex);
						graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
					}
				});								
			}
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				if(verticesChanged.indexOf(vertex) < 0) {
					var appName = appNameMap[vertex.id];
					graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
					graph.labelChanged(vertex,appName);
				}					
			}	
		});
		
		$('#applicationDevelopedBy-options').delegate('li','click',function() {
			var applicationDevelopedBy = $(this).text();
			var verticesChanged = [];
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				var id = idMap[vertices[i].value];
				var appData = appDataMap[id];
				$.each(appData,function(i, row) {
					if(row.name == "ApplicationDevelopedBy" && row.value == applicationDevelopedBy) {
						verticesChanged.push(vertex);
						graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
					}
				});								
			}
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				if(verticesChanged.indexOf(vertex) < 0) {
					var appName = appNameMap[vertex.id];
					graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
					graph.labelChanged(vertex,appName);
				}					
			}	
		});
		
		$('#states-options').delegate('li','click',function() {
			var state = $(this).text();
			var verticesChanged = [];
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				var id = idMap[vertices[i].value];
				var appData = appDataMap[id];
				$.each(appData,function(i, row) {
					if(row.name == "State" && row.value == state) {
						verticesChanged.push(vertex);
						graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
					}
				});								
			}
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				if(verticesChanged.indexOf(vertex) < 0) {
					var appName = appNameMap[vertex.id];
					graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
					graph.labelChanged(vertex,appName);
				}					
			}	
		});
		
		$('#cafCritical-options').delegate('li','click',function() {
			var cafCritical = $(this).text();
			var verticesChanged = [];
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				var id = idMap[vertices[i].value];
				var appData = appDataMap[id];
				$.each(appData,function(i, row) {
					if(row.name == "CAF_Critical" && row.value == cafCritical) {
						verticesChanged.push(vertex);
						graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
					}
				});								
			}
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				if(verticesChanged.indexOf(vertex) < 0) {
					var appName = appNameMap[vertex.id];
					graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
					graph.labelChanged(vertex,appName);
				}					
			}	
		});
		
		$('#technologyGroupOwners-options').delegate('li','click',function() {
			var technologyGroupOwner = $(this).text();
			var verticesChanged = [];
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				var id = idMap[vertices[i].value];
				var appData = appDataMap[id];
				$.each(appData,function(i, row) {
					if(row.name == "TechnologyGroupOwner" && row.value == technologyGroupOwner) {
						verticesChanged.push(vertex);
						graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
					}
				});								
			}
			for(var i = 0; i < vertices.length; i++) {
				var vertex = vertices[i];
				if(verticesChanged.indexOf(vertex) < 0) {
					var appName = appNameMap[vertex.id];
					graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
					graph.labelChanged(vertex,appName);
				}					
			}	
		});
		
		$('#envgroup-options').delegate('li','click',function() {
			var envGroupName = $(this).text();
			var dataVal = {
					'envGroupName':envGroupName
			};
			$.ajax({
				url:contextPath+"/app/users/getEnvironmentFilter",
				type:"GET",
				data: dataVal,
				success:function(data) {
					//graph.setCellStyles(mxConstants.STYLE_STROKECOLOR, "green", vertices[0]);
					//graph.setCellStyles(mxConstants.STYLE_STROKEWIDTH, 3 , vertices[0]);
					var json = $.parseJSON(data);
					var verticesChanged = [];
					$.each(json.environments, function(i, environment) {
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(idMap[vertex.value] == environment.applicationId) {
								verticesChanged.push(vertex)
								//filterMap[environment.environmentName] = vertex.value;
								graph.labelChanged(vertex,environment.environmentName);
								idMap[environment.environmentName] = environment.applicationId;
								graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								//cellChanges.push(vertex);
								//graph.setCellStyles(mxConstants.STYLE_STROKECOLOR, "green", vertices[0]);
								//graph.setCellStyles(mxConstants.STYLE_STROKEWIDTH, 3 , vertices[0]);
							}
						}
					});
					for(var i = 0; i < vertices.length; i++) {
						var vertex = vertices[i];
						if(verticesChanged.indexOf(vertex) < 0) {
							var appName = appNameMap[vertex.id];
							graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
							graph.labelChanged(vertex,appName);
						}					
					}
					
				},
				error:function(msg) {
					alert("ERROR: " + msg);
				}
			});
		});
		
		
					var highlight = new mxCellTracker(graph, '#00FF00');
					graph.addListener(mxEvent.DOUBLE_CLICK, function(source, evt) {
						var cell = evt.getProperty('cell');	
						if (cell != null) {
							if(graph.getModel().isEdge(cell)) {
								var edgeName = cell.value;
								if(edgeName == null || edgeName == "") {
									alert("No information found.");
								}
								else {
									var info = edgeMap[cell.id];
									var direction = info[0];
									var id = info[1];
									var parentId = info[2];
									var appInfo = [];
									var dataVal = {
											'id':parentId,
											'direction': direction
									};
									$.ajax({
										url:contextPath+"/app/users/getJSON",
										type:"GET",
										data: dataVal,
										success:function(data) {
											var json  = $.parseJSON(data);
											$.each(json.data, function(i, item){
												var rowData = item.row;
												appInfo.push(rowData);
											});
										},
										error:function(msg) {
											alert("ERROR: " + msg);
										}
									}).done(function() {
										var feedName, frequency, dataContent, transportMechanism;
										direction = (direction=="FromId"?"ToId":"FromId");
										for(var i = 0; i < appInfo.length; i++) {
											var match = false;
											var data = '';
											$.each(appInfo[i],function(i, row) {
												if(row.name == direction && row.value == id) {
													match = true;
													data = JSON.stringify(appInfo[i]);
												}
												else if(row.name == "FeedName") {
													feedName = row.value;
												}
												else if(row.name == "Frequency") {
													frequency = row.value;
												}
												else if(row.name == "DataContent") {
													dataContent = row.value;
												}
												else if(row.name == "TransportMechanism") {
													transportMechanism = row.value;
												}
											});
											if(match) {
												$('#feedName').val(feedName);
												$('#frequency').val(frequency);
												$('#dataContent').val(dataContent);
												$('#transportMechanism').val(transportMechanism);
												$("#dialogTransportInfo").dialog("open");
												break;
											}
										}
									});
								}
							}
							else {
								for (var k in idMap) {
								    if (idMap.hasOwnProperty(k)) {
								    	if(k == cell.value) {
								    		var id = idMap[k];
											var appData = appDataMap[id];
											$.each(appData,function(i, row) {
												if(row.name == "ApplicationName") {
													 $('#applicationName').val(row.value);
												}
												else if(row.name == "PreviousName") {
													 $('#previousName').val(row.value);
												}
												else if(row.name == "ApplicationId") {
													 $('#applicationId').val(row.value);
												}
												else if(row.name == "ApplicationLOB") {
													 $('#applicationLOB').val(row.value);
												}
												else if(row.name == "ApplicationAcronym") {
													 $('#applicationAcronym').val(row.value);
												}
												else if(row.name == "ApplicationCreationDate") {
													 $('#applicationCreationDate').val(row.value);
												}
												else if(row.name == "Description") {
													 $('#description').val(row.value);
												}
												else if(row.name == "ApplicationURL") {
													 $('#applicationURL').val(row.value);
												}
												else if(row.name == "InvestmentStrategy") {
													 $('#investmentStrategy').val(row.value);
												}
												else if(row.name == "State") {
													 $('#state').val(row.value);
												}
												else if(row.name == "TechnologyGroupOwner") {
													 $('#technologyGroupOwner').val(row.value);
												}
											});
											if(appData.length == 0) {
												alert("Application Information Not Found.");
											}
											else {
												$("#dialogAppInfo").dialog("open");	
											}									
								    	}
								    }
								}
							}
						}
					});
					$('#zoomIn').click(function() {
						graph.zoomIn();
					});
					$('#zoomOut').click(function() {
						graph.zoomOut();
					});	
					
					
				}
				finally
				{
					layout.execute(parent);
					//load(graph, parentNode, x, y, vertices);
					graph.getModel().endUpdate();
				}
			}
		};
		
		// Program starts here. Creates a sample graph in the
		// DOM node with the specified ID. This function is invoked
		// from the onLoad event handler of the document (see below).
		function main3(container, parentName, children)
		{
			$('#graphContainer').empty();
			// Checks if the browser is supported
			if (!mxClient.isBrowserSupported())
			{
				// Displays an error message if the browser is not supported.
				mxUtils.error('Browser is not supported!', 200, false);
			}
			else
			{
				// Disables the built-in context menu
				mxEvent.disableContextMenu(container);
				
				// Creates the graph inside the given container
				var graph = new mxGraph(container);
				graph.removeCells(graph.getChildVertices(graph.getDefaultParent()));
				// Enables rubberband selection
				new mxRubberband(graph);
				
				// Gets the default parent for inserting new cells. This
				// is normally the first child of the root (ie. layer 0).
				//var layout = new mxCircleLayout(graph);
				//graph.gridSize = 400;
				//layout.forceConstant = 250;
				//layout.minDistanceLimit = 500;
				var parent = graph.getDefaultParent();
				graph.setPanning(true);
				graph.panningHandler.useLeftButtonForPanning = true;
				graph.setAllowDanglingEdges(false);
				var prefix = 'shape=image;image=<%=contextPath%>/images/Server_small.jpg;';
				//mxCompactTreeLayout.prototype.maintainParentLocation = true;				
				// Adds cells to the model in a single step
				//graph.setEnabled(false);
				graph.getModel().beginUpdate();
				graph.setHtmlLabels(true);
				//var width = $('#graphContainer').width()/2 + $('#graphContainer').offset().left;
				//var height = $('#graphContainer').height()/2 + $('#graphContainer').offset().top;
				//alert("width: "+width+". height: "+height);
				var s = graph.view.scale;
				var c = graph.container;
				var w = 160;
				var h = 25;
				var x = (c.scrollLeft + c.clientWidth / 2) / s - w / 2;
				var y = ((c.scrollTop + c.clientHeight / 2) / s - h / 2) - 100;
				var vertices = [];
				var hostProcessesMap = [];
				try
				{	
					var v1, v2, e1;					
					var highlight = new mxCellTracker(graph, '#00FF00');
					$('#zoomIn').click(function() {
						graph.zoomIn();
					});
					$('#zoomOut').click(function() {
						graph.zoomOut();
					});		
					
					if(hostProcesses.length > 0) {
						v1 = graph.insertVertex(parent, null, parentName, x, y, w, h, prefix+'whiteSpace=wrap;verticalLabelPosition=bottom;verticalAlign=top');
						for(var i = 0; i < children.length; i++) {
							v2 = graph.insertVertex(parent, null, children[i].processName+" "+(i+1), 0, 0, w, h, prefix+'whiteSpace=wrap;verticalLabelPosition=bottom;verticalAlign=top');
							hostProcessesMap[v2.value] = children[i];
							e1 = graph.insertEdge(parent, null, "", v1, v2, 'whiteSpace=wrap;');
							vertices.push(v2);
						}
						
					}
					else {
						v1 = graph.insertVertex(parent, null, parentName, x, y, w, h, prefix+'whiteSpace=wrap;verticalLabelPosition=bottom;verticalAlign=top');
						for(var i = 0; i < children.length; i++) {
							v2 = graph.insertVertex(parent, null, children[i], 0, 0, w, h, prefix+'whiteSpace=wrap;verticalLabelPosition=bottom;verticalAlign=top');
							e1 = graph.insertEdge(parent, null, "", v1, v2, 'whiteSpace=wrap;');
							vertices.push(v2);
						}
					}
					
					
					
					graph.addListener(mxEvent.CLICK, function(source, evt) {
						var hostInfo = [];
						var cell = evt.getProperty('cell');	
						if(hostProcesses.length > 0) {
							var processName = cell.value;
							var processInfo = hostProcessesMap[processName];
							$('#processName').val(processInfo.processName);
							$('#command').val(processInfo.command);
							$('#argument').val(processInfo.argument);
							$('#userName').val(processInfo.userName);
							$("#dialogProcessInfo").dialog("open");	
						}
						else {
							var hostName = cell.value;
							hostName = hostName.replace(/-vip/g,'');				
							hostName = hostName.substring(0,hostName.indexOf("."));
							var dataVal = {
									'hostName':hostName
							}
							$.ajax({
								url:contextPath+"/app/users/getHostData",
								type:"GET",
								data:dataVal,
								success:function(data) {
									var json  = $.parseJSON(data);
									$.each(json.data, function(i, item){
										var rowData = item.row;
										hostInfo.push(rowData);
									});
								},
								error:function(msg) {
									alert("ERROR: " + msg);
								}
							}).done(function() {
								$('#hostName').val(hostName);
								for(var i = 0; i < hostInfo.length; i++) {
									$.each(hostInfo[i],function(i, row) {
										if(row.name == "AssetTag") {
											 $('#assetTag').val(row.value);
										}
										else if(row.name == "MemoryCapacity") {
											 $('#memoryCapacity').val(row.value);
										}
										else if(row.name == "NumberOfProcessors") {
											 $('#numberOfProcessors').val(row.value);
										}
										else if(row.name == "ServerAddress") {
											 $('#serverAddress').val(row.value);
										}
										else if(row.name == "ServerBuilding") {
											 $('#serverBuilding').val(row.value);
										}
										else if(row.name == "ServerCity") {
											 $('#serverCity').val(row.value);
										}
										else if(row.name == "ServerCountry") {
											 $('#serverCountry').val(row.value);
										}
										else if(row.name == "ServerFloor") {
											 $('#serverFloor').val(row.value);
										}
										else if(row.name == "ServerMake") {
											 $('#serverMake').val(row.value);
										}
										else if(row.name == "ServerModel") {
											 $('#serverModel').val(row.value);
										}
										else if(row.name == "ServerRole") {
											 $('#serverRole').val(row.value);
										}
										else if(row.name == "ServerState") {
											 $('#serverState').val(row.value);
										}
										else if(row.name == "ServerZipCode") {
											 $('#serverZipCode').val(row.value);
										}
									});
								}
								if(hostInfo.length == 0) {
									alert("Host Information Not Found.");
								}
								else {
									$("#dialogHostInfo").dialog("open");	
								}
							});	
						}
					});
					
				}
				finally
				{
					//layout.execute(parent);
					load(graph, null, x, y, vertices);
					graph.getModel().endUpdate();
				}
			}
		}
		
		
		// Program starts here. Creates a sample graph in the
		// DOM node with the specified ID. This function is invoked
		// from the onLoad event handler of the document (see below).
		function serverHardware(container)
		{
			$('#graphContainer').empty();
			// Checks if the browser is supported
			if (!mxClient.isBrowserSupported())
			{
				// Displays an error message if the browser is not supported.
				mxUtils.error('Browser is not supported!', 200, false);
			}
			else
			{
				// Disables the built-in context menu
				mxEvent.disableContextMenu(container);
				
				// Creates the graph inside the given container
				var graph = new mxGraph(container);
				var prefix = 'shape=image;image=<%=contextPath%>/images/Server_small.jpg;';
				graph.removeCells(graph.getChildVertices(graph.getDefaultParent()));
				// Enables rubberband selection
				new mxRubberband(graph);
				
				// Gets the default parent for inserting new cells. This
				// is normally the first child of the root (ie. layer 0).
				graph.setPanning(true);
				graph.panningHandler.useLeftButtonForPanning = true;
				graph.setAllowDanglingEdges(false);
				var parent = graph.getDefaultParent();		
				// Adds cells to the model in a single step
				//graph.setEnabled(false);
				graph.getModel().beginUpdate();
				graph.setHtmlLabels(true);
				graph.getView().updateStyle = true;
				var w = 100;
				var h = 80;
				var vertices = [];
				var map = new Object();
				var idMap = new Object();
				var edgeMap = [];
				var serverDataMap = [];
				var parentName;
				var cellChanges = [];
				var appNameMap = [];
				var serverInfo = [];
				var serverNameMap = [];
				memoryCapacity.length = 0, numberOfProcessors.length = 0, serverRole.length = 0, serverMake.length = 0, serverBuilding.length = 0;
				
				var style = new Object();
				style[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
				style[mxConstants.STYLE_STROKECOLOR] = '#000000';
				style[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_TOP;
				style[mxConstants.STYLE_VERTICAL_LABEL_POSITION] = mxConstants.ALIGN_BOTTOM;
				style[mxConstants.STYLE_IMAGE] = '<%=contextPath%>/images/Server_small.jpg';
				style[mxConstants.STYLE_IMAGE_WIDTH] = '48';
				style[mxConstants.STYLE_IMAGE_HEIGHT] = '48';
				graph.getStylesheet().putCellStyle('custom', style);
				
				try
				{
					var id = $('#search').val();
					var x = 0, y = 0;
					var dataVal = {
						'id':id	
					};
					$.ajax({
						url:contextPath+"/app/users/getServerHardware",
						type:"GET",
						data: dataVal,
						success:function(data) {
							var json  = $.parseJSON(data);
							$.each(json.data, function(i, item){
								var rowData = item.row;
								serverInfo.push(rowData);
							});
						},
						error:function(msg) {
							alert("ERROR: " + msg);
						}
					}).done(function() {
						var hostName = '';
						for(var i = 0; i < serverInfo.length; i++) {
							$.each(serverInfo[i],function(i, row) {
								if(row.name == "HostName") {
									hostName = row.value;
									serverDataMap[hostName] = serverInfo[i];
								}
								else if(row.name == "MemoryCapacity") {
									memoryCapacity.push(row.value);
								}
								else if(row.name == "NumberOfProcessors") {
									numberOfProcessors.push(row.value);
								}
								else if(row.name == "ServerRole") {
									serverRole.push(row.value);
								}
								else if(row.name == "ServerMake") {
									serverMake.push(row.value);
								}
								else if(row.name == "ServerBuilding") {
									serverBuilding.push(row.value);
								}
							});
							if(serverInfo.length < 35) {
								if(i%5 == 0 && i != 0) {
									y += 120;
									x = 0;
								}
							}
							else {
								if(i%10 == 0 && i != 0) {
									y += 120;
									x = 0;
								}
							}
							var v1 = graph.insertVertex(parent, null, hostName, x, y, w, h, prefix+'whiteSpace=wrap;verticalLabelPosition=bottom;verticalAlign=top');
							serverNameMap[v1.id] = hostName;
							vertices.push(v1);
							x += 130;
						}
					});
				

					$('#memoryCapacity-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var memoryCapacity = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var serverInfo = serverDataMap[vertex.value];
							$.each(serverInfo,function(i, row) {
								if(row.name == "MemoryCapacity" && row.value == memoryCapacity) {
									verticesChanged.push(vertex);
									//var style = new Object();
									//style[mxConstants.STYLE_STROKECOLOR] = '#000000';
									//style[mxConstants.STYLE_STROKEWIDTH] = '3';
									//graph.getStylesheet().putCellStyle(vertex, style);
									graph.getModel().setStyle(vertex,prefix+'perimeter=rectangePerimeter;verticalLabelPosition=bottom;verticalAlign=top;strokeColor=black;strokeWidth=10;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var hostName = serverNameMap[vertex.id];
								graph.getModel().setStyle(vertex,prefix+'whiteSpace=wrap;verticalLabelPosition=bottom;verticalAlign=top');				
								graph.labelChanged(vertex,hostName);
							}					
						}	
					});
					
					$('#numberOfProcessors-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var numberOfProcessors = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var serverInfo = serverDataMap[vertex.value];
							$.each(serverInfo,function(i, row) {
								if(row.name == "NumberOfProcessors" && row.value == numberOfProcessors) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					$('#serverRole-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var serverRole = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var serverInfo = serverDataMap[vertex.value];
							$.each(serverInfo,function(i, row) {
								if(row.name == "ServerRole" && row.value == serverRole) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					$('#serverMake-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var serverMake = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var serverInfo = serverDataMap[vertex.value];
							$.each(serverInfo,function(i, row) {
								if(row.name == "ServerMake" && row.value == serverMake) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					$('#serverBuilding-options').delegate('li','click',function() {
						if($(this).children('span').hasClass('ui-icon ui-icon-check')) {
							$(this).children('span').removeClass('ui-icon ui-icon-check');
						}
						else {
							$(this).children('span').addClass('ui-icon ui-icon-check');
						}
						var serverBuilding = $(this).text();
						var verticesChanged = [];
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							var serverInfo = serverDataMap[vertex.value];
							$.each(serverInfo,function(i, row) {
								if(row.name == "ServerBuilding" && row.value == serverBuilding) {
									verticesChanged.push(vertex);
									graph.getModel().setStyle(vertex,'strokeColor=green;strokeWidth=3;whiteSpace=wrap;');
								}
							});								
						}
						for(var i = 0; i < vertices.length; i++) {
							var vertex = vertices[i];
							if(verticesChanged.indexOf(vertex) < 0) {
								var appName = appNameMap[vertex.id];
								graph.getModel().setStyle(vertex,'whiteSpace=wrap;');				
								graph.labelChanged(vertex,appName);
							}					
						}	
					});
					
					var highlight = new mxCellTracker(graph, '#00FF00');
					graph.addListener(mxEvent.CLICK, function(source, evt) {
						var cell = evt.getProperty('cell');
						if (cell != null) {
							var serverInfo = serverDataMap[cell.value];
							$('#hostName').val(cell.value);
							$.each(serverInfo,function(i, row) {
								if(row.name == "AssetTag") {
									 $('#assetTag').val(row.value);
								}
								else if(row.name == "MemoryCapacity") {
									 $('#memoryCapacity').val(row.value);
								}
								else if(row.name == "NumberOfProcessors") {
									 $('#numberOfProcessors').val(row.value);
								}
								else if(row.name == "ServerAddress") {
									 $('#serverAddress').val(row.value);
								}
								else if(row.name == "ServerBuilding") {
									 $('#serverBuilding').val(row.value);
								}
								else if(row.name == "ServerCity") {
									 $('#serverCity').val(row.value);
								}
								else if(row.name == "ServerCountry") {
									 $('#serverCountry').val(row.value);
								}
								else if(row.name == "ServerFloor") {
									 $('#serverFloor').val(row.value);
								}
								else if(row.name == "ServerMake") {
									 $('#serverMake').val(row.value);
								}
								else if(row.name == "ServerModel") {
									 $('#serverModel').val(row.value);
								}
								else if(row.name == "ServerRole") {
									 $('#serverRole').val(row.value);
								}
								else if(row.name == "ServerState") {
									 $('#serverState').val(row.value);
								}
								else if(row.name == "ServerZipCode") {
									 $('#serverZipCode').val(row.value);
								}
							});						
							if(serverInfo == null) {
								alert("Host Information Not Found.");
							}
							else {
								$("#dialogHostInfo").dialog("open");	
							}
						}
					});
					
					$('#zoomIn').click(function() {
						graph.zoomIn();
					});
					$('#zoomOut').click(function() {
						graph.zoomOut();
					});				
				}
				finally
				{
					//layout.execute(parent);
					//load(graph, parentNode, x, y, vertices);
					graph.getModel().endUpdate();
				}
			}
		};
		
		function load(graph, cell, x, y, vertices) {
			//if (graph.getModel().isVertex(cell)) {										
				// Arranges the response in a circle
				var cellCount = vertices.length;
				var phi = 2 * Math.PI / cellCount;
				var r = x/2.6;//Math.max(x/1.5 , y/1.5);
				for (var i = 0; i < cellCount; i++) {
					var geo = graph.getModel().getGeometry(vertices[i]);		
					if (geo != null) {
						geo = geo.clone();
						geo.x =  x + r * Math.sin(i * phi);
						geo.y = y +  r * Math.cos(i * phi);
						graph.getModel().setGeometry(vertices[i], geo);
					}
				}		
			//}
				unBlockSection('body');
		}
		
		function eventsForAppInfo() {
			$("#dialogAppInfo").dialog({
				autoOpen: false,
				modal:true,
				width: 500,
				close: function () {
					$(this).dialog('close');
				},
				buttons: [
					{
						text: "Go to Application",
						click: function() {
							var id ;
							if($.trim($('#type').val()) == "Application ID") {
								id = $.trim($('#applicationId').val());
							}
							else if($.trim($('#type').val()) == "Application Name") {
								id = $.trim($('#applicationName').val());
							}
							else if($.trim($('#type').val()) == "Application Group Name") {
								$('#type').val('Application ID')
								id = $.trim($('#applicationId').val());
							}
							$('#search').val(id);
							$(this).dialog('close');
							$('#submit').trigger('click');
						}
					}
				]
			});
		}
		
		function eventsForHostInfo() {
			$("#dialogHostInfo").dialog({
				autoOpen: false,
				modal:true,
				width: 500,
				close: function () {
					$(this).dialog('close');
				},
				buttons: [
					{
						text: "Get Applications",
						click: function() {
							alert("clicked");
							$(this).dialog('close');
						}
					},
					{
						text: "Get Processes",
						click: function() {
							var processInfo = [];
							var hostName = $('#hostName').val();
							var dataVal = {
									'hostName':hostName
							}
							$.ajax({
								url:contextPath+"/app/users/getHostConnections",
								type:"GET",
								data:dataVal,
								success:function(data) {
									var json  = $.parseJSON(data);
									if($.isEmptyObject(json.processes)) {
										alert("Process information not found.")
									}
									else {
										$.each(json.processes, function(i,row) {
											hostProcesses.push(row);
										});
										main3(document.getElementById('graphContainer'),hostName,hostProcesses);
									}
								},
								error:function(msg) {
									alert("ERROR: " + msg);
								}
							})
							$(this).dialog('close');
						}
					}
				]
			});
		}
		
		function eventsForTransportInfo() {
			$("#dialogTransportInfo").dialog({
				autoOpen: false,
				modal:true,
				width: 500,
				close: function () {
					$(this).dialog('close');
				},
				buttons: [
					{
						text: "Close",
						click: function() {
							$(this).dialog('close');
						}
					}
				]
			});
		}
		
		function eventsForProcessInfo() {
			$("#dialogProcessInfo").dialog({
				autoOpen: false,
				modal:true,
				width: 500,
				close: function () {
					$(this).dialog('close');
				},
				buttons: [
					{
						text: "Close",
						click: function() {
							$(this).dialog('close');
						}
					}
				]
			});
		}
		
		function loadingBlockMask(blockId,message) {
			if (message == undefined) {
				message = 'PLEASE WAIT';
			}
			$(blockId).block({
				message: '<table style="padding-top:2px;border:none !important;margin: 0 auto;text-align:center;" ><tr><td><img src="'+contextPath+'/images/loading_icon.gif" style="width:38px;height:38px" /></td></tr><tr><td style="text-align:center;"><span style="font-size: 11px; font-weight: bold;color:#54301a">'+message+'</span></td><tr></table>',
				css: {
					textAlign:'center',
					top:'130px',
					width: '150px',
					border:'none'
				},
				overlayCSS: {
					backgroundColor: '#AAAAAA',
					opacity: 0.50,
					cursor: "default"
				}
			});
		}

		function unBlockSection(blockId) {
			$(blockId).unblock();
		}
	</script>
</head>
<body>
	<div id="dashboardHeader">
		<table style="padding-top: 5px; border: #331B0F;">
			<tr>
				<td style="width:190px; " ><img src="<%=contextPath%>/images/logo.png" /></td>
				<td><span class="dashboardHeaderStyle">AppConnect</span></td>
				<td style="height: 30px; width:100%; float:right; padding-bottom: 7px; padding-right: 10px;">
					<a style="color: #ffffff; font-size: 12px; float: right; font-family:Verdana,Arial,sans-serif;" href="#" onclick="logoutApp();">Logout</a>
					<a id="preferencesLink" style="color: #ffffff; font-size: 12px; float: right; width: 100px; font-family:Verdana,Arial,sans-serif;" href="#" >Preferences </a>
				</td>
			</tr>
		</table>
	</div>
	<div id="header">
		<div class="wrap zoom">
				<button id="zoomIn">+</button>
				<button id="zoomOut">-</button>
		</div>
		<div class="wrap">
			<label for="applications">Choose Search Type: </label>
	        <select name="type" id="type"></select>
	        <label for="search">Search: </label>
	        <input id="search">		    
	        <label for="applications">Choose Graph Type: </label>
	        <select name="graphType" id="graphType"></select>
	        <button id="submit">Submit</button>	  			    
	    </div>	    
	   <!--  <div class="businessProcess">
	    	<label for="l1process">L1 Business Process: </label>
	        <select name="l1ProcessList" id="l1ProcessList"></select> 
	        <label for="l2process">L2 Business Process: </label>
	        <select name="l2ProcessList" id="l2ProcessList"></select>   	
	        <label for="l3process">L3 Business Process: </label>
	        <select name="l3ProcessList" id="l3ProcessList"></select> 	    
	        <button id="processSubmit">Submit</button>	  
	    </div> -->
	</div>
	<hr>
	
	<div id="wrapper">
		<div id="filterToggle"><p>
					<a href="#" id="create-environment-link" class="dialog-link ui-state-default ui-corner-all">
						<span class="ui-icon ui-icon-newwin"></span>Toggle Filter
					</a>
				</p></div>
		<div id="filter">
			<h1>Filter</h1>
			<button id="reset">Reset</button>	
		</div>
	<div id="graphContainer" style="background: url('<%=contextPath%>/images/grid.gif');">
		<img src='<%=contextPath%>/images/loading_icon.gif' style="display: none;" id="loading_image">
	</div>
	</div>
	<div id="dialogAppInfo" title="Application Information">
		<table class="tftable" bgcolor="#404040">
			<tr>
				<td>Application Name:</td>
				<td><input type="text" class="styled-text" value="" name="applicationName" id="applicationName"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Previous Name:</td>
				<td><input type="text" class="styled-text" value="" name="previousName" id="previousName"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Application Id:</td>
				<td><input type="text" class="styled-text" value="" name="applicationId" id="applicationId"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Application LOB:</td>
				<td><input type="text" class="styled-text" value="" name="applicationLOB" id="applicationLOB"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Application Acronym:</td>
				<td><input type="text" class="styled-text" value="" name="applicationAcronym" id="applicationAcronym"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Application Creation Date:</td>
				<td><input type="text" class="styled-text" value="" name="applicationCreationDate" id="applicationCreationDate"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Application URL:</td>
				<td><input type="text" class="styled-text" value="" name="applicationURL" id="applicationURL"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Investment Strategy:</td>
				<td><input type="text" class="styled-text" value="" name="investmentStrategy" id="investmentStrategy"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>State:</td>
				<td><input type="text" class="styled-text" value="" name="state" id="state"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Technology Group Owner:</td>
				<td><input type="text" class="styled-text" value="" name="technologyGroupOwner" id="technologyGroupOwner"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Description:</td>
				<td><textarea id="description" rows="5" cols="49"></textarea></td>
			</tr>
		</table>
	</div>
	<div id="dialogHostInfo" title="Host Information">
		<table class="tftable" bgcolor="#404040">
			<tr>
				<td>Host Name:</td>
				<td><input type="text" class="styled-text" value="" name="hostName" id="hostName"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>AssetTag:</td>
				<td><input type="text" class="styled-text" value="" name="assetTag" id="assetTag"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Memory Capacity:</td>
				<td><input type="text" class="styled-text" value="" name="memoryCapacity" id="memoryCapacity"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Number of Processors:</td>
				<td><input type="text" class="styled-text" value="" name="numberOfProcessors" id="numberOfProcessors"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server Address:</td>
				<td><input type="text" class="styled-text" value="" name="serverAddress" id="serverAddress"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server Building:</td>
				<td><input type="text" class="styled-text" value="" name="serverBuilding" id="serverBuilding"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server City:</td>
				<td><input type="text" class="styled-text" value="" name="serverCity" id="serverCity"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server Country:</td>
				<td><input type="text" class="styled-text" value="" name="serverCountry" id="serverCountry"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server Floor:</td>
				<td><input type="text" class="styled-text" value="" name="serverFloor" id="serverFloor"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server Make:</td>
				<td><input type="text" class="styled-text" value="" name="serverMake" id="serverMake"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server Model:</td>
				<td><input type="text" class="styled-text" value="" name="serverModel" id="serverModel"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server Region:</td>
				<td><input type="text" class="styled-text" value="" name="serverRegion" id="serverRegion"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server Role:</td>
				<td><input type="text" class="styled-text" value="" name="serverRole" id="serverRole"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server State:</td>
				<td><input type="text" class="styled-text" value="" name="serverState" id="serverState"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Server ZipCode:</td>
				<td><input type="text" class="styled-text" value="" name="serverZipCode" id="serverZipCode"  maxlength="100"/></td>
			</tr>
		</table>
	</div>	
	<div id="dialogProcessInfo" title="Process Information">
		<table class="tftable" bgcolor="#404040">
			<tr>
				<td>Process Name:</td>
				<td><input type="text" class="styled-text" value="" name="processName" id="processName"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Command:</td>
				<td><input type="text" class="styled-text" value="" name="command" id="command"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Argument:</td>
				<td><input type="text" class="styled-text" value="" name="argument" id="argument"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>User Name:</td>
				<td><input type="text" class="styled-text" value="" name="userName" id="userName"  maxlength="100"/></td>
			</tr>
		</table>
	</div>
	
	<div id="dialogTransportInfo" title="Transport Information">
		<table class="tftable" bgcolor="#404040">
			<tr>
				<td>Feed Name:</td>
				<td><input type="text" class="styled-text" value="" name="feedName" id="feedName"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Frequency:</td>
				<td><input type="text" class="styled-text" value="" name="frequency" id="frequency"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Data Content:</td>
				<td><input type="text" class="styled-text" value="" name="dataContent" id="dataContent"  maxlength="100"/></td>
			</tr>
			<tr>
				<td>Transport Mechanism:</td>
				<td><input type="text" class="styled-text" value="" name="transportMechanism" id="transportMechanism"  maxlength="100"/></td>
			</tr>
		</table>
	</div>
</body>
</html>