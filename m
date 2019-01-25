Received: from mail.kernel.org ([198.145.29.99]:53858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfAYLqS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 25 Jan 2019 06:46:18 -0500
From: fdmanana@kernel.org
Subject: [PATCH 1/2] fstests: btrfs/081 declare local variables as local
Date: Fri, 25 Jan 2019 11:46:11 +0000
Message-Id: <20190125114611.3954-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

Some variables inside the test's functions were used as local but were not
being declared as such. Add the local declaration for them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/081 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/081 b/tests/btrfs/081
index dc357e53..7e83525f 100755
--- a/tests/btrfs/081
+++ b/tests/btrfs/081
@@ -45,7 +45,7 @@ extent_size=8192
 
 create_source_file()
 {
-	name=$1
+	local name=$1
 
 	# Create a file with $num_extents extents, each with a size of
 	# $extent_size bytes.
@@ -60,8 +60,8 @@ create_source_file()
 
 create_target_file()
 {
-	name=$1
-	file_size=$(($num_extents * $extent_size))
+	local name=$1
+	local file_size=$(($num_extents * $extent_size))
 
 	$XFS_IO_PROG -f -c "pwrite -S 0xff 0 $file_size" \
 		-c "fsync" $SCRATCH_MNT/$name | _filter_xfs_io
@@ -69,7 +69,7 @@ create_target_file()
 
 reader_loop()
 {
-	name=$1
+	local name=$1
 
 	while true; do
 		cat $SCRATCH_MNT/$name > /dev/null
-- 
2.11.0
