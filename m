Received: from mail-pg1-f194.google.com ([209.85.215.194]:40113 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1Imu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Nov 2018 03:42:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so8459468pgp.7
        for <fstests@vger.kernel.org>; Tue, 27 Nov 2018 13:43:34 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 2/3] ext4: 032: fail nicely if the test partition is not big enough for the test
Date: Tue, 27 Nov 2018 13:43:07 -0800
Message-Id: <20181127214308.137410-3-gwendal@chromium.org>
In-Reply-To: <20181127214308.137410-1-gwendal@chromium.org>
References: <20181127214308.137410-1-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 tests/ext4/032 | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/032 b/tests/ext4/032
index 8534ddd6..7d8c6da7 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -35,12 +35,21 @@ ext4_online_resize()
 	local original_size=$1
 	local final_size=$2
 	local check_if_supported=${3:-0}
+	local avail=`df -P $SCRATCH_DIR | awk 'END {print $4}'`
+	local requested=$(($final_size * $BLK_SIZ))
+
+	if [ $avail -lt $requested ]; then
+		echo "+++ not enough space on $SCRATCH_DIR: " \
+		     "requested $requested only $avail left" | \
+			tee -a $seqres.full
+		_notrun "incomplete test due to storage space constraint"
+	fi
 
 	## Start with a clean image file.
 	echo "" > ${IMG_FILE}
 	echo "+++ truncate image file to $final_size" | \
 		tee -a $seqres.full
-	$XFS_IO_PROG -f -c "truncate $(($final_size * $BLK_SIZ))" ${IMG_FILE}
+	$XFS_IO_PROG -f -c "truncate $requested" ${IMG_FILE}
 	LOOP_DEVICE=`_create_loop_device $IMG_FILE`
 
 	echo "+++ create fs on image file $original_size" | \
-- 
2.18.1
