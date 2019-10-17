Return-Path: <SRS0=KSdQ=YK=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E7ECE58E
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E51520869
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Oct 2019 09:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dV7wvvEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfJQJTM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:19:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43937 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfJQJTM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Oct 2019 05:19:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so1239107pfo.10
        for <fstests@vger.kernel.org>; Thu, 17 Oct 2019 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6yq3YcFgWVA75Nk82/UG5GxdaowbwFyqDOV0+1rMbCQ=;
        b=dV7wvvEksGlN3tiw03sf8V2H5lx01sSxA89Zt4t0W7UAp1a7WPh/RADuDnZGZdMBut
         6oshuubNitxNT8hAkbl31PUrxNkqzycrqf5npnKe/sbi+xvvP2bwgIis16wCnL29NQly
         QZK3Axzz3BEmHl3D4RSOmXYr+yR5dMuvzZBnvMZltgpUZK6igVB95l9smmd9rzO7OlxL
         O5ggh7l8d31rY0Btg+XJOTMtRTv0VoqEl8Hndr2pxOfBwJ18OQK3vjmnz69cFn4p4G5H
         QJpBTBCrhK4hFNz9sLiG1kGx4LltBrkHQRa7xq5fRXBWob4z5hiZcwzbE3dX0fdpaEVz
         NBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6yq3YcFgWVA75Nk82/UG5GxdaowbwFyqDOV0+1rMbCQ=;
        b=dG3FNd3E8wSkGK5L7i7o4t0yCyIuhbq3RujNZc+GuaMAqtmsmtsmm7SznXkEyldmST
         25EOxZT9LyWQuEUR+hES4W+KSa4HiLObDVLktBBsT+hOtWHMFEQazH5R6Hre6rOa1YKx
         +ZiWsBgfZXMt/McOvSTqFpEGa1LUQKGIXTqop0Hjse65SMgbo0crp/H4A7MkgRyGfkrl
         QOGyVPga7QPGYz4p7o18f82IL25W88ebGma3d7BBfqcthTgrKJPlECDDvCNWYw+VFYEq
         GVB7ij67TnH0QZloH8FSIsZnXaZF4WdYyIh0cdMLtM6tnCSCPH9mgCZSFnkxcplSCCCo
         5whQ==
X-Gm-Message-State: APjAAAWedS+CccnqrLnVqOivBkcwbZa+hrNk545BQIAJQ31s+8dl+Qp6
        hrULvQIqUoiSwmpatYmMFcs=
X-Google-Smtp-Source: APXvYqyRajZ39mmFYuOcfy9Dt2T9IX7pTmyMU814Z8bEoG5IjO746JzisRZDIq91MfUVTPlqbxLrXw==
X-Received: by 2002:a63:e055:: with SMTP id n21mr2944737pgj.411.1571303951294;
        Thu, 17 Oct 2019 02:19:11 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id k124sm1666639pga.83.2019.10.17.02.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 02:19:10 -0700 (PDT)
Date:   Thu, 17 Oct 2019 17:19:03 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     darrick.wong@oracle.com, ebiggers@google.com, yi.zhang@huawei.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH xfstests v2] common/rc: Add path $here before
 src/t_dir_type
Message-ID: <20191017091856.GI2622@desktop>
References: <1571188500-82985-1-git-send-email-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571188500-82985-1-git-send-email-chengzhihao1@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 16, 2019 at 09:15:00AM +0800, Zhihao Cheng wrote:
> Running generic/192 with overlayfs(Let ubifs as base fs) yields the
> following output:
> 
>   generic/192 - output mismatch
>      QA output created by 192
>      sleep for 5 seconds
>      test
>     +./common/rc: line 316: src/t_dir_type: No such file or directory
>      delta1 is in range
>      delta2 is in range
>     ...
> 
> When the use case fails, the call stack in generic/192 is:
> 
>   local unknowns=$(src/t_dir_type $dir u | wc -l)	common/rc:316
>   _supports_filetype					common/rc:299
>   _overlay_mount					common/overlay:52
>   _overlay_test_mount					common/overlay:93
>   _test_mount						common/rc:407
>   _test_cycle_mount					generic/192:50
> 
> Before _test_cycle_mount() being invoked, generic/192 executed 'cd /'
> to change work dir from 'xfstests-dev' to '/', so src/t_dir_type was not
> found.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks for the patch! But I think it's better to fix all similar issues
in the whole fstests tree, I can see there're a lot more tests use
src/<file> without the $here prefix.

Thanks!

Eryu

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index cfaabf10..28c27975 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -313,7 +313,7 @@ _supports_filetype()
>  		local testfile=$dir/$$.ftype
>  		touch $testfile
>  		# look for DT_UNKNOWN files
> -		local unknowns=$(src/t_dir_type $dir u | wc -l)
> +		local unknowns=$($here/src/t_dir_type $dir u | wc -l)
>  		rm $testfile
>  		# 0 unknowns is success
>  		return $unknowns
> -- 
> 2.13.6
> 
