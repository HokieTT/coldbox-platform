<!-----------------------------------------------------------------------********************************************************************************Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corpwww.coldboxframework.com | www.luismajano.com | www.ortussolutions.com********************************************************************************Author     :	Sana UllahDate        :	March 05 2008Description :	This proxy is an inherited coldbox remote proxy used for enabling	coldbox as a model framework.-----------------------------------------------------------------------><cfcomponent name="general" extends="coldbox.system.eventhandler" output="false">		<!--- This init format is mandatory if you are writing init code else is optional, 	      include the super.init(arguments.controller). 	<cffunction name="init" access="public" returntype="any" output="false">		<cfargument name="controller" type="any">		<cfset super.init(arguments.controller)>		<!--- Any constructor code here --->		<cfreturn this>	</cffunction>	--->	<cffunction name="dspHome" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Do Your Logic Here to prepare a view --->		<cfset Event.setValue("welcomeMessage","Welcome to ColdBox!")>			<!--- Set the View To Display, after Logic --->		<cfset Event.setView("vwHome")>	</cffunction>		<!--- CFGRID example --->	<cffunction name="dspGrid" access="public" returntype="any" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Do Your Logic Here to prepare a view --->		<cfset Event.setValue("welcomeMessage","Welcome to ColdBox!")>		<!--- Set the View To Display, after Logic --->		<cfset Event.setView("vwCFGrid")>	</cffunction>		<cffunction name="doData" access="public" returntype="query" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Call your service layer and data from database --->		<cfset var qry1 = getColdBoxOCM().get('qry1') />		<cfreturn qry1>	</cffunction>		<!--- CFINPUT Auto Suggest --->	<cffunction name="dspCFInput" access="public" returntype="any" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Do Your Logic Here to prepare a view --->		<cfset Event.setValue("welcomeMessage","Welcome to ColdBox!")>			<!--- Set the View To Display, after Logic --->		<cfset Event.setView("vwCFinputAutoSuggest")>	</cffunction>		<cffunction name="doLookupName" access="public" returntype="Array" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfset var searchstring = Event.getValue('search','') />		<cfset var FindFirstName = getColdBoxOCM().get('qry1') />		<cfset var results = ArrayNew(1)>				<cfif len(searchstring)>			<cfquery name="FindFirstName" dbtype="query">				SELECT * FROM FindFirstName				WHERE fname like '%#searchstring#%'			</cfquery>		</cfif>				<cfloop query="FindFirstName" endrow="5">			<cfset ArrayAppend(results,FindFirstName.fname)>		</cfloop>				<cfreturn results>	</cffunction>			<!--- CFAJAXPROXY feature... using client side javascript  --->	<cffunction name="dspAjaxProxy" access="public" returntype="any" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">				<!--- Do Your Logic Here to prepare a view --->		<cfset Event.setValue("welcomeMessage","Welcome to ColdBox!")>			<!--- Set the View To Display, after Logic --->		<cfset Event.setView("vwCFAjaxProxy")>			</cffunction>		<cffunction name="doEmployees" access="public" returntype="any" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<cfset var ID = Event.getValue('ID',0) />		<!--- Call your service layer and data from database --->		<!--- I have dummy query stored in ColdBox Cache (this is just for demo purpose) --->		<cfset var FindEmployee= getColdBoxOCM().get('qry1') />				<cfif ID GT 0>			<cfquery name="FindEmployee" dbtype="query">				SELECT * FROM FindEmployee				WHERE idt = #ID#			</cfquery>		</cfif>				<cfreturn FindEmployee>	</cffunction>		<!--- login form --->	<cffunction name="dspLogin" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Set the View To Display, after Logic --->		<cfset Event.setView("vwLoginForm")>	</cffunction>		<!--- cflayout with tabs --->	<cffunction name="dspTabLayout" access="public" returntype="void" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Set the View To Display, after Logic --->		<cfset Event.setView("vwTabLayout")>	</cffunction>		<!--- tab1 content --->	<cffunction name="dspTab1" access="public" returntype="string" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Set the View To Display, after Logic --->		<!--- no debuggin panel --->		<cfset Event.showdebugpanel(false)  />		<!--- just set view name without any layout --->		<cfset Event.setView(name = 'vwTab1',noLayout = true) />		<!--- render directly to browser --->		<cfreturn renderView('vwTab1') /> 	</cffunction>		<!--- tab2 content --->	<cffunction name="dspTab2" access="public" returntype="any" output="false">		<cfargument name="Event" type="coldbox.system.beans.requestContext">		<!--- Set the View To Display, after Logic --->		<!--- set view without any layout --->		<cfset Event.setView(name = 'vwTab2',noLayout = true) />		<!--- send back to proxy --->		<cfreturn renderView('vwTab2') />	</cffunction></cfcomponent>