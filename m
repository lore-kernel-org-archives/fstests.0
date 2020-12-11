Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBCFC433FE
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Dec 2020 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF06023BF0
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Dec 2020 16:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393130AbgLKPXx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Dec 2020 10:23:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437822AbgLKPXM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Dec 2020 10:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607700105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vk1EONzi2oPJ0JC5INJFIDnT8+2wZVDkvh44hE27q6s=;
        b=MetYPlBtHPvSUOdre2Yo+sNMQBESQ1kp6zPZvLnqDUDMmuMXFEdVrPxdnO7jtGQnRRo76b
        7UMb8DqDC7PyzpQ831gKw3O3+wa7TZKmTuz05dYcZ+WSlNBjkGdswI1+U+aK3drDVrFyQ7
        Lf960hWW9DlrWf0ejorMrmUkPH2zEMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-tBX9_qa0M3yDt0yckwSOPg-1; Fri, 11 Dec 2020 10:21:44 -0500
X-MC-Unique: tBX9_qa0M3yDt0yckwSOPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ADA01005504
        for <fstests@vger.kernel.org>; Fri, 11 Dec 2020 15:21:43 +0000 (UTC)
Received: from bfoster (ovpn-112-184.rdu2.redhat.com [10.10.112.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA80419C78
        for <fstests@vger.kernel.org>; Fri, 11 Dec 2020 15:21:42 +0000 (UTC)
Date:   Fri, 11 Dec 2020 10:21:40 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/563: use a loop device to avoid partition
 incompatibility
Message-ID: <20201211152140.GD2032335@bfoster>
References: <20201210161426.1927144-1-bfoster@redhat.com>
 <20201211084508.GY14354@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211084508.GY14354@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 11, 2020 at 04:45:08PM +0800, Zorro Lang wrote:
> On Thu, Dec 10, 2020 at 11:14:26AM -0500, Brian Foster wrote:
> > cgroup writeback accounting does not track partition level
> > statistics. Instead, I/O is accounted against the parent device. As
> > a result, the test fails if the scratch device happens to be a
> > device partition. Since parent level stats are potentially polluted
> > by factors external to the test, wrap the scratch device in a
> > loopback device to guarantee the test always runs on a top-level
> > block device.
> > 
> > Reported-by: Boyang Xue <bxue@redhat.com>
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  tests/generic/563 | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tests/generic/563 b/tests/generic/563
> > index 51deaa2f..9292dece 100755
> > --- a/tests/generic/563
> > +++ b/tests/generic/563
> > @@ -2,7 +2,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  # Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> >  #
> > -# FS QA Test No. 011
> > +# FS QA Test No. 563
> >  #
> >  # This test verifies that cgroup aware writeback properly accounts I/Os in
> >  # various scenarios. We perform reads/writes from different combinations of
> > @@ -26,6 +26,8 @@ _cleanup()
> >  
> >  	echo $$ > $cgdir/cgroup.procs
> >  	rmdir $cgdir/$seq-cg* > /dev/null 2>&1
> > +	umount $SCRATCH_MNT > /dev/null 2>&1
> > +	_destroy_loop_device $LOOP_DEV > /dev/null 2>&1
> >  }
> >  
> >  # get standard environment, filters and checks
> > @@ -42,14 +44,12 @@ rm -f $seqres.full
> >  _supported_fs generic
> >  _require_scratch
> >  _require_cgroup2 io
> > +_require_loop
> >  
> >  # cgroup v2 writeback is only support on block devices so far
> >  _require_block_device $SCRATCH_DEV
> >  
> > -smajor=$((0x`stat -L -c %t $SCRATCH_DEV`))
> > -sminor=$((0x`stat -L -c %T $SCRATCH_DEV`))
> >  cgdir=$CGROUP2_PATH
> > -
> >  iosize=$((1024 * 1024 * 8))
> >  
> >  # Check cgroup read/write charges against expected values. Allow for some
> > @@ -89,12 +89,19 @@ reset()
> >  	rmdir $cgdir/$seq-cg* > /dev/null 2>&1
> >  	$XFS_IO_PROG -fc "pwrite 0 $iosize" $SCRATCH_MNT/file \
> >  		>> $seqres.full 2>&1
> > -	_scratch_cycle_mount || _fail "mount failed"
> > +	umount $SCRATCH_MNT || _fail "umount failed"
> > +	_mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
> >  	stat $SCRATCH_MNT/file > /dev/null
> >  }
> >  
> > -_scratch_mkfs >> $seqres.full 2>&1
> > -_scratch_mount
> > +# cgroup I/O accounting doesn't work on partitions. Use a loop device to rule
> > +# that out.
> > +LOOP_DEV=$(_create_loop_device $SCRATCH_DEV)
> 
> I recommend using a file to create loop device. If you'd like to use SCRATCH_DEV
> to create loop device directly, you'd better to change the "_require_scratch"
> to "_require_scratch_nocheck". Or I think it might be failed, e.g. if SCRATCH_DEV
> is a 4k sector size device.
> 

What's the error that occurs with a 4k device, out of curiosity? I
suppose if it's just a repair thing then using _nocheck probably makes
sense (or technically might make sense regardless since we're not
formatting the scratch device directly). I don't mind creating a file
and using loop on that, but would like to make sure I understand if/why
it's necessary.

> Others look good to me.
> 

Thanks for the feedback.

Brian

> Thanks,
> Zorro
> 
> > +smajor=$((0x`stat -L -c %t $LOOP_DEV`))
> > +sminor=$((0x`stat -L -c %T $LOOP_DEV`))
> > +
> > +_mkfs_dev $LOOP_DEV >> $seqres.full 2>&1
> > +_mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
> >  
> >  echo "+io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
> >  
> > -- 
> > 2.26.2
> > 
> 

