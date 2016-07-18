Received: from mail-it0-f44.google.com ([209.85.214.44]:36922 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbcGRLy0 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 18 Jul 2016 07:54:26 -0400
Received: by mail-it0-f44.google.com with SMTP id f6so71263491ith.0
        for <fstests@vger.kernel.org>; Mon, 18 Jul 2016 04:54:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160718114723.GG27776@eguan.usersys.redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
 <1468500214-6237-7-git-send-email-jtulak@redhat.com> <20160716093358.GL2432@eguan.usersys.redhat.com>
 <20160717233003.GX1922@dastard> <CACj3i73TdnUcDT0J2QEBKQhoMsyYFVz6hBb_=bC99rL2ZbkCYQ@mail.gmail.com>
 <20160718114723.GG27776@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Mon, 18 Jul 2016 13:54:05 +0200
Message-ID: <CACj3i71VOC8i_11hFn_fphsMfGqduHB6on5UawUHm6mtAaVRhQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] xfstests: Add mkfs input validation tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, xfs-oss <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 18, 2016 at 1:47 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Mon, Jul 18, 2016 at 01:29:47PM +0200, Jan Tulak wrote:
>> On Mon, Jul 18, 2016 at 1:30 AM, Dave Chinner <david@fromorbit.com> wrote:
>> > On Sat, Jul 16, 2016 at 05:33:58PM +0800, Eryu Guan wrote:
>> >> On Thu, Jul 14, 2016 at 02:43:34PM +0200, Jan Tulak wrote:
>> >> > +do_mkfs_fail -l lazy-count=1garbage $SCRATCH_DEV
>> >> > +do_mkfs_fail -l lazy-count=2 $SCRATCH_DEV
>> >> > +do_mkfs_fail -l lazy-count=0 -m crc=1 $SCRATCH_DEV
>> >> > +do_mkfs_fail -l version=1 -m crc=1 $SCRATCH_DEV
>> >>
>> >> This test fails in my DAX testing, where SCRATCH_DEV is ramdisk. The
>> >> mkfs itself should fail, but it passed. Log version 2 was used
>> >> automatically, instead of prompting "V2 logs always enabled for CRC
>> >> enabled filesytems"
>> >>
>> >> [root@dhcp-66-86-11 xfstests]# mkfs -t xfs -f -l version=1 -m crc=1 /dev/ram0
>> >> meta-data=/dev/ram0              isize=512    agcount=1, agsize=4096 blks
>> >>          =                       sectsz=4096  attr=2, projid32bit=1
>> >>          =                       crc=1        finobt=1, sparse=0
>> >> data     =                       bsize=4096   blocks=4096, imaxpct=25
>> >>          =                       sunit=0      swidth=0 blks
>> >> naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
>> >> log      =internal log           bsize=4096   blocks=1605, version=2
>> >>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
>> >> realtime =none                   extsz=4096   blocks=0, rtextents=0
>> >>
>> >> Is it a mkfs.xfs bug or the test case should handle the special case?
>> >
>> > Looks like it might be a side effect of using a 4k sector size. v1
>> > logs only supported 512 byte sectors, so it's entirely possible that
>> > the sector size is silently overriding the log version
>> > specification. Probably should be fixed in mkfs.
>> >
>> >
>>
>> I tried to duplicate this, but in my config it didn't failed - how did
>> you create the ramdisk?
>
> I think you need to test on a 4k sector size disk. I use scsi_debug to
> simulate physical 4k sector disk to reproduce this:
>
> [root@dhcp-66-86-11 xfsprogs-dev]# modprobe -r scsi_debug
> [root@dhcp-66-86-11 xfsprogs-dev]# modprobe scsi_debug dev_size_mb=128 physblk_exp=3
> [root@dhcp-66-86-11 xfsprogs-dev]# blockdev --getbsz --getpbsz --getss /dev/sdc
> 4096
> 4096
> 512
> [root@dhcp-66-86-11 xfsprogs-dev]# mkfs -t xfs -l version=1 -m crc=1 /dev/sdc
> meta-data=/dev/sdc               isize=512    agcount=4, agsize=8192 blks
>          =                       sectsz=4096  attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=0
> data     =                       bsize=4096   blocks=32768, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> log      =internal log           bsize=4096   blocks=1605, version=2
>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
>
> If you remove the "physblk_exp=3" at modprobe time, mkfs failed as
> expected.
>

Ah, thanks. :-) Now I can reproduce it and see what happens.

Thanks.
Jan

-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
