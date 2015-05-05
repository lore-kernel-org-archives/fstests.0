Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:56386 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750887AbbEEAv0 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 4 May 2015 20:51:26 -0400
Date: Tue, 5 May 2015 10:51:12 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 3/4] xfs/045: can't change UUID on v5 filesystems.
Message-ID: <20150505005112.GK15810@dastard>
References: <1430776893-25158-1-git-send-email-david@fromorbit.com>
 <1430776893-25158-4-git-send-email-david@fromorbit.com>
 <5547F73F.2030303@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5547F73F.2030303@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 04, 2015 at 05:48:31PM -0500, Eric Sandeen wrote:
> On 5/4/15 5:01 PM, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > So pass "-m crc=0" to the scratch_mkfs command so that we only run
> > on old v4 format filesystems where the UUID can be changed.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> 
> hm, given that I might "fix" this should we instead trap
> on an xfs_db uuid failure, and _notrun the test?
> (oh, but older xfs_db let it go, didn't it.  sigh).
> 
> I guess nothing about the presence of crc vs. non-crc
> matters for this test, so turning it off by default is probably ok.
> It could use a comment about why it's got "-m crc=0" though, at
> least.

Added. New patch below.

-- 
Dave Chinner
david@fromorbit.com

xfs/045: can't change UUID on v5 filesystems.

From: Dave Chinner <dchinner@redhat.com>

So pass "-m crc=0" to the scratch_mkfs command so that we only run
on old v4 format filesystems where the UUID can be changed.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
V2: added comment explaining "-m crc=0".

 tests/xfs/045 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/xfs/045 b/tests/xfs/045
index 7d8a4a1..2733f5c 100755
--- a/tests/xfs/045
+++ b/tests/xfs/045
@@ -49,8 +49,11 @@ _require_scratch_nocheck
 
 echo "*** get uuid"
 uuid=`_get_existing_uuid`
+
+# We can only change the UUID on a v4 filesystem. Revist this when/if UUIDs
+# can be changed on v5 filesystems.
 echo "*** mkfs"
-if ! _scratch_mkfs_xfs >$tmp.out 2>&1
+if ! _scratch_mkfs_xfs -m crc=0 >$tmp.out 2>&1
 then
     cat $tmp.out
     echo "!!! failed to mkfs on $SCRATCH_DEV"
