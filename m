Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF09C07E99
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 11:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEDF613AB
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 11:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhGELN0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Jul 2021 07:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230132AbhGELNZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Jul 2021 07:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625483448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TNVzD/Q0gm4iA6FCbudf43tYz+fW1YIr1euM0/1CF6Y=;
        b=eV64ypnMK4THmfRSYcAgRVDPuxx+XVnJmFsPIz7OCWrm2ZuAcvI0+JZPYp5Lkm+2bdUfel
        OhlLMFHieRIbN0Gym0Ee1jWBZJiArEGkl2tBxCAi9y64MSWd6/MetdSbQmB/giznN8MO5S
        3ddAemcolV4nsdV3E3YNsS7ROF7+dhQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-FTFDB9PYMdqmWwopPvcnyQ-1; Mon, 05 Jul 2021 07:10:47 -0400
X-MC-Unique: FTFDB9PYMdqmWwopPvcnyQ-1
Received: by mail-pg1-f198.google.com with SMTP id b17-20020a63a1110000b02902231e33459dso13359459pgf.17
        for <fstests@vger.kernel.org>; Mon, 05 Jul 2021 04:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=TNVzD/Q0gm4iA6FCbudf43tYz+fW1YIr1euM0/1CF6Y=;
        b=W/YXtocJUkuHbzAZY3KuO41prBciIA5BEIWTf66m/xWX4NiZHWw86G18vXApqkgLpd
         f9PGImz4oBAlzmO6OoNBkOvjewNUM55+6LeiVjm5uIb4I1meZM/6C17tk3YqCq28rwHd
         QmBaatfhh9weumFXuOvItHGps7EZaLb6pHf2U1wsAF2oaGMsYYKhEOY4jovYDd9ugh2k
         KjKs3btbJv4eiXJpr43OxHI5VqJrQPnl2GrWlISMq5MThX9ddfQzS+CmgaTjwZlOwxhq
         vHSGSQiAsiFvlxqWR3OO3q5SavDeudAE0067XhfXXzr6PVDQ+aSLJR0uNOm2tPYl2oNu
         fv7w==
X-Gm-Message-State: AOAM533g17AKfA7eOoquZ5Alz8yPFsv6tWBmZiZquebrR439MD3Sq7Ql
        J7d9i2yRtQGwAeTYnUTCDW9nq1Q4NrP8vCHiQcEgsoLDgIywwXGLAfJu9aTj6t6QOHkP4Zxx12s
        o4GPsUS4TYx49Umvu1A==
X-Received: by 2002:a17:902:8bc3:b029:124:919f:6213 with SMTP id r3-20020a1709028bc3b0290124919f6213mr12245758plo.51.1625483446264;
        Mon, 05 Jul 2021 04:10:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC0SjLcULKF4xUYOn3T+zvW2vPmCeFa1zXI92HQMzuC014DkoV3Z+9OlxQC2/UKg5GZ46h0Q==
X-Received: by 2002:a17:902:8bc3:b029:124:919f:6213 with SMTP id r3-20020a1709028bc3b0290124919f6213mr12245741plo.51.1625483446025;
        Mon, 05 Jul 2021 04:10:46 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y1sm12354975pfe.72.2021.07.05.04.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 04:10:45 -0700 (PDT)
Date:   Mon, 5 Jul 2021 19:10:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic: add a test to ensure that page is properly
 filled before write
Message-ID: <20210705111042.q5rnc6dbgqvggwkb@fedora>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
References: <20210702134024.24233-1-jlayton@kernel.org>
 <20210705110434.wlc2gooeykoc6xcj@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705110434.wlc2gooeykoc6xcj@fedora>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 05, 2021 at 07:04:34PM +0800, Zorro Lang wrote:
> On Fri, Jul 02, 2021 at 09:40:24AM -0400, Jeff Layton wrote:
> > We had a broken optimization in cephfs and netfs lib that could cause
> > part of a page to be improperly zeroed-out when writing to an offset
> > that was beyond the EOF but in an existing page.
> > 
> > Add a simple test that would have caught this.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  tests/generic/639     | 39 +++++++++++++++++++++++++++++++++++++++
> >  tests/generic/639.out |  5 +++++
> >  2 files changed, 44 insertions(+)
> >  create mode 100755 tests/generic/639
> >  create mode 100644 tests/generic/639.out
> > 
> > v3: adapt to new test template
> > 
> > diff --git a/tests/generic/639 b/tests/generic/639
> > new file mode 100755
> > index 000000000000..c30f7644a2fc
> > --- /dev/null
> > +++ b/tests/generic/639
> > @@ -0,0 +1,39 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021, Jeff Layton <jlayton@redhat.com>
> > +#
> > +# FS QA Test No. 639
> > +#
> > +# Open a file and write a little data to it. Unmount (to clean out the cache)
> > +# and then mount again. Then write some data to it beyond the EOF and ensure
> > +# the result is correct.
> > +#
> > +# Prompted by a bug in ceph_write_begin that was fixed by commit 827a746f405d.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick rw
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_test
> > +
> > +testfile="$TEST_DIR/test_write_begin.$$"
> > +
> > +# write some data to file and fsync it out
> > +$XFS_IO_PROG -f -c "pwrite -q 0 32" $testfile
> 
> Looks good to me, if you've used this case to reproduce that issue.
> 
> Just one question, the comment says "fsync it out", does that mean we need an
> explicit "fsync" call (e.g. -c "pwrite -q 0 32" -c "fsync") to reproduce this
> bug? Or there's an implicit "fsync" somewhere?

Oh, this patch has just been merged, sorry for my late review. You can ignore
this message.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > +
> > +# cycle the mount to clean out the pagecache
> > +_test_cycle_mount
> > +
> > +# now, write to the file (near the end)
> > +$XFS_IO_PROG -c "pwrite -q 32 32" $testfile
> > +
> > +# dump what we think is in there
> > +echo "The result should be 64 bytes filled with 0xcd:"
> > +hexdump -C $testfile
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/639.out b/tests/generic/639.out
> > new file mode 100644
> > index 000000000000..9bf0bac96864
> > --- /dev/null
> > +++ b/tests/generic/639.out
> > @@ -0,0 +1,5 @@
> > +QA output created by 639
> > +The result should be 64 bytes filled with 0xcd:
> > +00000000  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> > +*
> > +00000040
> > -- 
> > 2.31.1
> > 

