Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40639 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726866AbfF1W7S (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Jun 2019 18:59:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v2 2/5] check: add ext4 group list when testing ext2 and ext3
Date: Fri, 28 Jun 2019 18:59:07 -0400
Message-Id: <20190628225910.17018-2-tytso@mit.edu>
In-Reply-To: <20190628225910.17018-1-tytso@mit.edu>
References: <20190628225910.17018-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Modern kernels use the ext4 implementation to support ext2 and ext3
mounts, and a number of the ext4 tests are actually suitable for ext2
and ext3.  We're trying to move tests out of shared anyway, so instead
of moving tests from ext4/NNN to shared, let's just include the ext4
group list when FSTYP is ext2 or ext3.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
Changes since v1:
   - none

 check | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 7511e1ce..2a5d8ab1 100755
--- a/check
+++ b/check
@@ -130,6 +130,7 @@ get_group_list()
 	local grp=$1
 	local grpl=""
 	local sub=$(dirname $grp)
+	local fsgroup="$FSTYP"
 
 	if [ -n "$sub" -a "$sub" != "." -a -d "$SRC_DIR/$sub" ]; then
 		# group is given as <subdir>/<group> (e.g. xfs/quick)
@@ -138,7 +139,10 @@ get_group_list()
 		return
 	fi
 
-	for d in $SRC_GROUPS $FSTYP; do
+	if [ "$FSTYP" = ext2 -o "$FSTYP" = ext3 ]; then
+	    fsgroup=ext4
+	fi
+	for d in $SRC_GROUPS $fsgroup; do
 		if ! test -d "$SRC_DIR/$d" ; then
 			continue
 		fi
-- 
2.22.0
