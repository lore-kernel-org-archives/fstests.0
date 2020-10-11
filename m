Return-Path: <SRS0=fsOW=DS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA61C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 12:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EE020781
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 12:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM5VMrfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbgJKMVk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Oct 2020 08:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387744AbgJKMVj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Oct 2020 08:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602418898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDM9B2W9yUKmVin7xCP4+0fq5TGI9pLh8I9/Eu8Fy4o=;
        b=AM5VMrfpbf04YRSIPfnOqIY3b8KrwQY3u4WWaj5E9C/n4f6YnRk8wCtikE1vBn+09Z9u4T
        tgvPenyzVDAm621n3zyTUAVVUrTbaQt3c/40QjaK3mDIBgnNTGPYC8t6g/Jx8TsN2wxPN1
        2kgTUCydhUzn+Q88m0V88tyBsaFDGEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-RHd0Khu4PtOD3HewqY499A-1; Sun, 11 Oct 2020 08:21:36 -0400
X-MC-Unique: RHd0Khu4PtOD3HewqY499A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 427FF80B702;
        Sun, 11 Oct 2020 12:21:35 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0EA76EF55;
        Sun, 11 Oct 2020 12:21:34 +0000 (UTC)
Date:   Sun, 11 Oct 2020 20:36:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] generic: IO_URING direct IO fsx test
Message-ID: <20201011123623.GB17190@localhost.localdomain>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        fstests@vger.kernel.org
References: <20200916171443.29546-1-zlang@redhat.com>
 <20200916171443.29546-4-zlang@redhat.com>
 <20201005164510.GG49541@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005164510.GG49541@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 05, 2020 at 09:45:10AM -0700, Darrick J. Wong wrote:
> On Thu, Sep 17, 2020 at 01:14:43AM +0800, Zorro Lang wrote:
> > After fsx supports IO_URING read/write, add IO_URING direct IO fsx
> > test with different read/write size and concurrent buffered IO.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> 
> Funny, I would have expected this to be a clone of generic/521, much
> like the previous test was a clone of g/522.  I guess it's fine to test
> various fsx parameters, but in that case, is there a reason /not/ to
> have a long soak io_uring directio test?

This case is copied from generic/091 :) Even the previous test was a clone
of g/522, but I reduce the default test time. The g/521 and g/522 takes too long
time, I'd like to have io_uring buffer and direct IO basic test cases which
doesn't take long time at first. From this side, I think g/091 does more test :-p

Thanks,
Zorro

> 
> --D
> 
> > ---
> >  tests/generic/610     | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/610.out |  7 ++++++
> >  tests/generic/group   |  1 +
> >  3 files changed, 60 insertions(+)
> >  create mode 100755 tests/generic/610
> >  create mode 100644 tests/generic/610.out
> > 
> > diff --git a/tests/generic/610 b/tests/generic/610
> > new file mode 100755
> > index 00000000..fc3f4c2a
> > --- /dev/null
> > +++ b/tests/generic/610
> > @@ -0,0 +1,52 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.
> > +#
> > +# FS QA Test 610
> > +#
> > +# IO_URING direct IO fsx test
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_test
> > +_require_odirect
> > +_require_io_uring
> > +
> > +psize=`$here/src/feature -s`
> > +bsize=`_min_dio_alignment $TEST_DEV`
> > +run_fsx -S 0 -U -N 20000           -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > +run_fsx -S 0 -U -N 20000 -o 8192   -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > +run_fsx -S 0 -U -N 20000 -o 128000 -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > +
> > +# change readbdy/writebdy to double page size
> > +psize=$((psize * 2))
> > +run_fsx -S 0 -U -N 20000           -l 600000 -r PSIZE -w PSIZE -Z -R -W
> > +run_fsx -S 0 -U -N 20000 -o 256000 -l 600000 -r PSIZE -w PSIZE -Z -R -W
> > +run_fsx -S 0 -U -N 20000 -o 128000 -l 600000 -r PSIZE -w BSIZE -Z -W
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/610.out b/tests/generic/610.out
> > new file mode 100644
> > index 00000000..97ad41a3
> > --- /dev/null
> > +++ b/tests/generic/610.out
> > @@ -0,0 +1,7 @@
> > +QA output created by 610
> > +fsx -S 0 -U -N 20000 -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > +fsx -S 0 -U -N 20000 -o 8192 -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > +fsx -S 0 -U -N 20000 -o 128000 -l 600000 -r PSIZE -w BSIZE -Z -R -W
> > +fsx -S 0 -U -N 20000 -l 600000 -r PSIZE -w PSIZE -Z -R -W
> > +fsx -S 0 -U -N 20000 -o 256000 -l 600000 -r PSIZE -w PSIZE -Z -R -W
> > +fsx -S 0 -U -N 20000 -o 128000 -l 600000 -r PSIZE -w BSIZE -Z -W
> > diff --git a/tests/generic/group b/tests/generic/group
> > index cf50f4a1..60280dc2 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -612,3 +612,4 @@
> >  607 auto attr quick dax
> >  608 auto attr quick dax
> >  609 auto rw io_uring
> > +610 auto rw io_uring
> > -- 
> > 2.20.1
> > 
> 

