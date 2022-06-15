Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C2DC43334
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jun 2022 06:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiFOGFs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243583AbiFOGFr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Jun 2022 02:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67BBE275F2
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 23:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655273137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3y5S8PqPHCj8v8Ds7+WPvzQmxRX4wMllfGS5pyz4dSY=;
        b=KEHdLm3JtQImqqTxPnFhz2HI3VSCNTyMaBwJKbKPT2z1GQ5J31XDfXTFirqHq6LlHuBuwD
        e5HJH2MPq8sug6jIWS6BD7+QS1wVBOV2Zv4E26O3oZ7o0Zzwy96fdXLDlfvFKylGzYpOth
        AmMoZa8yERlmzf9KhYkVFgBaqrfVpQc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-V0YNMdr9PxCXUDBS4yj0og-1; Wed, 15 Jun 2022 02:05:35 -0400
X-MC-Unique: V0YNMdr9PxCXUDBS4yj0og-1
Received: by mail-qt1-f198.google.com with SMTP id j8-20020ac85f88000000b0030515acf391so8319332qta.2
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 23:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3y5S8PqPHCj8v8Ds7+WPvzQmxRX4wMllfGS5pyz4dSY=;
        b=ay+nj4//z7ifizG3tfyIqBCl3DfIlukjCHUN6zlif5STH082gv61OOQyqzQn6pIpqf
         rAlI6IDiXHZOWVTgtRvVGMBzlzsaUAxpf1F1sv4beJ6dBBKDYv4KlcGFF0ztwxE8rxE2
         AsXILineOMkmv1weOkdX+zeSG+ZiIsluicHIMEGkBelFYTI44uhxrznXsIwa0I02wTYs
         HI4OLF3e26AvqXQqFhUDXkAsnGGZSJq34vt3ZCY73PPcX2jMFpn5/JUGrvUJqEW76JmG
         LPcacjjpIgMe5aH+/W+gwhxxo5nJVchAEhZY8MCWjXojTyNSmJsbWWR0cmyyWmPfaixU
         iBfA==
X-Gm-Message-State: AJIora8Q9BHoek5lrB22lVo0F5iykYRORaNCjeCS3kf3QSvMRWOK/wSp
        xS7Dc8M3eC20J8sEmDZRSk9ioeBi9Q/tO15Xyk7tbvyc9DBUTzcLRUaoZtG5/6aZFRwoM3j6Vit
        yAOhH8j2VNPAg1KM1ug==
X-Received: by 2002:a05:6214:5293:b0:46b:b72a:e830 with SMTP id kj19-20020a056214529300b0046bb72ae830mr6682485qvb.82.1655273135041;
        Tue, 14 Jun 2022 23:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tzDwAEJ7Y5IeYvW2DCQneBUWbaRztOZ1I0vIv5v6aS34OkIgBHCsbu65Q3/t13RUoUZDt9eg==
X-Received: by 2002:a05:6214:5293:b0:46b:b72a:e830 with SMTP id kj19-20020a056214529300b0046bb72ae830mr6682479qvb.82.1655273134811;
        Tue, 14 Jun 2022 23:05:34 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f11-20020ac859cb000000b00304dec6452csm8901863qtf.78.2022.06.14.23.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 23:05:34 -0700 (PDT)
Date:   Wed, 15 Jun 2022 14:05:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/rc: add _parse_size_from_string
Message-ID: <20220615060528.svv63plztw3rjm3m@zlang-mailbox>
References: <20220614050843.11802-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614050843.11802-1-lan@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 14, 2022 at 01:08:42PM +0800, An Long wrote:
> Add a helper to convert size value to bytes. This is used to handle
> value as bytes, such as 4k to 4096.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  common/rc | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 3c072c16..22050bc2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1028,6 +1028,54 @@ _check_minimal_fs_size()
>  	fi
>  }
>  
> +# Convert size value to bytes
> +# _parse_size_from_string <size>
> +_parse_size_from_string()

I think this name is better to be shorter, as it might be a lower level common
function. How about _convert_num() or _cvtnum()?

> +{
> +        local str=$1
> +        local mult=1
> +        local size
> +        local endchar
> +
> +        if [[ $str =~ ^[0-9]+[a-zA-Z]$ ]] ; then
> +                size=${str:: -1}
> +                endchar=${str: -1}
> +                case $endchar in
> +                e|E)
> +                                mult=$(($mult * 1024))
> +                                ;&
> +                p|P)
> +                                mult=$(($mult * 1024))
> +                                ;&
> +                t|T)
> +                                mult=$(($mult * 1024))
> +                                ;&
> +                g|G)
> +                                mult=$(($mult * 1024))
> +                                ;&
> +                m|M)
> +                                mult=$(($mult * 1024))
> +                                ;&
> +                k|K)
> +                                mult=$(($mult * 1024))
> +                                ;&
> +                b|B)
> +                                ;;
> +                *)
> +                                echo "unknown size descriptor $endchar"
> +                                exit 1
> +                esac
> +        elif [[ $str =~ ^[0-9]+$ ]] ; then
> +                size=$str
> +        else
> +                echo "size value $str is invalid"
> +                exit 1
> +        fi
> +
> +        size=$(($size * $mult))
                   ^       ^
I think above two '$' isn't necessary, although it doesn't make something
wrong if keep it. Same as all above (($mult * 1024)) .

Thanks,
Zorro
                                      ^

> +        echo $size
> +}
> +
>  # Create fs of certain size on scratch device
>  # _scratch_mkfs_sized <size in bytes> [optional blocksize]
>  _scratch_mkfs_sized()
> -- 
> 2.35.3
> 

