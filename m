Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB0C433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Oct 2022 14:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiJZOMg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiJZOMb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Oct 2022 10:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27C010D6BF
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666793548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gKSzBMGRs/uWtkQG1q7CTLEsgBVK2NaY8cijVYGGgA=;
        b=SsdcsQshSUju4lda+utv+7YdEhxq0gt9oSwTL48tXXjpoagJrInYiaZreUHq9s2FyNSqwD
        cDuBFmOne+QinjyLI1KIWGfQlY9nDRta++AWNNwh68OITjNaUGkgpZYfpLn2MhH6VYkqVe
        1Aoi9b1mFxPTguginsfTtZKCVLoYbVQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-XWW8WXTJO4ukMBm3E3J_Xw-1; Wed, 26 Oct 2022 10:12:26 -0400
X-MC-Unique: XWW8WXTJO4ukMBm3E3J_Xw-1
Received: by mail-pl1-f199.google.com with SMTP id z5-20020a170903018500b00184aedd9c75so10294970plg.11
        for <fstests@vger.kernel.org>; Wed, 26 Oct 2022 07:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gKSzBMGRs/uWtkQG1q7CTLEsgBVK2NaY8cijVYGGgA=;
        b=IDP2mKPkcaPXG5KNjH6gjO3Nz0Rt3EDfZOMd/cL09kRDFX272X+ht2zZNpB8ny2Zfk
         3Y7I4LX5b1pktcZ1WMIvTam+XfTMwWAGUlCN4WkcRnqKZfqpT35S5Wf86ynu2eO54lAA
         exxh0p+3rr1olcwRnW6Au9YyYkGNqZ/Nc8qSihMOfshsyQx80vtDHbssykAJfBf3XyNg
         /ug6AC0kA4cdHLovmzQAsfN9NpRc9E1SQQZ4wIflk9VqJu1ey2itVDuydx7w4XhqYBq2
         LONEFun9Q+YLOVc+ls3zBBJJVdKX5PhPix4i+g+0QHStnt1LLGjPnpyev6Tppu7d+KR/
         kUjQ==
X-Gm-Message-State: ACrzQf028tbqe7jhUaZuju+Ze1+9xYgQ0gp0rXdz9lcd2Q1hVrYDUdss
        RQWp2xHKtYHvCtBld1Mbuc2I0+TGNfv6LRz8er2e9r/Ns2ZysVNvxXMYcIsYYpPbLcR9Cj1JcQq
        fBjmpEo6BMMBZDvKdmQ==
X-Received: by 2002:a17:903:32cb:b0:186:deec:cd9f with SMTP id i11-20020a17090332cb00b00186deeccd9fmr2522040plr.82.1666793545112;
        Wed, 26 Oct 2022 07:12:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4vts4EIwMBrmcHQRDKwEWtkUdrUle9EHgYf9L9DAWDrNkCRpJjiebCyFeiTGY78iIplYU9sA==
X-Received: by 2002:a17:903:32cb:b0:186:deec:cd9f with SMTP id i11-20020a17090332cb00b00186deeccd9fmr2522017plr.82.1666793544785;
        Wed, 26 Oct 2022 07:12:24 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r17-20020a63ce51000000b0041a6638b357sm2854822pgi.72.2022.10.26.07.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:12:24 -0700 (PDT)
Date:   Wed, 26 Oct 2022 22:12:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
        lhenriques@suse.de, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        mchangir@redhat.com
Subject: Re: [PATCH 2/2] encrypt: add ceph support
Message-ID: <20221026141218.wg2h3ganvo2dx7hb@zlang-mailbox>
References: <20221026070418.259351-1-xiubli@redhat.com>
 <20221026070418.259351-3-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026070418.259351-3-xiubli@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 26, 2022 at 03:04:18PM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> For ceph we couldn't use the mkfs to check whether the encryption
> is support or not, we need to mount it first and then check the
> 'set_encpolicy', etc.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  common/encrypt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/common/encrypt b/common/encrypt
> index fd620c41..e837c9de 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -153,6 +153,23 @@ _scratch_check_encrypted()
>  		# erase the UBI volume; reformated automatically on next mount
>  		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
>  		;;
> +	ceph)
> +		# Try to mount the filesystem. We need to check whether the encryption
> +		# is support or not via the ioctl cmd, such as 'set_encpolicy'.
> +		if ! _try_scratch_mount &>>$seqres.full; then
> +			_notrun "kernel is unaware of $FSTYP encryption feature," \
> +				"or mkfs options are not compatible with encryption"
> +		fi
> +
> +		mkdir $SCRATCH_MNT/tmpdir
> +		if _set_encpolicy $SCRATCH_MNT/tmpdir 2>&1 >>$seqres.full | \
> +			grep -Eq 'Inappropriate ioctl for device|Operation not supported'
> +		then
> +			_notrun "kernel does not support $FSTYP encryption"
> +		fi
> +		rmdir $SCRATCH_MNT/tmpdir
> +		_scratch_unmount

As I replied in patch 1/2, this function is a mkfs function, if ceph need a
specific mkfs way, you can do it in this function, or you even can keep it
empty

  ceph)
	;;

Or does a simple cleanup

  ceph)
	_scratch_cleanup_files
	...
	;;

I'm not familar with ceph, that depends on you. But the change in this patch is
not "mkfs", it's a checking, checking if the current $SCRATCH_MNT supports
encryption, you should do it in other function which does that checking job, not
change a mkfs function to be a check function.

Thanks,
Zorro

> +		;;
>  	*)
>  		_notrun "No encryption support for $FSTYP"
>  		;;
> -- 
> 2.31.1
> 

