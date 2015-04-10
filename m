Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44414 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672AbbDJNCe (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 10 Apr 2015 09:02:34 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 2/7] fstests: environments - new functions in common/rc for environment support
Date: Fri, 10 Apr 2015 15:02:24 +0200
Message-Id: <1428670949-17524-3-git-send-email-jtulak@redhat.com>
In-Reply-To: <1428670949-17524-1-git-send-email-jtulak@redhat.com>
References: <1428670949-17524-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

Adds few new functions into common/rc script. Two generic, for working
with lists, and three for manipulaction with the environments,
to be called from tests.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 common/rc | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/common/rc b/common/rc
index c5db0dd..e090ecd 100644
--- a/common/rc
+++ b/common/rc
@@ -50,6 +50,41 @@ _math()
 	echo "$result"
 }
 
+# Get symetric difference of two lists ($1 - $2).
+# Can work with any list of single-worded values.
+#
+_get_lists_difference()
+{
+	local a="$1"
+	local b="$2"
+	local difference=""
+
+	#a=$(echo "$a" | sed -e "s/\b_//g")
+	#b=$(echo "$b" | sed -e "s/\b_//g")
+	for item in $a;do
+        if [ $(echo $b|grep -cw $item) -eq 0 ];then
+			difference="$difference $item"
+		fi
+	done
+	echo $difference
+}
+
+# Get intersect of two lists. Can work with any list of single-worded values.
+#
+_get_lists_intersect()
+{
+	local a="$1"
+	local b="$2"
+	local intersect=""
+
+	for item in $a;do
+        if [ $(echo $b|grep -cwE "_?$item") -gt 0 ];then
+			intersect="$intersect $item"
+		fi
+	done
+	echo $intersect
+}
+
 dd()
 {
    if [ "$HOSTOS" == "Linux" ]
@@ -1074,6 +1109,98 @@ _supported_os()
     _notrun "not suitable for this OS: $HOSTOS"
 }
 
+
+# filter given supported environments by user input
+#
+_filter_environments()
+{
+	supported="$1"
+	# list_env is exported in check script
+	env="$(_get_lists_intersect "$supported" "$list_env")"
+    if [ "$env" = "" ];then
+        touch $seqres.noenvironment
+        touch $seqres.notrun
+    else
+        echo "$env"
+    fi
+}
+
+# Require an environment and make sure it is prepared - call this in a test.
+# First argument is path in which to prepare the env.
+# Optional second argument will overwrite $ENV_NAME variable for selecting
+# an environment.
+_environment_require()
+{
+	target="$1"
+	env="$2"
+	if [ "$env" = "" ]; then
+		env=$ENV_NAME
+	fi
+
+	if [ "$env" = "" ];then
+		1>&2 echo "You must export \$env "\
+			"before calling _environment_require!"
+		exit 1
+	fi
+	if [ "$target" = "" ];then
+		1>&2 echo "You must provide a target for _environment_require!"\
+			" Aborting."
+		exit 1
+	fi
+
+	if [ "$env" != "none" ];then
+		if [ ! -f "./environments/$env" ];then
+			1>&2 echo "Environment $env don't exists!"
+		fi
+		prepare_method="prepare"
+		bash ./environments/$env $prepare_method $target
+		sts=$?
+		if [ "$sts" -ne 0 ]; then
+			echo "       [skipped]"
+			1>&2 echo "Failed to prepare environment $env "\
+				" (will skip the test)!"
+			1>&2 echo ""
+			exit 1
+		fi
+	fi
+}
+
+# clean after an environment
+#
+# First argument is path in which to clean the env.
+# Optional second argument will overwrite $ENV_NAME variable for selecting
+# an environment.
+_environment_clean()
+{
+	target="$1"
+	env="$2"
+	if [ "$env" = "" ]; then
+		env=$ENV_NAME
+	fi
+
+	if [ "$env" = "" ];then
+		1>&2 echo "You must export \$env "\
+			"before calling _environment_clean!"
+		exit 1
+	fi
+	if [ "$target" = "" ];then
+		1>&2 echo "You must provide a target for _environment_clean!"\
+			" Aborting."
+		exit 1
+	fi
+	# Clean environment if there was any.
+	if [ "$env" != "none" ];then
+		bash ./environments/$env clean $target
+		sts=$?
+		if [ "$sts" != "0" ];then
+			1>&2 echo "An error happened when "\
+				"cleaning environment $env!"
+			1>&2 echo ""
+		fi
+	fi
+
+}
+
 # this test needs a scratch partition - check we're ok & unmount it
 # No post-test check of the device is required. e.g. the test intentionally
 # finishes the test with the filesystem in a corrupt state
-- 
2.1.0

