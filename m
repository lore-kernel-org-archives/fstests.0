Received: from mx1.redhat.com ([209.132.183.28]:58800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbdKEILU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 5 Nov 2017 03:11:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28D1F5F7BA
        for <fstests@vger.kernel.org>; Sun,  5 Nov 2017 08:11:20 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/204: do not call _scratch_mkfs_sized in a pipe
Date: Sun,  5 Nov 2017 16:11:10 +0800
Message-Id: <20171105081110.26373-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

_scratch_mkfs_sized will create a filesystem of the given size, and
call _notrun and exit if current $FSTYP doesn't support sized mkfs.
But when it's called in a pipe, the exit in _notrun only exits from
the subshell created by the pipe not the test itself, and test
continues to run unnecessarily.

Fix it by not calling _scratch_mkfs_sized in a pipe, but dumping the
output to a tmp file, which will be fed to _filter_mkfs later.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

This is uncovered by Darrick's patch "generic/204: use available blocks
to determine the number of files to create", with this patch applied
test will 'hang' when testing on a large NFS export, because the number
of files to be created was based on the size of available space.

Note that I've dropped that patch because it also caused failure in 512B
block size XFS test.

 tests/generic/204 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/204 b/tests/generic/204
index 4c203a213f5b..ebc9c0fa001b 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -58,8 +58,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
 [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
 
 SIZE=`expr 115 \* 1024 \* 1024`
-_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null \
-		| _filter_mkfs 2> $tmp.mkfs > /dev/null
+_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
+cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
 _scratch_mount
 
 # Source $tmp.mkfs to get geometry
-- 
2.13.6

