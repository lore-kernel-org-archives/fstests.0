Received: from mx1.redhat.com ([209.132.183.28]:58772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbdI2CQS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Sep 2017 22:16:18 -0400
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v7] generic/413: skip dax to nondax dio test if needed
Date: Fri, 29 Sep 2017 10:16:11 +0800
Message-Id: <1506651371-21608-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <1506584500-867-1-git-send-email-xzhou@redhat.com>
References: <1506584500-867-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ross.zwisler@linux.intel.com, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

This test requires there is struct page backend for the
testing dax device. But not all devices which support dax
have that. So we give it a try, if it fails with EFAULT,
which is the same errno with the wrong device situation,
we skip this subtest.

This is not perfect, but it's efficient. Many devices
support dax, and there are more coming. It's nearly
impossible to maintain an uniq way to detect struct page
present for all kinds of devices modes.

>From testing perspectice, a testrun could cover this
code path as a sanity check and avoid more unnecessary
failires. If the device is compatible with the test, one
more testrun will not hurt much.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

v7:
  split this patch from that unrelated series.
  minor comment fix.

 src/t_mmap_dio.c  |  2 +-
 tests/generic/413 | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/t_mmap_dio.c b/src/t_mmap_dio.c
index 6c8ca1a..73e7648 100644
--- a/src/t_mmap_dio.c
+++ b/src/t_mmap_dio.c
@@ -27,7 +27,7 @@ void err_exit(char *op, unsigned long len, char *s)
 {
 	fprintf(stderr, "%s(%s) len %lu %s\n",
 		op, strerror(errno), len, s);
-	exit(1);
+	exit(errno);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/generic/413 b/tests/generic/413
index a1cc514..311bdc2 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -88,6 +88,18 @@ t_nondax_to_dax()
 t_dax_to_nondax()
 {
 	prep_files
+
+	# dax to nondax dio needs struct page backend, which is
+	# not always available among various devices. Skip this
+	# subtest if EFAULT(14 Bad address) returned, which means
+	# probably the device is not compatible with this test.
+	#
+	src/t_mmap_dio $SCRATCH_MNT/tf_s $TEST_DIR/tf_d \
+		$1 "test" > /dev/null 2>&1
+	if [ $? -eq 14 ] ; then
+		return
+	fi
+
 	src/t_mmap_dio $SCRATCH_MNT/tf_s \
 		$TEST_DIR/tf_d $1 "dio dax to nondax"
 
-- 
1.8.3.1

