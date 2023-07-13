Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB910C001DE
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 20:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjGMUak (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjGMUak (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2023 16:30:40 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4D02127
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 13:30:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a3a8d21208so1056740b6e.0
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689280238; x=1691872238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39txpBUCcuQ3c4p8/ix9ZxwfJot9Kz+g+t+rd2IqFAQ=;
        b=uv4uVM+P3aHmx9uKsi6ws9E4z2dlHpLa8W0i/V2IOfOjWqsiYoWum+C2zIl9Q+kNei
         U18sdQsnRV2RToymORiCiQrK0qZZ6USjHNjyAkkU5Z34492s2R78yRqW7JQFYKFQc84q
         w3gOxheowgpXJSzd1ZBN6aedV9+oz2WbYUnhyLXqj0hnQvNN1Coz/ieuhP/DCJ/S55s1
         rodosfmOWBJq6KRBaF5a9GyGFbK0tULm6zdHjhh/dlbDqw9ZiCCtbXnc1ZXNjzCDjuwj
         C3RuSQZ/8yd7Jq/tpe1Tg3RQRcrJnInJvrhee4kRCjuOB9Aq7CNaUfIC2NONjcPNV2wt
         0/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280238; x=1691872238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39txpBUCcuQ3c4p8/ix9ZxwfJot9Kz+g+t+rd2IqFAQ=;
        b=mCEDfwqmeBvGkK6syIdeYNocr1hc5SNy/4NbJFJjzDPH9AYElGC+aYroUX77BNtIb9
         Y4qoBRAiD45T9InBCUkfJbfgF6SG9M1EhA+Xxb4yJ6Ie4DmAZtqmb1IQideodikTKTA5
         c0ZFzuma6IGY6ah8RNEqoDNFGD+2L+QdYf+eVtK1UZPTV7cL1TtI2/PGNfcnSDm2bvL3
         jTpw0pOIgOCUQjklIJjiOkbVBzbM6C93kzfw0J0n1vIDIj9pk5U+3zcDjbicDe0yW5XI
         WI9G3/hjbaz4RFIOSLV+peKODoyTmjxiMupfM+HutS7+mU+m9lmS5Tx1cA629PTcU3PV
         CNcw==
X-Gm-Message-State: ABy/qLaj5i/yFlooUXhjKZCv+Yg+5S3wH14EXW//UQU1nF83bWdFXADN
        vERjR3Rps6PXWneTIuSl9ZOxcQ==
X-Google-Smtp-Source: APBJJlGvMD7joi4RHqcoLsfdAhZ8wScit7IjAs6MuwPBUK0GiC6HLcDRlYLJEvP/bLtrUpKbyvpKFw==
X-Received: by 2002:a05:6808:1308:b0:3a1:df16:2eed with SMTP id y8-20020a056808130800b003a1df162eedmr3853143oiv.30.1689280237920;
        Thu, 13 Jul 2023 13:30:37 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q9-20020a25f909000000b00c6135ffd2fcsm1498906ybe.15.2023.07.13.13.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:30:37 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:30:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH 3/5] common/btrfs: quota rescan helpers
Message-ID: <20230713203036.GA207541@perftesting>
References: <cover.1688600422.git.boris@bur.io>
 <0e9cb76f3ddad71bb36b70464b62423b77fd6399.1688600422.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9cb76f3ddad71bb36b70464b62423b77fd6399.1688600422.git.boris@bur.io>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 05, 2023 at 04:42:25PM -0700, Boris Burkov wrote:
> Many btrfs tests explicitly trigger quota rescan. This is not a
> meaningful operation for simple quotas, so we wrap it in a helper that
> doesn't blow up quite so badly and lets us run those tests where the
> rescan is a qgroup detail.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  common/btrfs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 66c065a10..d88feaded 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -715,6 +715,31 @@ _qgroup_mode()
>  	fi
>  }
>  
> +_check_regular_qgroup()
> +{
> +	local mnt=$1
> +
> +	_qgroup_mode $mnt | grep -q 'qgroup'
> +}
> +
> +_qgroup_rescan()
> +{
> +	local mnt=$1
> +
> +	_check_regular_qgroup $mnt || return 1
> +	_run_btrfs_util_prog quota rescan -w $mnt
> +}
> +
> +_require_qgroup_rescan()
> +{
> +	_scratch_mkfs >>$seqres.full 2>&1
> +	_scratch_mount
> +    _run_btrfs_util_prog quota enable $SCRATCH_MNT
> +    $BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT || \
> +         _notrun "not able to run quota rescan"
> +	_scratch_unmount
> +}

Looks like whitespace errors here.  Thanks,

Josef
