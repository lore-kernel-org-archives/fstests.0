Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA94C07E9B
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 05:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFAD61CB2
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 05:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhGGFad (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:30:33 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:58926 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230108AbhGGFad (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jul 2021 01:30:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Uf-ZxT4_1625635670;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0Uf-ZxT4_1625635670)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 07 Jul 2021 13:27:51 +0800
Date:   Wed, 7 Jul 2021 13:27:50 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Zorro Lang <zlang@redhat.com>, Eryu Guan <guaneryu@gmail.com>,
        fstests@vger.kernel.org, aweits@rit.edu, dhowells@redhat.com,
        willy@infradead.org
Subject: Re: [PATCH v3] generic: add a test to ensure that page is properly
 filled before write
Message-ID: <20210707052750.GH60846@e18g06458.et15sqa>
References: <20210702134024.24233-1-jlayton@kernel.org>
 <20210705110434.wlc2gooeykoc6xcj@fedora>
 <69594288685fdb38fb855345ef43252b6bd4aed3.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69594288685fdb38fb855345ef43252b6bd4aed3.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 06, 2021 at 06:56:41AM -0400, Jeff Layton wrote:
> On Mon, 2021-07-05 at 19:04 +0800, Zorro Lang wrote:
> > On Fri, Jul 02, 2021 at 09:40:24AM -0400, Jeff Layton wrote:
> > > We had a broken optimization in cephfs and netfs lib that could cause
> > > part of a page to be improperly zeroed-out when writing to an offset
> > > that was beyond the EOF but in an existing page.
> > > 
> > > Add a simple test that would have caught this.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  tests/generic/639     | 39 +++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/639.out |  5 +++++
> > >  2 files changed, 44 insertions(+)
> > >  create mode 100755 tests/generic/639
> > >  create mode 100644 tests/generic/639.out
> > > 
> > > v3: adapt to new test template
> > > 
> > > diff --git a/tests/generic/639 b/tests/generic/639
> > > new file mode 100755
> > > index 000000000000..c30f7644a2fc
> > > --- /dev/null
> > > +++ b/tests/generic/639
> > > @@ -0,0 +1,39 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2021, Jeff Layton <jlayton@redhat.com>
> > > +#
> > > +# FS QA Test No. 639
> > > +#
> > > +# Open a file and write a little data to it. Unmount (to clean out the cache)
> > > +# and then mount again. Then write some data to it beyond the EOF and ensure
> > > +# the result is correct.
> > > +#
> > > +# Prompted by a bug in ceph_write_begin that was fixed by commit 827a746f405d.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick rw
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_require_test
> > > +
> > > +testfile="$TEST_DIR/test_write_begin.$$"
> > > +
> > > +# write some data to file and fsync it out
> > > +$XFS_IO_PROG -f -c "pwrite -q 0 32" $testfile
> > 
> > Looks good to me, if you've used this case to reproduce that issue.
> > 
> > Just one question, the comment says "fsync it out", does that mean we need an
> > explicit "fsync" call (e.g. -c "pwrite -q 0 32" -c "fsync") to reproduce this
> > bug? Or there's an implicit "fsync" somewhere?
> > 
> > 
> 
> No, there is no implicit fsync. This is holdover from copy/paste that I
> did from another test. The patch is already merged now, but if we expand
> this test to cover other cases, I'll plan to clean up the comment then.
> 
> Thanks,
> Jeff
> 
> > 
> > > +
> > > +# cycle the mount to clean out the pagecache
> > > +_test_cycle_mount

I think this cycle mount accounts as an implicit fsync?

Thanks,
Eryu

> > > +
> > > +# now, write to the file (near the end)
> > > +$XFS_IO_PROG -c "pwrite -q 32 32" $testfile
> > > +
> > > +# dump what we think is in there
> > > +echo "The result should be 64 bytes filled with 0xcd:"
> > > +hexdump -C $testfile
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/639.out b/tests/generic/639.out
> > > new file mode 100644
> > > index 000000000000..9bf0bac96864
> > > --- /dev/null
> > > +++ b/tests/generic/639.out
> > > @@ -0,0 +1,5 @@
> > > +QA output created by 639
> > > +The result should be 64 bytes filled with 0xcd:
> > > +00000000  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> > > +*
> > > +00000040
> > > -- 
> > > 2.31.1
> > > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
