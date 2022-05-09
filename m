Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E86C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  9 May 2022 15:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbiEIPVy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 May 2022 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiEIPVx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 May 2022 11:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08252218CC
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 08:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E70261122
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 15:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981D4C385AE;
        Mon,  9 May 2022 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652109478;
        bh=Ua6myR+9TgSBYEdLTX8DVmr5hCyAyAozsiXOCXh3PVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSLKsOZrlMHGudg3TymOw7OBBAAUMSL6cxlCnnySLeKojJzYrgEc6T/zGdLTiQQOP
         fuaaBSfpevSFc0Ba0f9rqWjp8Frf1XSwSI2f2UoB/vZ/y/B3j/RCpfZOmvCNtqJoI6
         HRkq2/xd6oiIHwph1evM55InVZPhzlsm0Is1wSvs+Jrjlssjkhnc2DImeKcY9YNIBT
         i0L8BkOAmBNJzZxNsGHDevN9ToaaYz94GZBI+D9iDV+8wz4JyAEdJjSTxNSvIZpCtR
         3KrnI0Wh23IfuvI5kqEq3kcucjDJR9GdB9nw9hOU5riGATplrV2uDE3kz75dmIo+mS
         Z54QzPi2e1mYA==
Date:   Mon, 9 May 2022 23:17:53 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, amir73il@gmail.com
Subject: Re: [RFC v2 2/2] common: correct overlay+tmpfs cycle_mount
Message-ID: <20220509151753.6ot6vtbzajl354j2@zlang-mailbox>
Mail-Followup-To: Baokun Li <libaokun1@huawei.com>, fstests@vger.kernel.org,
        zlang@redhat.com, amir73il@gmail.com
References: <20220507094524.949615-1-libaokun1@huawei.com>
 <20220507094524.949615-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507094524.949615-3-libaokun1@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 07, 2022 at 05:45:24PM +0800, Baokun Li wrote:
> overlay+tmpfs cycle_mount should be like tmpfs cycle_mount,
> otherwise some test cases may have issue like "xxx: No such file or directory".

If the 1st patch brings in an issue, then have to fix it in the 2nd patch,
I'd like to merge them into one completed patch. And these two patches are
not big, so it might be fine to do that and send again.

As Amir has given you some review points from overlayfs side, this part might
affect him more. So I'd like to wait a few days, if no reponse from him or
others, I'll give your patch my personal RVB, and merge it if test passed.

Thanks,
Zorro

> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  common/rc | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 553ae350..ca465438 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -410,10 +410,19 @@ _scratch_cycle_mount()
>  {
>      local opts="$1"
>  
> -    if [ "$FSTYP" = tmpfs ]; then
> -	_scratch_remount "$opts"
> -	return
> -    fi
> +	case "$FSTYP" in
> +	tmpfs)
> +		_scratch_remount "$opts"
> +		return
> +		;;
> +	overlay)
> +		if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
> +			_scratch_remount "$opts"
> +			return
> +		fi
> +		;;
> +	esac
> +
>      if test -n "$opts"; then
>  	opts="-o $opts"
>      fi
> @@ -522,9 +531,17 @@ _test_unmount()
>  
>  _test_cycle_mount()
>  {
> -    if [ "$FSTYP" = tmpfs ]; then
> -	return
> -    fi
> +	case "$FSTYP" in
> +	tmpfs)
> +		return
> +		;;
> +	overlay)
> +		if [ "$OVL_BASE_FSTYP" = tmpfs ]; then
> +			return
> +		fi
> +		;;
> +	esac
> +
>      _test_unmount
>      _test_mount
>  }
> -- 
> 2.31.1
> 
