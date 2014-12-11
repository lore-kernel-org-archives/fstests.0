Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41202 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754264AbaLKRRL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 12:17:11 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBBHHA2H032767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 11 Dec 2014 12:17:11 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 3/4] btrfs/017: remove duplicate test
Date: Fri, 12 Dec 2014 01:16:10 +0800
Message-Id: <1418318171-5892-4-git-send-email-eguan@redhat.com>
In-Reply-To: <1418318171-5892-1-git-send-email-eguan@redhat.com>
References: <1418318171-5892-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

btrfs/017 is same as btrfs/015, remove it.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/btrfs/017     | 61 -----------------------------------------------------
 tests/btrfs/017.out |  2 --
 tests/btrfs/group   |  1 -
 3 files changed, 64 deletions(-)
 delete mode 100755 tests/btrfs/017
 delete mode 100644 tests/btrfs/017.out

diff --git a/tests/btrfs/017 b/tests/btrfs/017
deleted file mode 100755
index 1f31e8a..0000000
--- a/tests/btrfs/017
+++ /dev/null
@@ -1,61 +0,0 @@
-#! /bin/bash
-# FS QA Test No. btrfs/017
-#
-# Regression test to make sure we can create a snapshot after mounting with
-# readonly and remounting rw.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2013 Fusion IO.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-
-status=1	# failure is the default!
-
-_cleanup()
-{
-	rm -f $tmp.*
-}
-
-trap "_cleanup ; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs btrfs
-_supported_os Linux
-_require_scratch
-
-rm -f $seqres.full
-
-_scratch_mkfs > /dev/null 2>&1
-_scratch_mount -o ro
-_scratch_mount -o rw,remount
-
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap >> $seqres.full 2>&1 \
-	|| _fail "couldn't create snapshot"
-
-echo "Silence is golden"
-status=0 ; exit
diff --git a/tests/btrfs/017.out b/tests/btrfs/017.out
deleted file mode 100644
index 8222844..0000000
--- a/tests/btrfs/017.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 017
-Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index b63f174..8db4618 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -19,7 +19,6 @@
 014 auto
 015 auto quick
 016 auto quick
-017 auto quick
 018 auto quick
 019 auto quick
 020 auto quick
-- 
1.8.3.1

