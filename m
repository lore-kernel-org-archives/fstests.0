Received: from mx1.redhat.com ([209.132.183.28]:57816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbeCVUJz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Mar 2018 16:09:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 111FAC04BD38
        for <fstests@vger.kernel.org>; Thu, 22 Mar 2018 20:09:55 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6F6D5D757
        for <fstests@vger.kernel.org>; Thu, 22 Mar 2018 20:09:54 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] xfs/278: mkfs with v4 format
Message-ID: <bde6f5a1-1107-9c03-402d-486bfbdcbd35@redhat.com>
Date: Thu, 22 Mar 2018 15:09:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This test had silently stopped working when mkfs.xfs switched
to v5 supers by default, and changed inode sizes:

> field u not found
> parsing error
> field u not found
> parsing error

...

Switch back to the original behavior by turning off crcs,
and catch such failures if they crop up again by looking
for xfs_db errors in $seqres.full.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

(is it horrific to grep $seqres.full?  xfs_db doesn't exit
with failure in this case :( )

and now this causes repair to fail on a verifier error, but
I just sent an xfsprogs patch to fix that as well.

diff --git a/tests/xfs/278 b/tests/xfs/278
index b94ee9c..c0e09c7 100755
--- a/tests/xfs/278
+++ b/tests/xfs/278
@@ -48,7 +48,7 @@ _supported_os Linux
 _require_scratch
 
 rm -f $seqres.full
-_scratch_mkfs >$seqres.full 2>&1
+_scratch_mkfs -m crc=0 -n ftype=0 >$seqres.full 2>&1
 _scratch_mount
 
 mkdir -p $SCRATCH_MNT/dir/subdir
@@ -73,6 +73,8 @@ _scratch_xfs_db -x -c "inode $DIR_INO" -c "write core.nlinkv2 0"  >> $seqres.ful
 _scratch_xfs_db -x -c "inode $SUBDIR_INO" -c "write u.sfdir2.hdr.parent.i4 0"  >> $seqres.full
 _scratch_xfs_db -x -c "inode $SUBDIR_INO" -c "write core.nlinkv2 0"  >> $seqres.full
 
+grep -q "not found\|parsing error" $seqres.full && _fail "xfs_db commands failed"
+
 echo "===== BEGIN of xfs_repair =====" >> $seqres.full
 echo "" >>$seqres.full
 

