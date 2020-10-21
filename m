Return-Path: <SRS0=vxMy=D4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EB9C388F9
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Oct 2020 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85464222C8
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Oct 2020 14:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="spCBcQ1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442002AbgJUOj1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441957AbgJUOj0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Oct 2020 10:39:26 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4006C0613CE
        for <fstests@vger.kernel.org>; Wed, 21 Oct 2020 07:39:26 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id g13so1239262qvu.1
        for <fstests@vger.kernel.org>; Wed, 21 Oct 2020 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uhs2O0Q9ROPySc3PNKjV9W8o3FvbjaUgLr9y9vPm1wI=;
        b=spCBcQ1vptHk2ODMp7PEEmeVeQaLAHYVk7CYfT1n6TrmOdIB7azzmQmWrQ/4AZs6Yc
         kPlMhG9/sNDgsPxmGAWUz5s4mVpYPURI437CRAq0Hhb7npFvvYVX1W8FadQn9VD4S0Ts
         M6QD2zwp98x+dOeyD0GAhrp5+p+5K6Zih8PcMtimVOLavUDipwoXXStA/dO0T8yxVroR
         4nKGVGgOTTzS6fb5HT+49ZTWHfQ3Y+X6Vqg3QSAIY8wD9ipkK09zkfSCjDe4H9eY7xHn
         e9Gxs/Fq8HERCgf0v7C2V+LBDyF5ROCLPh/nbagT+wXQQ4lTOkEhaiFKysi0f9L1xHJU
         Y0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uhs2O0Q9ROPySc3PNKjV9W8o3FvbjaUgLr9y9vPm1wI=;
        b=U8EuW9LoSzOAHk5/baGu8PLDSIo+ElWTr+XB25VKrBMlXq2GowxNTVVxVS7VOscqYD
         UCxnZqtXDKLpuXSC295ukPfkDBaz+U3chbD1liH9Y3pbe0OVFgyewyeHP4aacp+WlgcD
         vW56unxjLunU7Zn0G8lnbiypOzxDw+OKLl/9Gur5AW17p2pYwRMCqcs6Mv9/Gbvvc9H8
         MO3smAKGsV36pteYGLmY3yxX1D5yf1JH28KT5ZQsZNbJbMcJUvki8pj7hCarAaCgQsGa
         hGsuB/tizFgFk/aNxiGSf7VqdBZlWsfarkZrKANjhfD2LZc21IyyH4t8Px/Oj0FmvaZU
         XBow==
X-Gm-Message-State: AOAM530r3lVv7HaMhcp9X+8PBw3soox4P6mq2p8YcVEf3jHQ05M7Nd5D
        qnC2Rk5U5BLjcL9c/VE23CGYHQ==
X-Google-Smtp-Source: ABdhPJzfZUQ7l5l9jL3TSZavb43dBYbAGvSWX2UE69O+MFoFvv5Hd+s60qtJca+XXxqBLp+IpRnwoA==
X-Received: by 2002:a05:6214:153:: with SMTP id x19mr3229836qvs.50.1603291165932;
        Wed, 21 Oct 2020 07:39:25 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n199sm1330258qkn.77.2020.10.21.07.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:39:25 -0700 (PDT)
Subject: Re: [PATCH] btrfs: add test case for rwf_nowait writes
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <5cfe8cb86da5593dda6c03b4ac404fa3b4c8b0d8.1603204654.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1aa6d939-6818-f8f3-d857-642237e56cf8@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:39:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <5cfe8cb86da5593dda6c03b4ac404fa3b4c8b0d8.1603204654.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 10/20/20 10:43 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test several scenarios for RWF_NOWAIT writes, to verify we don't regress
> on btrfs specific behaviour (snapshots, cow files, reflinks, holes,
> prealloc extent beyond eof).
> 
> We had some bugs in the past related to RWF_NOWAIT writes not failing on
> btrfs when they should or failing when they shouldn't, these were fixed by
> the following kernel commits:
> 
>    4b1946284dd6 ("btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof")
>    260a63395f90 ("btrfs: fix RWF_NOWAIT write not failling when we need to cow")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   tests/btrfs/225     | 140 ++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/225.out |  70 ++++++++++++++++++++++
>   tests/btrfs/group   |   1 +
>   3 files changed, 211 insertions(+)
>   create mode 100755 tests/btrfs/225
>   create mode 100644 tests/btrfs/225.out
> 
> diff --git a/tests/btrfs/225 b/tests/btrfs/225
> new file mode 100755
> index 00000000..f55e8c80
> --- /dev/null
> +++ b/tests/btrfs/225
> @@ -0,0 +1,140 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/225
> +#
> +# Test several (btrfs specific) scenarios with RWF_NOWAIT writes, cases where
> +# they should fail and cases where they should succeed.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch_reflink
> +_require_chattr C
> +_require_odirect
> +_require_xfs_io_command pwrite -N
> +_require_xfs_io_command falloc -k
> +_require_xfs_io_command fpunch
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Test a write against COW file/extent - should fail with -EAGAIN. Disable the
> +# NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatacow".
> +echo "Testing write against COW file"
> +touch $SCRATCH_MNT/f1
> +$CHATTR_PROG -C $SCRATCH_MNT/f1
> +$XFS_IO_PROG -s -c "pwrite -S 0xab 0 128K" $SCRATCH_MNT/f1 | _filter_xfs_io
> +$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xff 32K 64K" $SCRATCH_MNT/f1

Should we do something like

expected_to_fail_command > /dev/null 2>&1 || echo "FAILED!"

so we don't get screwed by error strings changing in the future or some such 
other nonsense?  Thanks,

Josef
