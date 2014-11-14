Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45809 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965207AbaKNN3O (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Nov 2014 08:29:14 -0500
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 6/7] Integrates environment functionality into existing code
Date: Fri, 14 Nov 2014 14:27:46 +0100
Message-Id: <1415971667-16873-6-git-send-email-jtulak@redhat.com>
In-Reply-To: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
References: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>, lczerner@redhat.com, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

This patch:
1) adds new arguments to --help and to the parser:
   -e                                 use testing environments
   -eo environment[,environment...]   test only in these environments
   -ex environment[,environment...]   exclude these environments

2) Adds call of sort_tests_by_environment() when -e is supplied.
   Currently, randomization of tests order and environments are
   mutually exclusive. I plan to add this later.

3) It slightly changes the main loop where tests are run. The change
is done because the tests and environments are paired in two variables
and it needs to access both of them. Here the required environment
name is exported and then when the test requires an environment, the
exported variable is used to determine the current one.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 check | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 777c7a2..ca5082b 100755
--- a/check
+++ b/check
@@ -34,6 +34,7 @@ diff="diff -u"
 showme=false
 have_test_arg=false
 randomize=false
+environments_used=false
 export here=`pwd`
 xfile=""
 
@@ -76,12 +77,15 @@ check options
     -n			show me, do not run tests
     -T			output timestamps
     -r			randomize test order
+    -e			use testing environments
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
 
 testlist options
     -g group[,group...]	include tests from these groups
     -x group[,group...]	exclude tests from these groups
+    -eo environment[,environment...]	test only in these environments
+    -ex environment[,environment...]	exclude these environments
     -X file		exclude individual tests
     -E external_file	exclude individual tests
     [testlist]		include tests matching names in testlist
@@ -283,7 +287,7 @@ get_all_tests()
 	for d in $SRC_GROUPS $FSTYP; do
 		ls $SRC_DIR/$d/* | \
 			grep -v "\..*" | \
-			grep -v "group\|Makefile" >> $tmp.list 2>/dev/null
+			grep -v "group\|Makefile\|environment" >> $tmp.list 2>/dev/null
 	done
 }
 
@@ -325,6 +329,7 @@ _timestamp()
 _prepare_test_list()
 {
 	unset list
+	unset list_env
 	# Tests specified on the command line
 	if [ -s $tmp.arglist ]; then
 		cat $tmp.arglist > $tmp.list
@@ -366,6 +371,15 @@ _prepare_test_list()
 	list=`sort -n $tmp.list | uniq`
 	rm -f $tmp.list $tmp.tmp $tmp.grep
 
+	if $environments_used
+	then
+		sort_tests_by_environment $list
+		list=$(cat $tmp.list)
+		list_env=$(cat $tmp.list_env)
+		rm -f $tmp.list $tmp.list_env
+		# TODO add randomizing also for environments
+	fi
+
 	if $randomize
 	then
 		list=`echo $list | awk -f randomize.awk`
@@ -389,6 +403,16 @@ while [ $# -gt 0 ]; do
 		XGROUP_LIST="$XGROUP_LIST $xgroup"
 		;;
 
+	-e)	environments_used=true ;;
+
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
@@ -429,6 +453,13 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
+# Test we don't have test randomizing and environment testing at the same time
+if [ $environments_used = true -a $randomize = true ];then
+	>&2 echo "Environments can't be used at the same time"\
+		" as randomized test order!"
+	exit 1
+fi
+
 # Process tests from command line now.
 if $have_test_arg; then
 	while [ $# -gt 0 ]; do
@@ -665,8 +696,20 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	seqres="$check"
 	_check_test_fs
 
-	for seq in $list
+	read -a list_a <<< $list
+	read -a list_env_a <<< $list_env
+	for i in "${!list_a[@]}"
 	do
+		seq="${list_a[$i]}"
+		export env_last="$env"
+		export env="${list_env_a[$i]}"
+		export env_next="${list_env_a[$(($i+1))]}"
+		export env_force=false
+		if [ "${env:0:1}" = "_" ];then
+			env_force=true
+			env="${env#?}"
+		fi
+
 	    err=false
 
 	    # the filename for the test and the name output are different.
@@ -688,6 +731,12 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	    echo -n "$seqnum"
 
+		# If an environment is requested, print it.
+		# When not requested, output is not changed.
+		if [ "$env" != "" ];then
+			echo -n " [$env]"
+		fi
+
 	    if $showme
 	    then
 		echo
-- 
1.9.3

