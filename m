Received: from mx1.redhat.com ([209.132.183.28]:36638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeITPPc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 20 Sep 2018 11:15:32 -0400
Date: Thu, 20 Sep 2018 17:33:58 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH V4 00/20] Fix tests to work on non-4k block sized fs
 instances
Message-ID: <20180920093358.GO8382@dhcp-12-152.nay.redhat.com>
References: <20180919120053.7339-1-chandan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919120053.7339-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 19, 2018 at 05:30:33PM +0530, Chandan Rajendra wrote:
> This patchset fixes tests (mostly XFS specific ones) to work on
> variable block size. These patches now use the output of "od" utility
> to verify the contents of the test files instead of the md5sum
> utility.
> 
> Also, The patchset modifies _filter_fiemap() filter function to
> optionally print the file offset range in block size units.
> 
> Changelog:
> V3->V4:
> 1. The following tests now use _get_file_block_size() function to obtain the
>    underlying filesystem's block size.
>    xfs/009
>    xfs/074
>    xfs/139
>    xfs/140
>    xfs/299
>    generic/018
>    generic/177
>    generic/130
> 2. xfs/139 now creates a scratch filesystem with AG size of 8192 filesystem
>    blocks instead of the previously used 4400 filesystem blocks.
> 3. xfs/050 has now been fixed to work with 512 byte sized filesystem blocks.
>    The "block soft" limit and "block hard" limit values have been increased to
>    enable the user to have enough blocks in quota to be able to create the
>    required test files when using 512 byte filesystem blocks.

Hi,

Test passed on 512b XFS this time [1]. BTW:
 - xfs 64k blocksize test PASS
 - xfs default blocksize test PASS
 - ext4 64k blocksize test PASS
 - ext4 default blocksize test PASS

So at least those cases which you modified look good to me.

Thanks,
Zorro

[1]
# ./check generic/018 generic/102 generic/108 generic/172 generic/177 generic/230 generic/235 generic/459 xfs/009 xfs/050 xfs/074 xfs/127 xfs/139 xfs/140 xfs/190 xfs/299 xfs/325
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/ppc64le ibm-p9z-16-lp5 4.18.0-xfs-debug                                            
MKFS_OPTIONS  -- -f -m crc=0 -b size=512 /dev/sda5
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda5 /mnt/xfstests/mnt2                      

generic/018 7s ...  6s
generic/102 25s ...  24s
generic/108 8s ...  8s
generic/172 11s ... [not run] Reflink not supported by scratch filesystem type: xfs                       
generic/177 4s ...  3s
generic/230 18s ...  15s
generic/235 3s ...  4s
generic/459 41s ...  23s
xfs/009 6s ...  3s
xfs/050 18s ...  19s
xfs/074 26s ...  26s
xfs/127 14s ... [not run] Reflink not supported by scratch filesystem type: xfs                           
xfs/139 243s ... [not run] Reflink not supported by scratch filesystem type: xfs                          
xfs/140 286s ... [not run] Reflink not supported by scratch filesystem type: xfs                          
xfs/190 6s ...  3s
xfs/299 19s ...  13s
xfs/325 4s ... [not run] Reflink not supported by scratch filesystem type: xfs                            
Ran: generic/018 generic/102 generic/108 generic/172 generic/177 generic/230 generic/235 generic/459 xfs/009 xfs/050 xfs/074 xfs/127 xfs/139 xfs/140 xfs/190 xfs/299 xfs/325                                         
Not run: generic/172 xfs/127 xfs/139 xfs/140 xfs/325
Passed all 17 tests

> 4. The patch for xfs/299 has now been split into two. The first one fixes a bug
>    in the test when using 4k block size and the second one lets the user execute
>    the test on 64k block sized filesystems.
> 
> Thanks to Darrick J Wong and Zorro Lang for their review comments.
> 
> V2->V3:
> Added fixes for getting generic/018, generic/108 and generic/459 tests
> to work in 64k block size scenario.
> 
> V1->V2:
> Eryu Guan pointed out that some of the tests were obtaining the
> filesystem's block size value from $TEST_DIR even though the test was
> executed on the $SCRATCH_DEV's filesystem. This version of the
> patchset fixes the following tests to obtain the block size from
> $SCRATCH_MNT. The relevant changes was made to the following tests:
> xfs/009, xfs/050, xfs/074, xfs/139, xfs/140, xfs/190, xfs/299,
> generic/177 and generic/230.
> 
> Chandan Rajendra (20):
>   Fix xfs/009 to work with 64k block size
>   xfs/050: Fix "Push past soft inode limit" case
>   Fix xfs/050 to work with 64k block size
>   Fix xfs/074 to work with 64k block size
>   Fix xfs/127 to work with 64k block size
>   Fix xfs/139 to work with 64k block size
>   Fix xfs/140 to work with 64k block size
>   Fix xfs/190 to work with 64k block size
>   xfs/299: Fix "Push past soft inode limit" case
>   Fix xfs/299 to work with 64k block size
>   xfs/325: Inject free_extent error after CoW operation
>   Fix generic/102 to work with 64k block size
>   Fix generic/172 to work with 64k block size
>   Filter fiemap output by FS block size
>   Fix generic/177 to work with 64k block size
>   Fix generic/230 to work with 64k block size
>   Fix generic/235 to work with 64k block size
>   Fix generic/459 to work with 64k block size
>   Fix generic/018 to work with 64k block size
>   Fix generic/108 to work with 64k block size
> 
>  common/punch          | 19 ++++++++---
>  tests/generic/018     |  2 +-
>  tests/generic/102     |  4 +--
>  tests/generic/102.out | 20 +++++------
>  tests/generic/108     |  4 +--
>  tests/generic/172     |  4 +--
>  tests/generic/177     | 20 ++++++-----
>  tests/generic/177.out | 23 ++++++++-----
>  tests/generic/230     | 23 +++++++------
>  tests/generic/230.out | 16 ++++-----
>  tests/generic/235     |  2 +-
>  tests/generic/235.out |  4 +--
>  tests/generic/459     | 14 ++++----
>  tests/xfs/009         | 92 ++++++++++++++++++++++++++++++++++++++++++---------
>  tests/xfs/009.out     | 66 ++++++++++++++++++------------------
>  tests/xfs/050         | 26 ++++++++++-----
>  tests/xfs/050.out     | 60 ++++++++++++++++-----------------
>  tests/xfs/074         | 23 ++++++++++---
>  tests/xfs/127         |  2 +-
>  tests/xfs/139         | 15 +++++----
>  tests/xfs/139.out     |  8 +++--
>  tests/xfs/140         | 12 ++++---
>  tests/xfs/190         | 26 ++++++++++-----
>  tests/xfs/299         | 29 ++++++++++------
>  tests/xfs/299.out     | 60 ++++++++++++++++-----------------
>  tests/xfs/325         |  5 +--
>  tests/xfs/325.out     |  2 +-
>  27 files changed, 358 insertions(+), 223 deletions(-)
> 
> -- 
> 2.9.5
> 
