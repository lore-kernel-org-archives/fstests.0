Received: from mail-pf1-f194.google.com ([209.85.210.194]:44065 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeIXUVn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Sep 2018 16:21:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so9068809pff.11
        for <fstests@vger.kernel.org>; Mon, 24 Sep 2018 07:19:21 -0700 (PDT)
Date: Mon, 24 Sep 2018 22:19:11 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH V4 00/20] Fix tests to work on non-4k block sized fs
 instances
Message-ID: <20180924141911.GE17817@desktop>
References: <20180919120053.7339-1-chandan@linux.vnet.ibm.com>
 <20180920093358.GO8382@dhcp-12-152.nay.redhat.com>
 <20180922162402.GD17817@desktop>
 <2488111.16P7BqhtSf@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2488111.16P7BqhtSf@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 24, 2018 at 03:34:27PM +0530, Chandan Rajendra wrote:
> On Saturday, September 22, 2018 9:54:02 PM IST Eryu Guan wrote:
> > On Thu, Sep 20, 2018 at 05:33:58PM +0800, Zorro Lang wrote:
> > > On Wed, Sep 19, 2018 at 05:30:33PM +0530, Chandan Rajendra wrote:
> > > > This patchset fixes tests (mostly XFS specific ones) to work on
> > > > variable block size. These patches now use the output of "od" utility
> > > > to verify the contents of the test files instead of the md5sum
> > > > utility.
> > > > 
> > > > Also, The patchset modifies _filter_fiemap() filter function to
> > > > optionally print the file offset range in block size units.
> > > > 
> > > > Changelog:
> > > > V3->V4:
> > > > 1. The following tests now use _get_file_block_size() function to obtain the
> > > >    underlying filesystem's block size.
> > > >    xfs/009
> > > >    xfs/074
> > > >    xfs/139
> > > >    xfs/140
> > > >    xfs/299
> > > >    generic/018
> > > >    generic/177
> > > >    generic/130
> > > > 2. xfs/139 now creates a scratch filesystem with AG size of 8192 filesystem
> > > >    blocks instead of the previously used 4400 filesystem blocks.
> > > > 3. xfs/050 has now been fixed to work with 512 byte sized filesystem blocks.
> > > >    The "block soft" limit and "block hard" limit values have been increased to
> > > >    enable the user to have enough blocks in quota to be able to create the
> > > >    required test files when using 512 byte filesystem blocks.
> > > 
> > > Hi,
> > > 
> > > Test passed on 512b XFS this time [1]. BTW:
> > >  - xfs 64k blocksize test PASS
> > >  - xfs default blocksize test PASS
> > >  - ext4 64k blocksize test PASS
> > >  - ext4 default blocksize test PASS
> > 
> > Thanks a lot for testing, Zorro!!
> > 
> > As I don't have access to hardware that supports 64k page, so I only
> > tested them on x86_64 hardware. I tested all explicitly modified cases
> > and all cases use _filter_fiemap helper, with test matrix 4k/2k/1k/512 x
> > v4/v5/reflink/rmapbt on xfs, 4k/2k/1k on ext4 and btrfs. I also hit some
> > other failures that we need to look into.
> 
> Eryu, Thanks for testing the patchset.
> 
> > 
> > xfs/299 fails (and only fails) on 1k block size xfs with reflink or
> > rmapbt feature enabled. e.g.
> > 
> >  *** push past the hard inode limit (expect EDQUOT)
> >  [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
> > -[NAME] 35 25 125 00 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
> > +[NAME] 35 25 125 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
> > 
> >  *** push past the hard block limit (expect EDQUOT)
> >  [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
> > -[NAME] =OK= 25 125 0 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
> > +[NAME] =OK= 25 125 0 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
> > ...
> > 
> 
> I will check this and get back soon.
> 
> > And generic/473 fails on xfs with all test combinations. e.g. the diff on 4k
> > block size v4 xfs
> > 
> >      1: [256..287]: hole
> >      Hole + Data
> >      0: [0..127]: hole
> >     -1: [128..255]: data
> >     +1: [128..135]: data
> >      Hole + Data + Hole
> >      0: [0..127]: hole
> 
> The above test fails even without my patches applied. This is because 
> xfs_bmapi_read() invoked by xfs_file_iomap_begin() returns a trimmed
> extent.

Ah, I missed that, just recalled that generic/473 is a broken test.

Thanks,
Eryu

> 
> However, generic/473 passes on Ext4 with 4k blocksize.
> 
> -- 
> chandan
> 
