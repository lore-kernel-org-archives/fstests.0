Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13A4C25B06
	for <linux-fstests@archiver.kernel.org>; Sun, 14 Aug 2022 03:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiHNDpl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 13 Aug 2022 23:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHNDpk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 13 Aug 2022 23:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FFD4DF85
        for <fstests@vger.kernel.org>; Sat, 13 Aug 2022 20:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660448735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeRwwaq+dd2T3K/1XS3RkGJL+IgITHyvikfbH5ZqsyM=;
        b=gTMmg2qSUy1dOagGL1TANDq4SYUri6HQiWk969AHNwc0BFUUjeSw+hB31PdkW0G6cXx9j1
        5av1wd0VgcwUwwJ+vPsnUV34/DihGFiRLDxQ4h5ogOyrQpeBGmxTavsqXnXh43/1J1LEVB
        7Jt05sfxNW3dnjp9NGhnX6DL6cPeJX4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-rbySbEBbMHm0RtX3JMz69A-1; Sat, 13 Aug 2022 23:45:33 -0400
X-MC-Unique: rbySbEBbMHm0RtX3JMz69A-1
Received: by mail-qk1-f198.google.com with SMTP id j19-20020a05620a289300b006b949aff6ddso4100919qkp.0
        for <fstests@vger.kernel.org>; Sat, 13 Aug 2022 20:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KeRwwaq+dd2T3K/1XS3RkGJL+IgITHyvikfbH5ZqsyM=;
        b=0pmBBZfBA9MMNioVOvSqjz7ukXd+6Xbb3on8hhC7LPoUhsboUPnpRFlmQ/RcLBYvwT
         z/g5igOUl1Ze9AKbZmRp8dZNvGzokL2cw9VXmVNuFKXY7s8d8LIfjo6eqmp54Bh8w4K5
         1xU1K34/07o3AUEhSTITjEb3omo/1mV26oswk1htait77zIhiGrXZ/aHq4Rq3BuejATD
         y+38Ucn8g9XGtO6JU3BB4/GtZA186wMhZ5/sbKTFUhpMWdLr+Xk5lgpq8p/iGC88oYzK
         DQ/OfMEH0TDKFmBqK9TlNY+vV4rj0+P0eU1Q6UkZul3OLM1MhBYgEpvZAHhyenEc0bAQ
         PsuQ==
X-Gm-Message-State: ACgBeo2DG0cQY2Tp86/ovJWY5Fftgn5P8ZWPE25Lrr1z3Tke2SKFGisi
        M4s3Avoe3QaQBpxN6/3CLI6YE0e3HCvO5jjemVRCyfnPxn8wjUkuAb/rRC7jsblJgoq9nxbRpP7
        BToANugwZiCA4WVzfRA==
X-Received: by 2002:ac8:58c6:0:b0:343:292:5980 with SMTP id u6-20020ac858c6000000b0034302925980mr9436112qta.319.1660448732962;
        Sat, 13 Aug 2022 20:45:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4J68Qa+GW1Ka4y0/fbRd8Zvx2BUsc4Bb2gcGOLTLLkV7jO70C6diTCPDoabGxmDpZtsPFGqQ==
X-Received: by 2002:ac8:58c6:0:b0:343:292:5980 with SMTP id u6-20020ac858c6000000b0034302925980mr9436104qta.319.1660448732715;
        Sat, 13 Aug 2022 20:45:32 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w22-20020ac857d6000000b0033c36ef019esm5130648qta.63.2022.08.13.20.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 20:45:32 -0700 (PDT)
Date:   Sun, 14 Aug 2022 11:45:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, sj1557.seo@samsung.com
Subject: Re: [PATCH] generic: test i_blocks for large files
Message-ID: <20220814034526.4ozrc6tq72a5mrlu@zlang-mailbox>
References: <20220812145050.43966-1-preichl@redhat.com>
 <20220813054438.ghygw23t6phvuwos@zlang-mailbox>
 <292c6dd6-fcc7-f163-ca79-34e021beaa7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292c6dd6-fcc7-f163-ca79-34e021beaa7d@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 13, 2022 at 11:00:54AM +0200, Pavel Reichl wrote:
> 
> On 8/13/22 07:44, Zorro Lang wrote:
> > On Fri, Aug 12, 2022 at 04:50:50PM +0200, Pavel Reichl wrote:
> > > This is a regression test for an incorrect
> > > computation of i_blocks for files larger than
> > > 4 GiB. Bug was filed for exFAT.
> > > 
> > > Signed-off-by: Pavel Reichl <preichl@redhat.com>
> > > ---
> > >   tests/generic/693-inodes-for-large-files     | 49 ++++++++++++++++++++
> > >   tests/generic/693-inodes-for-large-files.out |  1 +
> > >   2 files changed, 50 insertions(+)
> > >   create mode 100755 tests/generic/693-inodes-for-large-files
> > >   create mode 100644 tests/generic/693-inodes-for-large-files.out
> > > 
> > > diff --git a/tests/generic/693-inodes-for-large-files b/tests/generic/693-inodes-for-large-files
> > I think case *number* is enough.
> 0K, the 'new' script asked, so I provided:-)
> > 
> > > new file mode 100755
> > > index 00000000..797d6a21
> > > --- /dev/null
> > > +++ b/tests/generic/693-inodes-for-large-files
> > > @@ -0,0 +1,49 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> > > +#
> > > +# FS QA Test 693
> > > +#
> > > +# Verify that i_blocks for files larger than 4 GiB have correct
> > > +# values.
> > > +#
> > > +# This test verifies the problem fixed in kernel with commit
> > > +# 0c336d6e33f4 exfat: fix incorrect loading of i_blocks for large files
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto
> > > +
> > > +# Override the default cleanup function.
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -r -f $tmp.* $junk_dir
> > > +}
> > > +
> > > +_supported_fs generic
> > > +_require_test
> > If this test need 4G free space, I'm wondering if we need to make sure
> > there's enough space in $TEST_DIR, as we do in _require_scratch_size.
> OK, I'll look into it.
> > 
> > > +
> > > +junk_dir=$TEST_DIR/$seq
> > > +junk_file=$junk_dir/junk
> > > +mkdir -p $junk_dir
> > > +
> > > +$XFS_IO_PROG -f -c "truncate 4G" $junk_file
> > It helps to allocate 4g real space on exfat, due to exfat doesn't
> > support sparse file, but on other filesystems (e.g. xfs, ext4, btrfs)
> > it will get a file which i_blocks=0.
> OK, I know that and I think it's fine - I just need a test for consistency
> after remounting.

So you don't need to allocate 4g real space? If so, that helps the test faster,
but that depends on what are you really trying to test. I just saw you try to
get 4g i_blocks, so thought you might need 4g real space.

Thanks,
Zorro

> > 
> > As a generic test case, if you really want to allocate 4g real space,
> > I think you have to real write data:
> > 
> >    $XFS_IO_PROG -f -c "pwrite -W 0 4g" $junk_file
> > 
> > If anyone knows any better idea, feel free to reply :)
> > 
> > > +
> > > +iblocks=`$XFS_IO_PROG -c "stat" $junk_file | grep 'stat.blocks'`
> > stat -c %b $junk_file ??
> > 
> > > +test -z "$iblocks" && echo 'Failed to parse the blocks'
> > > +
> > > +_test_cycle_mount
> > > +
> > > +iblocks_after_remount=`$XFS_IO_PROG -c "stat" $junk_file | grep 'stat.blocks'`
> > stat -c %b $junk_file ??
> > 
> > > +
> > > +test -z "$iblocks_after_remount" && echo 'Failed to parse the blocks'
> > When will we get an empty "$iblocks_after_remount" ?
> It is just a check that both xfs_io and grep worked as expected.
> > 
> > > +
> > > +if [ "$iblocks" != "$iblocks_after_remount" ]; then
> > > +	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
> > > +	status=1
> > If you "exit" directly, the status is 1 by default. But I think you don't need
> > to exit at here, due to above output will break golden image and fail this test.
> OK, I'll fix that. Thanks!
> > 
> > > +	exit
> > > +fi
> > > +
> > > +status=0
> > > +
> > > +exit
> > > diff --git a/tests/generic/693-inodes-for-large-files.out b/tests/generic/693-inodes-for-large-files.out
> > > new file mode 100644
> > > index 00000000..f39aa77c
> > > --- /dev/null
> > > +++ b/tests/generic/693-inodes-for-large-files.out
> > > @@ -0,0 +1 @@
> > > +QA output created by 693-inodes-for-large-files
> > Silence is golden ??
> 
> Well I don't echo that in the script, but if that's custom I'll do it.
> 
> 
> Thanks for the comments!
> 
> > 
> > > -- 
> > > 2.37.1
> > > 
> 

