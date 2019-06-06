Received: from mx2.suse.de ([195.135.220.15]:40806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfFFLjM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Jun 2019 07:39:12 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH fstests v2] btrfs: add validation of compression options to btrfs/048
Date: Thu,  6 Jun 2019 13:39:07 +0200
Message-Id: <20190606113907.17551-1-jthumshirn@suse.de>
In-Reply-To: <CAL3q7H665Rh7P8bwxNxHJVFibvb6pSg7MeFaqhsRWKx4jMW8JA@mail.gmail.com>
References: <CAL3q7H665Rh7P8bwxNxHJVFibvb6pSg7MeFaqhsRWKx4jMW8JA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>, Filipe Manana <fdmanana@gmail.com>
Cc: Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>, fstests@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>
List-ID: <fstests@vger.kernel.org>

The current btrfs/048 test-case did not check the behavior of properties
with options like compression and with the compression level supplied.

Add test cases for compression with compression level as well so we can be
sure we don't regress there.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Filipe Manana <fdmanana@suse.com>

---
Changes to v1:
- Removed output redirection and filtering for the cases we don't expect any
  actual output (Filipe)
---
 tests/btrfs/048     | 15 +++++++++++++++
 tests/btrfs/048.out | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 8bb10a904bc9..04df3ed98ff7 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -226,5 +226,20 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' 2>&1 | _filter_scrat
 $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
 $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^generation'
 
+echo -e "\nTesting argument validation with options"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo:9'
+echo "***"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zlib:3'
+echo "***"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zstd:0'
+echo "***"
+
+echo -e "\nTesting invalid argument validation with options, should fail"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz:9' 2>&1 | _filter_scratch
+echo "***"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli:0' 2>&1 | _filter_scratch
+echo "***"
+$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst:3' 2>&1 | _filter_scratch
+
 status=0
 exit
diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
index 16a785a642f7..016eba265b01 100644
--- a/tests/btrfs/048.out
+++ b/tests/btrfs/048.out
@@ -92,3 +92,15 @@ Testing generation is unchanged after failed validation
 generation		7
 ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
 generation		7
+
+Testing argument validation with options
+***
+***
+***
+
+Testing invalid argument validation with options, should fail
+ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
+***
+ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
+***
+ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
-- 
2.16.4
