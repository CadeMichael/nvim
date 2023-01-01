local fc = {}

fc.createClass = "sfdx force:apex:class:create -n "
fc.createTrigger = "sfdx force:apex:trigger:create -n "
fc.createLightningApp = "sfdx force:lightning:app:create -n "
fc.createLightingComp = "sfdx force:lightning:component:create -n "
fc.orgOpen = "sfdx force:org:open "
fc.retrieve = "sfdx force:source:retrieve "
fc.execute = "sfdx force:apex:execute -f "

return fc
