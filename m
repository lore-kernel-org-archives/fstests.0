Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:49722 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934162AbcLOGgz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Dec 2016 01:36:55 -0500
Date: Thu, 15 Dec 2016 17:36:50 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: trouble with generic/081
Message-ID: <20161215063650.GJ4326@dastard>
References: <20161214164314.GA25105@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214164314.GA25105@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: eguan@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 14, 2016 at 08:43:14AM -0800, Christoph Hellwig wrote:
> Hi Eryu,
> 
> I'm running into a fairly reproducable issue with generic/081
> (about every other run): For some reason the umount call in
> _cleanup doesn't do anything because it thinks the file system isn't
> mounted, but then vgremove complains that there is a mounted file
> system.  This leads to the scratch device no being release and all
> subsequent tests failing.

Yup, been seeing that on my pmem test setup for months. Reported
along with the subsequent LVM configuration fuckup it resulted in:

https://www.redhat.com/archives/dm-devel/2016-July/msg00405.html

> Here is the output if I let the commands in _cleanup print to stdout:
> 
> QA output created by 081
> Silence is golden
> umount: /mnt/test/mnt_081: not mounted
>   Logical volume vg_081/snap_081 contains a filesystem in use.
>   PV /dev/sdc belongs to Volume Group vg_081 so please use vgreduce first.
> 
> You added a comment in _cleanup that sais:
> 
> # lvm may have umounted it on I/O error, but in case it does not
> 
> Does LVM really unmount filesystems on it's own?  Could we be racing
> with it?

Nope, I'm pretty sure it's a snapshot lifecycle issue - the snapshot
is still busy doing something (probably IO) for a short while after
we unmount, so LVM can't tear it down immediately like we ask. Wait
a few seconds, the snapshot work finishes, goes idle, and then it
can be torn down.

But if you consider the fuckup that occurs if generic/085 starts up
and tries to reconfigure LVM while the snapshot from generic/081 is
still in this whacky window (as reported in the above link), this is
really quite a nasty bug.

> With a "sleep 1" added before the umount call the test passes reliably
> for me, but that seems like papering over the issue.

Yup, same here. My local patch is this:

---
 tests/generic/081 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/generic/081 b/tests/generic/081
index 11755d4d89ff..ff33ffaa4fb8 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -36,6 +36,11 @@ _cleanup()
 	rm -f $tmp.*
 	# lvm may have umounted it on I/O error, but in case it does not
 	$UMOUNT_PROG $mnt >/dev/null 2>&1
+
+	# on a pmem device, the vgremove/pvremove commands fail immediately
+	# after unmount. Wait a bit before removing them in the hope it
+	# succeeds.
+	sleep 5
 	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
 	$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
 }

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
