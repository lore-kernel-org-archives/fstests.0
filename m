Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43103 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594AbaIPSqO (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 16 Sep 2014 14:46:14 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8GIkCnb015505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2014 14:46:13 -0400
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8GIkBZo005730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2014 14:46:12 -0400
Message-ID: <54188573.3070907@redhat.com>
Date: Tue, 16 Sep 2014 13:46:11 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] xfs/005: sync superblock modification to disk before mount
 test
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This test tries to directly corrupt the CRC field of the primary
superblock by using xfs_io pwrite, but never syncs it to disk,
so it's quite likely that the mount will not see the bad data.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/005 b/tests/xfs/005
index 5d4534b..fade4bb 100755
--- a/tests/xfs/005
+++ b/tests/xfs/005
@@ -61,7 +61,7 @@ rm -f $seqres.full
 _scratch_mkfs_xfs -m crc=1 >> $seqres.full 2>&1 || _fail "mkfs failed"
 
 # Zap the crc.  xfs_db updates the CRC post-write, so poke it directly
-$XFS_IO_PROG -c "pwrite 224 4" $SCRATCH_DEV | _filter_xfs_io
+$XFS_IO_PROG -c "pwrite 224 4" -c fsync $SCRATCH_DEV | _filter_xfs_io
 
 # should FAIL, the crc is bad; golden output contains mount failure
 _scratch_mount 2>&1 | filter_mount

