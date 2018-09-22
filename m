Received: from mail-pl1-f194.google.com ([209.85.214.194]:46076 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbeIVWSQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 22 Sep 2018 18:18:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so7275825pll.12
        for <fstests@vger.kernel.org>; Sat, 22 Sep 2018 09:24:09 -0700 (PDT)
Date: Sun, 23 Sep 2018 00:24:02 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH V4 00/20] Fix tests to work on non-4k block sized fs
 instances
Message-ID: <20180922162402.GD17817@desktop>
References: <20180919120053.7339-1-chandan@linux.vnet.ibm.com>
 <20180920093358.GO8382@dhcp-12-152.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920093358.GO8382@dhcp-12-152.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>, Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 20, 2018 at 05:33:58PM +0800, Zorro Lang wrote:
> On Wed, Sep 19, 2018 at 05:30:33PM +0530, Chandan Rajendra wrote:
> > This patchset fixes tests (mostly XFS specific ones) to work on
> > variable block size. These patches now use the output of "od" utility
> > to verify the contents of the test files instead of the md5sum
> > utility.
> > 
> > Also, The patchset modifies _filter_fiemap() filter function to
> > optionally print the file offset range in block size units.
> > 
> > Changelog:
> > V3->V4:
> > 1. The following tests now use _get_file_block_size() function to obtain the
> >    underlying filesystem's block size.
> >    xfs/009
> >    xfs/074
> >    xfs/139
> >    xfs/140
> >    xfs/299
> >    generic/018
> >    generic/177
> >    generic/130
> > 2. xfs/139 now creates a scratch filesystem with AG size of 8192 filesystem
> >    blocks instead of the previously used 4400 filesystem blocks.
> > 3. xfs/050 has now been fixed to work with 512 byte sized filesystem blocks.
> >    The "block soft" limit and "block hard" limit values have been increased to
> >    enable the user to have enough blocks in quota to be able to create the
> >    required test files when using 512 byte filesystem blocks.
> 
> Hi,
> 
> Test passed on 512b XFS this time [1]. BTW:
>  - xfs 64k blocksize test PASS
>  - xfs default blocksize test PASS
>  - ext4 64k blocksize test PASS
>  - ext4 default blocksize test PASS

Thanks a lot for testing, Zorro!!

As I don't have access to hardware that supports 64k page, so I only
tested them on x86_64 hardware. I tested all explicitly modified cases
and all cases use _filter_fiemap helper, with test matrix 4k/2k/1k/512 x
v4/v5/reflink/rmapbt on xfs, 4k/2k/1k on ext4 and btrfs. I also hit some
other failures that we need to look into.

xfs/299 fails (and only fails) on 1k block size xfs with reflink or
rmapbt feature enabled. e.g.

 *** push past the hard inode limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] 35 25 125 00 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
+[NAME] 35 25 125 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
 
 *** push past the hard block limit (expect EDQUOT)
 [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
-[NAME] =OK= 25 125 0 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
+[NAME] =OK= 25 125 0 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
...

And generic/473 fails on xfs with all test combinations. e.g. the diff on 4k
block size v4 xfs

     1: [256..287]: hole
     Hole + Data
     0: [0..127]: hole
    -1: [128..255]: data
    +1: [128..135]: data
     Hole + Data + Hole
     0: [0..127]: hole

Thanks,
Eryu
