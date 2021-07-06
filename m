Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB54C07E96
	for <linux-fstests@archiver.kernel.org>; Tue,  6 Jul 2021 10:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D57619D1
	for <linux-fstests@archiver.kernel.org>; Tue,  6 Jul 2021 10:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhGFK7V (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 6 Jul 2021 06:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhGFK7V (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Jul 2021 06:59:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C84D619BE;
        Tue,  6 Jul 2021 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569003;
        bh=l3+QCQtBUbOBtWksvXY35qZwLrAswVJ0X8ca7y+RoFY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ViPq3tzgAia1mqCfODmUfdtM12uT45F9oKivXWYmLihv2lMB9epuI5LEKOfPDyvvD
         lfUrf2hemO1wLNR5VUjR2ExkCp567cQ22LwN1aHrp9Z7DD7zNT15ipzxEVrSEY+8d6
         TrOMknUa3qQrEK45hvfvy2OYAfopslqsB+sC5qSOIYgxkXTBkqCOj2kMk3FVmJQ6zB
         7UNKNNKfZHaoVjRrimLqD4EY2Lo26BNiR+H5e5+DFvAW9KiakS/xkcHwa2Vcc5oMYs
         sXhp2D0ANntE220qycjeT/tjqOti6Qhp2asHI/SOX0NKR4v3BDIqEmuZJr3D7WSXMA
         FSXD1OU+Bl42A==
Message-ID: <69594288685fdb38fb855345ef43252b6bd4aed3.camel@kernel.org>
Subject: Re: [PATCH v3] generic: add a test to ensure that page is properly
 filled before write
From:   Jeff Layton <jlayton@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        aweits@rit.edu, dhowells@redhat.com, willy@infradead.org
Date:   Tue, 06 Jul 2021 06:56:41 -0400
In-Reply-To: <20210705110434.wlc2gooeykoc6xcj@fedora>
References: <20210702134024.24233-1-jlayton@kernel.org>
         <20210705110434.wlc2gooeykoc6xcj@fedora>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, 2021-07-05 at 19:04 +0800, Zorro Lang wrote:
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
> 
> 

No, there is no implicit fsync. This is holdover from copy/paste that I
did from another test. The patch is already merged now, but if we expand
this test to cover other cases, I'll plan to clean up the comment then.

Thanks,
Jeff

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
> 

-- 
Jeff Layton <jlayton@kernel.org>

