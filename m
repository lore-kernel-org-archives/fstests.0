Received: from mail.sigma-star.at ([95.130.255.111]:45998 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753509AbdEQJ4Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 05:56:16 -0400
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: [PATCH 2/2] Accept failing with EPERM in addition to ENOKEY for rename without key
Date: Wed, 17 May 2017 11:55:30 +0200
Message-Id: <20170517095531.11818-3-david.oberhollenzer@sigma-star.at>
In-Reply-To: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
References: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, richard@nod.at, David Oberhollenzer <david.oberhollenzer@sigma-star.at>
List-ID: <fstests@vger.kernel.org>

Some filesystems (e.g. UBIFS) fail with EPERM when trying to move a
file into an encrypted directory via cross rename, without having
access to the encryption key.

Since rename is perfectly allowed to return EPERM, which is also tested
for, and no precise specification seems to exist that clarifys when to
expect EPERM and when ENOKEY, this patch modifies the generic/398 test
to accept both, for the test case where the key is not available.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
---
 tests/generic/398 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/generic/398 b/tests/generic/398
index b486b9c5..390c4380 100755
--- a/tests/generic/398
+++ b/tests/generic/398
@@ -43,6 +43,12 @@ _cleanup()
 	rm -f $tmp.*
 }
 
+_filter_rename()
+{
+	# rename without key can also fail with EPERM instead of ENOKEY
+	sed -e "s/Operation not permitted/Required key not available/g"
+}
+
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
@@ -149,9 +155,9 @@ efile1=$(find $edir1 -type f)
 efile2=$(find $edir2 -type f)
 
 echo -e "\n\n*** Exchange encrypted <=> encrypted without key ***"
-src/renameat2 -x $efile1 $efile2
+src/renameat2 -x $efile1 $efile2 |& _filter_rename
 echo -e "\n*** Exchange encrypted <=> unencrypted without key ***"
-src/renameat2 -x $efile1 $udir/ufile
+src/renameat2 -x $efile1 $udir/ufile |& _filter_rename
 
 # success, all done
 status=0
-- 
2.12.0

