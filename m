Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:5433 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752032AbcAUBoD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jan 2016 20:44:03 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1aM4HL-0001zx-A9
	for fstests@vger.kernel.org; Thu, 21 Jan 2016 12:43:15 +1100
Received: from dave by disappointment with local (Exim 4.86)
	(envelope-from <dave@disappointment.disaster>)
	id 1aM4HL-0002gx-9L
	for fstests@vger.kernel.org; Thu, 21 Jan 2016 12:43:15 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/3] check: add exclude sections CLI parameter
Date: Thu, 21 Jan 2016 12:43:13 +1100
Message-Id: <1453340593-10236-4-git-send-email-david@fromorbit.com>
In-Reply-To: <1453340593-10236-1-git-send-email-david@fromorbit.com>
References: <1453340593-10236-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

When we have a config file with multiple sections, we might want to
exclude certain config sections from running. Rather than specifying
all the section we want to run, add a "-S <section>" option to build
up a list of sections to exclude.

This is useful if a given section config is known to cause a fatal
failure,but you still want to run all the other config sections.

Also add support to the setup program that emits the currently
configured setup for each section in the config file.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check | 15 +++++++++++++++
 setup | 17 ++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 135a9fb..3ef79fc 100755
--- a/check
+++ b/check
@@ -73,6 +73,7 @@ check options
     -d			dump test output to stdout
     --large-fs		optimise scratch device for large filesystems
     -s section		run only specified section from config file
+    -S section		exclude the specified section from the config file
 
 testlist options
     -g group[,group...]	include tests from these groups
@@ -228,6 +229,7 @@ while [ $# -gt 0 ]; do
 	        fi
 		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
+	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
 	-l)	diff="diff" ;;
 	-udiff)	diff="$diff -u" ;;
 
@@ -428,6 +430,19 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		fi
 	fi
 
+	# Did this section get excluded?
+	if [ ! -z "$EXCLUDE_SECTION" ]; then
+		skip=false
+		for s in $EXCLUDE_SECTION; do
+			if [ $section == $s ]; then
+				skip=true
+			fi
+		done
+		if $skip; then
+			continue
+		fi
+	fi
+
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
 		echo "failed to create results directory $RESULT_BASE"
diff --git a/setup b/setup
index 1a41d81..6ef2293 100755
--- a/setup
+++ b/setup
@@ -20,7 +20,8 @@ usage()
 
 	echo "Usage: $0 [options]"'
 
-	-s section		run only specified section(s) from config file
+	-s section	run only specified section(s) from config file
+	-S section	exclude the specified section from the config file
 '
 	exit 0
 }
@@ -29,6 +30,7 @@ while [ $# -gt 0 ]; do
 	case "$1" in
 	-\? | -h | --help) usage ;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
+	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
 	*)	usage ;;
 	esac
 	shift
@@ -58,6 +60,19 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		fi
 	fi
 
+	# Did this section get excluded?
+	if [ ! -z "$EXCLUDE_SECTION" ]; then
+		skip=false
+		for s in $EXCLUDE_SECTION; do
+			if [ $section == $s ]; then
+				skip=true
+			fi
+		done
+		if $skip; then
+			continue
+		fi
+	fi
+
 	[ "$USE_EXTERNAL"    = yes ] || USE_EXTERNAL=no
 	[ "$USE_LBD_PATCH"   = yes ] || USE_LBD_PATCH=no
 	[ "$LARGE_SCRATCH_DEV"  = yes ] || LARGE_SCRATCH_DEV=no
-- 
2.5.0

