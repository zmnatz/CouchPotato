 <!DOCTYPE html>
 <html>
 <head>
     <meta charset="utf-8">
     <title>Couch Potato Remote</title>

	 <!-- Sencha Touch CSS -->
	 <link rel="stylesheet" href="sencha-touch/resources/css/sencha-touch.css" type="text/css">

	 <!-- Google Maps JS -->
	 <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=true"></script>

	 <!-- Sencha Touch JS -->
	 <script type="text/javascript" src="sencha-touch/sencha-touch.js"></script>
	 
 <script type="text/javascript">
 var movieInfo;
 var friendInfo;
  var play = true;
 function togglePlay(){
	if(play){
		Ext.fly('play').hide();
		Ext.fly('pause').show();
	}else{
		Ext.fly('pause').hide();
		Ext.fly('play').show();
	}
	play = !play;
}
 Ext.setup({
	    glossOnIcon: false,
	    onReady: function() {
	     	
	        var panel = new Ext.TabPanel({
	            fullscreen: true,
	            tabBarDock: 'bottom',
	            cardSwitchAnimation: 'cube',
	            id: 'remotePanel',
	            items: [
	                {
	                	iconCls: 'favorites',
	                    title: 'Movies',
	                    xtype: 'panel',
	                    dockedItems: [{
                            dock : 'top',
                            xtype: 'toolbar',
                            ui   : 'light',
                            items: [
								{xtype: 'spacer'},
                                {
                                	xtype: 'selectfield',
                                	name: 'sortOptions',
                                	width: 160,
                                	options: [
										{text:'Sort',value:''},
                                		{text:'Title',value: 'title'},
                                		{text:'Year',value: 'year'},
                                		{text:'Date Added',value:'dateAdded'},
                                		{text:'Genre',value: 'genre'},
                                		{text:'Director',value: 'director'},
                                		{text:'Actor',value:'actor'}
                                	]
                                }
							]
                        }],
                        layout: 'fit',
                        items: [{
                        	id:'movieList',
							xtype: 'list',
							store:new Ext.data.Store({
								sorters: 'title',
								data: <%@ include file="data/movies.json"%>,
								fields: ['title','year','genre','director','actor',''],
								getGroupString: function(record){
									var firstLetter = record.get('title')[0];
									return isNaN(firstLetter) ? firstLetter.toUpperCase() : '#'; 
								}
							}),
							itemTpl: '<div>{title}</div>',
							grouped: true,
							indexBar: true,
							listeners: {itemtap: function(){showMovieInfo(true,false,'movieList')}}
                        }]
	                },
	                {
	                	iconCls: 'team',
	                    title: 'Friends',
	                    xtype: 'panel',
	                    dockedItems: [{
                            dock : 'top',
                            xtype: 'toolbar',
                            ui   : 'light',
                            items: [
								
							]
                        }],
                        layout: 'fit',
                        items: [{
							xtype: 'list',
							store:new Ext.data.JsonStore({
								sorters: 'lastName',
								data: <%@ include file="data/friends.json"%>,
								fields: ['firstName','lastName'],
								getGroupString: function(record){
									return record.get('lastName')[0]
								}
							}),
							listeners: {itemtap: showFriendInfo},
							itemTpl: '<div>{firstName} {lastName}</div>',
							grouped: true,
							indexBar: true
                        }]
	                },
	                {
	                	iconCls: 'maps',
	                    title: 'Watch List',
	                    xtype: 'panel',
	                    dockedItems: [{
                            dock : 'top',
                            xtype: 'toolbar',
                            ui   : 'light',
                            items: [
								{xtype: 'spacer'},
                                {
									iconMask: true,
									ui: 'plain',
                                	iconCls: 'add',
                                	handler: function(){
                                		if(!this.actions)
                                			this.actions = new Ext.ActionSheet({
                                				items: [
												{
													text: 'Add By Name',
													scope: this,
													handler: function(){
														this.actions.hide();
														
														Ext.Msg.prompt('Add a Movie','Please enter the name:',
																function(btn,name){
																if(btn=='ok'){
																	Ext.getCmp('watchList').getStore().add({title: name});
																	Ext.getCmp('watchList').getStore().sort('title','ASC');
																}
																Ext.Msg.hide();
															},window,false,'',{focus: true,autocapitalize:true}
														)
													}
												},
												{
                                					text: 'Add From Camera',
                                					disabled: true,
                                					handler: Ext.emptyFn
                                				},
                                				{
                                					text: 'Cancel',
                                					scope: this,
                                					ui: 'decline',
                                					handler: function(){this.actions.hide()}
                                				}]
                                			})
                                		this.actions.show();
                                	}
                                }
							]
                        }],
                        layout: 'fit',
                        items: [{
                        	id: 'watchList',
							xtype: 'list',
							store:new Ext.data.Store({
								sorters: 'title',
								data: <%@ include file="data/watchlist.json"%>,
								fields: ['title']
							}),
							listeners: {itemtap: function(view,index,item){showMovieInfo(false,false,'watchList')}},
							itemTpl: '<div>{title}</div>'
                        }]
	                },
	                {
	                	iconCls: 'home',
	                	title: 'Remote',
	                	xtype: 'panel',
	                	bodyStyle: "background: url('img/remote.jpg') no-repeat;"
	                },{
	                	iconCls: 'arrow_right',
	                	title: 'Now Playing',
	                	dockedItems: [{
                            dock : 'top',
                            xtype: 'toolbar',
                            ui   : 'light',
                            title: 'Movie Name Here'
                        }],
                        bodyStyle: 'background-color: #203042; padding:10px;',
                        defaults: {
                        	style: 'background-color: transparent;',
                        	defaults: {
                        		flex:1,
                        		layout: {type: 'hbox',align: 'stretch', pack: 'center'},
                        		bodyStyle: 'text-align:center',
                        		style: 'background-color: transparent; color: white'
                        	}
                        },
                       	layout: {type:'vbox',align: 'stretch'},
                        items: [
							{
								flex: 1,
								layout: {type: 'hbox',align: 'stretch', pack: 'center'},
								items: [{html: '<br/>0:00'},{flex: 3,xtype: 'sliderfield'},{html:'<br/>2:23'}]
							},
							{
								flex: 2,
								layout: {type:'hbox',pack:'center'},
								items: [{html: '<img src="img/rewind.png"/>'},
								        {html:'<span onclick="togglePlay()"><img id="play" src="img/play.png"/><img src="img/pause.png" class="x-hidden-display" id="pause"/></span>'},
								        {html:'<img src="img/forward.png"/>'}
								]
							},{
								flex: 2,
								layout: {type:'hbox',pack:'center'},
								items: [
									{html: '<img src="img/previous.png"/>'},
									{html:'<img src="img/stop.png"/>'},
									{html:'<img src="img/next.png"/>'}								
								]
							},
							{
								flex: 1,
								layout: 'hbox',
								items: [{html: '<div style="padding-top: 20px">Volume:</div>'},{flex: 4,xtype: 'sliderfield',minValue: 0,maxValue: 100,value: 60}]
							}
						],listeners: {activate: function(){
							Ext.fly('pause').hide();
							Ext.fly('play').show();
							play = true;
						}}
	                }
	            ]
	        });
	        
	        function showMovieInfo(watchNow,borrow,item){
	        	Ext.getCmp('remotePanel').hide('slide');
        		movieInfo = new Ext.Panel({
             		fullscreen: true,
     	        	hidden: true,
     	        	id: 'moviePanel',
             	 	dockedItems: [{
     					dock : 'top',
     					xtype: 'toolbar',
     					ui   : 'light',
     					items: [
     						{xtype:'button',ui:'back',text:'Back',handler:function(){Ext.getCmp('moviePanel').destroy()}},
     						{xtype: 'spacer'},
     						{xtype:'button',ui:'forward',hidden: !borrow && !watchNow,text:borrow ? 'Borrow Movie' : 'Watch Now',handler:function(){
     							function destroy(){ Ext.getCmp('moviePanel').destroy() }
     							if(this.text=='Borrow Movie')
     								Ext.Msg.alert('Request Sent',null,destroy);
     							else{
     								Ext.getCmp('remotePanel').setActiveItem(4);
     								destroy();
     							}
     						}}
     					]
                     }],
                     listeners: {
     					destroy: function(){
     						Ext.getCmp('remotePanel').show('slide');
     					}
                     },
                     bodyPadding: 20,
    					html: '<div style="float: left; padding: 0px 15px 15px 0px"><img width="100px" height="133px" src="img/Avatar.jpg"/></div><b>Avatar</b><br/><br/>James Cameron<br/>Sam Worthington, Zoe Saldana, Sigourney Weaver<br/><div style="float: left">A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.</div>'
     	        }).show('slide');
	        }
	        
	        function showFriendInfo(list,index,item){
	        	Ext.getCmp('remotePanel').hide('slide');
	        	if(!friendInfo)
	        		 friendInfo = new Ext.Panel({
	             		fullscreen: true,
	     	        	hidden: true,
	     	        	id: 'friendPanel',
	             	 	dockedItems: [{
	     					dock : 'top',
	     					xtype: 'toolbar',
	     					ui   : 'light',
	     					items: [
	     						{xtype:'button',ui:'back',text:'Back',handler:function(){Ext.getCmp('friendPanel').hide(); Ext.getCmp('remotePanel').show('slide');}},
	     					]
	                    }],
	                    layout: {type:'vbox',align: 'stretch'},
	                    items: [
							{ height: 133,bodyStyle:'text-align: center',html: '<img src="img/smiley.gif" width="133px" height="133px"/>' },
							{ height: 30,bodyStyle:'font-weight: bold',html: 'Movies Available'},
							{ 
								id: 'friendMovieList',
								flex: 1,
								xtype: 'list',
								store:new Ext.data.Store({
									sorters: 'title',
									data: <%@ include file="data/movies.json"%>,
									fields: ['title','year','genre','director','actor'],
									getGroupString: function(record){
										var firstLetter = record.get('title')[0];
										return isNaN(firstLetter) ? firstLetter.toUpperCase() : '#'; 
									}
								}),
								itemTpl: '<div>{title}</div>',
								grouped: true,
								listeners: {itemtap: function(view,index,item){Ext.getCmp('friendPanel').hide(); showMovieInfo(false,true,'friendMovieList')}}
							}
						]
	     	        });
	        	friendInfo.getDockedComponent(0).setTitle(item.innerText);
	        	friendInfo.show('slide');
	        }
	    }
	});
 </script>
 </head>
 <body></body>
 </html>