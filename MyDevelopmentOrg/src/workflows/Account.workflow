<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Type_To_Customer</fullName>
        <field>Type</field>
        <literalValue>Customer</literalValue>
        <name>Set Type To Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Type_To_Pending</fullName>
        <field>Type</field>
        <literalValue>Pending</literalValue>
        <name>Set Type To Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Type_To_Prospect</fullName>
        <field>Type</field>
        <literalValue>Prospect</literalValue>
        <name>Set Type To Prospect</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Texas_Owner</fullName>
        <field>OwnerId</field>
        <lookupValue>brianandrhonda@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Texas Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Texas Accounts</fullName>
        <actions>
            <name>Texas_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.BillingState</field>
            <operation>equals</operation>
            <value>TX</value>
        </criteriaItems>
        <description>A workflow rule for Texas accounts</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Follow_Up_with_New_Account</name>
                <type>Task</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>Follow_Up_with_New_Account</fullName>
        <assignedTo>brianandrhonda@gmail.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Follow Up with New Account</subject>
    </tasks>
</Workflow>
