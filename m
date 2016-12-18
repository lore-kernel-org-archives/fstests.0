Received: from mx1.redhat.com ([209.132.183.28]:34970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752879AbcLRDsV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 17 Dec 2016 22:48:21 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1921A3F1FB
        for <fstests@vger.kernel.org>; Sun, 18 Dec 2016 03:48:21 +0000 (UTC)
Date: Sun, 18 Dec 2016 11:48:18 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] fstests: teach _scratch_mkfs to handle mkfs option
 conflicts
Message-ID: <20161218034818.GA1859@eguan.usersys.redhat.com>
References: <20161205084256.4593-1-eguan@redhat.com>
 <20161216142208.GC8447@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161216142208.GC8447@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Dec 16, 2016 at 09:22:09AM -0500, Brian Foster wrote:
> On Mon, Dec 05, 2016 at 04:42:56PM +0800, Eryu Guan wrote:
> > Currently in _scratch_mkfs only xfs and ext4 could handle the mkfs
> > failure caused by conflicts between $MKFS_OPTIONS and mkfs options
> > specified by tests, because of _scratch_mkfs_xfs and
> > _scratch_mkfs_ext4. This is a very useful functionality that allows
> > tests to specify mkfs options safely and to test specific fs
> > configurations, without worrying about mkfs failures caused by these
> > options.
> > 
> > Now teach _scratch_mkfs to handle such mkfs option conflicts for
> > other filesystems too, i.e. mkfs again only with mkfs options
> > specified by tests. Also add the ability to filter unnecessary
> > messages from mkfs stderr.
> > 
> > Also update some btrfs tests to throw away _scratch_mkfs stdout,
> > because previously _scratch_mkfs did this for btrfs.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> > 
> > v3:
> > - rebase against master HEAD, some changes go to common/xfs
> > 
> > v2:
> > - return in each case if fstyp is special-handled in _scratch_mkfs
> > - introduce _scratch_do_mkfs helper and convert _scratch_mkfs_xfs and
> >   _scratch_mkfs_ext4 to use it too. I'm not good at naming functions,
> >   please suggest if it's badly named..
> > - update some btrfs tests to avoid failures caused by mkfs stdout output
> > 
> >  common/rc       | 180 +++++++++++++++++++++++++++++++++-----------------------
> >  common/xfs      |  47 ++++-----------
> >  tests/btrfs/028 |   2 +-
> >  tests/btrfs/121 |   2 +-
> >  tests/btrfs/122 |   2 +-
> >  tests/btrfs/123 |   2 +-
> >  tests/btrfs/126 |   2 +-
> >  7 files changed, 126 insertions(+), 111 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 2719b23..7e45c14 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -410,6 +410,52 @@ _scratch_mkfs_options()
> >      echo $SCRATCH_OPTIONS $MKFS_OPTIONS $* $SCRATCH_DEV
> >  }
> >  
> > +# Do the actual mkfs work on SCRATCH_DEV. Firstly mkfs with both MKFS_OPTIONS
> > +# and user specified mkfs options, if that fails (due to conflicts between mkfs
> > +# options), do a second mkfs with only user provided mkfs options.
> > +#
> > +# First param is the mkfs command without any mkfs optoins and device.
> 
> Typo here:					      options

Will fix at commit time.

> 
> Otherwise looks Ok to me:
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>

Thanks for the review!

Eryu
