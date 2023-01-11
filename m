Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4668C5479D
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Jan 2023 20:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjAKUwG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Jan 2023 15:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjAKUv5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2023 15:51:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D312A3D9F2
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 12:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54FA761E4F
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 20:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980D2C433EF;
        Wed, 11 Jan 2023 20:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673470314;
        bh=QnTd++72vORq2zGpgV7n7qf+bjnssqglsfjQQmN/ctQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5uXjAHLsQ9j6t1FqpiXmRYh31vR+vuczUAdsLaM9Z8NHgJ/NzLVpbV3r61q14cJe
         Vfxg0OC9C6lVclLhXSVyLnw9HeM0hYYChobGRhT6b/nrDd56zqkEhR8oVioSCuyd7N
         5F+6gTHfnnPIOI8ValcRuZtgCIk2sSs7rTTkjJFJwjKEy3cL752nJWIqlYfJkAenDt
         vVS6P0JhM+9YbwzJ8CTrbbxZ2A57zSUqzv2hJm71bIaNI3LGf8IT7HSG3EqtBWxr+M
         LXGI/m7q99fm3S2wwKEP4yZ8sJZRTIDd8ukVzEV7leescJjNiV8MQ16gEYUW5bCrCB
         YptkqJ7KbPf7A==
Date:   Wed, 11 Jan 2023 12:51:52 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/692: Generalize the test for non-4k merkle tree
 block sizes
Message-ID: <Y78haOvystSsS+nJ@sol.localdomain>
References: <20230111175314.73346-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111175314.73346-1-ojaswin@linux.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 11, 2023 at 11:23:14PM +0530, Ojaswin Mujoo wrote:
> Due to the assumtion of Merkle tree block size being 4k, the size calculated
> for second test was taking way too long to hit EFBIG in case of bigger block
> sizes like 64k. Fix this by genralizing the calculation.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/692 | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/generic/692 b/tests/generic/692
> index d6da734b..0a354802 100755
> --- a/tests/generic/692
> +++ b/tests/generic/692
> @@ -54,15 +54,24 @@ _fsv_enable $fsv_file |& _filter_scratch
>  # (MAX) to be in the middle of L0 -- ideally near the beginning of L0 so that we
>  # don't have to write many blocks before getting an error.
>  #
> -# With SHA-256 and 4K blocks, there are 128 hashes per block.  Thus, ignoring
> -# padding, L0 is 1/128 of the file size while the other levels in total are
> -# 1/128**2 + 1/128**3 + 1/128**4 + ... = 1/16256 of the file size.  So still
> +# For example, with SHA-256 and 4K blocks, there are 128 hashes per block. Thus,
> +# ignoring padding, L0 is 1/128 of the file size while the other levels in total
> +# are 1/128**2 + 1/128**3 + 1/128**4 + ... = 1/16256 of the file size. So still
>  # ignoring padding, for L0 start exactly at MAX, the file size must be s such
> -# that s + s/16256 = MAX, i.e. s = MAX * (16256/16257).  Then to get a file size
> +# that s + s/16256 = MAX, i.e. s = MAX * (16256/16257). Then to get a file size
>  # where MAX occurs *near* the start of L0 rather than *at* the start, we can
>  # just subtract an overestimate of the padding: 64K after the file contents,
> -# then 4K per level, where the consideration of 8 levels is sufficient.
> -sz=$(echo "scale=20; $max_sz * (16256/16257) - 65536 - 4096*8" | $BC -q | cut -d. -f1)
> +# then 4K per level, where the consideration of 8 levels is sufficient. Below
> +# code generalizes this logic for all merkle tree sizes.
> +bs=$FSV_BLOCK_SIZE
> +hash_size=32   # SHA-256
> +hash_per_block=$(echo "scale=20; $bs/($hash_size)" | $BC -q)
> +a=$(echo "scale=20; 1/($hash_per_block^2)" | $BC -q)
> +r=$(echo "scale=20; 1/$hash_per_block" | $BC -q)
> +treesize_without_l1=$(echo "scale=20; $a/(1-$r)" | $BC -q)
> +sz=$(echo "scale=20; $max_sz/(1+$treesize_without_l1)" | $BC -q)
> +# adjust $sz so we are more likely to hit EFBIG while building level 1
> +sz=$(echo "scale=20; $sz - 65536 - $bs*8" | $BC -q | cut -d. -f1)
>  _fsv_scratch_begin_subtest "still too big: fail on first invalid merkle block"
>  truncate -s $sz $fsv_file
>  _fsv_enable $fsv_file |& _filter_scratch

Thanks!  I'd like to improve the explanation of the calculation, and fix up a
few other things, so I ended up just sending out an updated version of this
patch --- I hope that's okay with you.  Can you take a look?
https://lore.kernel.org/r/20230111204739.77828-1-ebiggers@kernel.org

- Eric
