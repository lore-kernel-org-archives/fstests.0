Received: from mx2.suse.de ([195.135.220.15]:60928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752212AbeENJfe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 14 May 2018 05:35:34 -0400
Date: Mon, 14 May 2018 11:35:31 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4/309: Add SEEK_DATA tests for offsets in the middle
 of holes
Message-ID: <20180514093531.xrreeuhpi3dzcaih@quack2.suse.cz>
References: <20180510154139.4823-1-jack@suse.cz>
 <CAOQ4uxhD6=FrZri1a-fWaPEEOBPJE1MT+2ECiq1xseejCN0+cQ@mail.gmail.com>
 <20180511012940.GL8373@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511012940.GL8373@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, fstests <fstests@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>, Ext4 <linux-ext4@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri 11-05-18 09:29:40, Eryu Guan wrote:
> On Thu, May 10, 2018 at 06:51:32PM +0300, Amir Goldstein wrote:
> > On Thu, May 10, 2018 at 6:41 PM, Jan Kara <jack@suse.cz> wrote:
> > > ext4 had a bug for files with indirect extents where it wrongly reported
> > > a size of a hole in some cases and thus SEEK_DATA implementation could
> > > skip some data in a file. Test for that. The problem is fixed by patch
> > > "ext4: Fix hole length detection in ext4_ind_map_blocks()".
> > >
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  src/seek_sanity_test.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/ext4/309         | 56 +++++++++++++++++++++++++++++++++++++++
> > >  tests/ext4/309.out     |  1 +
> > >  tests/ext4/group       |  1 +
> > >  4 files changed, 129 insertions(+)
> > >  create mode 100755 tests/ext4/309
> > >  create mode 100644 tests/ext4/309.out
> > >
> > > Note that I'm adding new tests to a common test program src/seek_sanity_test
> > > but I only use them from ext4 specific test as the offsets are pretty ext4
> > > specific and so I don't see any use in making this run for all other
> > > filesystems. If people think it should be done differently, please speak up.
> > 
> > I think its a very quick test and it deserves to be in generic.
> > Even thought the numbers are computed for ext4, the test is generic
> > enough to run on all fs.
> 
> Agreed.

OK, will do.


> > > --- /dev/null
> > > +++ b/tests/ext4/309
> > > @@ -0,0 +1,56 @@
> > > +#! /bin/bash
> > > +# FS QA Test No. 309
> > > +#
> > > +# SEEK_DATA sanity tests.
> > 
> > Please mention this is a regression test for ext4 bug fix
> > with commit id.
> 
> And it'd be good to have some more descriptive information on what the
> test actually exercises here.

OK, I'll improve that.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
