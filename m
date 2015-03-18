Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39619 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbbCRSL1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 Mar 2015 14:11:27 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2IIBR0v018925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 18 Mar 2015 14:11:27 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 2/6] new: environments - new functions in common/rc for environment support
Date: Wed, 18 Mar 2015 19:10:26 +0100
Message-Id: <1426702230-22085-3-git-send-email-jtulak@redhat.com>
In-Reply-To: <1426702230-22085-1-git-send-email-jtulak@redhat.com>
References: <1426702230-22085-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Adds few new functions into common/rc script. Two generic, for working
with lists, and three for manipulaction with the environments,
to be called from tests.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 common/rc | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/common/rc b/common/rc
index 1ed9df5..7f786f4 100644
--- a/common/rc
+++ b/common/rc
@@ -40,6 +40,41 @@ _math()
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
@@ -1064,6 +1099,85 @@ _supported_os()
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
+# require an environment and make sure it is prepared - call this in a test
+#
+_environment_require()
+{
+	target="$1"
+
+	if [ "$ENV_NAME" = "" ];then
+		1>&2 echo "You must export \$ENV_NAME "\
+			"before calling _environment_require!"
+		exit 1
+	fi
+	if [ "$target" = "" ];then
+		1>&2 echo "You must provide a target for _environment_require!"\
+			" Aborting."
+		exit 1
+	fi
+
+	if [ "$ENV_NAME" != "none" ];then
+		if [ ! -f "./environments/$ENV_NAME" ];then
+			1>&2 echo "Environment $ENV_NAME don't exists!"
+		fi
+		prepare_method="prepare"
+		bash ./environments/$ENV_NAME $prepare_method $target
+		sts=$?
+		if [ "$sts" -ne 0 ]; then
+			echo "       [skipped]"
+			1>&2 echo "Failed to prepare environment $ENV_NAME "\
+				" (will skip the test)!"
+			1>&2 echo ""
+			exit 1
+		fi
+	fi
+}
+
+# clean after an environment
+#
+_environment_clean()
+{
+	target="$1"
+
+	if [ "$ENV_NAME" = "" ];then
+		1>&2 echo "You must export \$ENV_NAME "\
+			"before calling _environment_clean!"
+		exit 1
+	fi
+	if [ "$target" = "" ];then
+		1>&2 echo "You must provide a target for _environment_clean!"\
+			" Aborting."
+		exit 1
+	fi
+	# Clean environment if there was any.
+	if [ "$ENV_NAME" != "none" ];then
+		bash ./environments/$ENV_NAME clean $target
+		sts=$?
+		if [ "$sts" != "0" ];then
+			1>&2 echo "An error happened when "\
+				"cleaning environment $ENV_NAME!"
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

