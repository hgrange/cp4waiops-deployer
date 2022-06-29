<center> <h1>CP4WatsonAIOps CP4WAIOPS v.3.4.0</h1> </center>
<center> <h2>Demo Environment Installation - Short Track 🚀</h2> </center>

![K8s CNI](./doc/pics/front.png)


<center> ©2022 Niklaus Hirt / IBM </center>


<div style="page-break-after: always;"></div>


### ❗ THIS IS WORK IN PROGRESS
Please drop me a note on Slack or by mail nikh@ch.ibm.com if you find glitches or problems.





<div style="page-break-after: always;"></div>

---------------------------------------------------------------
# Installation
---------------------------------------------------------------

## 🚀 Demo Installation

Those are the steps that you have to execute to install a complete demo environment:

1. [AI Manager Installation](#2-ai-manager-installation)
1. [AI Manager Configuration](#3-ai-manager-configuration)
1. [Slack integration](#6-slack-integration)
1. [Demo the Solution](#7-demo-the-solution)

> ❗You can find a PDF version of this guide here: [PDF](./INSTALL_CP4WAIOPS.pdf).
> 

### 🚨🚨🚨🚨 📺 Here is a video that walks you through the complete [installation process](https://ibm.box.com/s/nn9731pjbbjq0i79o89zyr1v3kovfaxm).

## 🚀 TLDR - Fast Track

These are the high level steps that you need to execute to install the demo environment

1. Install AI Manager
	1. Install directly from the OCP Web UI
		1. In the the OCP Web UI click on the + sign in the right upper corner
		1. Copy and paste the content from [this file](./tools/08_Quick_Install_Jobs/02_FVT_INSTALL_AIMGR_ALL.yaml)
		2. Replace `<REGISTRY_TOKEN>` at the end of the file with your pull token from step 1.3.1
		3. Click `Save`
		
	1. Install from your PC
		```bash
		ansible-playbook ./ansible/01_cp4waiops-aimanager-all.yaml -e CP_ENTITLEMENT_KEY=<REGISTRY_TOKEN> 
		```


1. [AI Manager Configuration](#3-ai-manager-configuration)
1. [Slack integration](#6-slack-integration)

<div style="page-break-after: always;"></div>

## ℹ️ Old documentation for reference

* Info
	* [Changelog](./CHANGELOG.md)
	* [Demo Architecture](./doc/ARCHITECTURE.md)
	* [Detailed Prerequisites](./doc/PREREQUISITES.md)
	* [Troubleshooting](./doc/TROUBLESHOOTING.md)
* Installation
	* [Event Manager Install](./doc/INSTALL_EVENT_MANAGER.md)
	* [Event Manager Configuration](./doc/CONF_EVENT_MANAGER.md)
	* [Uninstall CP4WAIOPS](./doc/UNINSTALL.md)
* Configuration
	* [Manual Runbook Configuration](./doc/CONF_RUNBOOKS.md)
	* [Additional Configuration](./doc/CONF_MISC.md)
	* [Service Now integration](./doc/INTEGRATION_SNOW.md)
* Install additional components
	* [Installing Turbonomic](./doc/INSTALL_TURBONOMIC.md)
	* [Installing ELK ](./doc/INSTALL_ELK.md)





<div style="page-break-after: always;"></div>

---------------------------------------------------------------
# 1 Introduction
---------------------------------------------------------------


This document is a short version of the full [README](./README_FULL.md) 🐥 that contains only the essential steps.



This is provided `as-is`:

* I'm sure there are errors
* I'm sure it's not complete
* It clearly can be improved


**❗This has been tested for the new CP4WAIOPS v.3.4.0 release on OpenShift 4.8 (4.10 not being available on Techzone yet) on ROKS**




So please if you have any feedback contact me 

- on Slack: @niklaushirt or
- by Mail: nikh@ch.ibm.com


<div style="page-break-after: always;"></div>




## 1.1 Get the code 

Clone the GitHub Repository

From IBM internal:

```
git clone https://<YOUR GIT TOKEN>@github.ibm.com/NIKH/cp4waiops-deployer.git 
```

Or my external repo:

```
git clone https://github.com/niklaushirt/cp4waiops-deployer.git
```


## 1.2 Prerequisites 

### 1.2.1 OpenShift requirements 

I installed the demo in a ROKS environment.

You'll need:

- ROKS 4.8
- 5x worker nodes Flavor `b3c.16x64` (so 16 CPU / 64 GB) 

You **might** get away with less if you don't install some components (Event Manager, ELK, Turbonomic,...) but no guarantee:

- Typically 4x worker nodes Flavor `b3c.16x64` _**for only AI Manager**_

<div style="page-break-after: always;"></div>

### 1.2.2 Tooling 

You need the following tools installed in order to follow through this guide (if you decide to install from your PC):

- ansible
- oc (4.7 or greater)
- jq
- kafkacat (only for training and debugging)
- elasticdump (only for training and debugging)
- IBM cloudctl (only for LDAP)



#### 1.2.1 On Mac - Automated (preferred) 

*Only needed if you decide to install from your PC*

Just run:

```bash
./10_install_prerequisites_mac.sh
```

#### 1.2.2 On Ubuntu - Automated (preferred) 

*Only needed if you decide to install from your PC*

Just run:

```bash
./11_install_prerequisites_ubuntu.sh
```

 

<div style="page-break-after: always;"></div>

## 1.3 Pull Secrets 

### 1.3.1 Get the CP4WAIOPS installation token 

You can get the installation (pull) token from [https://myibm.ibm.com/products-services/containerlibrary](https://myibm.ibm.com/products-services/containerlibrary).

This allows the CP4WAIOPS images to be pulled from the IBM Container Registry.

<div style="page-break-after: always;"></div>




---------------------------------------------------------------
# 2 AI Manager Installation
---------------------------------------------------------------

You have different options:

1. **Install directly from the OCP Web UI** *(no need to install anything on your PC)*
	1. In the the OCP Web UI click on the + sign in the right upper corner
	1. Copy and paste the content from [this file](./tools/08_Quick_Install_Jobs/02_FVT_INSTALL_AIMGR_ALL.yaml)
	2. Replace `<REGISTRY_TOKEN>` at the end of the file with your pull token from step 1.3.1
	3. Click `Save`
	
1. **Install from your PC** *with the token from 1.3.1*
	```bash
	ansible-playbook ./ansible/01_cp4waiops-aimanager-all.yaml -e CP_ENTITLEMENT_KEY=<REGISTRY_TOKEN> 
	```
	
1. **Install with the Easy Installer** *with the token from 1.3.1*
	1. Just run:
		```bash
		./01_easy-install.sh -t <REGISTRY_TOKEN>
		```

	2. Select option 🐥`01` to install the complete `AI Manager` environment with Demo Content.




> This takes about 1.5 to 2 hours.
> After completion Easy Installer will exit, open the documentation and the AI Manager webpage (on Mac) and you'll have to to perform the last manual steps.

> You now have a full, basic installtion of AI Manager with:
> 
>  - AI Manager
>  - Open LDAP & Register with AI Manager
>  - RobotShop demo application
>  - Trained Models based on precanned data (Log- and Metric Anomalies, Similar Incidents, Change Risk)
>  - Topologies for demo scenarios
>  - AWX (OpenSource Ansible Tower) with runbooks for the demo scenarios
>  - Demo UI
>  - Demo Service Account 
>  - Creates valid certificate for Ingress (Slack) 
>  - External Routes (Flink, Topology, ...)
>  - Create Policy Creation for Stories and Runbooks 
> 


 <div style="page-break-after: always;"></div>
 
---------------------------------------------------------------
# 3. AI Manager Configuration 
---------------------------------------------------------------

Those are the manual configurations you'll need to demo the system and that are covered by the flow above.
 
**Configure Topology**
 
1. Re-Run Kubernetes Observer

**Configure Slack**
 
1. Setup Slack



## 3.1 First Login

After successful installation, the Playbook creates a file `./LOGINS.txt` in your installation directory (only if you installed from your PC).

> ℹ️ You can also run `./tools/20_get_logins.sh` at any moment. This will print out all the relevant passwords and credentials.

## 3.1.1 Login as admin

* Open the `LOGINS.txt` file that has been created by the Installer in your root directory
	![K8s CNI](./doc/pics/doc54.png)
* Open the URL from the `LOGINS.txt` file
* Click on `IBM provided credentials (admin only)`

	![K8s CNI](./doc/pics/doc53.png)

<div style="page-break-after: always;"></div>

* Login as `admin` with the password from the `LOGINS.txt` file

	![K8s CNI](./doc/pics/doc55.png)

## 3.1.2 Login as demo User

* Open the `LOGINS.txt` file that has been created by the Installer in your root directory
	![K8s CNI](./doc/pics/doc54.png)
* Open the URL from the `LOGINS.txt` file
* Click on `Enterprise LDAP`
* Login as `demo` with the password `P4ssw0rd!`


	
<div style="page-break-after: always;"></div>



## 3.2 Re-Run Kubernetes Integration

In the AI Manager (CP4WAIOPS) 

1. In the `AI Manager` "Hamburger" Menu select `Define`/`Data and tool integrations`
1. Click `Kubernetes`	
1. Under `robot-shop`, click on `Run` (with the small play button)


<div style="page-break-after: always;"></div>

---------------------------------------------------------------
# 4 Event Manager Installation
---------------------------------------------------------------



You have different options:

1. **Install directly from the OCP Web UI** *(no need to install anything on your PC)*
	1. In the the OCP Web UI click on the + sign in the right upper corner
	1. Copy and paste the content from [this file](./tools/08_Quick_Install_Jobs/03_FVT_INSTALL_EVTMGR_ALL.yaml)
	2. Replace `<REGISTRY_TOKEN>` at the end of the file with your pull token from step 1.3.1
	3. Click `Save`
	
1. **Install from your PC** *with the token from 1.3.1*
	```bash
	ansible-playbook ./ansible/04_cp4waiops-eventmanager-all.yaml -e CP_ENTITLEMENT_KEY=<REGISTRY_TOKEN> 
	```
	
1. **Install with the Easy Installer** *with the token from 1.3.1*
	1. Just run:
		```bash
		./01_easy-install.sh -t <REGISTRY_TOKEN>
		```

	2. Select option 🐥`02` to install the complete `Event Manager` environment with Demo Content.




> This takes about 1 hour.



 <div style="page-break-after: always;"></div>
 
---------------------------------------------------------------
# 5. Event Manager Configuration 
---------------------------------------------------------------




## 5.1 First Login

After successful installation, the Playbook creates a file `./LOGINS.txt` in your installation directory (only if you installed from your PC).

> ℹ️ You can also run `./tools/20_get_logins.sh` at any moment. This will print out all the relevant passwords and credentials.

### 5.1.1 Login as smadmin

* Open the `LOGINS.txt` file that has been created by the Installer in your root directory
* Open the URL from the `LOGINS.txt` file
* Login as `smadmin` with the password from the `LOGINS.txt` file



## 5.2 Topology

### 5.2.1 Create Kubernetes Observer for the Demo Applications 

This is basically the same as for AI Manager as we need two separate instances of the Topology Manager. 


* In the `Event Manager` "Hamburger" Menu select `Administration`/`Topology Management`
* Under `Observer jobs` click `Configure`
* Click `Add new job`
* Under `Kubernetes`, click on `Configure`
* Choose `local` for `Connection Type`
* Set `Unique ID` to `robot-shop`
* Set `data_center` to `robot-shop`
* Under `Additional Parameters`
* Set `Terminated pods` to `true`
* Set `Correlate` to `true`
* Set Namespace to `robot-shop`
* Under `Job Schedule`
* Set `Time Interval` to 5 Minutes
* Click `Save`

## 5.3 EventManager Webhook 

Create Webhooks in EventManager for Event injection and incident simulation for the Demo.

The demo scripts (in the `demo` folder) give you the possibility to simulate an outage without relying on the integrations with other systems.

At this time it simulates:

- Git push event
- Log Events (ELK)
- Security Events (Falco)
- Instana Events
- Metric Manager Events (Predictive)
- Turbonomic Events
- CP4MCM Synthetic Selenium Test Events



<div style="page-break-after: always;"></div>


You have to define the following Webhook in EventManager (NOI): 

* `Administration` / `Integration with other Systems`
* `Incoming` / `New Integration`
* `Webhook`
* Name it `Demo Generic`
* Jot down the WebHook URL and copy it to the `NETCOOL_WEBHOOK_GENERIC` in the `./tools/01_demo/incident_robotshop-noi.sh`file
* Click on `Optional event attributes`
* Scroll down and click on the + sign for `URL`
* Click `Confirm Selections`


Use this json:

```json
{
  "timestamp": "1619706828000",
  "severity": "Critical",
  "summary": "Test Event",
  "nodename": "productpage-v1",
  "alertgroup": "robotshop",
  "url": "https://pirsoscom.github.io/grafana-robotshop.html"
}
```

Fill out the following fields and save:

* Severity: `severity`
* Summary: `summary`
* Resource name: `nodename`
* Event type: `alertgroup`
* Url: `url`
* Description: `"URL"`

Optionnally you can also add `Expiry Time` from `Optional event attributes` and set it to a convenient number of seconds (just make sure that you have time to run the demo before they expire.

<div style="page-break-after: always;"></div>


## 5.4 Create custom Filters and Views


### 5.4.1 Filter 


* In the `Event Manager` "Hamburger" Menu select `Netcool WebGui`
* Click `Administration`
* Click `Filters`
* Select `Global Filters` from the DropDown menu
* Select `Default`
* Click `Copy Filter` (the two papers on the top left) 
* Set to `global`
* Click `Ok`
* Name: AIOPS
* Logic: **Any** ❗ (the right hand option)
* Filter:
	* AlertGroup = 'CEACorrelationKeyParent'
	* AlertGroup = 'robot-shop'

![](./doc/pics/noi10.png)


### 5.4.2 View 
* In the `Event Manager` "Hamburger" Menu select `Netcool WebGui`
* Click `Administration`
* Click `Views`
* Select `System Views` from the DropDown menu
* Select `Example_IBM_CloudAnalytics`
* Click `Copy View` (the two papers on the top left) 
* Set to `global`
* Click `Ok`
* Name: AIOPS
* Configure to your likings.


## 5.5 Create grouping Policy 

* In the `Event Manager` "Hamburger" Menu select `Netcool WebGui`
* Click `Insights`
* Click `Scope Based Grouping`
* Click `Create Policy`
* `Action` select fielt `Alert Group`
* Toggle `Enabled` to `On`
* Save

<div style="page-break-after: always;"></div>

## 5.6 Create Menu item

In the Netcool WebGUI

* Go to `Administration` / `Tool Configuration`
* Click on `LaunchRunbook`
* Copy it (the middle button with the two sheets)
* Name it `Launch URL`
* Replace the Script Command with the following code

	```javascript
	var urlId = '{$selected_rows.URL}';
	
	if (urlId == '') {
	    alert('This event is not linked to an URL');
	} else {
	    var wnd = window.open(urlId, '_blank');
	}
	```
* Save

Then 

* Go to `Administration` / `Menu Configuration`
* Select `alerts`
* Click on `Modify`
* Move Launch URL to the right column
* Save


	
<div style="page-break-after: always;"></div>


---------------------------------------------------------------
# 6. Slack integration
---------------------------------------------------------------


For the system to work you need to follow those steps:

1. Create Slack Workspace
1. Create Slack App
1. Create Slack Channels
1. Create Slack Integration
1. Get the Integration URL
1. Create Slack App Communications
1. Slack Reset

<div style="page-break-after: always;"></div>

## 6.1 Create your Slack Workspace

1. Create a Slack workspace by going to https://slack.com/get-started#/createnew and logging in with an email <i>**which is not your IBM email**</i>. Your IBM email is part of the IBM Slack enterprise account and you will not be able to create an independent Slack workspace outside if the IBM slack service. 

  ![slack1](./doc/pics/slackws1.png)

2. After authentication, you will see the following screen:

  ![slack2](./doc/pics/slackws2.png)

3. Click **Create a Workspace** ->

4. Name your Slack workspace

  ![slack3](./doc/pics/slackws3.png)

  Give your workspace a unique name such as aiops-\<yourname\>.

5. Describe the workspace current purpose

  ![slack4](./doc/pics/slackws4.png)

  This is free text, you may simply write “demo for Watson AIOps” or whatever you like.

6. 

  ![slack5](./doc/pics/slackws5.png)

  You may add team members to your new Slack workspace or skip this step.


At this point you have created your own Slack workspace where you are the administrator and can perform all the necessary steps to integrate with CP4WAOps.

![slack6](./doc/pics/slackws6.png)

**Note** : This Slack workspace is outside the control of IBM and must be treated as a completely public environment. Do not place any confidential material in this Slack workspace.

<div style="page-break-after: always;"></div>

## 6.2 Create Your Slack App

1. Create a Slack app, by going to https://api.slack.com/apps and clicking `Create New App`. 

   ![slack7](./doc/pics/slack01.png)


2. Select `From an app manifest`


  ![slack7](./doc/pics/slack02.png)

3. Select the appropriate workspace that you have created before and click `Next`

4. Copy and paste the content of this file [./doc/slack/slack-app-manifest.yaml](./slack-app-manifest.yaml).

	Don't bother with the URLs just yet, we will adapt them as needed.

5. Click `Next`

5. Click `Create`

6. Scroll down to Display Information and name your CP4WAIOPS app.

7. You can add an icon to the app (there are some sample icons in the ./tools/4_integrations/slack/icons folder.

8. Click save changes

9. In the `Basic Information` menu click on `Install to Workspace` then click `Allow`

<div style="page-break-after: always;"></div>

## 6.3 Create Your Slack Channels


1. In Slack add a two new channels:
	* aiops-demo-reactive
	* aiops-demo-proactive

	![slack7](./doc/pics/slack03.png)


2. Right click on each channel and select `Copy Link`

	This should get you something like this https://xxxx.slack.com/archives/C021QOY16BW
	The last part of the URL is the channel ID (i.e. C021QOY16BW)
	Jot them down for both channels
	
3. Under Apps click Browse Apps

	![slack7](./doc/pics/slack13.png)

4. Select the App you just have created

5. Invite the Application to each of the two channels by typing

	```bash
	@<MyAppname>
	```

6. Select `Add to channel`

	You shoud get a message from <MyAppname> saying `was added to #<your-channel> by ...`


<div style="page-break-after: always;"></div>

## 6.4 Integrate Your Slack App

In the Slack App: 

1. In the `Basic Information` menu get the `Signing Secret` (not the Client Secret!) and jot it down

	![K8s CNI](./doc/pics/doc47.png)
	
3. In the `OAuth & Permissions` get the `Bot User OAuth Token` (not the User OAuth Token!) and jot it down

	![K8s CNI](./doc/pics/doc48.png)

In the AI Manager (CP4WAIOPS) 

1. In the `AI Manager` "Hamburger" Menu select `Define`/`Data and tool integrations`
1. Click `Add connection`
 
	![K8s CNI](./doc/pics/doc14.png)
	
1. Under `Slack`, click on `Add Connection`
	![K8s CNI](./doc/pics/doc45.png)

6. Name it "Slack"
7. Paste the `Signing Secret` from above
8. Paste the `Bot User OAuth Token` from above

	![K8s CNI](./doc/pics/doc50.png)
	
9. Paste the channel IDs from the channel creation step in the respective fields

	![K8s CNI](./doc/pics/doc49.png)
	
	![K8s CNI](./doc/pics/doc52.png)
		
		

10. Test the connection and click save




<div style="page-break-after: always;"></div>

## 6.5 Create the Integration URL

In the AI Manager (CP4WAIOPS) 

1. Go to `Data and tool integrations`
2. Under `Slack` click on `1 integration`
3. Copy out the URL

	![secure_gw_search](./doc/pics/slack04.png)

This is the URL you will be using for step 6.


<div style="page-break-after: always;"></div>

## 6.6 Create Slack App Communications

Return to the browser tab for the Slack app. 

### 6.6.1 Event Subscriptions

1. Select `Event Subscriptions`.

2. In the `Enable Events` section, click the slider to enable events. 

3. For the Request URL field use the `Request URL` from step 5.

	e.g: `https://<my-url>/aiops/aimanager/instances/xxxxx/api/slack/events`

4. After pasting the value in the field, a *Verified* message should display.

	![slacki3](./doc/pics/slacki3.png)

	If you get an error please check 5.7

5. Verify that on the `Subscribe to bot events` section you got:

	*  `app_mention` and 
	*  `member_joined_channel` events.

	![slacki4](./doc/pics/slacki4.png)

6. Click `Save Changes` button.


### 6.6.2 Interactivity & Shortcuts

7. Select `Interactivity & Shortcuts`. 

8. In the Interactivity section, click the slider to enable interactivity. For the `Request URL` field, use use the URL from above.

 **There is no automatic verification for this form**

![slacki5](./doc/pics/slacki5.png)

9. Click `Save Changes` button.

### 6.6.3 Slash Commands

Now, configure the `welcome` slash command. With this command, you can trigger the welcome message again if you closed it. 

1. Select  `Slash Commands`

2. Click `Create New Command` to create a new slash command. 

	Use the following values:
	
	
	| Field | Value |
	| --- | --- |
	|Command| /welcome|
	|Request URL|the URL from above|
	|Short Description| Welcome to Watson AIOps|

3. Click `Save`.

### 6.6.4 Reinstall App

The Slack app must be reinstalled, as several permissions have changed. 

1. Select `Install App` 
2. Click `Reinstall to Workspace`

Once the workspace request is approved, the Slack integration is complete. 

If you run into problems validating the `Event Subscription` in the Slack Application, see 5.2

<div style="page-break-after: always;"></div>

<div style="page-break-after: always;"></div>



<div style="page-break-after: always;"></div>

## 6.7 Slack Reset


### 6.7.1 Get the User OAUTH Token

This is needed for the reset scripts in order to empty/reset the Slack channels.

This is based on [Slack Cleaner2](https://github.com/sgratzl/slack_cleaner2).
You might have to install this:

```bash
pip3 install slack-cleaner2
```
#### Reset reactive channel 

In your Slack app

1. In the `OAuth & Permissions` get the `User OAuth Token` (not the Bot User OAuth Token this time!) and jot it down

In file `./tools/98_reset/13_reset-slack.sh`

2. Replace `not_configured` for the `SLACK_TOKEN` parameter with the token 
3. Adapt the channel name for the `SLACK_REACTIVE` parameter


#### Reset proactive channel 

In your Slack app

1. In the `OAuth & Permissions` get the `User OAuth Token` (not the Bot User OAuth Token this time!) and jot it down (same token as above)

In file `./tools/98_reset/14_reset-slack-changerisk.sh`

2. Replace `not_configured` for the `SLACK_TOKEN` parameter with the token 
3. Adapt the channel name for the `SLACK_PROACTIVE` parameter



### 6.7.2 Perform Slack Reset

Call either of the scripts above to reset the channel:

```bash

./tools/98_reset/13_reset-slack.sh

or

./tools/98_reset/14_reset-slack-changerisk.sh

```


---------------------------------------------------------------
# 7. Demo the Solution
---------------------------------------------------------------



## 7.1 Simulate incident - Command Line

**Make sure you are logged-in to the Kubernetes Cluster first** 

In the terminal type 

```bash
./22_simulate_incident_robotshop.sh
```

This will delete all existing Alerts/Stories and inject pre-canned event, metrics and logs to create a story.

ℹ️  Give it a minute or two for all events and anomalies to arrive in Slack.
ℹ️  You might have to run the script 3-4 times for the log anomalies to start appearing.


