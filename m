Received: from mail-wm0-f66.google.com ([74.125.82.66]:36733 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdIOKq4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 15 Sep 2017 06:46:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id r136so2420780wmf.3
        for <fstests@vger.kernel.org>; Fri, 15 Sep 2017 03:46:56 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] overlay/038: fix impure xattr test
Date: Fri, 15 Sep 2017 13:47:28 +0300
Message-Id: <1505472448-588-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, fstests@vger.kernel.org, Chandan Rajendra <chandan@linux.vnet.ibm.com>
List-ID: <fstests@vger.kernel.org>

On kvm-xfstest, getfattr (2.4.43) does not return failure exit code
when the requested xattr is not found.

Change the test to check the returned xattr value instead of exit code.

Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

This test is supposed to pass on master now and it does pass on my
Ubuntu 16.04, but fails on kvm-xfstests (Debian stretch).

The failure is due to different behavior of getfattr on different
systems and as a result of me suggesting to Chandan to check getfattr
exit code. So this patch is for my redemption ;-)

I surveyed for other places that check exit code of getfattr as
indication of ENODATA and found only one other instance in
_require_scratch_richacl_support() (for non xfs/ext4 FSTYP).
However, this instance is buggy regardless, because it provides no
file argument to getfattr.
I would fix it, but I am not sure what's the semantics and have no
idea how to test this.

Amir.


 tests/overlay/038 | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/overlay/038 b/tests/overlay/038
index 24cd432..69fd76a 100755
--- a/tests/overlay/038
+++ b/tests/overlay/038
@@ -108,9 +108,9 @@ test_file_st_ino=$(stat -c '%i' $SCRATCH_MNT/test_file)
 
 mv $SCRATCH_MNT/test_file $impure_dir
 
-$GETFATTR_PROG --absolute-names -n 'trusted.overlay.impure' \
-	       $upperdir/test_dir/impure_dir >>$seqres.full 2>&1
-[[ $? == 0 ]] || echo "Impure directory missing impure xattr"
+impure=$($GETFATTR_PROG --absolute-names --only-values -n 'trusted.overlay.impure' \
+			$upperdir/test_dir/impure_dir)
+[[ $impure == "y" ]] || echo "Impure directory missing impure xattr"
 
 # After $impure_dir becomes impure
 parent_d=$($here/src/t_dir_type $impure_dir $impure_dir_parent_st_ino)
@@ -133,9 +133,9 @@ rm -rf $impure_dir/test_file
 $here/src/t_dir_type $impure_dir $test_file_st_ino
 [[ $? != 0 ]] || echo "Directory's readdir cache has stale entries"
 
-$GETFATTR_PROG --absolute-names -n 'trusted.overlay.impure' \
-	       $upperdir/test_dir/impure_dir >>$seqres.full 2>&1
-[[ $? != 0 ]] || echo "Pure directory has impure xattr"
+impure=$($GETFATTR_PROG --absolute-names --only-values -n 'trusted.overlay.impure' \
+			$upperdir/test_dir/impure_dir 2>/dev/null)
+[[ -z $impure ]] || echo "Pure directory has impure xattr"
 
 # Verify d_ino values corresponding to "." and ".." entries of a
 # pure lower dir.
-- 
2.7.4

