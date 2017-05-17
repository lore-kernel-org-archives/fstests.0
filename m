Received: from aserp1040.oracle.com ([141.146.126.69]:51849 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdEQFB3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 01:01:29 -0400
Date: Tue, 16 May 2017 21:59:38 -0700
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH 3/6] fstests: regression test for btrfs dio read repair
Message-ID: <20170517045938.GA16025@lim.localdomain>
Reply-To: bo.li.liu@oracle.com
References: <1494352571-17199-1-git-send-email-bo.li.liu@oracle.com>
 <1494352571-17199-4-git-send-email-bo.li.liu@oracle.com>
 <20170510105326.GB7250@eguan.usersys.redhat.com>
 <20170516174846.GB2736@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170516174846.GB2736@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Tue, May 16, 2017 at 11:48:46AM -0600, Liu Bo wrote:
> On Wed, May 10, 2017 at 06:53:26PM +0800, Eryu Guan wrote:
> > On Tue, May 09, 2017 at 11:56:08AM -0600, Liu Bo wrote:
[...]
> > > +
> > > +# step 3, 128k dio read (this read can repair bad copy)
> > > +echo "step 3......repair the bad copy" >>$seqres.full
> > > +
> > > +# since raid1 consists of two copies, and the following read may read the good
> > > +# copy directly, so lets loop 10 times here and discard output that dio reads
> > > +# give
> > > +for i in `seq 1 10`; do
> > > +	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev/null
> > > +	_get_current_dmesg | grep -q -e "csum failed" && break
> > > +done
> > 
> > Half of the time I got test failure because pread from SCRATCH_DEV read
> > 0xbb instead of 0xaa on v4.11 kernel (bug should be fixed there), tested
> > on two different hosts and could hit failure on both hosts.
> > 
> > Similar failure happened to all the 4 tests randomly. I thought it was
> > because "csum failed" was never hit, so I tried a "while true; do" loop,
> > and that did fix the btrfs/140 failure for me, but then btrfs/141 would
> > loop forever sometimes.
> > 
> > On the other hand, the tests from your last post always passed on the
> > same test host, but I didn't see anything particular would make this
> > difference..
> > 
> > Can you please take a look? Thanks!
> > 
> 
> Oh, sorry for the trouble, it's all due to the same reason, that
> is, the stripe read balance in btrfs simply looks at
> (current->pid % num_stripes) and picks up a stripe to read from.
> 
> Since I put the bad data on stripe 1 in raid1 profile, we need an
> odd $pid to trigger the checksum failures, but I have no idea how
> to certainly get a task with odd pid number in one shot, so I'll
> just use "while true; do" for now, and update it later if I find
> a solution.
>

(Originally I thought that 'loop forever' was due to bad luck so that the reader
always gets an evenly %pid.)

I figured out why running ./check btrfs/14[0-1] would end up looping on 141
forever, it turns out that csum errors got printed by btrfs_warn_rl which has a
global rate limit, running 140 will drain the rate limit so running 141 won't
have csum errors output in dmesg and it loops forever since 'grep' couldn't find
anything.

Obviously that forever thing is not acceptable, so..here is the workaround.

Since I've put the bad copy on stripe #1 while the good copy lies on stripe #0,
in that 'while true; do' loop, the bad copy gets access when (the reader's pid %
2 == 1) is true, thus we could check the reader's pid instead of doing grep in
dmesg.  It's probably fragile though.

Thanks,

-liubo

> Thanks,
> 
> -liubo
> > Eryu
> > 
> > > +
> > > +_scratch_unmount
> > > +
> > > +# check if the repair works
> > > +$XFS_IO_PROG -d -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV | _filter_xfs_io
> > > +
> > > +_scratch_dev_pool_put
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/140.out b/tests/btrfs/140.out
> > > new file mode 100644
> > > index 0000000..c8565f5
> > > --- /dev/null
> > > +++ b/tests/btrfs/140.out
> > > @@ -0,0 +1,39 @@
> > > +QA output created by 140
> > > +wrote 131072/131072 bytes at offset 0
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +wrote 65536/65536 bytes at offset 136708096
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +08260000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260010:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260020:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260030:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260040:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260050:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260060:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260070:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260080:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260090:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082600a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082600b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082600c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082600d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082600e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082600f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260100:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260110:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260120:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260130:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260140:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260150:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260160:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260170:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260180:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +08260190:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082601a0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082601b0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082601c0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082601d0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082601e0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +082601f0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
> > > +read 512/512 bytes at offset 136708096
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > > index 9d4b80b..1cb9c98 100644
> > > --- a/tests/btrfs/group
> > > +++ b/tests/btrfs/group
> > > @@ -141,3 +141,4 @@
> > >  137 auto quick send
> > >  138 auto compress
> > >  139 auto qgroup
> > > +140 auto quick
> > > -- 
> > > 2.5.0
> > > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
