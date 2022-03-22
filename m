Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126EAC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 05:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiCVFYb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 01:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbiCVFYa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 01:24:30 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A9F12AF2
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 22:23:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A91D210E4CB8;
        Tue, 22 Mar 2022 16:23:00 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nWWyx-008OSE-Cn; Tue, 22 Mar 2022 16:22:59 +1100
Date:   Tue, 22 Mar 2022 16:22:59 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 1/2] xfstests: replace hexdump with od command
Message-ID: <20220322052259.GC1609613@dread.disaster.area>
References: <20220321110341.1323882-1-zlang@redhat.com>
 <20220321110341.1323882-2-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321110341.1323882-2-zlang@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=62395d35
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=gaCFx0GJ2BoOlcL2CtsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 21, 2022 at 07:03:40PM +0800, Zorro Lang wrote:
> The "od" is one of the most fundamental commands in GNU/Linux and
> most Unix-like systems. So we nearly always can count on it, don't
> need to check if it's installed.
> 
> The "hexdump" isn't such fundamental as "od", some systems don't
> install it by default. And as "od" nearly can replace all functions
> of "hexdump", so let's use an unified command "od" to do the hexdump
> job in fstests cases.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

> ---
> 
> Hi,
> 
> As Dave and Darrick suggested, I did this change, I've tested most of cases,
> except f2fs/001 and ceph/002, but I think they're good. And I used "od"
> command directly in generic/404 and generic/042 for their special reason.

That generic/404 usage is ... strange. Why record md5sums of the
encoded hexdump output of the file when you can just run md5sum on
the file directly and get the same information?  i.e.

> diff --git a/tests/generic/404 b/tests/generic/404
> index f1e8b0a8..939692eb 100755
> --- a/tests/generic/404
> +++ b/tests/generic/404
> @@ -110,7 +110,7 @@ for (( block=3; block<=500; block++ )); do
>  	# or blocks are in correct order, this commit:
>  	#   2b3864b32403 ("ext4: do not polute the extents cache while shifting extents")
>  	#
> -	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
> +	md5=`od -An -c $testfile | md5sum`
>  	printf "#%d %s\n" "$block" "$md5"

Why isn't this just:

-	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
-	printf "#%d %s\n" "$block" "$md5"
+	echo -n "#$block "
+	md5sum $testfile | _filter_test_dir

Seperate patch, perhaps?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
