Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC2AC001E0
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Oct 2023 15:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJWPpR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Oct 2023 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjJWPpQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Oct 2023 11:45:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348CE9D
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2023 08:45:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6031C433C8;
        Mon, 23 Oct 2023 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075913;
        bh=so36s5G0RF5gA1XPz0t+VuvIDi1rWO4pdhC5Z5DFdYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tI+4sL34AC0qO1/8vjEbxRCUjrpcDjamRsSAtAlX++taIewI2ZjVxo0yCq7NRNeQh
         W/NU8DFe63j2LDUoPFw9ixokXyMMZ8wdxnbzZaku0v8XwxEj7w4LbG6jtZxxELoAZ9
         utFnfTzgADzbbUPy1/YLsUvzD4/TlqTUB60kUO2Y/JEwB00c5QsvSexPnrS2EWOAM6
         UAgF16Ug0iYKuoEuhkoabKtCNGfAG/MllWX/W7X5G6CBL+y0wcxAi/lBIlEhm5sC8F
         jZN7FIcvAZHNGhukQCLO+bO47xNFs9KsbmS6b+V/8mX2UhI0cnyjbd3rR8Fgs4kQcr
         77D/iWDEveOEw==
Date:   Mon, 23 Oct 2023 08:45:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common: check if the scratch device can support 1024
 block sizes
Message-ID: <20231023154513.GF11391@frogsfrogsfrogs>
References: <20231022215529.2202150-1-tytso@mit.edu>
 <20231022215529.2202150-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231022215529.2202150-2-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 22, 2023 at 05:55:28PM -0400, Theodore Ts'o wrote:
> If the scratch device has as logical blocksize larger than 512 --- for
> example, some SSD or HDD's may have a 4k logical blocksize, and so
> will not support a file system with a 1k block size.
> 
> Add a new function, _require_scratch_support_blocksize so we can skip
> tests that use _scratch_mkfs_blocksized with a size less than the
> scratch device's logical block size.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/rc      | 12 ++++++++++++
>  tests/ext4/055 |  1 +
>  tests/xfs/205  |  1 +
>  tests/xfs/432  |  1 +
>  tests/xfs/516  |  1 +
>  5 files changed, 16 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 7f5a9527c..8d7179567 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1124,6 +1124,9 @@ _scratch_mkfs_blocksized()
>  	if [ $blocksize -lt $(_get_page_size) ]; then
>  		_exclude_scratch_mount_option dax
>  	fi
> +	if [ $blocksize -lt $(blockdev --getss $SCRATCH_DEV) ]; then
> +		_require_scratch_support_blocksize "$blocksize"
> +	fi

This duplicates the logic in _require_scratch_support_blocksize, so I
think you can drop it.

>  
>  	case $FSTYP in
>  	btrfs)
> @@ -4452,6 +4455,15 @@ _get_device_size()
>  	echo $(($(blockdev --getsz $1) >> 1))
>  }
>  
> +_require_scratch_support_blocksize()
> +{
> +	local blocksize=$1
> +
> +	if [ $blocksize -lt $(blockdev --getss $SCRATCH_DEV) ]; then
> +		_notrun "$SCRATCH_DEV does not support a block size of $blocksize."

"block" is a bit vague in this context -- you mean the LBA size, not the
internal physical block size, right?

May I suggest "...does not support an LBA size of $blocksize." ?

--D

> +	fi
> +}
> +
>  # Make sure we actually have dmesg checking set up.
>  _require_check_dmesg()
>  {
> diff --git a/tests/ext4/055 b/tests/ext4/055
> index aa15cfe98..7025f6283 100755
> --- a/tests/ext4/055
> +++ b/tests/ext4/055
> @@ -27,6 +27,7 @@ echo "Silence is golden"
>  
>  # The 1K blocksize is designed for debugfs.
>  _exclude_scratch_mount_option dax
> +_require_scratch_support_blocksize 1024
>  _scratch_mkfs "-F -O quota -b 1024" > $seqres.full 2>&1
>  
>  # Start from 0, fill block 1 with 6，replace the original 2.
> diff --git a/tests/xfs/205 b/tests/xfs/205
> index 104f1f45a..84c099208 100755
> --- a/tests/xfs/205
> +++ b/tests/xfs/205
> @@ -23,6 +23,7 @@ _require_scratch_nocheck
>  unset SCRATCH_RTDEV
>  
>  fsblksz=1024
> +_require_scratch_support_blocksize $fsblksz
>  _scratch_mkfs_xfs -d size=$((32768*fsblksz)) -b size=$fsblksz >> $seqres.full 2>&1
>  _scratch_mount
>  
> diff --git a/tests/xfs/432 b/tests/xfs/432
> index 66315b039..2efa6230b 100755
> --- a/tests/xfs/432
> +++ b/tests/xfs/432
> @@ -50,6 +50,7 @@ echo "Format and mount"
>  # block.  8187 hashes/dablk / 248 dirents/dirblock = ~33 dirblocks per
>  # dablock.  33 dirblocks * 64k mean that we can expand a directory by
>  # 2112k before we have to allocate another da btree block.
> +_require_scratch_support_blocksize 1024
>  _scratch_mkfs -b size=1k -n size=64k > "$seqres.full" 2>&1
>  _scratch_mount >> "$seqres.full" 2>&1
>  
> diff --git a/tests/xfs/516 b/tests/xfs/516
> index 9e1b99317..65fc635dd 100755
> --- a/tests/xfs/516
> +++ b/tests/xfs/516
> @@ -23,6 +23,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs xfs
>  _require_scratch_nocheck
> +_require_scratch_support_blocksize 1024
>  
>  # Assume that if we can run scrub on the test dev we can run it on the scratch
>  # fs too.
> -- 
> 2.31.0
> 
