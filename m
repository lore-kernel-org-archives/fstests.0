Received: from mx2.suse.de ([195.135.220.15]:43690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752557AbeENRD6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 14 May 2018 13:03:58 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7DE6AACB0
        for <fstests@vger.kernel.org>; Mon, 14 May 2018 17:03:57 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] common/quota: Make project quota handling work for ext2 & ext3
Date: Mon, 14 May 2018 19:03:49 +0200
Message-Id: <20180514170351.13737-2-jack@suse.cz>
In-Reply-To: <20180514170351.13737-1-jack@suse.cz>
References: <20180514170351.13737-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Project quota can work for ext2 & ext3 the same way as for ext4. Handle
them properly as currently the tests just fail because of unknown
prjquota mount option. After this patch, tests will be "not run" because
ext4 driver refuses to use project quota mount options for "old" fs
types.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/quota | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/quota b/common/quota
index f8e037995ad4..2b99521df43d 100644
--- a/common/quota
+++ b/common/quota
@@ -90,9 +90,9 @@ _require_xfs_quota_foreign()
 _require_prjquota()
 {
     [ -n "$1" ] && _dev="$1" || _dev="$TEST_DEV"
-    if [ "$FSTYP" == "ext4" ]; then
+    if [[ "$FSTYP" == ext[234] ]]; then
 	dumpe2fs -h $_dev 2>&1 | grep -qw project || \
-		_notrun "Project quota not available on this ext4"
+		_notrun "Project quota not available on this $FSTYP"
     fi
     src/feature -P $_dev
     [ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
@@ -116,7 +116,7 @@ _require_getnextquota()
 # prior to mount.  This is a relatively new feature ...
 _scratch_enable_pquota()
 {
-	[ "$FSTYP" != "ext4" ] && return
+	[[ "$FSTYP" != ext[234] ]] && return
 
 	tune2fs -O quota,project $SCRATCH_DEV >>$seqres.full 2>&1
 	_try_scratch_mount >/dev/null 2>&1 \
@@ -242,7 +242,7 @@ _qmount_option()
 
 	# ext4 doesn't _do_ "-o pquota/prjquota" because reasons
 	# Switch it to "quota" to enable mkfs-time pquota
-	if [ "$FSTYP" == "ext4" ]; then
+	if [[ "$FSTYP" == ext[234] ]]; then
 		OPTS=`echo $OPTS \
 		| sed	-e 's/\bpquota/quota/g'	\
 			-e 's/prjquota/quota/g'`
-- 
2.13.6

