Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48019 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933794AbaKNNaQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Nov 2014 08:30:16 -0500
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 7/7] Adds functions for tests to call environment setup/cleaning
Date: Fri, 14 Nov 2014 14:27:47 +0100
Message-Id: <1415971667-16873-7-git-send-email-jtulak@redhat.com>
In-Reply-To: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
References: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>, lczerner@redhat.com, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

This patch adds two functions into common/rc. These two functions are
called by tests to setup and clean environment. They have a single
argument - a target directory. So everything required in a test to
support environments is to call _require_environment $target after
requireing test or scratch dir, and then call the clean function at
the end.

Specific environment name is taken from variables exported by check
script.

Calling of the cleaning function is not critical as before setup,
cleaning is called automatically.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 common/rc | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/common/rc b/common/rc
index d5e3aff..14dbb1f 100644
--- a/common/rc
+++ b/common/rc
@@ -1037,6 +1037,55 @@ _supported_os()
     _notrun "not suitable for this OS: $HOSTOS"
 }
 
+_require_environment()
+{
+	target="$1"
+	if [ "$target" = "" ];then
+		1>&2 echo "Target directory for environment can't be empty! Aborting."
+		exit 1
+	fi
+
+	if [ "$env" != "" -a "$env" != "none" ];then
+		prepare_method="prepare-once"
+		if $env_force;then
+			prepare_method="prepare-always"
+		fi
+		bash ./environments/$env $prepare_method $target 
+		sts=$?
+		if [ "$sts" != 0 ]; then
+			echo "       [skipped]"
+			1>&2 echo "Failed to prepare environment $env "\
+				" (will skip the test)!"
+			1>&2 echo ""
+			exit 1
+		fi
+	fi
+}
+
+
+
+_environment_clean()
+{
+	target="$1"
+	if [ "$target" = "" ];then
+		1>&2 echo "Target directory for environment cleaning can't be empty!"\
+		" Aborting."
+		exit 1
+	fi
+	# Clean environment if there was some
+	# and the next environment is different.
+	# The variables are exported from check script.
+	if [ "$env" != "" -a "$env" != "none" -a "$env" != "$env_next" ];then
+		bash ./environments/$env clean $target
+		sts=$?
+		if [ "$sts" != "0" ];then
+			1>&2 echo "An error happened when cleaning environment $env!"
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
1.9.3

