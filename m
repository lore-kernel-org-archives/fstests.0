Received: from mx2.suse.de ([195.135.220.15]:47637 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028AbcCCSRB (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 3 Mar 2016 13:17:01 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 544B6ADCF
	for <fstests@vger.kernel.org>; Thu,  3 Mar 2016 18:16:59 +0000 (UTC)
From: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs/048: user filter for property error messages
Date: Thu,  3 Mar 2016 19:16:43 +0100
Message-Id: <6dbf926cd05b145a54044c48c1c2b04ebe6b3e3d.1457028701.git.dsterba@suse.com>
In-Reply-To: <cover.1457028701.git.dsterba@suse.com>
References: <cover.1457028701.git.dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/btrfs/048 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/048 b/tests/btrfs/048
index c2cb4a63b095..4a36303632eb 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -41,6 +41,7 @@ _cleanup()
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/filter
+. ./common/filter.btrfs
 
 # real QA test starts here
 _supported_fs btrfs
@@ -70,7 +71,8 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT label ''
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT label
 echo "***"
 mkdir $SCRATCH_MNT/testdir
-$BTRFS_UTIL_PROG property get $SCRATCH_MNT/testdir label
+$BTRFS_UTIL_PROG property get $SCRATCH_MNT/testdir label 2>&1 |
+	_filter_btrfs_prop_error label
 echo "***"
 
 echo -e "\nTesting subvolume ro property"
-- 
1.8.4.5

