<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Date        :	9/3/2007
Description :
	Request service Test
----------------------------------------------------------------------->
<cfcomponent name="cacheTest" extends="coldbox.system.testing.BaseTestCase" output="false">

	<cffunction name="setUp" returntype="void" access="public" output="false">
		<cfscript>
		this.loadColdbox = false;
		
		//super.setup();
		
		mockController = getMockBox().createMock(className='coldbox.system.Controller',clearMethods=true,callLogging=true);
		mockService = getMockBox().createMock(className='coldbox.system.services.interceptorService',clearMethods=true,callLogging=true);
		mockService.$("processState");
		
		mockController.$('getInterceptorService',mockService);
		mockController.$('getAppHash', hash(createUUID()) );
		
		ccbean = createObject("component","coldbox.system.cache.config.CacheConfigBean");
		memento = structnew();
		memento.CacheObjectDefaultTimeout = 20;
		memento.CacheObjectDefaultLastAccessTimeout = 20;
		memento.CacheReapFrequency = 1;
		memento.CacheMaxObjects = 100;
		memento.CacheFreeMemoryPercentageThreshold = 1;
		memento.CacheUseLastAccessTimeouts = true;
		memento.CacheEvictionPolicy = "FIFO";
		ccbean.init(argumentCollection=memento);
		
		cm = createObject("component","coldbox.system.cache.CacheManager").init(mockController);
		cm.configure(ccbean);
		</cfscript>
	</cffunction>
	
	<cffunction name="testConfigure" access="public" returntype="void" hint="" output="false" >
		<cfscript>
			cm.configure(ccbean);
		</cfscript>
	</cffunction>
	
	<cffunction name="testannounceExpiration" output="false">
		<cfscript>
			makePublic(cm,"announceExpiration","_announceExpiration");
			cm._announceExpiration('test');
			debug(mockService.$debug());
		</cfscript>
	</cffunction>
	
	<cffunction name="testClearMulti" output="false">
		<cfscript>
			/* testList */
			list = 'luis,test,whatever,MyTest';
			
			cm.set('MyTest',now());
			
			removed = cm.clearKeyMulti(list);
			
			AssertTrue(removed["MyTest"]);
			
		</cfscript>
	</cffunction>
	
	<cffunction name="testgetCachedObjectMetadataMulti" output="false">
		<cfscript>
			
			/* testList */
			list = 'MyTest,Luis,Whatever';
			
			cm.set('MyTest',now());
			cm.set('Luis',now());
			
			retrieved = cm.getCachedObjectMetadataMulti(list);
			
			AssertTrue( isStruct(retrieved['Luis']) );
			AssertTrue( isStruct(retrieved['MyTest']) );
			AssertFalse( structKeyExists(retrieved,'Whatever') );
		</cfscript>
	</cffunction>
	
	<cffunction name="testgetCachedObjectMetadata" output="false">
		<cfscript>
			
			cm.set('MyTest',now());
			
			md = cm.getCachedObjectMetadata('MyTest');

			AssertTrue( not structisempty(md) );
		</cfscript>
	</cffunction>
	
	<cffunction name="testGetMulti" output="false">
		<cfscript>
			
			/* testList */
			list = 'MyTest,Luis,Whatever';
			
			cm.set('MyTest',now());
			cm.set('Luis',now());
			
			retrieved = cm.getMulti(list);
			
			AssertTrue(structKeyExists(retrieved,"Luis"));
			AssertTrue(structKeyExists(retrieved,"MyTest"));
			AssertFalse(structKeyExists(retrieved,"Whatever"));
		</cfscript>
	</cffunction>
	
	<cffunction name="testLookupMulti" output="false">
		<cfscript>
			
			/* testList */
			list = 'MyTest,Luis,Whatever';
			
			cm.set('MyTest',now());
			cm.set('Luis',now());
			
			retrieved = cm.lookupMulti(list);
			
			AssertTrue(retrieved["Luis"]);
			AssertTrue(retrieved["MyTest"]);
			AssertFalse(retrieved["Whatever"]);
		</cfscript>
	</cffunction>
	
	<cffunction name="testSetMulti" output="false">
		<cfscript>
			
			/* testList */
			mapping["MyTest"] = now();
			mapping["Myname"] = "Luis Majano";
			mapping["MyEmail"] = "whatever@gmail.com";
			
			cm.setMulti(mapping=mapping);
			
			debug(cm.getObjectPool().getPool());
			debug(cm.getpool_metadata());
			
			AssertTrue(cm.lookup('MyTest'),'MyTest failed');
			AssertTrue(cm.lookup('Myname'),'Myname failed');
			AssertTrue(cm.lookup('MyEmail'),'MyEmail failed');
		</cfscript>
	</cffunction>
	
	
</cfcomponent>