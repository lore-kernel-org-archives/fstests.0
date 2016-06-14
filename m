Received: from mx1.redhat.com ([209.132.183.28]:46334 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbcFNEVH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 14 Jun 2016 00:21:07 -0400
Date: Tue, 14 Jun 2016 12:21:03 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: ext4: regression test for fsync transaction ids
 initialization
Message-ID: <20160614042103.GM5140@eguan.usersys.redhat.com>
References: <1465354945-11307-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
 <20160608085546.GP5140@eguan.usersys.redhat.com>
 <575F6DDC.9050000@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575F6DDC.9050000@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 14, 2016 at 10:37:16AM +0800, Wang Xiaoguang wrote:
> Hello,
> 
> Thanks for reviewing.
> 
> On 06/08/2016 04:55 PM, Eryu Guan wrote:
[snip]
> >>+
> >>+loop_dev1=`_create_loop_device $fs_img1`
> >>+loop_dev2=`_create_loop_device $fs_img2`
> >You're using two loop devices and one is used as external journal
> >device, I think test on SCRATCH_DEV should be fine, e.g.
> >
> >_scratch_mkfs_sized a 8M ext4 filesystem, then use a script to find the
> >journal superblock on disk, then modify the journal.s_sequence according
> >to the location of journal superblock and the offset of s_sequence to
> >it. I use the following script to do all this:
> >
> >#/bin/bash
> >dev=$1
> >mkfs -t ext4 $dev 8M
> >blocksize=`dumpe2fs -h $dev 2>/dev/null | grep "Block size" | awk '{print $3}'`
> >offset=0
> >found=0
> ># this is the jbd2 journal superblock magic number on disk, in big endian
> >magic="c0 3b 39 98"
> >
> ># 8M in bytes
> >filesize=$((8 * 1024 * 1024))
> >while [ $offset -lt $filesize ]; do
> >         if  | grep -i "$magic";then
> >                 echo "Found journal: $offset"
> >                 found=1
> >                 break
> >         fi
> >         offset=$((offset + blocksize))
> >done
> Thanks for your script, but I wonder whether there will be some other
> metadata which would have the same magic number "c0 3b 39 98", such
> as ext4 super_block or block_group_description.

I don't think so. If they have the same magic number, it looks like a
bug to me.

Thanks,
Eryu
