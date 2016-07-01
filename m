Received: from mx1.redhat.com ([209.132.183.28]:49834 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbcGAQOi (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 1 Jul 2016 12:14:38 -0400
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH v3] xfstests: update xfs/096 for new behaviour
Date: Fri,  1 Jul 2016 18:14:34 +0200
Message-Id: <1467389674-5341-1-git-send-email-jtulak@redhat.com>
In-Reply-To: <1464858659-610-1-git-send-email-jtulak@redhat.com>
References: <1464858659-610-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Because we recently changed how mkfs behaves when it gets incorrect/invalid
values, add a feature check to run this test only on older binaries, which
accepts invalid sunit values.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
UPDATE:
Change it to _notrun on newer binaries. Commit message updated respectivvely.
---
 tests/xfs/096 | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/096 b/tests/xfs/096
index f949e83..803b49d 100755
--- a/tests/xfs/096
+++ b/tests/xfs/096
@@ -39,6 +39,20 @@ _cleanup()
     rm -f $tmp.*
 }
 
+# maximum log record size
+max_lr_size=`expr 256 \* 1024`
+big_su=`expr $max_lr_size + 4096`
+
+requires_mkfs_accept_invalid_log_sunit()
+{
+	accepts=`mkfs.xfs -N -l version=2,su=$big_su 2>&1 | \
+		grep -ci "No device name"`
+	if [ "$accepts" -eq 0 ];then
+		_notrun "Runs only on older xfsprogs accepting invalid log sunit"
+	fi
+	return 1
+}
+
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
@@ -97,6 +111,9 @@ mkfs_filter()
    | grep -v parent
 }
 
+# skip on newer versions
+requires_mkfs_accept_invalid_log_sunit
+
 # real QA test starts here
 rm -f $seqres.full
 
@@ -108,16 +125,13 @@ _require_v2log
 
 # choose .out file based on internal/external log
 rm -f $seqfull.out
+
 if [ "$USE_EXTERNAL" = yes ]; then
 	ln -s $seq.out.external $seqfull.out
 else
 	ln -s $seq.out.internal $seqfull.out
 fi
 
-# maximum log record size
-max_lr_size=`expr 256 \* 1024`
-
-big_su=`expr $max_lr_size + 4096`
 
 #
 # Test out various mkfs param combinations
-- 
2.5.5

