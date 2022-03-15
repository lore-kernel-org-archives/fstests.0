Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6276BC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Mar 2022 04:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiCOEDF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Mar 2022 00:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiCOEDF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Mar 2022 00:03:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E7347AE5
        for <fstests@vger.kernel.org>; Mon, 14 Mar 2022 21:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 95D1ACE1828
        for <fstests@vger.kernel.org>; Tue, 15 Mar 2022 04:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DF3C340E8;
        Tue, 15 Mar 2022 04:01:47 +0000 (UTC)
Message-ID: <de79517f-4fa6-c409-42d4-6187eb968e0e@oppo.com>
Date:   Tue, 15 Mar 2022 12:01:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [f2fs-dev] [PATCH v2] generic/066: attr1 is still there after log
 replay on f2fs
Content-Language: en-US
To:     Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org, guan@eryu.me
Cc:     jaegeuk@kernel.org, david@fromorbit.com,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220311094315.2476774-1-sunke32@huawei.com>
From:   Chao Yu <chao.yu@oppo.com>
In-Reply-To: <20220311094315.2476774-1-sunke32@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/3/11 17:43, Sun Ke via Linux-f2fs-devel wrote:
> The test fail on f2fs:
>       xattr names and values after second fsync log replay:
>       # file: SCRATCH_MNT/foobar
>      +user.attr1="val1"
>       user.attr3="val3"
> 
> attr1 is still there after log replay. f2fs doesn't support fs-op level
> transaction functionality. so it have no way to persist all metadata
> updates in one transaction.  We can use "fastboot" mountoption for this
> case, so during last fsync on qwerty, f2fs can trigger a checkpoint
> which will persist all metadata updates before fsync().
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>   tests/generic/066 | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tests/generic/066 b/tests/generic/066
> index 105a7acd..b8465101 100755
> --- a/tests/generic/066
> +++ b/tests/generic/066
> @@ -56,6 +56,14 @@ sync
>   $SETFATTR_PROG -x user.attr2 $SCRATCH_MNT/foobar
>   $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foobar
>   
> +# f2fs doesn't support fs-op level transaction functionality. so it have no way
> +# to persist all metadata updates in one transaction.  We can use "fastboot"
> +# mountoption for this case, so during last fsync on qwerty, f2fs can trigger a
> +# checkpoint which will persist all metadata updates before fsync().
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fastboot"

Can we merge "fastboot" with original mount options? and after the test, how about
recovering to original mount options?

Thanks,

> +fi
> +
>   _flakey_drop_and_remount
>   
>   # After the fsync log is replayed, the file should have only 2 xattrs, the ones
