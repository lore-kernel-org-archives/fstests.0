Received: from mx1.redhat.com ([209.132.183.28]:43186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757459AbeD0L0k (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Apr 2018 07:26:40 -0400
Date: Fri, 27 Apr 2018 07:26:38 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v2] tests/xfs: filestream allocator inode use-after-free
 test
Message-ID: <20180427112638.GA9120@bfoster.bfoster>
References: <20180426120444.3620-1-bfoster@redhat.com>
 <20180427020458.GJ11384@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427020458.GJ11384@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 27, 2018 at 10:04:58AM +0800, Eryu Guan wrote:
> On Thu, Apr 26, 2018 at 08:04:44AM -0400, Brian Foster wrote:
> > The XFS filestreams allocator caches dir inode -> agno mappings in
> > an MRU mechanism that holds elements in memory for an amount of time
> > and then cleans up expired elements in the background. The elements
> > typically held inode pointers without holding a reference to the
> > associated inode. This means that if the inode is reclaimed before
> > an expired entry is cleaned up, the MRU reaper can access freed
> > memory and cause a panic.
> > 
> > Test for this problem by performing continuous filestreams
> > allocations under short-lived parent directory inodes. This will
> > produce KASAN use-after-free splats if enabled during the test.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > v2:
> > - Drop unnecessary _scratch_mount error check.
> > - Create and use helper for min. scratch dev size.
> > v1: https://marc.info/?l=fstests&m=152302430125453&w=2
> > 
> >  common/rc         |  10 +++++
> >  tests/xfs/445     | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/445.out |   2 +
> >  tests/xfs/group   |   1 +
> >  4 files changed, 122 insertions(+)
> >  create mode 100755 tests/xfs/445
> >  create mode 100644 tests/xfs/445.out
> > 
> > diff --git a/common/rc b/common/rc
> > index 366489bb..ab15eca1 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1600,6 +1600,16 @@ _require_scratch()
> >  	touch ${RESULT_DIR}/require_scratch
> >  }
> >  
> > +# require a scratch dev of a minimum size (in kb)
> > +_require_scratch_size()
> > +{
> > +	[ $# -eq 1 ] || _fail "_require_scratch_size: expected size param"
> > +
> > +	_require_scratch
> > +	devsize=`_get_device_size $SCRATCH_DEV`
> 
> I made it a 'local' variable.
> 

Ok.

> [snip]
> 
> > diff --git a/tests/xfs/group b/tests/xfs/group
> > index 831f2cfa..2a7dec6f 100644
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -442,3 +442,4 @@
> >  442 auto stress clone quota
> >  443 auto quick ioctl fsr
> >  444 auto quick
> > +445 auto filestreams
> 
> It looks like a 'quick' test too, it runs for around 15s on my test vm.
> Will add 'quick' group on commit.
> 

Sounds good to me, thanks!

Brian

> Thanks,
> Eryu
> 
> > -- 
> > 2.13.6
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
