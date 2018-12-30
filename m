Received: from mx1.redhat.com ([209.132.183.28]:52080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeL3PBn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 30 Dec 2018 10:01:43 -0500
Date: Sun, 30 Dec 2018 23:01:40 +0800
From: Xiong Murphy Zhou <xzhou@redhat.com>
Subject: Re: [PATCH] common/nfs: add FSX_AVOID when testing on NFS
Message-ID: <20181230150140.usmcus3ldvidh4in@XZHOUW.usersys.redhat.com>
References: <20181229085304.4310-1-xzhou@redhat.com>
 <20181229190117.GC20474@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229190117.GC20474@magnolia>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Xiong Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 29, 2018 at 11:01:17AM -0800, Darrick J. Wong wrote:
> On Sat, Dec 29, 2018 at 04:53:04PM +0800, Xiong Murphy Zhou wrote:
> > copy_file_range on NFSv4.2 requires that src offset and dest offset
> > are aligned with server blocksize. So does copy count, except that
> > after this copy, we'll reach the EOF. See Linux commit 811b7b85.
> > 
> > ltp/fsx.c tests copy_file_range on random offset with random size
> > by default. This makes these tests get EINVAL on NFS.
> > 
> > Signed-off-by: Xiong Murphy Zhou <xzhou@redhat.com>
> > ---
> >  common/nfs | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/common/nfs b/common/nfs
> > index a03eaf48..5600147d 100644
> > --- a/common/nfs
> > +++ b/common/nfs
> > @@ -33,3 +33,12 @@ _require_scratch_nfs_version()
> >  	fi
> >  	_scratch_unmount
> >  }
> > +
> > +# copy_file_range on NFSv4.2 requires src offset and dest offset
> > +# are aligned with server blocksize. So does copy count, except that
> > +# after this copy, we'll reach the EOF. See Linux commit 811b7b85
> > +# for details.
> > +# ltp/fsx.c tests copy_file_range on random offset with random size
> > +# by default. This makes these tests get EINVAL on NFS.
> 
> I think it's more appropriate to fix the vfs copy_file_range to fall
> back to page cache copy when the nfs server declines to do it.
> 
> And, since we already know Dave Chinner is working on that, just wait
> for the v2 patches.

Great to know that! Thanks for the info!

> 
> > +# Now add FSX_AVOID to make fsx tests on NFS rational.
> > +FSX_AVOID="-r 4096 -w 4096 -O -o 4096 -Z $FSX_AVOID"
> 
> How do you know the server blocksize is 4k?

Ha, I don't know. Very good point. :)

> 
> Also, this forces /every/ fsx operation to be page aligned directio, I
> don't think we want to apply such a big hammer.

Adding -Z was to make the IO size aligned with readbdy. O_DIRECT is not
necessary here. I just found -Z can do that for me. Maybe we need another
option to archive this:
	if (some_option)
		size -= size % readbdy;
in ltp/fsx.c

Thanks for the reviewing!

Xiong
> 
> --D
> 
> > 2.17.0.252.gfe0a9ea
> > 
