Return-Path: <SRS0=+QVP=DT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E418C433DF
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Oct 2020 17:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A83020776
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Oct 2020 17:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="du56RrNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390190AbgJLRzz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Oct 2020 13:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389562AbgJLRzz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Oct 2020 13:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602525353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9u5HmCT8A7IgMLqzlDL9iLUuImOEy9DfsOep0sOMftY=;
        b=du56RrNOGxyUg8tMBloNi2m17PzH8olY5bKunfnzN2DM4It5r8ZEMZJ0s2s6MWtmplnpbx
        0hB06NZbJv5Orch0Z6/4QYBBfxPfxqcFT68JnkLe0GMzWxkETZ+hTAbFoUgHaI7MwJI9La
        s7aPXhMmPVRi5BYY8K3UkgogUFJg9lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-DpHW40toNa-1RblLZxN9GA-1; Mon, 12 Oct 2020 13:55:51 -0400
X-MC-Unique: DpHW40toNa-1RblLZxN9GA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C210718A0724
        for <fstests@vger.kernel.org>; Mon, 12 Oct 2020 17:55:50 +0000 (UTC)
Received: from bfoster (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B76A10013BD
        for <fstests@vger.kernel.org>; Mon, 12 Oct 2020 17:55:50 +0000 (UTC)
Date:   Mon, 12 Oct 2020 13:55:48 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] generic: IO_URING direct IO fsx test
Message-ID: <20201012175548.GL917726@bfoster>
References: <20200916171443.29546-1-zlang@redhat.com>
 <20200916171443.29546-4-zlang@redhat.com>
 <20201002182031.GE4708@bfoster>
 <20201011121520.GA17190@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011121520.GA17190@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 11, 2020 at 08:15:20PM +0800, Zorro Lang wrote:
> On Fri, Oct 02, 2020 at 02:20:31PM -0400, Brian Foster wrote:
> > On Thu, Sep 17, 2020 at 01:14:43AM +0800, Zorro Lang wrote:
> > > After fsx supports IO_URING read/write, add IO_URING direct IO fsx
> > > test with different read/write size and concurrent buffered IO.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > ---
> > >  tests/generic/610     | 52 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/610.out |  7 ++++++
> > >  tests/generic/group   |  1 +
> > >  3 files changed, 60 insertions(+)
> > >  create mode 100755 tests/generic/610
> > >  create mode 100644 tests/generic/610.out
> > > 
> > > diff --git a/tests/generic/610 b/tests/generic/610
> > > new file mode 100755
> > > index 00000000..fc3f4c2a
> > > --- /dev/null
> > > +++ b/tests/generic/610
> > > @@ -0,0 +1,52 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.
> > 
> > The copyright needs fixing.
> > 
> > > +#
> > > +# FS QA Test 610
> > > +#
> > > +# IO_URING direct IO fsx test
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1	# failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +
> > > +# remove previous $seqres.full before test
> > > +rm -f $seqres.full
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_supported_os Linux
> > > +_require_test
> > > +_require_odirect
> > > +_require_io_uring
> > > +
> > > +psize=`$here/src/feature -s`
> > > +bsize=`_min_dio_alignment $TEST_DEV`
> > > +run_fsx -S 0 -U -N 20000           -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > > +run_fsx -S 0 -U -N 20000 -o 8192   -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > > +run_fsx -S 0 -U -N 20000 -o 128000 -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > > +
> > > +# change readbdy/writebdy to double page size
> > > +psize=$((psize * 2))
> > > +run_fsx -S 0 -U -N 20000           -l 600000 -r PSIZE -w PSIZE -Z -R -W
> > > +run_fsx -S 0 -U -N 20000 -o 256000 -l 600000 -r PSIZE -w PSIZE -Z -R -W
> > > +run_fsx -S 0 -U -N 20000 -o 128000 -l 600000 -r PSIZE -w BSIZE -Z -W
> > > +
> > 
> > Can you elaborate on why PSIZE/BSIZE are used where they are for the
> > writebdy option? Also is -R intentionally dropped from the final test?
> 
> Sure:) This test is copied from generic/091.
> 

Hmm.. but generic/091 doesn't seem to use the same values and always
passes a writebdy of BSIZE (at least for the tests that aren't commented
out). It kind of looks like this tweaks some values across the board,
then randomly selects some of the commented and non-commented test
commands without any explanation.

Brian

> > 
> > Brian
> > 
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/610.out b/tests/generic/610.out
> > > new file mode 100644
> > > index 00000000..97ad41a3
> > > --- /dev/null
> > > +++ b/tests/generic/610.out
> > > @@ -0,0 +1,7 @@
> > > +QA output created by 610
> > > +fsx -S 0 -U -N 20000 -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > > +fsx -S 0 -U -N 20000 -o 8192 -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > > +fsx -S 0 -U -N 20000 -o 128000 -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > > +fsx -S 0 -U -N 20000 -l 600000 -r PSIZE -w PSIZE -Z -R -W
> > > +fsx -S 0 -U -N 20000 -o 256000 -l 600000 -r PSIZE -w PSIZE -Z -R -W
> > > +fsx -S 0 -U -N 20000 -o 128000 -l 600000 -r PSIZE -w BSIZE -Z -W
> > > diff --git a/tests/generic/group b/tests/generic/group
> > > index cf50f4a1..60280dc2 100644
> > > --- a/tests/generic/group
> > > +++ b/tests/generic/group
> > > @@ -612,3 +612,4 @@
> > >  607 auto attr quick dax
> > >  608 auto attr quick dax
> > >  609 auto rw io_uring
> > > +610 auto rw io_uring
> > > -- 
> > > 2.20.1
> > > 
> 

