Received: from mx2.suse.de ([195.135.220.15]:49348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727794AbfEQLY1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 17 May 2019 07:24:27 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38B8EAD5D
        for <fstests@vger.kernel.org>; Fri, 17 May 2019 11:24:26 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 1/2] generic/319: use numeric user and group IDs in getfacl
Date: Fri, 17 May 2019 12:24:21 +0100
Message-Id: <20190517112422.20671-2-lhenriques@suse.com>
In-Reply-To: <20190517112422.20671-1-lhenriques@suse.com>
References: <20190517112422.20671-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Luis Henriques <lhenriques@suse.com>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

This prevents test failures if cases where, e.g., /etc/group doesn't
include the 'root' group ID.

Cc: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/generic/319     | 4 ++--
 tests/generic/319.out | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/generic/319 b/tests/generic/319
index 02973d90cbe2..504cf627537b 100755
--- a/tests/generic/319
+++ b/tests/generic/319
@@ -44,10 +44,10 @@ _scratch_mount
 
 mkdir $SCRATCH_MNT/testdir
 setfacl -d --set u::rwx,g::rwx,o::- $SCRATCH_MNT/testdir
-getfacl --absolute-names $SCRATCH_MNT/testdir | _filter_scratch
+getfacl -n --absolute-names $SCRATCH_MNT/testdir | _filter_scratch
 
 mkdir $SCRATCH_MNT/testdir/testsubdir
-getfacl --absolute-names $SCRATCH_MNT/testdir/testsubdir | _filter_scratch
+getfacl -n --absolute-names $SCRATCH_MNT/testdir/testsubdir | _filter_scratch
 
 # success, all done
 status=0
diff --git a/tests/generic/319.out b/tests/generic/319.out
index b090bfaf6a04..bf6b4bc80462 100644
--- a/tests/generic/319.out
+++ b/tests/generic/319.out
@@ -1,7 +1,7 @@
 QA output created by 319
 # file: SCRATCH_MNT/testdir
-# owner: root
-# group: root
+# owner: 0
+# group: 0
 user::rwx
 group::r-x
 other::r-x
@@ -10,8 +10,8 @@ default:group::rwx
 default:other::---
 
 # file: SCRATCH_MNT/testdir/testsubdir
-# owner: root
-# group: root
+# owner: 0
+# group: 0
 user::rwx
 group::rwx
 other::---
