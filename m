Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55462 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbbCRSL1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 Mar 2015 14:11:27 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2IIBQBW000402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 18 Mar 2015 14:11:27 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 1/6] new: environments - add support for environments into the check script
Date: Wed, 18 Mar 2015 19:10:25 +0100
Message-Id: <1426702230-22085-2-git-send-email-jtulak@redhat.com>
In-Reply-To: <1426702230-22085-1-git-send-email-jtulak@redhat.com>
References: <1426702230-22085-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

This extends the ./check script for environments support. That includes
arguments parsing for new options "-eo" and "-ex" and few functions
for loading list of available environments from "environments" directory.

The last two hunks in the patch deals with a situation when a user limits
available environments, so a test has no environment it can run in.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 check | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/check b/check
index 0830e0c..fc95d06 100755
--- a/check
+++ b/check
@@ -61,6 +61,7 @@ fi
 SUPPORTED_TESTS="[0-9][0-9][0-9] [0-9][0-9][0-9][0-9]"
 SRC_GROUPS="generic shared"
 export SRC_DIR="tests"
+export ENV_DIR="environments"
 
 usage()
 {
@@ -81,6 +82,8 @@ check options
 testlist options
     -g group[,group...]	include tests from these groups
     -x group[,group...]	exclude tests from these groups
+    -eo environment[,environment...]	test only in these environments
+    -ex environment[,environment...]	exclude these environments
     -X file		exclude individual tests
     -E external_file	exclude individual tests
     [testlist]		include tests matching names in testlist
@@ -88,6 +91,85 @@ testlist options
 	    exit 0
 }
 
+
+
+# Find all environments with setup files in given directory.
+get_environments()
+{
+	local env_list=""
+
+	# ommit "none", this one always has to exists implicitly
+	# and we want it add later
+	env_list=$(ls $ENV_DIR|grep -v "none")
+
+	echo "none $env_list"
+}
+
+# Check if all tests passed in first argument exists in a list passed
+# as a second argument.
+environments_test_existence()
+{
+	local specified  existing
+	specified="$1"
+	existing="$2"
+
+	nonexisting=$(_get_lists_difference "$specified" "$existing")
+	if [ "$nonexisting" != "" ];then
+		echo "Unknown environment(s) were passed"\
+			" as an argument: $nonexisting"
+		exit 1
+	fi
+}
+
+# find which environments are required and which are excluded and export
+# them in "$list_env"
+#
+export_filtered_environments()
+{
+	active_tests="$*"
+	sorted_tests=""
+	sorted_envs=""
+	include_implicit=false
+	existing_environments=$(get_environments)
+
+	required_environments="${ENVIRONMENT_LIST/,/ }"
+	excluded_environments="${XENVIRONMENT_LIST/,/ }"
+
+	# test for nonexisting required
+	environments_test_existence \
+		"$required_environments $excluded_environments" \
+		"$existing_environments"
+
+	# filter environments based on -ex or -eo arguments
+	if [ "$required_environments" = "" ];then
+		# we have no explicit list of envs, so include all
+		required_environments="$existing_environments"
+		include_implicit=true
+
+	elif [ $(echo "$required_environments" |\
+		grep -cw "none") -gt 0 ]
+	then
+		# If there is an explicit list, but "none" is listed there,
+		# include implicit "none" too.
+		# Otherwise "none" is ignored.
+		include_implicit=true
+	fi
+
+	# remove any excluded environment from the list
+	for xenv in $excluded_environments; do
+		required_environments=$(echo "$required_environments" |\
+			sed "s/\b$xenv\b//g")
+
+		# do not include implicit none if explicitly blocked
+		if [ "$xenv" = "none" ];then
+			include_implicit=false
+		fi
+	done
+
+	export list_env="$required_environments"
+
+}
+
 get_group_list()
 {
 	grp=$1
@@ -194,6 +276,8 @@ _prepare_test_list()
 	list=`sort -n $tmp.list | uniq`
 	rm -f $tmp.list $tmp.tmp $tmp.grep
 
+	export_filtered_environments $list
+
 	if $randomize
 	then
 		list=`echo $list | awk -f randomize.awk`
@@ -217,6 +301,14 @@ while [ $# -gt 0 ]; do
 		XGROUP_LIST="$XGROUP_LIST $xgroup"
 		;;
 
+	-eo)	environment=$2 ; shift ;
+		ENVIRONMENT_LIST="$ENVIRONMENT_LIST $environment"
+		;;
+
+	-ex)	xenvironment=$2 ; shift ;
+		XENVIRONMENT_LIST="$XENVIRONMENT_LIST $xenvironment"
+		;;
+
 	-X)	xfile=$2; shift ;
 		for d in $SRC_GROUPS $FSTYP; do
 			[ -f $SRC_DIR/$d/$xfile ] || continue
@@ -581,7 +673,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		else
 			echo -n "	"	# prettier output with timestamps.
 		fi
-		rm -f core $seqres.notrun
+		rm -f core $seqres.notrun $seqres.noenvironment
 
 		start=`_wallclock`
 		$timestamp && echo -n "	["`date "+%T"`"]"
@@ -610,8 +702,15 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 		if [ -f $seqres.notrun ]
 		then
-		    $timestamp || echo -n " [not run] "
-		    $timestamp && echo " [not run]" && echo -n "	$seqnum -- "
+		    # tell user if the test wasn't run because
+		    # he forbid all environments this test supports
+		    # (by -eo/-ex argruments)
+		    nr="not run"
+		    if [ -f $seqres.noenvironment ];then
+		        nr="no environment available"
+		    fi
+		    $timestamp || echo -n " [$nr] "
+		    $timestamp && echo " [$nr]" && echo -n "	$seqnum -- "
 		    cat $seqres.notrun
 		    notrun="$notrun $seqnum"
 		else
-- 
2.1.0

