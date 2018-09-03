Received: from mail-wr1-f65.google.com ([209.85.221.65]:38061 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeICQr3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Sep 2018 12:47:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so487194wrc.5
        for <fstests@vger.kernel.org>; Mon, 03 Sep 2018 05:27:34 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH] tmpfs: don't require TEST_DEV
Date: Mon,  3 Sep 2018 14:27:28 +0200
Message-Id: <20180903122728.22882-1-mszeredi@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

tmpfs doesn't require a device and the source argument of the mount is ignored.
If TEST_DEV is not given then set it to "none".

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 common/config | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 2f1f27206776..40c2b399a3c7 100644
--- a/common/config
+++ b/common/config
@@ -456,8 +456,9 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
-	9p)
+	9p|tmpfs)
 		# 9p mount tags are just plain strings, so anything is allowed
+		# tmpfs doesn't use mount source, ignore
 		;;
 	overlay)
 		if [ ! -d "$dev" ]; then
@@ -657,6 +658,10 @@ get_next_config() {
 		export RESULT_BASE="$here/results/"
 	fi
 
+	if [ "$FSTYP" == tmpfs -a -z "$TEST_DEV" ]; then
+		export TEST_DEV=none
+	fi
+
 	#  Mandatory Config values.
 	MC=""
 	[ -z "$EMAIL" ]          && MC="$MC EMAIL"
-- 
2.14.3
