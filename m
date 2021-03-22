Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF774C433E8
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A693F619A1
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Mar 2021 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCVNqI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhCVNpu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 22 Mar 2021 09:45:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B95D61992;
        Mon, 22 Mar 2021 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616420749;
        bh=uZi5dDE/KqB+nD7T220o5jvy5GSJtTn7JTrXmX+jQ08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAF4nicIEQVlDdkVaBH1Ykc4CAU2GMYAn4GRx328BG3CSDUNCr1FrGk6qCi/1fS9w
         Me7WEZCDDOfRI3ZhEQHko0cRd9vn3kqYUjorqtWXnYa1YmMnUPsoSXfYYGnE0IPWhB
         mLy9tTIbKGRRny4eRO/0rs0QxLM5cQoSpvvb3iZixxLTTYrgmTMyFw3YUbsgAlDJKz
         TuS3QK0tjaaSng/9fb63hfRvekJfKViRKjkpWep0yht6p1mZlKaTHsILUO9ZE7GMYw
         vtQz2G1FR3PLBz/wmiJnLzKaJDhvp8vj9dSIwy22XX8libd1AHQ1fPsFke91l2DbBj
         bYyYSZKSHemDA==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v10 6/6] xfs/530: quotas on idmapped mounts
Date:   Mon, 22 Mar 2021 14:45:22 +0100
Message-Id: <20210322134522.916512-7-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210322134522.916512-1-brauner@kernel.org>
References: <20210322134522.916512-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=cOLF8OTvRYXC3y485VSv6ujk3GSawMtRMrE2w7da8uQ=; m=NSojVSEcGmHs17du71gAqBeEPUmyNa+aTP10K3+zNDY=; p=aj0Hr+szSuIhRLWk7zzElxLHMVZOelJBqRWbdBDS3Zw=; g=dfa8216c3948a476487fdb111738b495db276e1b
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYFifaAAKCRCRxhvAZXjcoq5FAP0WAo7 9h4dThblf9CmUtcTJWd0jeBFcckYmaIe34mWvnAEA5OZepXDEYMvZf55yIjPHHEE0h5lYrJQIyYhp igXVcAk=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

This is basically a re-implementation of xfs/050 but each file creation
call is done through an idmapped mount which verifies that the semantics
are identical even when the mount is idmapped.

Cc: Eryu Guan <guan@eryu.me>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 - v8 */
patch not present

/* v9 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Rebased onto current master.

/* v10 */
- Eryu Guan <guan@eryu.me>:
  - Remove leading "_" from local helpers.
  - Use newly introduced _scratch_{u}mount_idmapped() helpers
---
 tests/xfs/530     | 211 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/530.out | 129 ++++++++++++++++++++++++++++
 tests/xfs/group   |   1 +
 3 files changed, 341 insertions(+)
 create mode 100644 tests/xfs/530
 create mode 100644 tests/xfs/530.out

diff --git a/tests/xfs/530 b/tests/xfs/530
new file mode 100644
index 00000000..7f2d51e8
--- /dev/null
+++ b/tests/xfs/530
@@ -0,0 +1,211 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2021 Christian Brauner <christian.brauner@ubuntu.com>
+# All Rights Reserved.
+#
+# FS QA Test No. 530
+#
+# Exercises basic XFS quota functionality
+#       uquota, gquota, uqnoenforce, gqnoenforce
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/quota
+
+_cleanup()
+{
+	cd /
+	_scratch_unmount 2>/dev/null
+	rm -f $tmp.*
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# real QA test starts here
+_supported_fs xfs
+
+cp /dev/null $seqres.full
+chmod a+rwx $seqres.full	# arbitrary users will write here
+
+_require_scratch
+_require_xfs_quota
+_require_user fsgqa
+
+_scratch_mkfs >/dev/null 2>&1
+_scratch_mount
+bsize=$(_get_file_block_size $SCRATCH_MNT)
+_scratch_unmount
+
+bsoft=$(( 200 * $bsize ))
+bhard=$(( 1000 * $bsize ))
+isoft=4
+ihard=10
+
+# The actual point at which limit enforcement takes place for the
+# hard block limit is variable depending on filesystem blocksize,
+# and iosize.  What we want to test is that the limit is enforced
+# (ie. blksize less than limit but not unduly less - ~85% is kind)
+# nowadays we actually get much closer to the limit before EDQUOT.
+#
+_filter_and_check_blks()
+{
+	perl -npe '
+		if (/^\#'$id'\s+(\d+)/ && '$enforce') {
+			$maximum = '$bhard';
+			$minimum = '$bhard' * 85/100;
+			$used = $1 * 1024;
+			if (($used < $minimum || $used > $maximum) && '$noextsz') {
+				printf(" URK %d: %d is out of range! [%d,%d]\n",
+					'$id', $used, $minimum, $maximum);
+			}
+			s/^(\#'$id'\s+)(\d+)/\1 =OK=/g;
+		}
+	' | _filter_quota_report
+}
+
+run_tests()
+{
+	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
+	cat $tmp.mkfs >>$seqres.full
+
+	# keep the blocksize and data size for dd later
+	. $tmp.mkfs
+
+	_qmount
+
+	# Figure out whether we're doing large allocations
+	# (bail out if they're so large they stuff the test up)
+	_test_inode_flag extsz-inherit $SCRATCH_MNT
+	noextsz=$?
+	extsize=`_test_inode_extsz $SCRATCH_MNT`
+	[ $extsize -ge 512000 ] && \
+		_notrun "Extent size hint is too large ($extsize bytes)"
+
+	_qsetup $1
+
+	echo "Using type=$type id=$id" >>$seqres.full
+
+	$XFS_QUOTA_PROG -x -c "warn -$type 65535 -d" $SCRATCH_DEV
+
+	echo
+	echo "*** report no quota settings" | tee -a $seqres.full
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_quota_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	echo "*** report initial settings" | tee -a $seqres.full
+	_scratch_mount_idmapped $type $id
+	_file_as_id $SCRATCH_MNT/initme 0 $type 1024 0
+	_scratch_umount_idmapped
+	echo "ls -l $SCRATCH_MNT" >>$seqres.full
+	ls -l $SCRATCH_MNT >>$seqres.full
+	$XFS_QUOTA_PROG -D $tmp.projects -P $temp.projid -x \
+		-c "limit -$type bsoft=${bsoft} bhard=${bhard} $id" \
+		-c "limit -$type isoft=$isoft ihard=$ihard $id" \
+		$SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_quota_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	echo "*** push past the soft inode limit" | tee -a $seqres.full
+	_scratch_mount_idmapped $type $id
+	_file_as_id $SCRATCH_MNT/softie1 0 $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie2 0 $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie3 0 $type 1024 0
+	_file_as_id $SCRATCH_MNT/softie4 0 $type 1024 0
+	_scratch_umount_idmapped
+	_qmount
+	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_quota_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	echo "*** push past the soft block limit" | tee -a $seqres.full
+	_scratch_mount_idmapped $type $id
+	_file_as_id $SCRATCH_MNT/softie 0 $type $bsize 300
+	_scratch_umount_idmapped
+	_qmount
+	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" \
+		-c "warn -b -$type 0 $id" $SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_quota_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	# Note: for quota accounting (not enforcement), EDQUOT is not expected
+	echo "*** push past the hard inode limit (expect EDQUOT)" | tee -a $seqres.full
+	for i in 1 2 3 4 5 6 7 8 9 10 11 12
+	do
+		_scratch_mount_idmapped $type $id
+		_file_as_id $SCRATCH_MNT/hard$i 0 $type 1024 0
+		_scratch_umount_idmapped
+	done
+	_qmount
+	$XFS_QUOTA_PROG -x  -c "warn -b -$type 0 $id" \
+		-c "warn -i -$type 0 $id" $SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_quota_report | LC_COLLATE=POSIX sort -ru
+
+	echo
+	# Note: for quota accounting (not enforcement), EDQUOT is not expected
+	echo "*** push past the hard block limit (expect EDQUOT)" | tee -a $seqres.full
+	_scratch_mount_idmapped $type $id
+	_file_as_id $SCRATCH_MNT/softie 0 $type $bsize 1200
+	_scratch_umount_idmapped
+	echo "ls -l $SCRATCH_MNT" >>$seqres.full
+	ls -l $SCRATCH_MNT >>$seqres.full
+	_qmount
+	$XFS_QUOTA_PROG -x -c "warn -b -$type 0 $id" $SCRATCH_DEV
+	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
+		-c "repquota -birnN -$type" $SCRATCH_DEV |
+		_filter_and_check_blks | LC_COLLATE=POSIX sort -ru
+
+	echo
+	echo "*** unmount"
+	_scratch_unmount
+
+}
+
+cat >$tmp.projects <<EOF
+1:$SCRATCH_MNT
+EOF
+
+cat >$tmp.projid <<EOF
+root:0
+scrach:1
+EOF
+
+projid_file="$tmp.projid"
+
+echo "*** user"
+_qmount_option "uquota"
+run_tests u
+
+echo "*** group"
+_qmount_option "gquota"
+run_tests g
+
+echo "*** uqnoenforce"
+_qmount_option "uqnoenforce"
+run_tests uno
+
+echo "*** gqnoenforce"
+_qmount_option "gqnoenforce"
+run_tests gno
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/530.out b/tests/xfs/530.out
new file mode 100644
index 00000000..39266b38
--- /dev/null
+++ b/tests/xfs/530.out
@@ -0,0 +1,129 @@
+QA output created by 530
+*** user
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+
+*** report no quota settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+
+*** report initial settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft inode limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the soft block limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the hard inode limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the hard block limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] =OK= 200 1000 0 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** unmount
+*** group
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+
+*** report no quota settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+
+*** report initial settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft inode limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 5 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the soft block limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the hard inode limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** push past the hard block limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] =OK= 200 1000 0 [7 days] 10 4 10 00 [7 days] 0 0 0 00 [--------]
+
+*** unmount
+*** uqnoenforce
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+
+*** report no quota settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+
+*** report initial settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft inode limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft block limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the hard inode limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
+
+*** push past the hard block limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 1200 200 1000 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
+
+*** unmount
+*** gqnoenforce
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+
+*** report no quota settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+
+*** report initial settings
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 1 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft inode limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 0 200 1000 00 [--------] 5 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the soft block limit
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [--------] 6 4 10 00 [--------] 0 0 0 00 [--------]
+
+*** push past the hard inode limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 300 200 1000 00 [--------] 18 4 10 00 [--none--] 0 0 0 00 [--------]
+
+*** push past the hard block limit (expect EDQUOT)
+[ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
+[NAME] 1200 200 1000 00 [--none--] 18 4 10 00 [--none--] 0 0 0 00 [--------]
+
+*** unmount
diff --git a/tests/xfs/group b/tests/xfs/group
index fb4599ca..a536d01a 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -506,3 +506,4 @@
 527 auto quick quota
 528 auto quick rw realtime
 529 auto quick quota
+530 auto quick quota
-- 
2.27.0

