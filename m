Received: from mx2.suse.de ([195.135.220.15]:34877 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757500AbdEYJIu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 May 2017 05:08:50 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8669AAB09
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 09:08:49 +0000 (UTC)
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] generic/108: Fix return value check from _get_scsi_debug_dev
Date: Thu, 25 May 2017 12:08:46 +0300
Message-Id: <1495703326-1269-1-git-send-email-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

_get_scsi_debug_dev is supposed to return a "/dev/$device".
However, in case the scsi device is not mapped to a disk, hence
/dev/sd* doesn't exist, then get_scsi_debug_dev would return only the
"/dev/" string. In generic/108 we check whether return value is ""
and only then consider it a failure. This behavior allows the
test to erroneously consider _get_scsi_debug_dev succeeded even
if it returned a malformed string. Fix this by correctly checking
whether the return value is "/dev/"

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/generic/108 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/108 b/tests/generic/108
index cc8d7038..1525dfb6 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -64,7 +64,7 @@ rm -f $seqres.full
 
 # _get_scsi_debug_dev returns a scsi debug device with 128M in size by default
 SCSI_DEBUG_DEV=`_get_scsi_debug_dev`
-if [ "$SCSI_DEBUG_DEV" == "" ]; then
+if [ "$SCSI_DEBUG_DEV" == "/dev/" ]; then
 	_fail "Failed to initialize scsi debug device"
 fi
 echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
-- 
2.12.3

