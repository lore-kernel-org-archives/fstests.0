Received: from mx1.redhat.com ([209.132.183.28]:60678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbcLOG3q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 15 Dec 2016 01:29:46 -0500
Date: Thu, 15 Dec 2016 14:29:44 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: trouble with generic/081
Message-ID: <20161215062944.GE28577@eguan.usersys.redhat.com>
References: <20161214164314.GA25105@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214164314.GA25105@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
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
> 
> Here is the output if I let the commands in _cleanup print to stdout:
> 
> QA output created by 081
> Silence is golden
> umount: /mnt/test/mnt_081: not mounted
>   Logical volume vg_081/snap_081 contains a filesystem in use.
>   PV /dev/sdc belongs to Volume Group vg_081 so please use vgreduce first.

Yes, I have this problem too.

My original patch didn't have "-c fsync" in the last xfs_io pwrite
command,

$XFS_IO_PROG -fc "pwrite 0 5m" -c fsync $mnt/testfile >>$seqres.full 2>&1

and Brian suggested that an explicit fsync would make the test clear.
And Dave added it and committed the patch.

https://www.spinics.net/lists/fstests/msg01265.html

This cleanup failure was the exact reason why I didn't include fsync at
first.

https://www.spinics.net/lists/fstests/msg01269.html

Then I sent a follow-up patch to workaround this issue, but Dave
suggested that we should triage and fix the underlying bug first (if
there's any).

https://www.spinics.net/lists/fstests/msg01406.html

I tried to follow & dig into it but went nowhere, I didn't know that
part of code good enough..

> 
> You added a comment in _cleanup that sais:
> 
> # lvm may have umounted it on I/O error, but in case it does not
> 
> Does LVM really unmount filesystems on it's own?  Could we be racing
> with it?

IIRC, there's some kind of hooks in LVM that unmount the filesystems,
but I can't recall the details now.. From the ending results, the
filesystems are umounted, perhaps that's why you see "/mnt/test/mnt_081:
not mounted" (this error message is redirected to /dev/null in the
test).

> 
> With a "sleep 1" added before the umount call the test passes reliably
> for me, but that seems like papering over the issue.

Do you have any preference on this?

Thanks,
Eryu
