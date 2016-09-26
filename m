Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49552 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751950AbcIZBuO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Sep 2016 21:50:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1504CB40
        for <fstests@vger.kernel.org>; Sun, 25 Sep 2016 21:44:15 -0400 (EDT)
Received: from mba-jeffm.home.jeffm.io (c-73-100-145-192.hsd1.ma.comcast.net [73.100.145.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8B936F2988
        for <fstests@vger.kernel.org>; Sun, 25 Sep 2016 21:44:14 -0400 (EDT)
From: Jeff Mahoney <jeffm@jeffm.io>
Subject: [PATCH] check: check SCRATCH_MNT before calling _scratch_mkfs
Message-ID: <81e70e43-b337-acca-1c29-69db4f3a3cfa@jeffm.io>
Date: Sun, 25 Sep 2016 21:44:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On NFS or Overlayfs, "mkfs" turns into rm -rf $SCRATCH_MNT/*

There is no warning/error in check if SCRATCH_MNT is unset.

Also add the checks to _scratch_cleanup_files.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 check     | 12 ++++++++++++
 common/rc |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/check b/check
index 69341d8..b22d2df 100755
--- a/check
+++ b/check
@@ -512,6 +512,18 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	needwrap=true
 
 	if [ ! -z "$SCRATCH_DEV" ]; then
+	   if [ -z "$SCRATCH_MNT" ]
+	    then
+		echo "\$SCRATCH_MNT is unset"
+		status=1
+		exit
+	    fi
+	   if [ ! -d "$SCRATCH_MNT" ]
+	    then
+		echo "\$SCRATCH_MNT is not a dir"
+		status=1
+		exit
+	    fi
 	  _scratch_unmount 2> /dev/null
 	  # call the overridden mkfs - make sure the FS is built
 	  # the same as we'll create it later.
diff --git a/common/rc b/common/rc
index 13afc6a..4266c18 100644
--- a/common/rc
+++ b/common/rc
@@ -764,10 +764,18 @@ _scratch_cleanup_files()
 {
 	case $FSTYP in
 	overlay)
+		if [ -z "$SCRATCH_DEV" ]; then
+			echo "\$SCRATCH_DEV is unset."
+			return 1
+		fi
 		# $SCRATCH_DEV is a valid directory in overlay case
 		rm -rf $SCRATCH_DEV/*
 		;;
 	*)
+		if [ -z "$SCRATCH_MNT" ]; then
+			echo "\$SCRATCH_MNT is unset."
+			return 1
+		fi
 		_scratch_mount
 		rm -rf $SCRATCH_MNT/*
 		_scratch_unmount
-- 
1.7.12.4

