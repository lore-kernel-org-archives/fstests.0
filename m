Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819EFC433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Mar 2021 00:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD6564E6B
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Mar 2021 00:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCOAi7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Mar 2021 20:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhCOAia (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Mar 2021 20:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615768710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2r1gO/yZtucF7Cy/WyusVBV0cJ3AcRwK1sqvEnQKfw=;
        b=a2k7tnvlX+CuMvx0iuiHeSrhIz+OtSOXcQ49WDhsCESBFt48Rzc6kaNJrO2uzSzBRQnmPQ
        V0B1mM1tcIGj/w012jMNmSOcxBuHBsWL5ybvxhJeHXNVTgB5Z3HQ542WICRfBAaOGgj0Dv
        kiseYufzQwTOokQM7gNpvRey94wdpno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-uO7qF8vnPzSXP1r9J1fw-g-1; Sun, 14 Mar 2021 20:38:27 -0400
X-MC-Unique: uO7qF8vnPzSXP1r9J1fw-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4A0E192D787;
        Mon, 15 Mar 2021 00:38:26 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3ACD02B1B3;
        Mon, 15 Mar 2021 00:38:25 +0000 (UTC)
Date:   Mon, 15 Mar 2021 08:56:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: don't silence fio error output
Message-ID: <20210315005654.GO3499219@localhost.localdomain>
Mail-Followup-To: Eryu Guan <eguan@linux.alibaba.com>,
        fstests@vger.kernel.org
References: <20210202062253.24478-1-zlang@redhat.com>
 <YE31QG7qhHQY2E6S@desktop>
 <20210314154920.GN3499219@localhost.localdomain>
 <20210314160214.GB64722@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314160214.GB64722@e18g06458.et15sqa>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 15, 2021 at 12:02:14AM +0800, Eryu Guan wrote:
> On Sun, Mar 14, 2021 at 11:49:20PM +0800, Zorro Lang wrote:
> > On Sun, Mar 14, 2021 at 07:36:32PM +0800, Eryu Guan wrote:
> > > Hi Zorro,
> > > 
> > > On Tue, Feb 02, 2021 at 02:22:53PM +0800, Zorro Lang wrote:
> > > > This case print both fio stdout and stderr to .full file, that cause
> > > > we miss some unexpected failures when there's a bug. For example:
> > > > 
> > > >   file:io_u.c:1803, func=io_u error, error=Block device required
> > > > 
> > > > This's an regression issue we find on a downstream kernel, not in
> > > > upstream. So release unexpected fio error output to find more issues.
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > > ---
> > > >  tests/generic/095 | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tests/generic/095 b/tests/generic/095
> > > > index 9afaa761..30fe77a5 100755
> > > > --- a/tests/generic/095
> > > > +++ b/tests/generic/095
> > > > @@ -98,8 +98,11 @@ _require_fio $fio_config
> > > >  _scratch_mkfs >>$seqres.full 2>&1
> > > >  _scratch_mount
> > > >  
> > > > +# There's a known EIO failure to report collisions between directio and buffered
> > > > +# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
> > > > +# at here.
> > > > +$FIO_PROG $fio_config --ignore_error=,EIO --output=$seqres.full
> > > 
> > > I found that with this change, EIO is ignored and the return value of
> > > fio command is 0 as expected, but the output breaks golden image and
> > > fails the test.
> > > 
> > > [root@fedoravm xfstests]# ./check -s xfs_4k_reflink generic/095
> > > SECTION       -- xfs_4k_reflink
> > > RECREATING    -- xfs on /dev/mapper/testvg-lv1
> > > FSTYP         -- xfs (debug)
> > > PLATFORM      -- Linux/x86_64 fedoravm 5.11.0 #5 SMP Sun Feb 28 21:50:24 CST 2021
> > > MKFS_OPTIONS  -- -f -f -b size=4k -m reflink=1,rmapbt=1 /dev/mapper/testvg-lv2
> > > MOUNT_OPTIONS -- /dev/mapper/testvg-lv2 /mnt/scratch
> > > 
> > > generic/095 4s ... - output mismatch (see /root/workspace/xfstests/results//xfs_4k_reflink/generic/095.out.bad)
> > >     --- tests/generic/095.out   2018-02-25 15:15:00.097388035 +0800
> > >     +++ /root/workspace/xfstests/results//xfs_4k_reflink/generic/095.out.bad    2021-03-14 19:32:04.126884255 +0800
> > >     @@ -1,2 +1,7 @@
> > >      QA output created by 095
> > >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> > >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> > >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> > >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> > >     +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> > >      Silence is golden
> > > 
> > > Did you hit the same failure? If so I think we should filter out this
> > > message.
> > 
> > Hmm... I never hit that. I don't think this patch can cause this error, can you
> > still reproduce it without this patch? The mmap operation from fio might get
> > some unexpected random arguments, you might find a fio bug :-P
> 
> No, it's not reproducible without this patch, because...
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Thanks,
> > > Eryu
> > > 
> > > >  echo "Silence is golden"
> > > > -$FIO_PROG $fio_config >>$seqres.full 2>&1
> 
> The original behavior threw away all the fio output, so there was no
> such failure. The patch in question made stderr visiable.

Oh, you're right. But I don't think this patch is the root cause of this error,
I just let error output visible, doesn't inject any new behaviors.

I've tested with this change on different systems, never hit this error, even on
latest upstream xfs with latest upstream fio:

# ./check generic/095
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 ibm-xxxxx-xx 5.12.0-rc2-xfs #6 SMP Mon Mar 15 00:02:03 CST 2021                                                                                               
MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/testvg-scratchdev
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev /mnt/scratch                                                                                            

generic/095 39s ...  30s
Ran: generic/095
Passed all 1 tests

If you still can reproduce this error with lastest fio, I think you can
use "--debug=io" agrument to get more informations, then CC fio people to take
a look?

Thanks,
Zorro

> 
> Thanks,
> Eryu
> 
> > > >  
> > > >  # xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
> > > >  # direct IO on the same file. On the other hand, this fio job has been proven
> > > > -- 
> > > > 2.29.2
> > > 
> 

