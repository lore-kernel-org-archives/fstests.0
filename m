Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D4C32771
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 00:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIVA1w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Sep 2022 20:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIVA1v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Sep 2022 20:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4570AA8976
        for <fstests@vger.kernel.org>; Wed, 21 Sep 2022 17:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D49EC61F6E
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 00:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE1BC433D6;
        Thu, 22 Sep 2022 00:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663806470;
        bh=9FIOybtLGl+dofm5alUPM39DdeQpvgRbji2PEXfj8kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KkOJIfWY3dFm2C+gngp3TfAs0eLVVhJNvl9FJhhyEralN/KXzR4IOFISLQKtSXB7E
         XLbjrPbjmmqql1MLTH8BgVHqPM9Q/08anY9Hx6kRKo7N7BdrbRYNZqfVLN0fFYnDFq
         U++Ac6b1lhoGEGmphfWuBdshOuJqnWfF+7vnXcfsbSiyJtiMNcYjtPHFUmPMgjBa96
         +B7ugkCZ1CM2TXhycy9xpN/X360livQ3QKJkSEIig0lJL5M/0V13wv4ITudVo81c4t
         3AyZb8CIiNn/899k+CCnBrbpiTev28dbamWeqAXcjNPWxOf043QOAnWPNxtbRVxqWW
         /6aXiyi4Bn16Q==
Date:   Wed, 21 Sep 2022 17:27:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4 1/2] common: new helper to alloacate fixed size files
Message-ID: <YyusBYYvkBA0qEF4@magnolia>
References: <20220921141025.920599-1-preichl@redhat.com>
 <20220921141025.920599-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921141025.920599-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 21, 2022 at 04:10:24PM +0200, Pavel Reichl wrote:
> Helper that creates files of specified size using falloc if supported,
> otherwise pwrite is used.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  common/rc         | 22 ++++++++++++++++++++++
>  tests/generic/694 |  8 +++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index a25cbcd0..3d4587b7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4925,6 +4925,28 @@ hexdump()
>  	_fail "Use _hexdump(), please!"
>  }
>  
> +# Try to create a file with inode->i_blocks = $length. There may be some small

Nit: It's really trying to create a file with i_blocks >= (length/blocksize).

> +# overhead, e.g. ext2 filesystem allocates a substantial number of blocks
> +# to store block mappings. Those are accounted to i_blocks.
> +_create_file_sized()
> +{
> +	local length=$1
> +	local file=$2
> +	local tmp=`mktemp -u`
> +	local ret=0
> +
> +	$XFS_IO_PROG -ft -c "falloc 0 $length" $file >$tmp.out 2>&1
> +	ret=$?
> +	if (grep -Eq "Operation not supported|command .* not found" $tmp.out);then
> +		# fallocate isn't supported, fallback to general buffer write
> +		$XFS_IO_PROG -ft -c "pwrite 0 $length" $file >$tmp.out 2>&1
> +		ret=$?
> +	fi
> +	[ $ret -ne 0 ] && cat $tmp.out
> +	rm -f $tmp.out
> +	return $ret
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/generic/694 b/tests/generic/694
> index dfd988df..09fb9e71 100755
> --- a/tests/generic/694
> +++ b/tests/generic/694
> @@ -21,6 +21,9 @@ _cleanup()
>  }
>  
>  _supported_fs generic
> +_fixed_by_kernel_commit 0c336d6e33f4 \
> +	"exfat: fix incorrect loading of i_blocks for large file"
> +
>  _require_test
>  _require_fs_space $TEST_DIR $((4 * 1024 * 1024)) #kB
>  
> @@ -30,7 +33,10 @@ junk_dir=$TEST_DIR/$seq
>  junk_file=$junk_dir/junk
>  mkdir -p $junk_dir
>  
> -$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> +_create_file_sized 4G $junk_file
> +if [ $? -ne 0 ]; then
> +	echo "_create_file_sized failed"

echo "could not create 4G test file" ?

--D

> +fi
>  
>  iblocks=`stat -c '%b' $junk_file`
>  
> -- 
> 2.37.3
> 
