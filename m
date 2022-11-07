Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84B4C433FE
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Nov 2022 03:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiKGD0F (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Nov 2022 22:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKGD0E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Nov 2022 22:26:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E2A47C
        for <fstests@vger.kernel.org>; Sun,  6 Nov 2022 19:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667791507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BcR8BZ978GOcUY42RVk0m9oe4YfNexSEpQ+SsmOuPdQ=;
        b=jB0u0vl3SyfYzzfzvIsFlbi9TMpD8VNTfqwzxlXo4FkMu2LWMMCdxMo2QkFXan4t3opElO
        6flx1PAq2Y9fWJCRY2GRG32t037UqvFXeRsLRmG4EgdAznmiFD34uGBw8AVB2jOV40Hk0S
        8KwN1uzy1+3Jy/JvihBwIXpF1/YBw64=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-Og3Eid0APa-JlwNAo5DaXA-1; Sun, 06 Nov 2022 22:25:06 -0500
X-MC-Unique: Og3Eid0APa-JlwNAo5DaXA-1
Received: by mail-qt1-f198.google.com with SMTP id fb5-20020a05622a480500b003a525d52abcso7411460qtb.10
        for <fstests@vger.kernel.org>; Sun, 06 Nov 2022 19:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcR8BZ978GOcUY42RVk0m9oe4YfNexSEpQ+SsmOuPdQ=;
        b=5fh5IR3N7i246VHtIDnd2pTpahH6PLh79cVskdcfea4p9hdriBqksl1NJ1X7Y2jRNe
         v3C4Cegl7aVA9xj1IOQgaEvovWsRrB7FnQ192cB8RRKXWcQm8CHaFbkspSS9FZyDHAlv
         mb/RWu3VR5neHa3HyRup0zTQcKKOsbdNlW6Jqb31aRI2+mqfobP+BqvjpDBNap3J5DBs
         lT+u4SOQszvAf7yf4WpQYzCLeRAdP/Hp7D2AP4maW6+q+9PDgzDa4E9oaBTr8ZISPIGS
         AGBbHi6zU7Bz/GA+0DnVFSSXBuwSJvSREP8Q7+ghe6hCByYgD/dQ+czffpumCMzs67i9
         +4yg==
X-Gm-Message-State: ACrzQf0NWk3SiBUrpPzez33T2HRIQQPcsRAjy/kNulcyAPBpFhHB/1gu
        DpWsMhfifPm1fT1lkvQdHtStS9ndlGT9hGInyvaBVNjmif5iLPcPzWoMn38MrfYq4pvZTN4gqJV
        tssXomWbXnxTFo/1o4A==
X-Received: by 2002:ac8:57c5:0:b0:39a:6512:6e3e with SMTP id w5-20020ac857c5000000b0039a65126e3emr38355673qta.334.1667791505782;
        Sun, 06 Nov 2022 19:25:05 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4Gqd7/UygXKKtGRHrkrRmR7Z3lgzC10lN/9UQpffFe3vrMJJPoZsJLtSIvzkqF4X1rtKV3CQ==
X-Received: by 2002:ac8:57c5:0:b0:39a:6512:6e3e with SMTP id w5-20020ac857c5000000b0039a65126e3emr38355666qta.334.1667791505514;
        Sun, 06 Nov 2022 19:25:05 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bm35-20020a05620a19a300b006eed75805a2sm5769409qkb.126.2022.11.06.19.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 19:25:04 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:25:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] fstests: btrfs: add a regression test case to make sure
 scrub can detect errors
Message-ID: <20221107032500.lfzr3h3lqqomu26c@zlang-mailbox>
References: <20221106235348.9732-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106235348.9732-1-wqu@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 07, 2022 at 07:53:48AM +0800, Qu Wenruo wrote:
> There is a regression in v6.1-rc kernel, which will prevent btrfs scrub
> from detecting corruption (thus no repair either).
> 
> The regression is caused by commit 786672e9e1a3 ("btrfs: scrub: use
> larger block size for data extent scrub").
> 
> The new test case will:
> 
> - Create a data extent with 2 sectors
> - Corrupt the second sector of above data extent
> - Scrub to make sure we detect the corruption
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/278     | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/278.out |  2 ++
>  2 files changed, 68 insertions(+)
>  create mode 100755 tests/btrfs/278
>  create mode 100644 tests/btrfs/278.out
> 
> diff --git a/tests/btrfs/278 b/tests/btrfs/278
> new file mode 100755
> index 00000000..ebbf207a
> --- /dev/null
> +++ b/tests/btrfs/278
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 278
> +#
> +# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
> +# larger block size for data extent scrub"), which makes btrfs scrub unable
> +# to detect corruption if it's not the first sector of an data extent.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick scrub
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/btrfs
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +
> +# Need to use 4K as sector size
> +_require_btrfs_support_sectorsize 4096
> +_require_scratch

Hi Darrick,

I noticed that you created some scrub helpers in common/fuzzy:
  # Do we have an online scrub program?
  _require_scrub() {
        case "${FSTYP}" in
        "xfs")
                test -x "$XFS_SCRUB_PROG" || _notrun "xfs_scrub not found"
                ;;
        *)
                _notrun "No online scrub program for ${FSTYP}."
                ;;
        esac
  }

  # Scrub the scratch filesystem metadata (online)
  _scratch_scrub() {
        case "${FSTYP}" in
        "xfs")
                $XFS_SCRUB_PROG -d -T -v "$@" $SCRATCH_MNT
                ;;
        *)
                _fail "No online scrub program for ${FSTYP}."
                ;;
        esac
  }

and common/xfs:
  _supports_xfs_scrub()

(PS: How about change _require_scrub to _require_scrub_command, and then calls
_supports_xfs_scrub in _require_scrub to check kernel part? Or combine kernel
and userspace checking all into _require_scrub? )

From the code logic, they're only support xfs now. But we can see btrfs support
scrub too. Did you plan to make them to be common helpers, or just for xfs fuzzy
test inside?

Hi btrfs folks, do you think if btrfs need _require_scrub and _scratch_scrub?

Thanks,
Zorro

> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +# Create a data extent with 2 sectors
> +$XFS_IO_PROG -fc "pwrite -S 0xff 0 8k" $SCRATCH_MNT/foobar >> $seqres.full
> +sync
> +
> +first_logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +echo "logical of the first sector: $first_logical" >> $seqres.full
> +
> +second_logical=$(( $first_logical + 4096 ))
> +echo "logical of the second sector: $second_logical" >> $seqres.full
> +
> +second_physical=$(_btrfs_get_physical $second_logical 1)
> +echo "physical of the second sector: $second_physical" >> $seqres.full
> +
> +second_dev=$(_btrfs_get_device_path $second_logical 1)
> +echo "device of the second sector: $second_dev" >> $seqres.full
> +
> +_scratch_unmount
> +
> +# Corrupt the second sector of the data extent.
> +$XFS_IO_PROG -c "pwrite -S 0x00 $second_physical 4k" $second_dev >> $seqres.full
> +_scratch_mount
> +
> +# Redirect stderr and stdout, as if btrfs detected the unrepairable corruption,
> +# it will output an error message.
> +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT &> $tmp.output
> +cat $tmp.output >> $seqres.full
> +_scratch_unmount
> +
> +if ! grep -q "csum=1" $tmp.output; then
> +	echo "Scrub failed to detect corruption"
> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
> new file mode 100644
> index 00000000..b4c4a95d
> --- /dev/null
> +++ b/tests/btrfs/278.out
> @@ -0,0 +1,2 @@
> +QA output created by 278
> +Silence is golden
> -- 
> 2.38.0
> 

