Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C20EC61DA4
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Feb 2023 13:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBXNlu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Feb 2023 08:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXNlt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Feb 2023 08:41:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99AF57D29
        for <fstests@vger.kernel.org>; Fri, 24 Feb 2023 05:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677246061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vxAeGMcximnxeonxM9d/wdloov2nu6QekQgZrg7SflU=;
        b=hGSLyubEt9bWzxTSsi5sS39FU+fTCEJlZVx64UHzqQOgq938Et/VyI/4TsO6x64EzAd3DN
        Z/uePEy8pF32lAST2Gh8ec5UlaMjsDzY23IaAVd1+3OK3D1javA1oA7sy04BtCa8DAVGMh
        fT2xZ42exC930EpUdguc/jr89yZ0K9c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-rL5PtQ94PoGCCguMmLSUNw-1; Fri, 24 Feb 2023 08:41:00 -0500
X-MC-Unique: rL5PtQ94PoGCCguMmLSUNw-1
Received: by mail-pj1-f69.google.com with SMTP id m18-20020a17090a7f9200b002375a3cbc9bso2313879pjl.9
        for <fstests@vger.kernel.org>; Fri, 24 Feb 2023 05:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxAeGMcximnxeonxM9d/wdloov2nu6QekQgZrg7SflU=;
        b=s9urJI0QXW24rGMxx6FwQl0Hb1vGEEcsUHjbC75nYCbddxOvOtogkMqmkMSwQXYqTL
         Q66K6KeOorUp7Zq8G51NhHYqFrhgKk3bAeP63RqxOXrs76rm/NgrBdB+mqSaKrb8ZHrt
         nEnZiC1WYLZkwdvAS8aCcOEVA7KePdcls3IuugSfLFvpET/sX8Wmbg4xtU1BfIzuwVMe
         ykcntx9rc/Q7v7zuK4F3pUDlSWp9fNwBFaTy2orZpRevLq+pZGuS26RuZUIlO5GgNAqZ
         EufZWVgbfTpScLvZ9ZcSI3kMjCJGtmZx4TnpVPEi5qO4IwJjqJYUxSrERwHX/WFEqzEi
         HvMA==
X-Gm-Message-State: AO0yUKV9YtFO/QVQsA3zgReNws/mQXa65ERVFNH5ORxRsIR5Wx/UWUq0
        Qx84kX8t7RdI5Impx4R+RyANPfBIyguzfoWdkL+v5WGB1TFWRLGFwOj4PM2rlYId/Mq7SYCEake
        ez6Oh3H8aKtw5zmdwnA==
X-Received: by 2002:a62:4e8e:0:b0:5d6:4ef8:8c6f with SMTP id c136-20020a624e8e000000b005d64ef88c6fmr7142031pfb.34.1677246059282;
        Fri, 24 Feb 2023 05:40:59 -0800 (PST)
X-Google-Smtp-Source: AK7set/y+MHXwPlwrjf+nzTJ6g1sSpCwpvKaE0z9xrGVABaKnz7tvMDOhR85LkevjZrQJO+cte9VvQ==
X-Received: by 2002:a62:4e8e:0:b0:5d6:4ef8:8c6f with SMTP id c136-20020a624e8e000000b005d64ef88c6fmr7142016pfb.34.1677246058830;
        Fri, 24 Feb 2023 05:40:58 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y5-20020a62b505000000b005df0c2b1b6asm2588383pfe.153.2023.02.24.05.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:40:57 -0800 (PST)
Date:   Fri, 24 Feb 2023 21:40:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: don't clear superblock for zoned scratch pools
Message-ID: <20230224134054.62lcl5tcqqitsxbr@zlang-mailbox>
References: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 23, 2023 at 07:40:35AM -0800, Johannes Thumshirn wrote:
> _require_scratch_dev_pool() zeros the first 100 sectors of each device to
> clear eventual remains of older filesystems.
> 
> On zoned devices this creates all sorts of problems, so just skip the
> clearing there.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 654730b21ead..d763501be2b2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3461,7 +3461,9 @@ _require_scratch_dev_pool()
>  		fi
>  		# to help better debug when something fails, we remove
>  		# traces of previous btrfs FS on the dev.
> -		dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		if [ "`_zone_type "$i"`" = "none" ]; then
> +			dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +		fi

Better to add some comments to explain why we need to check
[ "`_zone_type "$i"`" = "none" ] at here, even if only copy
your git commit log at here.

>  	done
>  }
>  
> -- 
> 2.39.1
> 

