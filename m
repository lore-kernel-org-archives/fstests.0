Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773AbbCRSLb (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 Mar 2015 14:11:31 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2IIBVk3024402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 18 Mar 2015 14:11:31 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 5/6] new: environments - create the environment directory
Date: Wed, 18 Mar 2015 19:10:29 +0100
Message-Id: <1426702230-22085-6-git-send-email-jtulak@redhat.com>
In-Reply-To: <1426702230-22085-1-git-send-email-jtulak@redhat.com>
References: <1426702230-22085-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add the environment directory and "empty-files" environment used by
performance/001 test. The empty-files script checks ENV_FILES_NUMBER
environment variable to know how many files it should create.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 environments/empty-files | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 environments/empty-files

diff --git a/environments/empty-files b/environments/empty-files
new file mode 100644
index 0000000..ab63935
--- /dev/null
+++ b/environments/empty-files
@@ -0,0 +1,96 @@
+#!/bin/bash
+# FS QA Environment setup
+#
+# Create directories with lots of empty files. Name the dirs with
+# amount of the files inside. No whitheouts.
+#
+#-----------------------------------------------------------------------
+# Copyright 2015 (C) Red Hat, Inc., Jan Tulak <jtulak@redhat.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+#-----------------------------------------------------------------------
+#
+# arguments: prepare, clean
+# env variables: ENV_FILES_NUMBER
+
+# default value
+if [ "" = "$ENV_FILES_NUMBER" ];then
+	ENV_FILES_NUMBER=1000
+fi
+
+NR_FILES=$ENV_FILES_NUMBER
+
+
+
+TEST_ENV="$(basename "$BASH_SOURCE")"
+
+
+make_dir(){
+	local path=$1
+	local num=$2
+	local i=0
+	# make files
+	time while [ "$i" -lt "$num" ]; do
+		touch "$path/$TEST_ENV-file-$i"
+		let i+=1
+	done
+}
+
+
+# This function should prepare the environment
+prepare()
+{
+	target="$1"
+	echo "Creating $NR_FILES files in $target."
+	make_dir "$target" $NR_FILES
+}
+
+# This function should clean files created by prepare()
+clean()
+{
+	target="$1"
+	rm "$target/$TEST_ENV-"*
+}
+
+
+
+usage()
+{
+echo "Usage: 
+$0 OPTION TARGET_DIR
+Where OPTION is one (and only one) of the following:
+    prepare, clean"
+}
+
+# arguments...
+if [ $# -ne 2 ];then
+	usage
+	exit 1
+fi
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+		prepare) 
+			echo "# ENVIROMENT $TEST_ENV PREPARE START"
+			prepare "$2"
+			echo "# ENVIROMENT $TEST_ENV PREPARE END"
+			shift ;;
+		clean) clean "$2"; shift ;;
+		*) usage ; exit 1 ;;
+	esac
+	shift
+done
+
+exit 0
-- 
2.1.0

