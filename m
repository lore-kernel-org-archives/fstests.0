Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D342EC433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Mar 2022 00:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiCCANX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiCCANV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Mar 2022 19:13:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E510C50D
        for <fstests@vger.kernel.org>; Wed,  2 Mar 2022 16:12:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA9D7B8228C
        for <fstests@vger.kernel.org>; Wed,  2 Mar 2022 22:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5A5C004E1;
        Wed,  2 Mar 2022 22:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646261821;
        bh=fxcJcqd+OrC97CiQOwe4OVM6fDl9Yfghp5YXlrbDAto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPNAbL68PgQ4M2jow7tPga3iOncRP/Vgefonw/RYkPgk6JaOjEfgGQLdtMXiQBjjs
         43pWwoloujSUMZSP+VdQE3KLYk80Sce/W4P9V4+D8UkBFON4PmYCweqRMB/J5uAp1j
         /GlVKfPWLM6BZ7k9JMcgdVTPUuqkT/ZRJquoF1jwjgb1KjwjerYxGis3bUcTK01AKH
         tfnyYncxvZY2Iqk3kQc925Ni9jnWAMebH3GT/fjSmkuoid6oETuSs9h8d8QYwbXKMM
         b9SzIAhXKLoUf5xCO71s1FixAWRP1ld5pMOT7eNw/DAte+0a8iCgbACfkAEac8OVF3
         oB7T/MYw8VUsQ==
Date:   Wed, 2 Mar 2022 14:57:00 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com,
        p.raghav@samsung.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        mcgrof@kernel.org
Subject: Re: [PATCH] xfs/205,432,516: read sysfs for mkfs block size instead
 of hardcoded values
Message-ID: <20220302225700.GA117704@magnolia>
References: <CGME20220301213529epcas5p2974c84878339d5661336533696d3938f@epcas5p2.samsung.com>
 <20220301213022.28999-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301213022.28999-1-nj.shetty@samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 02, 2022 at 03:00:22AM +0530, Nitesh Shetty wrote:
> At present block size of 1024 is hardcoded for mkfs. This creates
> problem when device block size is more than 1024. So we use sysfs values

What kinds of problems?

> of SCRATCH_DEV, if not found then default to 1024.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  tests/xfs/205 | 3 ++-
>  tests/xfs/432 | 3 ++-
>  tests/xfs/516 | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/205 b/tests/xfs/205
> index 104f1f45..73e32c4d 100755
> --- a/tests/xfs/205
> +++ b/tests/xfs/205
> @@ -22,7 +22,8 @@ _require_scratch_nocheck
>  # bitmap consuming all the free space in our small data device.
>  unset SCRATCH_RTDEV
>  
> -fsblksz=1024
> +physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)

For a disk with 512 byte sectors, does this set physical=512?

The code within the $() really ought to be turned into a helper
_scratch_dev_phys_block_size or something.

> +fsblksz=${physical:-1024}

Filesystem blocksize isn't supposed to be smaller than the physical
blocksize, but why do you change the fs block size to the physical size?


>  _scratch_mkfs_xfs -d size=$((32768*fsblksz)) -b size=$fsblksz >> $seqres.full 2>&1
>  _scratch_mount
>  
> diff --git a/tests/xfs/432 b/tests/xfs/432
> index 86012f0b..cd6367e2 100755
> --- a/tests/xfs/432
> +++ b/tests/xfs/432
> @@ -49,7 +49,8 @@ echo "Format and mount"
>  # block.  8187 hashes/dablk / 248 dirents/dirblock = ~33 dirblocks per
>  # dablock.  33 dirblocks * 64k mean that we can expand a directory by
>  # 2112k before we have to allocate another da btree block.
> -_scratch_mkfs -b size=1k -n size=64k > "$seqres.full" 2>&1
> +physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> +_scratch_mkfs -b size=${physical:-1k} -n size=64k > "$seqres.full" 2>&1

This test formats a very specific geometry because it needs precise
calculations to generate a directory with 1000 consecutively mapped
blocks.  Does it still do that if the blocksize isn't 1k?

>  _scratch_mount >> "$seqres.full" 2>&1
>  
>  metadump_file="$TEST_DIR/meta-$seq"
> diff --git a/tests/xfs/516 b/tests/xfs/516
> index 9e1b9931..b9d4f0c9 100755
> --- a/tests/xfs/516
> +++ b/tests/xfs/516
> @@ -84,7 +84,8 @@ test_su_opts()
>  	local mounted=0
>  
>  	echo "Format with 256k stripe unit; 4x stripe width" >> $seqres.full
> -	_scratch_mkfs -b size=1k -d su=256k,sw=4 >> $seqres.full 2>&1
> +	physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> +	_scratch_mkfs -b size=${physical:-1k} -d su=256k,sw=4 >> $seqres.full 2>&1

This is a test of sunit/swidth.  Do you need to scale those up as well?

--D

>  
>  	__test_mount_opts "$@"
>  }
> 
> base-commit: 2ea74ba4e70b546279896e2a733c8c7f4b206193
> -- 
> 2.25.1
> 
