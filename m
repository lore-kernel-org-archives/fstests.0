Received: from mail.kernel.org ([198.145.29.99]:51452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAKVyY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 11 Jan 2019 16:54:24 -0500
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] check: force hostname to be unique
Date: Fri, 11 Jan 2019 13:54:20 -0800
Message-Id: <20190111215420.9676-1-mcgrof@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
List-ID: <fstests@vger.kernel.org>

If you use a hostname which is part of the output of
standard tools you end up with failures with fstests
due to differences in output against the golden output.

The failures are false positives due to the hostname.
For instance if you hostname is 'xfs' _dump_filter_main()
will substitute the initiial 'xfs' with HOSTNAME as part
of your logs, and will fail the output will fail against
the golden output on say all xfsdump / xfsrestores tests.

The hostname must be a unique string, not used as part
of the output from any tool used when capturing output.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

We could be more pedantic about uniqueness, but this should suffice at
last of most issues.

 README |  2 ++
 check  | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/README b/README
index 73f057f3..7128da67 100644
--- a/README
+++ b/README
@@ -22,6 +22,8 @@ _______________________
 - create fsgqa test user ("sudo useradd fsgqa")
 - create fsgqa group ("sudo groupadd fsgqa")
 - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
+- assign a unique hostname to the test system. It must not clash with
+  any word used on output by standard tools or tools for your filesystem.
 
 ______________________
 USING THE FSQA SUITE
diff --git a/check b/check
index 77a06b00..3a0bb026 100755
--- a/check
+++ b/check
@@ -251,6 +251,40 @@ _prepare_test_list()
 	fi
 }
 
+_invalid_hostname()
+{
+	host_check=`hostname`
+
+	case $host_check in
+	xfs)
+		return 1;
+	;;
+	btrfs)
+		return 1;
+	;;
+	ext4)
+		return 1;
+	;;
+	ext3)
+		return 1;
+	;;
+	ext2)
+		return 1;
+	;;
+	esac
+
+	return 0
+}
+
+_check_unique_hostname()
+{
+	_invalid_hostname
+	if [ $? -ne -0 ]; then
+		echo "Hostname `hostname` is not unique, make a unique hostname to avoid output log clashes with tools"
+		exit 1
+	fi
+}
+
 # Process command arguments first.
 while [ $# -gt 0 ]; do
 	case "$1" in
@@ -371,6 +405,8 @@ then
     exit 1
 fi
 
+_check_unique_hostname
+
 _wipe_counters()
 {
 	n_try="0"
-- 
2.20.1
