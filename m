Received: from mx1.redhat.com ([209.132.183.28]:35404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751812AbdDGH4P (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 Apr 2017 03:56:15 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH 1/3] common: helper to get value from ndctl list by key
Date: Fri,  7 Apr 2017 15:56:02 +0800
Message-Id: <1491551764-18779-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

For some nvdimm DAX related tests, it's better to know
some details of devices being tested. Adding new prog
ndctl to manage nvdimms and jq to parse outputs.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 common/config |  2 ++
 common/rc     | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/common/config b/common/config
index 59041a3..dfdcb8e 100644
--- a/common/config
+++ b/common/config
@@ -212,6 +212,8 @@ export XZ_PROG="`set_prog_path xz`"
 export FLOCK_PROG="`set_prog_path flock`"
 export LDD_PROG="`set_prog_path ldd`"
 export TIMEOUT_PROG="`set_prog_path timeout`"
+export NDCTL_PROG="`set_prog_path ndctl`"
+export JQ_PROG="`set_prog_path jq`"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/common/rc b/common/rc
index e1ab2c6..0540fdc 100644
--- a/common/rc
+++ b/common/rc
@@ -3148,6 +3148,30 @@ _require_chattr()
     rm -f $TEST_DIR/syscalltest.out
 }
 
+_require_ndctl()
+{
+	ndctl list >> $seqres.full || \
+	_notrun "this test requires ndctl"
+}
+
+_require_jq()
+{
+	jq -V >> $seqres.full || \
+	_notrun "this test requires jq"
+}
+
+# $1 SCRATCH_DEV or TEST_DEV or other dev
+# $2 key
+_ndctl_get_pmem_key_value()
+{
+	_require_jq
+	_require_ndctl
+
+	$NDCTL_PROG list | \
+	  $JQ_PROG -r ".[] | \
+	  select(.blockdev == \"${1#/dev/}\") | .$2"
+}
+
 _get_total_inode()
 {
 	if [ -z "$1" ]; then
-- 
1.8.3.1

