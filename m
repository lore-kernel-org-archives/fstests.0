From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 1/3] common/rc: factor out _supports_filetype() helper
Date: Tue, 20 Dec 2016 15:17:33 +0200
Message-Id: <1482239855-791-2-git-send-email-amir73il@gmail.com>
In-Reply-To: <1482239855-791-1-git-send-email-amir73il@gmail.com>
References: <1482239855-791-1-git-send-email-amir73il@gmail.com>
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

_overlay_mount_dirs() checks for the filetype feature
on upper dir fs.

factor out that feature test to a helper.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/common/rc b/common/rc
index 2639fbd..288517f 100644
--- a/common/rc
+++ b/common/rc
@@ -264,6 +264,23 @@ _scratch_mount_options()
 					$SCRATCH_DEV $SCRATCH_MNT
 }
 
+_supports_filetype()
+{
+	local dir=$1
+	shift 1
+
+	local upper_fst=$(df --output=fstype $dir | tail -1)
+	case "$upper_fst" in
+	xfs)
+		xfs_info $dir | grep -q "ftype=1"
+		;;
+	ext2|ext3|ext4)
+		tune2fs -l $(df --output=source $dir | tail -1) | \
+		   grep -q filetype
+		;;
+	esac
+}
+
 # helper function to do the actual overlayfs mount operation
 _overlay_mount_dirs()
 {
@@ -284,20 +301,8 @@ _overlay_mount()
 	local mnt=$2
 	shift 2
 
-	local upper_fst=$(df --output=fstype $dir | tail -1)
-	case "$upper_fst" in
-	xfs)
-		if ! xfs_info $dir | grep -q "ftype=1" ; then
-			_notrun "upper fs needs to support d_type"
-		fi
-		;;
-	ext2|ext3|ext4)
-		if ! tune2fs -l $(df --output=source $dir | tail -1) | \
-		   grep -q filetype ; then
-			_notrun "upper fs needs to support d_type"
-		fi
-		;;
-	esac
+	_supports_filetype $dir || \
+		_notrun "upper fs needs to support d_type"
 
 	mkdir -p $dir/$OVERLAY_UPPER_DIR
 	mkdir -p $dir/$OVERLAY_LOWER_DIR
-- 
2.7.4
