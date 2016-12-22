Received: from mx1.redhat.com ([209.132.183.28]:51768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938649AbcLVBXg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Dec 2016 20:23:36 -0500
Subject: [PATCH 1/2] generic/244: remove extra junk
References: <a3c43ff2-c641-aba4-b10e-781a3f3c86e3@redhat.com>
 <8c91051e-8a78-cb20-d926-ea86e5b4645a@sandeen.net>
From: Eric Sandeen <sandeen@redhat.com>
Message-ID: <7a066f0b-337a-8920-48d4-88b65633c5d6@redhat.com>
Date: Wed, 21 Dec 2016 19:23:06 -0600
MIME-Version: 1.0
In-Reply-To: <8c91051e-8a78-cb20-d926-ea86e5b4645a@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Lots of pointless mounting & unmounting & quotaon etc,
get rid of it.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/244 b/tests/generic/244
index 0b50438..36c632e 100755
--- a/tests/generic/244
+++ b/tests/generic/244
@@ -54,18 +54,11 @@ _supported_os Linux
 _require_quota
 _require_scratch
 
-scratch_unmount 2>/dev/null
 _scratch_mkfs >> $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
-quotacheck -u -g $SCRATCH_MNT 2>/dev/null
-quotaon $SCRATCH_MNT 2>/dev/null
-_scratch_unmount
 
 TYPES="u g"
 MOUNT_OPTIONS="-o usrquota,grpquota"
-
 _qmount
-quotaon $SCRATCH_MNT 2>/dev/null
 
 # Ok, do we even have GETNEXTQUOTA?  Querying ID 0 should work.
 $here/src/test-nextquota -i 0 -u -d $SCRATCH_DEV &> $seqres.full || \

