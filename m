Received: from userp2120.oracle.com ([156.151.31.85]:41610 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDHV5d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Apr 2019 17:57:33 -0400
Date: Mon, 8 Apr 2019 14:57:19 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/populate: decrease the step of rm file
Message-ID: <20190408215719.GF32415@magnolia>
References: <1553759339-2206-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190403224359.GB32415@magnolia>
 <5CA5A471.7090306@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CA5A471.7090306@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: xuyang <xuyang2018.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 04, 2019 at 02:30:09PM +0800, xuyang wrote:
> On 2019/4/4 6:43, Darrick J. Wong wrote:
> > On Thu, Mar 28, 2019 at 03:48:59PM +0800, Yang Xu wrote:
> > >   Now that we have allocated 2*4096*64/16(32768) inodes after "Inode btree",
> > >   but the step of rm file is too large to create enough free inodes in agi.
> > >   So the freecount is not enough large to make free_level gt 1 and call
> > >   _scratch__populate on xfs will report the following failure(such as xfs/083):
> > > 
> > > Failed to create fino of sufficient height!
> > > 
> > > By decreasing the step of rm file, xfs/083 will pass.
> > Hmm, what are MOUNT_OPTS and MKFS_OPTIONS when this happens?  Are you
> > running on top of some kind of RAID or 4k sector disk or something?
>    The mkfs and mount option as below:
>    MKFS_OPTIONS  -- -f -bsize=4096 /dev/sda11
>    MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda11 /mnt/xfstests/scratch
> 
>    I run this case on anordinary  disk, in xfs/083.full, the disk information as below:
>    meta-data=/dev/sda11             isize=512    agcount=4, agsize=1310720 blks
>             =                       sectsz=512   attr=2, projid32bit=1
>             =                       crc=1        finobt=1, sparse=1, rmapbt=0
>             =                       reflink=1
>    data     =                       bsize=4096   blocks=5242880, imaxpct=25
>             =                       sunit=0      swidth=0 blks
>    naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
>    log      =internal log           bsize=4096   blocks=2560, version=2
>             =                       sectsz=512   sunit=0 blks, lazy-count=1
>    realtime =none                   extsz=4096   blocks=0, rtextents=0
>    + populate fs image
>    MOUNT_OPTIONS =  -o usrquota,grpquota,prjquota
> 
>    fdisk -l /dev/sda
>    Disk /dev/sda: 298.1 GiB, 320072933376 bytes, 625142448 sectors
>    Units: sectors of 1 * 512 = 512 bytes
>    Sector size (logical/physical): 512 bytes / 512 bytes
>    I/O size (minimum/optimal): 512 bytes / 512 bytes
>    Disklabel type: dos
>    Disk identifier: 0x00039ec7
> 
>    /dev/sda11      553664512 595607551  41943040    20G 83 Linux
> 
> 
> > I think this patch looks ok but I'm puzzled for why a step of
> > $(ino_per_rec + 1) isn't enough.
> > 
> > --D
> 
>   Hi Darrick
> 
>   Sorry, I am not aware that the count mechanism of agi_free_level. IMO, agi_free_count achives a
>    threshold that current free inode btree level can notstore free inode information(I want to search the threshold in kernel,but fail).
>   Then, free_level will add.
> 
>   on my machine, I decrease the step. When the value of step is 2,4,8,16, the free count becomes larger
>   and the free_level turns into 2.
> 
>   a step of $(ino_per_rec + 1) isn't enough. It maynot fill up current agi_free_level because it doesn't create enough free inodes
>  (allocat,free,not unused inodes).

Ok, seems fine to me after a few days of playing around with it...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
>   Thanks,
>   Yang Xu
> 
> > > Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> > > ---
> > >   common/populate | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/common/populate b/common/populate
> > > index 4fa118f0..7403dec3 100644
> > > --- a/common/populate
> > > +++ b/common/populate
> > > @@ -271,7 +271,7 @@ _scratch_xfs_populate() {
> > >   		touch "${dir}/${f}"
> > >   	done
> > > 
> > > -	seq 0 "$((ino_per_rec + 1))" "${nr}" | while read f; do
> > > +	seq 0 2 "${nr}" | while read f; do
> > >   		rm -f "${dir}/${f}"
> > >   	done
> > > 
> > > -- 
> > > 2.18.1
> > > 
> > > 
> > > 
> > 
> > 
> 
> 
> 
