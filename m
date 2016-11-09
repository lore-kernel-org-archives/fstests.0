Received: from mx1.redhat.com ([209.132.183.28]:59804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbcKIJno (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 9 Nov 2016 04:43:44 -0500
Date: Wed, 9 Nov 2016 17:43:41 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: btrfs: Check false ENOSPC bug caused by
 incorrect metadata reserve
Message-ID: <20161109094341.GY27776@eguan.usersys.redhat.com>
References: <20161108091515.20867-1-quwenruo@cn.fujitsu.com>
 <20161108105826.GN27776@eguan.usersys.redhat.com>
 <d9a9d224-2f21-5b77-a3e9-de271cd4e755@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9a9d224-2f21-5b77-a3e9-de271cd4e755@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 09, 2016 at 08:24:38AM +0800, Qu Wenruo wrote:
> 
> 
> At 11/08/2016 06:58 PM, Eryu Guan wrote:
> > On Tue, Nov 08, 2016 at 05:15:15PM +0800, Qu Wenruo wrote:
> > > Due to the fact that btrfs uses different max extent size for
> > > compressed and non-compressed write, it calculates metadata reservation
> > > incorrectly.
> > > 
> > > This can leads to false ENOSPC alert for compressed write.
> > > 
> > > This test case will check it by using small fs and large nodesize, and
> > > do parallel compressed write to trigger it.
> > > 
> > > The fix is not merged and may change in the future, but the function is
> > > good enough:
> > > btrfs: improve inode's outstanding_extents computation
> > > btrfs: fix false enospc for compression
> > > 
> > > Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> > > ---
[snip]
> > > +
> > > +# Use small filesystem with maximum nodesize.
> > > +# Since the false ENOSPC happens due to incorrect metadata reservation,
> > > +# larger nodesize and small fs will make it much easier to reproduce
> > > +_scratch_mkfs -b 512M -n 64k >> $seqres.full 2>&1
> > 
> > How about override MKFS_OPTIONS and call _scratch_mkfs_sized? e.g.
> > 
> > export MKFS_OPTIONS="-n 64k"
> > _scratch_mkfs_sized $((512 * 1024 * 1024))
> 
> Overriding MKFS_OPTIONS makes us unable to parse more mkfs options, for
> example to test some incompatible features.
> 
> So I'd just parse this mkfs options as extra options.

We should use helpers and not open-code when helpers are available. So
we should really use _scratch_mkfs_sized here.

And "-n 64k" is only to make bug easier to reproduce, but I don't think
it's necessary. In my testings, 50%-75% runs hit the ENOSPC failure on
my x86_64 test vm, even I removed the "-n 64k" mkfs option from the
test.

So I'd say remove "-n 64k" and test whatever mkfs options user
specified.

> > 
> > > +_scratch_mount "-o compress"

And compress mount option is not necessary to me either. btrfs compress
is a commonly tested configuration, there's no need to force the
compress option in the test. So we can test other configurations too.

Thanks,
Eryu
