Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7ABC48BCF
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Jun 2021 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB44161245
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Jun 2021 17:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhFMRdo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Jun 2021 13:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhFMRdn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 13 Jun 2021 13:33:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09ADD60FEE;
        Sun, 13 Jun 2021 17:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623605502;
        bh=hK93ponT0x87SdzzM5uUlX9iZLwx33IzNu/TMS4gQxM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mgaGqSZko619St6P9J1QGjzwj88OaYNs0L+TcnMvJRi1a5FX3SOLT2qo/IA6Q9QgM
         vQdhrEKSLYQs80gdERkuDMbq0kPIctksAUywGsksCmiMlwvK71eMPVPG8hR5oCLO2W
         rh0mmzI1zXMx0BWZ8Ht8OtZrZlqDkWb2+k4YtAI9tSsqFXYi6aHmxByH1BZMWuDDnA
         XbqtE63VigEcajNe2xZlNadCbsTNT5zqHuZ9Wzdk467gcaufqn2d+GYH7UMYnpa5vC
         yRyH0KK1A4sC8YrjBg0VRRyEB3kXmdj/65H80SpT/V1QNcqU3AWigUsmMpes1481CF
         2jgH9sHVeb65Q==
Message-ID: <705733a48274f5235a76a60fe9b229493e9772de.camel@kernel.org>
Subject: Re: [PATCH] generic: add a test to ensure that page is properly
 filled before write
From:   Jeff Layton <jlayton@kernel.org>
To:     Eryu Guan <guan@eryu.me>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        aweits@rit.edu, dhowells@redhat.com, willy@infradead.org
Date:   Sun, 13 Jun 2021 13:31:40 -0400
In-Reply-To: <YMYbkDgYdkLkA0BW@desktop>
References: <20210612123154.8098-1-jlayton@kernel.org>
         <YMYbkDgYdkLkA0BW@desktop>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, 2021-06-13 at 22:52 +0800, Eryu Guan wrote:
> On Sat, Jun 12, 2021 at 08:31:54AM -0400, Jeff Layton wrote:
> > We had a broken optimization in cephfs and netfs lib that could cause
> > part of a page to be improperly zeroed-out when writing to an offset
> > that was beyond the EOF but in an existing page.
> > 
> > Add a simple test that would have caught this.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  tests/generic/XXX     | 53 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/XXX.out |  5 ++++
> 
> Ah, all the 'XXX' in this test should be replaced with proper seq
> number.
> 

I can do that and resend.

> >  tests/generic/group   |  1 +
> >  3 files changed, 59 insertions(+)
> >  create mode 100755 tests/generic/XXX
> >  create mode 100644 tests/generic/XXX.out
> > 
> > diff --git a/tests/generic/XXX b/tests/generic/XXX
> > new file mode 100755
> > index 000000000000..0ddaaa544609
> > --- /dev/null
> > +++ b/tests/generic/XXX
> > @@ -0,0 +1,53 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021, Jeff Layton <jlayton@redhat.com>
> > +#
> > +# FS QA Test No. XXX
> > +#
> > +# Open a file and write a little data to it. Unmount (to clean out the cache)
> > +# and then mount again. Then write some data to it beyond the EOF and ensure
> > +# the result is correct. Prompted by a bug in ceph_write_begin. See:
> > +#
> > +# https://lore.kernel.org/ceph-devel/97002.1623448034@warthog.procyon.org.uk/T/#m9f34b328623b493c529505e12f64f4dfdbddfb27
> 
> This looks like a thread 9 months ago. Was the fix merged? If so, it'd
> be better to reference the kernel commit here.
> 
> Otherwise test looks fine to me.
> 

Not yet. v5.13 will require a fix in the netfs lib, whereas ceph will
need a one-off fix in v5.10.z - v5.12.z. We're sorting out both fixes
now.

Thanks!

> 
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +status=1    # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $testfile
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +_supported_fs generic
> > +_require_test
> > +
> > +rm -f $seqres.full
> > +
> > +testfile="$TEST_DIR/test_write_begin.$$"
> > +
> > +# write some data to file and fsync it out
> > +$XFS_IO_PROG -f -c "pwrite -q 0 32" $testfile
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
> > diff --git a/tests/generic/XXX.out b/tests/generic/XXX.out
> > new file mode 100644
> > index 000000000000..4e7653858e51
> > --- /dev/null
> > +++ b/tests/generic/XXX.out
> > @@ -0,0 +1,5 @@
> > +QA output created by XXX
> > +The result should be 64 bytes filled with 0xcd:
> > +00000000  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> > +*
> > +00000040
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 9a636b23f243..204a9b548f78 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -641,3 +641,4 @@
> >  636 auto quick swap
> >  637 auto quick dir
> >  638 auto quick rw
> > +XXX auto quick rw
> > -- 
> > 2.31.1
> > 

-- 
Jeff Layton <jlayton@kernel.org>

