Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728349AbeIXQD1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Sep 2018 12:03:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8O9xBsO122956
        for <fstests@vger.kernel.org>; Mon, 24 Sep 2018 06:02:11 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mpumg5c5t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 24 Sep 2018 06:02:11 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Mon, 24 Sep 2018 11:02:08 +0100
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 00/20] Fix tests to work on non-4k block sized fs instances
Date: Mon, 24 Sep 2018 15:34:27 +0530
In-Reply-To: <20180922162402.GD17817@desktop>
References: <20180919120053.7339-1-chandan@linux.vnet.ibm.com> <20180920093358.GO8382@dhcp-12-152.nay.redhat.com> <20180922162402.GD17817@desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2488111.16P7BqhtSf@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Saturday, September 22, 2018 9:54:02 PM IST Eryu Guan wrote:
> On Thu, Sep 20, 2018 at 05:33:58PM +0800, Zorro Lang wrote:
> > On Wed, Sep 19, 2018 at 05:30:33PM +0530, Chandan Rajendra wrote:
> > > This patchset fixes tests (mostly XFS specific ones) to work on
> > > variable block size. These patches now use the output of "od" utility
> > > to verify the contents of the test files instead of the md5sum
> > > utility.
> > > 
> > > Also, The patchset modifies _filter_fiemap() filter function to
> > > optionally print the file offset range in block size units.
> > > 
> > > Changelog:
> > > V3->V4:
> > > 1. The following tests now use _get_file_block_size() function to obtain the
> > >    underlying filesystem's block size.
> > >    xfs/009
> > >    xfs/074
> > >    xfs/139
> > >    xfs/140
> > >    xfs/299
> > >    generic/018
> > >    generic/177
> > >    generic/130
> > > 2. xfs/139 now creates a scratch filesystem with AG size of 8192 filesystem
> > >    blocks instead of the previously used 4400 filesystem blocks.
> > > 3. xfs/050 has now been fixed to work with 512 byte sized filesystem blocks.
> > >    The "block soft" limit and "block hard" limit values have been increased to
> > >    enable the user to have enough blocks in quota to be able to create the
> > >    required test files when using 512 byte filesystem blocks.
> > 
> > Hi,
> > 
> > Test passed on 512b XFS this time [1]. BTW:
> >  - xfs 64k blocksize test PASS
> >  - xfs default blocksize test PASS
> >  - ext4 64k blocksize test PASS
> >  - ext4 default blocksize test PASS
> 
> Thanks a lot for testing, Zorro!!
> 
> As I don't have access to hardware that supports 64k page, so I only
> tested them on x86_64 hardware. I tested all explicitly modified cases
> and all cases use _filter_fiemap helper, with test matrix 4k/2k/1k/512 x
> v4/v5/reflink/rmapbt on xfs, 4k/2k/1k on ext4 and btrfs. I also hit some
> other failures that we need to look into.

Eryu, Thanks for testing the patchset.

> 
> xfs/299 fails (and only fails) on 1k block size xfs with reflink or
> rmapbt feature enabled. e.g.
> 
>  *** push past the hard inode limit (expect EDQUOT)
>  [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
> -[NAME] 35 25 125 00 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
> +[NAME] 35 25 125 00 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
> 
>  *** push past the hard block limit (expect EDQUOT)
>  [ROOT] 0 0 0 00 [--------] 3 0 0 00 [--------] 0 0 0 00 [--------]
> -[NAME] =OK= 25 125 0 [7 days] 9 4 10 00 [7 days] 0 0 0 00 [--------]
> +[NAME] =OK= 25 125 0 [7 days] 6 4 10 00 [7 days] 0 0 0 00 [--------]
> ...
> 

I will check this and get back soon.

> And generic/473 fails on xfs with all test combinations. e.g. the diff on 4k
> block size v4 xfs
> 
>      1: [256..287]: hole
>      Hole + Data
>      0: [0..127]: hole
>     -1: [128..255]: data
>     +1: [128..135]: data
>      Hole + Data + Hole
>      0: [0..127]: hole

The above test fails even without my patches applied. This is because 
xfs_bmapi_read() invoked by xfs_file_iomap_begin() returns a trimmed
extent.

However, generic/473 passes on Ext4 with 4k blocksize.

-- 
chandan
