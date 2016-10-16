Received: from mail-wm0-f66.google.com ([74.125.82.66]:36447 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752383AbcJPIug (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Oct 2016 04:50:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id 79so5228556wmy.3
        for <fstests@vger.kernel.org>; Sun, 16 Oct 2016 01:50:35 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2 2/2] fstests: run xfs_io as multi threaded for 'quick' tests
Date: Sun, 16 Oct 2016 11:50:01 +0300
Message-Id: <1476607801-27684-2-git-send-email-amir73il@gmail.com>
In-Reply-To: <1476607801-27684-1-git-send-email-amir73il@gmail.com>
References: <1476607801-27684-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Try to run xfs_io for tests in group quick with command line
option -M which starts an idle thread before performing any io.

The purpose of this idle thread is to test io from a multi threaded
process. With single threaded process, the file table is not shared
and file structs are not reference counted.

In order to improve the chance of detecting file struct reference
leaks, we should run xfs_io commands with this option as much as
possible.

Analysis of the effect of xfs_io -M on tests runtime showed that
it may lead to slightly longer run times in extreme cases (e.g +3s
for generic/132), but has a negligable effect on runtime of tests
among the 'quick' group (worst case +0.3s for generic/130).

Therefore, we automatically add the -M flags only to tests in the
'quick' group.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check     |  2 ++
 common/rc | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/check b/check
index 69341d8..e568598 100755
--- a/check
+++ b/check
@@ -574,6 +574,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	    mkdir -p $RESULT_DIR
 
+	    export TEST_GROUPS=`grep $(basename $seqnum) "$SRC_DIR/$(dirname $seqnum)/group"`
+
 	    echo -n "$seqnum"
 
 		if $showme; then
diff --git a/common/rc b/common/rc
index 565ba67..6a76fba 100644
--- a/common/rc
+++ b/common/rc
@@ -3799,6 +3799,21 @@ init_rc()
 	$XFS_IO_PROG -c stat $TEST_DIR 2>&1 | grep -q "is not on an XFS filesystem" && \
 		export XFS_IO_PROG="$XFS_IO_PROG -F"
 
+	if echo $TEST_GROUPS | grep -q quick; then
+		# xfs_io -M flag runs xfs_io as multi threaded process
+		# in order to catch fdget/fdset reference leaks, because
+		# file structs are not reference counted in a single threaded
+		# process.
+		# Because reference counted fdget/fdset may lead to slightly
+		# longer run times in extreme cases (such as generic/132),
+		# we limit the use of -M flags to tests with short runtime,
+		# where the effect of the flag is negligable.
+		#
+		# Figure out if xfs_io supports the -M option
+		$XFS_IO_PROG -M -c quit 2>/dev/null && \
+			export XFS_IO_PROG="$XFS_IO_PROG -M"
+	fi
+
 	# xfs_copy doesn't work on v5 xfs yet without -d option
 	if [ "$FSTYP" == "xfs" ] && [[ $MKFS_OPTIONS =~ crc=1 ]]; then
 		export XFS_COPY_PROG="$XFS_COPY_PROG -d"
-- 
2.7.4

