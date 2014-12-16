Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbaLPLm1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 16 Dec 2014 06:42:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBGBgRNc028698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Tue, 16 Dec 2014 06:42:27 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v2 3/3] check: treat _check_{test,scratch}_fs failures as test failures
Date: Tue, 16 Dec 2014 19:41:42 +0800
Message-Id: <1418730102-17061-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1418730102-17061-1-git-send-email-eguan@redhat.com>
References: <1418730102-17061-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Currently if _check_test_fs and/or _check_scratch_fs find corruption,
the test itself is still reported as pass, like

	[root@hp-dl388eg8-01 xfstests]# ./check xfs/071 xfs/072
	FSTYP         -- xfs (non-debug)
	PLATFORM      -- Linux/x86_64 hp-dl388eg8-01 3.18.0-rc7+
	MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda6
	MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/sda6 /mnt/testarea/scratch

	xfs/071  2s
	_check_xfs_filesystem: filesystem on /dev/sda6 is inconsistent (r) (see /root/xfstests/results//xfs/071.full)
	xfs/072  1s
	Ran: xfs/071 xfs/072
	Passed all 2 tests

	[root@hp-dl388eg8-01 xfstests]# echo $?
	0

Usually it's not a problem, but it does confuse scripts that depend on
return value of check. Update check to treat _check_{test,scratch}_fs
failures as test failures too, new test output is like

	[root@hp-dl388eg8-01 xfstests]# ./check xfs/071 xfs/072
	FSTYP         -- xfs (non-debug)
	PLATFORM      -- Linux/x86_64 hp-dl388eg8-01 3.18.0-rc7+
	MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda6
	MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/sda6 /mnt/testarea/scratch

	xfs/071 2s ... 2s
	_check_xfs_filesystem: filesystem on /dev/sda6 is inconsistent (r) (see /root/xfstests/results//xfs/071.full)
	xfs/072 1s ... 1s
	Ran: xfs/071 xfs/072
	Failures: xfs/071
	Failed 1 of 2 tests

	[root@hp-dl388eg8-01 xfstests]# echo $?
	1

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

v2:
- introduce new _check_filesystems helper using 8 spaces tabs

Note that the xfs/071 corruption issue is an xfs_repair bug,
Eric has sent a patch to fix it, see

http://www.spinics.net/lists/xfs/msg31018.html

 check | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/check b/check
index 42a1ac2..10f4a18 100755
--- a/check
+++ b/check
@@ -385,6 +385,18 @@ _summary()
 	rm -f $tmp.*
 }
 
+_check_filesystems()
+{
+	if [ -f ${RESULT_DIR}/require_test ]; then
+		_check_test_fs || err=true
+		rm -f ${RESULT_DIR}/require_test
+	fi
+	if [ -f ${RESULT_DIR}/require_scratch ]; then
+		_check_scratch_fs || err=true
+		rm -f ${RESULT_DIR}/require_scratch
+	fi
+}
+
 _prepare_test_list
 
 if $OPTIONS_HAVE_SECTIONS; then
@@ -611,6 +623,9 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			    err=true
 			fi
 		    fi
+		    try="$try $seqnum"
+		    n_try=`expr $n_try + 1`
+		    _check_filesystems
 		fi
 
 	    fi
@@ -623,15 +638,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		n_bad=`expr $n_bad + 1`
 		quick=false
 	    fi
-	    if [ ! -f $seqres.notrun ]
-	    then
-		try="$try $seqnum"
-		n_try=`expr $n_try + 1`
-		test -f ${RESULT_DIR}/require_test && _check_test_fs
-		rm -f ${RESULT_DIR}/require_test
-		test -f ${RESULT_DIR}/require_scratch && _check_scratch_fs
-		rm -f ${RESULT_DIR}/require_scratch
-	    fi
 
 	    seq="after_$seqnum"
 	done
-- 
2.1.0

