Received: from mail-pl0-f51.google.com ([209.85.160.51]:45083 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeDNFum (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 14 Apr 2018 01:50:42 -0400
Date: Sat, 14 Apr 2018 13:50:35 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v3] fstests: btrfs/159 superblock corruption test case
Message-ID: <20180414055035.GI2932@desktop>
References: <20180329102848.12669-1-anand.jain@oracle.com>
 <20180409052830.4772-1-anand.jain@oracle.com>
 <20180413044335.GG2932@desktop>
 <a4195afb-60cd-0183-3ce2-d99338bc0d51@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4195afb-60cd-0183-3ce2-d99338bc0d51@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Apr 14, 2018 at 06:43:49AM +0800, Anand Jain wrote:
> 
> > > +# Test if the superblock corruption is handled correctly:
> > > +# 	- Test fsid miss-match (csum ok) between primary and copy superblock
> > > +#	Fixed by the ML patch:
> > > +#	btrfs: check if the fsid in the primary sb and copy sb are same
> > > +# 	- Test if the mount fails if the primary superblock csum is
> > > +#		corrupted on any disk
> > > +# 	- Test if the mount does not fail if the copy1 sb csum is corrupted
> > > +#	Fixed by the ML patches:
> > > +#	btrfs: verify superblock checksum during scan
> > > +#	btrfs: verify checksum for all devices in mount context
> > 
> > Do you have a tree that I can pull from? I want to make sure the test
> > does pass on patched kernel, but the patchset doesn't apply on v4.16
> > kernel.
> 
> We have new discussions on whether to check for the alien-superblock and
> the superblock-checksum at the mount and scan time respectively. And
> depending on its outcome this test-case should be modified as well. So
> can you please defer this fstest patch, for now, I shall send a revised
> fstest patch when kernel patches gets integrated.

Thanks for the heads-up, I'll drop it for now.

> 
> In any case, if you want to give a try, those patches are base on kdave repo
> at [1].
>  [1]
>  https://github.com/kdave/btrfs-devel.git misc-next

Thanks!

Eryu
