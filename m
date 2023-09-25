Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A9CE7A94
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Sep 2023 14:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjIYOz4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Sep 2023 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjIYOz4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Sep 2023 10:55:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F8710A
        for <fstests@vger.kernel.org>; Mon, 25 Sep 2023 07:55:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37932C433C8;
        Mon, 25 Sep 2023 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695653749;
        bh=iJIofJstftPKYBdeSkKT90LwhbTDmzNkCCWebwAUp5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BX3yYlVObPUnnIQhMa9j4lNJncLVVMcqqIDO4lUTE3nOIZGGT4wwQV1WO5tg68DD8
         j9HYpXPlDSlKyatNoChKb9ifFbGA3WbIRjNu5Gm3O/T1olzvumGBspkqDSdj9pl6A/
         r+5RmxaNRHxOE5FdTobcvOpPTu1mMBcKDs+ODiHJHlbW4PL8QfZHO/OO7P8ng7dyyt
         WHKnYSxDIIrsCf4/HiSYkGXlmCs5BaEoZLQx0O/SuZc3Xy2x94qd7y3p9vK6n2uyCR
         Egki1wn6sX9gLvMpBmE0nOKOqdsYQErVjK3Dyk4IqzU6i6dY1rMSPEq2SIsY4bvMyx
         D/iOE69gzSCHQ==
Date:   Mon, 25 Sep 2023 07:55:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chandan Babu R <chandanbabu@kernel.org>
Cc:     fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH] _scratch_mkfs_geom: Fix regex used for matching block
 size option
Message-ID: <20230925145548.GA11423@frogsfrogsfrogs>
References: <20230925134805.1559201-1-chandanbabu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925134805.1559201-1-chandanbabu@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 25, 2023 at 07:18:05PM +0530, Chandan Babu R wrote:
> The regular expression used by _scratch_mkfs_geom() to match mkfs.xfs' block
> size argument interprets the character 'b' as optional. It should actually
> interpret whitespace as optional.
> 
> This causes generic/223 to fail when testing an XFS filesystem which uses an
> external log device along with the -lsize option. In this case, the original
> value of -lsize is replaced with the value of $blocksize.
> 
> _scratch_mkfs_sized() also uses the same incorrect regex.
> 
> Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

Heh. :(
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed..991a5731 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -971,7 +971,7 @@ _scratch_mkfs_sized()
>  	case $FSTYP in
>  	xfs)
>  		# don't override MKFS_OPTIONS that set a block size.
> -		echo $MKFS_OPTIONS |grep -E -q "b?size="
> +		echo $MKFS_OPTIONS |grep -E -q "b\s*size="
>  		if [ $? -eq 0 ]; then
>  			_scratch_mkfs_xfs -d size=$fssize $rt_ops
>  		else
> @@ -1063,8 +1063,8 @@ _scratch_mkfs_geom()
>  
>      case $FSTYP in
>      xfs)
> -	if echo "$MKFS_OPTIONS" | grep -E -q "b?size="; then
> -		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r "s/(b?size=)[0-9]+k?/\1$blocksize/")
> +	if echo "$MKFS_OPTIONS" | grep -E -q "b\s*size="; then
> +		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r "s/(b\s*size=)[0-9]+k?/\1$blocksize/")
>  	else
>  		MKFS_OPTIONS+=" -b size=$blocksize"
>  	fi
> -- 
> 2.39.1
> 
