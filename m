Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D015FC433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF5864EB6
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Mar 2021 16:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhCNQCq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Mar 2021 12:02:46 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44184 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234211AbhCNQCS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Mar 2021 12:02:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0URrZv0u_1615737734;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0URrZv0u_1615737734)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Mar 2021 00:02:14 +0800
Date:   Mon, 15 Mar 2021 00:02:14 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     zlang@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: don't silence fio error output
Message-ID: <20210314160214.GB64722@e18g06458.et15sqa>
References: <20210202062253.24478-1-zlang@redhat.com>
 <YE31QG7qhHQY2E6S@desktop>
 <20210314154920.GN3499219@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314154920.GN3499219@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Mar 14, 2021 at 11:49:20PM +0800, Zorro Lang wrote:
> On Sun, Mar 14, 2021 at 07:36:32PM +0800, Eryu Guan wrote:
> > Hi Zorro,
> > 
> > On Tue, Feb 02, 2021 at 02:22:53PM +0800, Zorro Lang wrote:
> > > This case print both fio stdout and stderr to .full file, that cause
> > > we miss some unexpected failures when there's a bug. For example:
> > > 
> > >   file:io_u.c:1803, func=io_u error, error=Block device required
> > > 
> > > This's an regression issue we find on a downstream kernel, not in
> > > upstream. So release unexpected fio error output to find more issues.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >  tests/generic/095 | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/095 b/tests/generic/095
> > > index 9afaa761..30fe77a5 100755
> > > --- a/tests/generic/095
> > > +++ b/tests/generic/095
> > > @@ -98,8 +98,11 @@ _require_fio $fio_config
> > >  _scratch_mkfs >>$seqres.full 2>&1
> > >  _scratch_mount
> > >  
> > > +# There's a known EIO failure to report collisions between directio and buffered
> > > +# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
> > > +# at here.
> > > +$FIO_PROG $fio_config --ignore_error=,EIO --output=$seqres.full
> > 
> > I found that with this change, EIO is ignored and the return value of
> > fio command is 0 as expected, but the output breaks golden image and
> > fails the test.
> > 
> > [root@fedoravm xfstests]# ./check -s xfs_4k_reflink generic/095
> > SECTION       -- xfs_4k_reflink
> > RECREATING    -- xfs on /dev/mapper/testvg-lv1
> > FSTYP         -- xfs (debug)
> > PLATFORM      -- Linux/x86_64 fedoravm 5.11.0 #5 SMP Sun Feb 28 21:50:24 CST 2021
> > MKFS_OPTIONS  -- -f -f -b size=4k -m reflink=1,rmapbt=1 /dev/mapper/testvg-lv2
> > MOUNT_OPTIONS -- /dev/mapper/testvg-lv2 /mnt/scratch
> > 
> > generic/095 4s ... - output mismatch (see /root/workspace/xfstests/results//xfs_4k_reflink/generic/095.out.bad)
> >     --- tests/generic/095.out   2018-02-25 15:15:00.097388035 +0800
> >     +++ /root/workspace/xfstests/results//xfs_4k_reflink/generic/095.out.bad    2021-03-14 19:32:04.126884255 +0800
> >     @@ -1,2 +1,7 @@
> >      QA output created by 095
> >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> >      Silence is golden
> > 
> > Did you hit the same failure? If so I think we should filter out this
> > message.
> 
> Hmm... I never hit that. I don't think this patch can cause this error, can you
> still reproduce it without this patch? The mmap operation from fio might get
> some unexpected random arguments, you might find a fio bug :-P

No, it's not reproducible without this patch, because...

> 
> Thanks,
> Zorro
> 
> > 
> > Thanks,
> > Eryu
> > 
> > >  echo "Silence is golden"
> > > -$FIO_PROG $fio_config >>$seqres.full 2>&1

The original behavior threw away all the fio output, so there was no
such failure. The patch in question made stderr visiable.

Thanks,
Eryu

> > >  
> > >  # xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
> > >  # direct IO on the same file. On the other hand, this fio job has been proven
> > > -- 
> > > 2.29.2
> > 
