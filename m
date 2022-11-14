Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1484C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Nov 2022 14:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiKNO6Q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Nov 2022 09:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbiKNO5x (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Nov 2022 09:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A786F1BEA1
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668437823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnJeNBbkFDqVK7FuYTaPwZSP/3h9xze9dcrRnZF+i1I=;
        b=fN0lsseks7hhJovQBzmHEAqsYhS6XXXC6+TW71piIFWz35S3UG6SAXKTRMI+7+Ggwuna1Z
        6a+sRyMklesLyNpppUHRVCUf/g4Y3eUoefHYdPvrOBekEoXbjtWTA8blRyty5MMb9+pDSi
        a9InoJszrUUIoER0wHraX5G4tMyTQFg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-JuaSYf6XNv-a0lf0UnOy-Q-1; Mon, 14 Nov 2022 09:57:02 -0500
X-MC-Unique: JuaSYf6XNv-a0lf0UnOy-Q-1
Received: by mail-qv1-f72.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso8645321qvb.23
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 06:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnJeNBbkFDqVK7FuYTaPwZSP/3h9xze9dcrRnZF+i1I=;
        b=mH4Rhfr3MGujeqWcOz7q651MC3o/0ZuHWIdSsBvJA88V/wYZgMKUINmfL3tAqPeE9p
         N39Ii6RwXA5zynht5qSGW8FqDVb6x00H07fwGF+cDP44HBQdKl6fwPp6n337DuBXP3rl
         6r/oQLu2MARkbu2ITe2jGE2MfujsYZqNi57d3ugu6XELbSS9w1EFNq7a77Ec1Na4xKK1
         hmPLuDt8nsOJNtF2lSHNAM3lrW5jaBKyf2ZQJmeQ6gntKF29KLRxIcSBhHCxJTXwBMRU
         v1NRAejiPappLb3/Bf4+1F043AQi/QoF5tJW9HwCH3kpWKq8+tW683uOHz0KRALp/2PI
         3SAQ==
X-Gm-Message-State: ANoB5pklq7fHj51zotl1zLt3q5yhBULrVBvZkr1mA1vXVMLzVv33+eIb
        a6w4cY7Ih4knnNMVl43Sbba5IWIjXgvdHc3MEGmRH6bn21mm2iP0FfQPodfu/GoSiMQ5ejeSM0b
        bO50BxJ3YcVka/wtydQ==
X-Received: by 2002:a05:620a:79b:b0:6fa:1032:10a1 with SMTP id 27-20020a05620a079b00b006fa103210a1mr11265339qka.167.1668437822025;
        Mon, 14 Nov 2022 06:57:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7+7bfbn9WprnRT62uoL1HgMrwCaAvtjPCkfpySC786akkJWIQJAndh8G8Eq87oqOpWgs2EiA==
X-Received: by 2002:a05:620a:79b:b0:6fa:1032:10a1 with SMTP id 27-20020a05620a079b00b006fa103210a1mr11265318qka.167.1668437821740;
        Mon, 14 Nov 2022 06:57:01 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o5-20020ac87c45000000b003a494b61e67sm5776680qtv.46.2022.11.14.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:57:01 -0800 (PST)
Date:   Mon, 14 Nov 2022 22:56:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     djwong@kernel.org, fstests@vger.kernel.org, bfoster@redhat.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH v2 1/2] common/dmlogwrites: Extend _log_writes_init() to
 accept the specified length
Message-ID: <20221114145656.cn5bnvllpwaud2px@zlang-mailbox>
References: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 14, 2022 at 08:35:02AM +0000, Xiao Yang wrote:
> It is unnecssary to always create a dm-log-writes device
> based on the entire size of the target/underlying device.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---

Darrick has given his RVB [1]:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

I think you can keep it in this V2 patch.

Thanks,
Zorro

[1]
https://lore.kernel.org/fstests/Y3EvUgtux4tP1tdY@magnolia/T/#m83b97790ba6570874f36cd0601747e1b6b155de2

>  common/dmlogwrites | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 9fa1c977..c1c85de9 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -59,14 +59,28 @@ _require_log_writes_dax_mountopt()
>  	fi
>  }
>  
> +# Set up a dm-log-writes device
> +#
> +# blkdev: the specified target device
> +# length(optional): the mapped length in bytes
> +# Note that the entire size of the target device will be used
> +# if length is not specified.
>  _log_writes_init()
>  {
> -	blkdev=$1
> +	local blkdev=$1
> +	local length=$2
> +	local BLK_DEV_SIZE
>  
>  	[ -z "$blkdev" ] && _fail \
>  	"block dev must be specified for _log_writes_init"
>  
> -	local BLK_DEV_SIZE=`blockdev --getsz $blkdev`
> +	if [ -z "$length" ]; then
> +		BLK_DEV_SIZE=`blockdev --getsz $blkdev`
> +	else
> +		local blksz=`blockdev --getss $blkdev`
> +		BLK_DEV_SIZE=$((length / blksz))
> +	fi
> +
>  	LOGWRITES_NAME=logwrites-test
>  	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
>  	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $blkdev $LOGWRITES_DEV"
> -- 
> 2.34.1
> 

