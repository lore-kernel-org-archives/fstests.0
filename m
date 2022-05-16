Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D36C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 08:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiEPI7f (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiEPI73 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 04:59:29 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24CF21C905
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 01:59:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 950AA10E6A77
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 18:59:25 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqWZY-00CbZR-44
        for fstests@vger.kernel.org; Mon, 16 May 2022 18:59:24 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqWZY-005U4H-2g
        for fstests@vger.kernel.org;
        Mon, 16 May 2022 18:59:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 3/4] xfs/148: fix failure from bad shortform size assumptions
Date:   Mon, 16 May 2022 18:59:21 +1000
Message-Id: <20220516085922.1306879-4-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516085922.1306879-1-david@fromorbit.com>
References: <20220516085922.1306879-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6282126e
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=mDPyBUI4OX8v4RjPpF4A:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

We replaced an attr named:

slashstr="are_bad_for_you"

with this substitution:

cp $imgfile $imgfile.old
sed -b \
        -e "s/$nullstr/too_many\x00beans/g" \
        -e "s/$slashstr/are_bad\/for_you/g" \
        -i $imgfile

We then try to retreive the attr named 'a_are_bad/for_you'. The
failure is:

    -Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-148/testfile:
    -heh
    +attr_get: No data available
    +Could not get "a_are_bad/for_you" for TEST_DIR/mount-148/testfile

The error returned is ENODATA - the xattr does not exist. While the
name might exist in the attr leaf block:

....
nvlist[0].valuelen = 3
nvlist[0].namelen = 17
nvlist[0].name = "a_are_bad/for_you"
nvlist[0].value = "heh"
nvlist[1].valuelen = 3
....

xattrs are not looked up by name matches when in leaf or node form
like they are in short form.  They are looked up by *name hash*
matches, and if the hash is not found, then the name does not exist.
Only if the has match is found, then it goes and retrieves the xattr
pointed to by the hash and checks the name.

At this point, it should be obvious that the hash of
"a_are_bad_for_you" is different to "a_a_are_bad/for_you". Hence the
leaf lookup is always rejected at the hash match stage and never
gets to the name compare stage.

IOWs, this test can *never* pass when the xattr is in leaf/node
form, only when it is in short form.

The reason the attr fork is in leaf form is that we are using
"-m crc=0" and so the inodes are only 256 bytes in size and can only
hold ~150 bytes in the literal area. That leaves ~100 bytes maximum
for shortform attr data. The test consumes ~80 bytes of shortform
space, so it should fit and the test pass.

However:

nvlist[4].valuelen = 37
nvlist[4].namelen = 7
nvlist[4].name = "selinux"
nvlist[4].value = "unconfined_u:object_r:unlabeled_t:s0\000"

Yes, I run the fstests with selinux enabled on some of test
machines. The selinux attr pushes the attr fork way over the size
that can fit in the shortform literal area, and so it moves to leaf
form as the attrs are initially added and the test fails.

Fix this by forcing the test to use 512 byte inodes, so as to
provide around 350 bytes of usable attr fork literal area so it's
not affected by security attributes.

While there, clean up the silly conditional loop device cleanup
code.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/148 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/xfs/148 b/tests/xfs/148
index 8d50a642..5d0a0bf4 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -15,7 +15,7 @@ _cleanup()
 {
 	cd /
 	$UMOUNT_PROG $mntpt > /dev/null 2>&1
-	test -n "$loopdev" && _destroy_loop_device $loopdev > /dev/null 2>&1
+	_destroy_loop_device $loopdev > /dev/null 2>&1
 	rm -r -f $tmp.*
 }
 
@@ -41,9 +41,12 @@ test_names=("something" "$nullstr" "$slashstr" "another")
 rm -f $imgfile $imgfile.old
 
 # Format image file w/o crcs so we can sed the image file
+# We need to use 512 byte inodes to ensure the attr forks remain in short form
+# even when security xattrs are present so we are always doing name matches on
+# lookup and not name hash compares as leaf/node forms will do.
 $XFS_IO_PROG -f -c 'truncate 40m' $imgfile
 loopdev=$(_create_loop_device $imgfile)
-MKFS_OPTIONS="-m crc=0" _mkfs_dev $loopdev >> $seqres.full
+MKFS_OPTIONS="-m crc=0 -i size=512" _mkfs_dev $loopdev >> $seqres.full
 
 # Mount image file
 mkdir -p $mntpt
@@ -121,9 +124,6 @@ res=$?
 test $res -eq 1 || \
 	echo "repair failed to report corruption ($res)"
 
-_destroy_loop_device $loopdev
-loopdev=
-
 # success, all done
 status=0
 exit
-- 
2.35.1

