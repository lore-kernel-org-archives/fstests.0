Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E751C4332F
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Nov 2022 09:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiKGJIJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Nov 2022 04:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiKGJH7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Nov 2022 04:07:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4456D12763
        for <fstests@vger.kernel.org>; Mon,  7 Nov 2022 01:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667812020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RymeAz5EkK8gDF6aqcPa20azrd6fC1wMVpEs94SO9nE=;
        b=TVa8jiAJVfZLog+zumuwz4a30UdhcGQCOMuV0U38YPFOxpur+ss12d+hdkWPllSS321+tm
        7XXue0CjzYFSCCTwaaTLA51OMYxHjf8u5fh98CGrKwnsmuSi4FovIz3qlnSZwdt4Qn63Oo
        +5sCdupVEmLBhLB9tGQlZeM9luF21Zc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-179-1w_lCa1QORuPailK8WOnMg-1; Mon, 07 Nov 2022 04:06:59 -0500
X-MC-Unique: 1w_lCa1QORuPailK8WOnMg-1
Received: by mail-pj1-f69.google.com with SMTP id q1-20020a17090aa00100b002139a592adbso10067452pjp.1
        for <fstests@vger.kernel.org>; Mon, 07 Nov 2022 01:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RymeAz5EkK8gDF6aqcPa20azrd6fC1wMVpEs94SO9nE=;
        b=2Eug7Ng5yWd5eIeTmWYxCYSL0AqChyjlHtDuNMpQ4lHO4t6/bC5NLKxpj6c5HEuaaq
         RN7rFpoNsl09uMjGd1l7ZH+AbpYzY63E83MZbapqbM2s4/z072GTDNEk+2pAIKvWdoEY
         FalTkdSkK/EgosFlj6MJ59bZLCkUYIcz8CUtzUaujS2RQH1I8IXDhSQZonWmV3eRdcj6
         vTVdxOrKqc0KXv9Kb+OxYT2+ompc3NM96L92AhtTMtAwQ8r/SP4Z3v9zPlFftvLOZB5b
         21Y/GY8JLsg5bmNlwk/NHum+DNlXMulOH7UE2IHaqCSixS1spve7+snvJEX3qkeuC1yB
         TgGg==
X-Gm-Message-State: ACrzQf11F4y3pwACbmsGrYI0k9Tiv2v9lAMEebbOtXW63blH4C7OFtjN
        6VMALCJvnC/4WYyqQK3UosNWYOmJ9DmYQwsrr+ZvG9tGvGuwia8x2W4K0enuNy2alvVfeFK9qBR
        lCsbhCxs9iC6Qdlbmvg==
X-Received: by 2002:a17:902:7b98:b0:187:4889:7dcb with SMTP id w24-20020a1709027b9800b0018748897dcbmr28085343pll.79.1667812017450;
        Mon, 07 Nov 2022 01:06:57 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5ww23Oq2MRayPfcewP+n/FDg425gsawDX3KRocrqWKgMO51H7+rsb8//Xky5M30sGhHPs8AA==
X-Received: by 2002:a17:902:7b98:b0:187:4889:7dcb with SMTP id w24-20020a1709027b9800b0018748897dcbmr28085319pll.79.1667812017087;
        Mon, 07 Nov 2022 01:06:57 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b0015e8d4eb26esm4432403ple.184.2022.11.07.01.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:06:56 -0800 (PST)
Date:   Mon, 7 Nov 2022 17:06:50 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] fstests: btrfs: add a regression test case to make sure
 scrub can detect errors
Message-ID: <20221107090650.huninpikhasx7hdi@zlang-mailbox>
References: <20221106235348.9732-1-wqu@suse.com>
 <20221107032500.lfzr3h3lqqomu26c@zlang-mailbox>
 <CAL3q7H6TfL9eReF_SWAJ6V0QTZK83LH=3RVtuT4GR7ht2JxfUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6TfL9eReF_SWAJ6V0QTZK83LH=3RVtuT4GR7ht2JxfUA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 07, 2022 at 08:42:17AM +0000, Filipe Manana wrote:
> On Mon, Nov 7, 2022 at 3:36 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Mon, Nov 07, 2022 at 07:53:48AM +0800, Qu Wenruo wrote:
> > > There is a regression in v6.1-rc kernel, which will prevent btrfs scrub
> > > from detecting corruption (thus no repair either).
> > >
> > > The regression is caused by commit 786672e9e1a3 ("btrfs: scrub: use
> > > larger block size for data extent scrub").
> > >
> > > The new test case will:
> > >
> > > - Create a data extent with 2 sectors
> > > - Corrupt the second sector of above data extent
> > > - Scrub to make sure we detect the corruption
> > >
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >  tests/btrfs/278     | 66 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/278.out |  2 ++
> > >  2 files changed, 68 insertions(+)
> > >  create mode 100755 tests/btrfs/278
> > >  create mode 100644 tests/btrfs/278.out
> > >
> > > diff --git a/tests/btrfs/278 b/tests/btrfs/278
> > > new file mode 100755
> > > index 00000000..ebbf207a
> > > --- /dev/null
> > > +++ b/tests/btrfs/278
> > > @@ -0,0 +1,66 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 278
> > > +#
> > > +# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
> > > +# larger block size for data extent scrub"), which makes btrfs scrub unable
> > > +# to detect corruption if it's not the first sector of an data extent.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick scrub
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +. ./common/btrfs
> > > +
> > > +# real QA test starts here
> > > +
> > > +# Modify as appropriate.
> > > +_supported_fs btrfs
> > > +
> > > +# Need to use 4K as sector size
> > > +_require_btrfs_support_sectorsize 4096
> > > +_require_scratch
> >
> > Hi Darrick,
> >
> > I noticed that you created some scrub helpers in common/fuzzy:
> >   # Do we have an online scrub program?
> >   _require_scrub() {
> >         case "${FSTYP}" in
> >         "xfs")
> >                 test -x "$XFS_SCRUB_PROG" || _notrun "xfs_scrub not found"
> >                 ;;
> >         *)
> >                 _notrun "No online scrub program for ${FSTYP}."
> >                 ;;
> >         esac
> >   }
> >
> >   # Scrub the scratch filesystem metadata (online)
> >   _scratch_scrub() {
> >         case "${FSTYP}" in
> >         "xfs")
> >                 $XFS_SCRUB_PROG -d -T -v "$@" $SCRATCH_MNT
> >                 ;;
> >         *)
> >                 _fail "No online scrub program for ${FSTYP}."
> >                 ;;
> >         esac
> >   }
> >
> > and common/xfs:
> >   _supports_xfs_scrub()
> >
> > (PS: How about change _require_scrub to _require_scrub_command, and then calls
> > _supports_xfs_scrub in _require_scrub to check kernel part? Or combine kernel
> > and userspace checking all into _require_scrub? )
> >
> > From the code logic, they're only support xfs now. But we can see btrfs support
> > scrub too. Did you plan to make them to be common helpers, or just for xfs fuzzy
> > test inside?
> >
> > Hi btrfs folks, do you think if btrfs need _require_scrub and _scratch_scrub?
> 
> I don't think that provides any value for btrfs.
> 
> The scrub feature has existed for well over a decade, and I don't
> think anyone is running fstests with kernels and btrfs-progs versions
> that don't have scrub.
> Even SLE11-SP2+ kernels (first SUSE enterprise distros supporting
> btrfs) have scrub...
> 
> Plus I don't recall ever anyone complaining that fstests failed
> because the underlying kernel or btrfs-progs had no support for scrub.

Sure, thanks for your feedback! I'll think/talk about if we should change
that _require_scrub and _scratch_scrub to be more common helpers for fs which
has supported or will support scrub feature. I'll cc btrfs-list if I touch
btrfs cases :)

Thanks,
Zorro

> 
> 
> >
> > Thanks,
> > Zorro
> >
> > > +
> > > +_scratch_mkfs >> $seqres.full
> > > +_scratch_mount
> > > +
> > > +# Create a data extent with 2 sectors
> > > +$XFS_IO_PROG -fc "pwrite -S 0xff 0 8k" $SCRATCH_MNT/foobar >> $seqres.full
> > > +sync
> > > +
> > > +first_logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> > > +echo "logical of the first sector: $first_logical" >> $seqres.full
> > > +
> > > +second_logical=$(( $first_logical + 4096 ))
> > > +echo "logical of the second sector: $second_logical" >> $seqres.full
> > > +
> > > +second_physical=$(_btrfs_get_physical $second_logical 1)
> > > +echo "physical of the second sector: $second_physical" >> $seqres.full
> > > +
> > > +second_dev=$(_btrfs_get_device_path $second_logical 1)
> > > +echo "device of the second sector: $second_dev" >> $seqres.full
> > > +
> > > +_scratch_unmount
> > > +
> > > +# Corrupt the second sector of the data extent.
> > > +$XFS_IO_PROG -c "pwrite -S 0x00 $second_physical 4k" $second_dev >> $seqres.full
> > > +_scratch_mount
> > > +
> > > +# Redirect stderr and stdout, as if btrfs detected the unrepairable corruption,
> > > +# it will output an error message.
> > > +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT &> $tmp.output
> > > +cat $tmp.output >> $seqres.full
> > > +_scratch_unmount
> > > +
> > > +if ! grep -q "csum=1" $tmp.output; then
> > > +     echo "Scrub failed to detect corruption"
> > > +fi
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
> > > new file mode 100644
> > > index 00000000..b4c4a95d
> > > --- /dev/null
> > > +++ b/tests/btrfs/278.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 278
> > > +Silence is golden
> > > --
> > > 2.38.0
> > >
> >
> 

