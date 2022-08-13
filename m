Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39024C25B08
	for <linux-fstests@archiver.kernel.org>; Sat, 13 Aug 2022 05:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiHMFou (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 13 Aug 2022 01:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiHMFot (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 13 Aug 2022 01:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D51D31FCE1
        for <fstests@vger.kernel.org>; Fri, 12 Aug 2022 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660369486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lFU6T+JdTccahhugLcMJcCfyqRMDCfKmpnSxIiC2Hts=;
        b=fIQ+EZSvS2gB60mrZFiLG1b6vIYtJ5NY0hu17BBbf6f/Jzljt6k6zojTbH0G4oV1ZDGcaF
        709jakPOQGoMU2YD7RjSo0datT8ltVXC3MaltPkI2KTIwrkq6AaG5H3Q1vxcheIDu3goYd
        XkAV5KsyruCfYxgcyuml58TLuczeABs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-NkKLVkpKNSyuQ8DTw0Mj8g-1; Sat, 13 Aug 2022 01:44:45 -0400
X-MC-Unique: NkKLVkpKNSyuQ8DTw0Mj8g-1
Received: by mail-qk1-f197.google.com with SMTP id bj26-20020a05620a191a00b006b5c4e2dc77so2353832qkb.16
        for <fstests@vger.kernel.org>; Fri, 12 Aug 2022 22:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lFU6T+JdTccahhugLcMJcCfyqRMDCfKmpnSxIiC2Hts=;
        b=LVMmtp+CpoOjajExANr2qjCQvr04eGs2oiIFyzZfs3iQ/t2/2sbpleIiTv07LSnT2Y
         rh/75bdmLMVDjErFozOZZpLEZQd+qe0EyReBU70mLpD7ZoDvVMPWPsOt9FrYlx0t0hTh
         dAIkx2X0iMVvqndXAPspZQDiQc0IF+LMIgqmrELZz5k45rSP+hNEPrLVLckFwrvUam3x
         7DBMqRyEjilAoGUioiR3ry/WDDrRK3pUsmVBEMtx+6f23XZ9NEHqIoAVeLbW460t0zHY
         jmESHK8unEp6V+NUV355elmn5YJMikNaS0MWV/JxxkFzRnuV1tvoToIq6TlPDeCrcc0h
         XRsg==
X-Gm-Message-State: ACgBeo05vXQqXb3hpPdMfBW+SZiotopnxclGlsfHP3HQuys6tylq5eaG
        HUwv6QHq0QvFBbMV4aKYliz5IRYM2hNMeJ4RJF/4lyQNwoAMTW6LqplqkpwUimxZypvjUN1hJLm
        u5tyYFHLRnQDFanfo9w==
X-Received: by 2002:ac8:5a83:0:b0:343:11f:a781 with SMTP id c3-20020ac85a83000000b00343011fa781mr6334986qtc.19.1660369484536;
        Fri, 12 Aug 2022 22:44:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6CWS55FGDjDb+BjOR7HqVEYUuvsjutmRJnlZT5LXxql+088hJMGmJz4BsuijnV52RsbzS5XQ==
X-Received: by 2002:ac8:5a83:0:b0:343:11f:a781 with SMTP id c3-20020ac85a83000000b00343011fa781mr6334973qtc.19.1660369484273;
        Fri, 12 Aug 2022 22:44:44 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bk3-20020a05620a1a0300b006b9be18b774sm3243572qkb.105.2022.08.12.22.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 22:44:43 -0700 (PDT)
Date:   Sat, 13 Aug 2022 13:44:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, sj1557.seo@samsung.com
Subject: Re: [PATCH] generic: test i_blocks for large files
Message-ID: <20220813054438.ghygw23t6phvuwos@zlang-mailbox>
References: <20220812145050.43966-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812145050.43966-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 12, 2022 at 04:50:50PM +0200, Pavel Reichl wrote:
> This is a regression test for an incorrect
> computation of i_blocks for files larger than
> 4 GiB. Bug was filed for exFAT.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/generic/693-inodes-for-large-files     | 49 ++++++++++++++++++++
>  tests/generic/693-inodes-for-large-files.out |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100755 tests/generic/693-inodes-for-large-files
>  create mode 100644 tests/generic/693-inodes-for-large-files.out
> 
> diff --git a/tests/generic/693-inodes-for-large-files b/tests/generic/693-inodes-for-large-files

I think case *number* is enough.

> new file mode 100755
> index 00000000..797d6a21
> --- /dev/null
> +++ b/tests/generic/693-inodes-for-large-files
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> +#
> +# FS QA Test 693
> +#
> +# Verify that i_blocks for files larger than 4 GiB have correct
> +# values.
> +#
> +# This test verifies the problem fixed in kernel with commit
> +# 0c336d6e33f4 exfat: fix incorrect loading of i_blocks for large files
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.* $junk_dir
> +}
> +
> +_supported_fs generic
> +_require_test

If this test need 4G free space, I'm wondering if we need to make sure
there's enough space in $TEST_DIR, as we do in _require_scratch_size.

> +
> +junk_dir=$TEST_DIR/$seq
> +junk_file=$junk_dir/junk
> +mkdir -p $junk_dir
> +
> +$XFS_IO_PROG -f -c "truncate 4G" $junk_file

It helps to allocate 4g real space on exfat, due to exfat doesn't
support sparse file, but on other filesystems (e.g. xfs, ext4, btrfs)
it will get a file which i_blocks=0.

As a generic test case, if you really want to allocate 4g real space,
I think you have to real write data:

  $XFS_IO_PROG -f -c "pwrite -W 0 4g" $junk_file

If anyone knows any better idea, feel free to reply :)

> +
> +iblocks=`$XFS_IO_PROG -c "stat" $junk_file | grep 'stat.blocks'`

stat -c %b $junk_file ??

> +test -z "$iblocks" && echo 'Failed to parse the blocks'
> +
> +_test_cycle_mount
> +
> +iblocks_after_remount=`$XFS_IO_PROG -c "stat" $junk_file | grep 'stat.blocks'`

stat -c %b $junk_file ??

> +
> +test -z "$iblocks_after_remount" && echo 'Failed to parse the blocks'

When will we get an empty "$iblocks_after_remount" ?

> +
> +if [ "$iblocks" != "$iblocks_after_remount" ]; then
> +	echo "Number of blocks needs to be same: $iblocks, $iblocks_after_remount"
> +	status=1

If you "exit" directly, the status is 1 by default. But I think you don't need
to exit at here, due to above output will break golden image and fail this test.

> +	exit
> +fi
> +
> +status=0
> +
> +exit
> diff --git a/tests/generic/693-inodes-for-large-files.out b/tests/generic/693-inodes-for-large-files.out
> new file mode 100644
> index 00000000..f39aa77c
> --- /dev/null
> +++ b/tests/generic/693-inodes-for-large-files.out
> @@ -0,0 +1 @@
> +QA output created by 693-inodes-for-large-files

Silence is golden ??

> -- 
> 2.37.1
> 

