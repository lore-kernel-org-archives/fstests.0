Received: from mx1.redhat.com ([209.132.183.28]:59908 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbcELCzY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 May 2016 22:55:24 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A8EA91E92
	for <fstests@vger.kernel.org>; Thu, 12 May 2016 02:55:23 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] xfs/133 134: filter redundant projid 0 quota report info out
Date: Thu, 12 May 2016 10:55:19 +0800
Message-Id: <1463021719-9814-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, Zorro Lang <zlang@redhat.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

After GETNEXTQUOTA ioctl be supported, xfs_quota -c "report" always
outputs one more quota info about default quota (as project ID 0).
For fix this problem, xfsprogs has merged commit 3d607a1.

Now xfstests face this same problem from this issue. xfs/133 and
xfs/134 can't match their golden output, due to this one more line
quota report output. So this patch filter this redundant quota info
out.

There're 3 kinds of xfsprogs:
1. not support GETNEXTQUOTA
2. support GETNEXTQUOTA but not merged commit 3d607a1
3. The newest one support all

The 1st one won't report Project ID 0, the 2nd will report projid 0
info as "(null) 0 0 0 ...", the 3rd will report projid 0 info as
"#0 0 0 0 ...". For deal with all of these situations, we will use

  _filter_quota | grep -v "^#0 \|^(null) "

But if someone specify a name for projid 0, e.g.
  # cat $projid_file
  # root:0

I think that means someone want to deal with it by himself, the
common filter won't filter it out.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---

Hi,

Follow Eric's suggestion, I add a new filter function. I have tested
below situations:
1. New kernel(support GETNEXTQUOTA) with xfsprogs support GETNEXTQUOTA.
2. New kernel with the newest xfsprogs merged commit 3d607a1
3. Old kernel(not support GETNEXTQUOTA) with xsfprogs not support GETNEXTQUOTA.

Test passed.

Thanks,
Zorro

 common/filter |  9 +++++++++
 tests/xfs/133 |  2 +-
 tests/xfs/134 | 20 +++++++++++++-------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/common/filter b/common/filter
index 1be377c..244621a 100644
--- a/common/filter
+++ b/common/filter
@@ -302,6 +302,15 @@ _filter_quota()
 	sed -e 'N;s/TEST_DEV\n/TEST_DEV/g'
 }
 
+_filter_project_quota()
+{
+	# Project ID 0 is always present on disk but was not reported
+	# until the GETNEXTQUOTA ioctl came into use.  Filter it out.
+	# But if you specify a name for ID 0, that means you want to
+	# deal with it by yourself, this function won't filter it out.
+	_filter_quota | grep -v "^\#0 \|^(null) "
+}
+
 # Account for different "ln" failure messages
 _filter_ln()
 {
diff --git a/tests/xfs/133 b/tests/xfs/133
index 82c38b1..f77bc79 100755
--- a/tests/xfs/133
+++ b/tests/xfs/133
@@ -81,7 +81,7 @@ EOF
 
 	echo "=== report command output ==="
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
-		-c "report -p -N -b" $SCRATCH_MNT | _filter_quota
+		-c "report -p -N -b" $SCRATCH_MNT | _filter_project_quota
 }
 
 # Test project
diff --git a/tests/xfs/134 b/tests/xfs/134
index be18ee8..cd47069 100755
--- a/tests/xfs/134
+++ b/tests/xfs/134
@@ -87,17 +87,24 @@ fi
 src/feature -p $SCRATCH_DEV
 [ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
 
+report_quota()
+{
+    $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		    -c "repquota -inN -p" $SCRATCH_DEV | \
+		    tr -s '[:space:]' | _filter_project_quota
+}
+
 mkdir $dir
 $XFS_IO_PROG -r -c "chproj -R 1" -c "chattr -R +P" $dir
 
-xfs_quota -D $tmp.projects -P $tmp.projid -x \
+$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
     -c "limit -p bsoft=100m bhard=100m 1" $SCRATCH_DEV
-xfs_quota -D $tmp.projects -P $tmp.projid -x -c "repquota -inN -p" $SCRATCH_DEV | tr -s '[:space:]'
+report_quota
+
 touch $dir/1
 touch $dir/2
 cp $dir/2 $dir/3
-
-xfs_quota -D $tmp.projects -P $tmp.projid -x -c "repquota -inN -p" $SCRATCH_DEV | tr -s '[:space:]'
+report_quota
 
 if [ "$HOSTOS" == "IRIX" ] ; then
     mkfile 1M $TEST_DIR/6
@@ -107,12 +114,11 @@ fi
 
 #try cp to dir
 cp $TEST_DIR/6 $dir/6
-xfs_quota -D $tmp.projects -P $tmp.projid -x -c "repquota -inN -p" $SCRATCH_DEV | tr -s '[:space:]'
+report_quota
 
 #try mv to dir
 mv $TEST_DIR/6 $dir/7
-
-xfs_quota -D $tmp.projects -P $tmp.projid -x -c "repquota -inN -p" $SCRATCH_DEV | tr -s '[:space:]'
+report_quota
 
 # success, all done
 status=0
-- 
2.5.5

