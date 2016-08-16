Received: from mx1.redhat.com ([209.132.183.28]:53364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958AbcHPDVI (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Aug 2016 23:21:08 -0400
Date: Tue, 16 Aug 2016 11:20:48 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/263: test xfs_quota "state" command
Message-ID: <20160816032048.GK27776@eguan.usersys.redhat.com>
References: <ae59c7a8-321c-42c4-70e4-8d9e8dca80b8@redhat.com>
 <20160815053626.GF27776@eguan.usersys.redhat.com>
 <5efd2e7f-5cd9-2a01-4a8f-b9308f3bd13d@sandeen.net>
 <6979e124-ee73-94e3-1c09-1dfb2d0b368a@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6979e124-ee73-94e3-1c09-1dfb2d0b368a@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 15, 2016 at 10:15:17PM -0500, Eric Sandeen wrote:
> 
> 
> On 8/15/16 9:48 PM, Eric Sandeen wrote:
> > 
> > 
> > On 8/15/16 12:36 AM, Eryu Guan wrote:
> >> On Fri, Aug 12, 2016 at 05:53:04PM -0500, Eric Sandeen wrote:
> >>> This exercises the xfs_quota "state" command for every
> >>> combination of user, group, and project quota enablement
> >>> on both crc (with project quota inode on disk) and non-crc
> >>> (where project quota overlaps group quota on disk) filesystems.
> >>>
> >>> It currently requires patches to the upstream kernel
> >>> ("quota: fill in Q_XGETQSTAT inode information for inactive quotas")
> >>> and to xfsprogs ("xfs_quota: wire up XFS_GETQSTATV") to pass.
> >>
> >> I've applied these patches to kernel (4.8-rc1 based) and xfsprogs
> >> (4.7-rc1 based), and the quota filter fix to xfstests, but I still saw
> >> failures on this, did I miss anything?
> >>
> >> [root@dhcp-66-86-11 xfstests]# diff -u tests/xfs/263.out /root/workspace/xfstests/results//xfs_4k_crc/xfs/263.out.bad
> >> --- tests/xfs/263.out   2016-08-15 10:56:23.973000000 +0800
> >> +++ /root/workspace/xfstests/results//xfs_4k_crc/xfs/263.out.bad        2016-08-15 13:29:48.934000000 +0800
> >> @@ -9,11 +9,11 @@
> >>  Group quota state on SCRATCH_MNT (SCRATCH_DEV)
> >>    Accounting: OFF
> >>    Enforcement: OFF
> >> -  Inode: N/A
> >> +  Inode: #0 (0 blocks, 0 extents)
> >>  Project quota state on SCRATCH_MNT (SCRATCH_DEV)
> >>    Accounting: OFF
> >>    Enforcement: OFF
> >> -  Inode: N/A
> >> +  Inode: #0 (0 blocks, 0 extents)
> > 
> > strange, that's the kind of thing the kernel patch was intended to fix.
> > 
> > I meant to retest from scratch on bleeding-edge upstream, but too many
> > things got in the way today.  Will try again tomorrow...
> 
> Can you recheck?  I built everything from scratch on a freshly-installed
> box, and with the patches mentioned, it passes for me.

Sure, will do.

> 
> oh, but try V2 of the xfsprogs patch ;)  (I'll send that in a minute).

No problem :)

Thanks,
Eryu
