Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD0C61DA4
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Feb 2023 15:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjBIPMp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjBIPMo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Feb 2023 10:12:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDE234C35
        for <fstests@vger.kernel.org>; Thu,  9 Feb 2023 07:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675955515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HoCadHE3I4v3OxNeHj9dxKevMpJTtgaUlsOu3Rjf5Ow=;
        b=cGjYfMULOLt02mJTxK0djxqBvvQYPHwAdKHwQAIr0yChKsQaDUtFlr8nRPf2NaApw/oH+o
        RgLkgJsHqJ4tz/WBx2UQI1PeyX0Ik5Cf8LKj9OJkojk8hnUy5xgFznGoKY1/AgDJztMihm
        LCka0l3Oj56ocssQfS8H/7GcEWpufPs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-567-WQoAySMsO3OvGkELCggKew-1; Thu, 09 Feb 2023 10:11:54 -0500
X-MC-Unique: WQoAySMsO3OvGkELCggKew-1
Received: by mail-pl1-f199.google.com with SMTP id l1-20020a170903244100b0019a59370c75so1384573pls.7
        for <fstests@vger.kernel.org>; Thu, 09 Feb 2023 07:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoCadHE3I4v3OxNeHj9dxKevMpJTtgaUlsOu3Rjf5Ow=;
        b=E4C9dpFs7VasuNg2iR1IOfhIvTkVAuRhVKO9RlZqq6ShUi5EPzD0pDHBFZ9oLDoNLE
         3DrU8Sw5hG4s6EMXYEk9NXf7SZVm5BwFE9lI12DhlcYdaSB0khODrB+u+B+3Seg9s1EU
         pSaWvZ2BBxY9sMNfv5S56XbmNK1dsajbY+9cJyHdaA1avuy4K64vuI8QNuswj0XkOGkH
         OC2K2Xh78k6m+tkS4ngTERiyfCrnrJtNXHe3K95p30mKo/7WELOY0OQFJlNzQelYbDLs
         9ZAjinnFPjZC2Jud0pJ1eo4jyBk1kzouXH1s8WkJA905GBbvcNwNlVIHqSJgbq0gRHj+
         ePZg==
X-Gm-Message-State: AO0yUKWGbLgMk0WBoXz4ovf8HmopFzm9qUCTi5SgpawOWRMFQVsmGUae
        /YxJehG7NdjXg/HjZpdwFOJI0ufMqYl2dbix4UiQgSGvvgtq7be+wDLXhm85rjqd16vA0MuBh6x
        T7ZAyBpkvx7T/L+PGlv2Dh/CTfxdy
X-Received: by 2002:a05:6a21:300e:b0:bc:9f82:93a6 with SMTP id yd14-20020a056a21300e00b000bc9f8293a6mr8939614pzb.7.1675955512425;
        Thu, 09 Feb 2023 07:11:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+XgeFVpM9LZOdUVWo5/di90ZNY7ZNDH+Jc4pgh6r2ib7rl1aF93cG20ouFjjXSk8d71x2RUg==
X-Received: by 2002:a05:6a21:300e:b0:bc:9f82:93a6 with SMTP id yd14-20020a056a21300e00b000bc9f8293a6mr8939602pzb.7.1675955512088;
        Thu, 09 Feb 2023 07:11:52 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c4-20020a633504000000b004facdf070d6sm1425082pga.39.2023.02.09.07.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:11:51 -0800 (PST)
Date:   Thu, 9 Feb 2023 23:11:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/btrfs: avoid reinitialization of unsupported
 profile array
Message-ID: <20230209151148.2yeaslftxnj6vfqz@zlang-mailbox>
References: <20230111105827.16852-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111105827.16852-1-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 11, 2023 at 11:58:27AM +0100, David Disseldorp wrote:
> The _btrfs_get_profile_configs() unsupported array doesn't change
> between configs, so avoid reinitializing it on each loop iteration.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/btrfs | 66 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ee673a93..9531c914 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -201,6 +201,39 @@ _btrfs_get_profile_configs()
>  		return
>  	fi
>  
> +	local unsupported=()
> +	if [ "$1" == "replace" ]; then
> +		# We can't do replace with these profiles because they
> +		# imply only one device ($SCRATCH_DEV), and we need to
> +		# keep $SCRATCH_DEV around for _scratch_mount
> +		# and _check_scratch_fs.
> +		unsupported+=(
> +			"dup"
> +		)
> +	elif [ "$1" == "replace-missing" ]; then
> +		# We can't replace missing devices with these profiles
> +		# because there isn't enough redundancy.
> +		unsupported+=(
> +			"single"
> +			"dup"
> +			"raid0"
> +		)
> +	fi
> +
> +	if _scratch_btrfs_is_zoned; then
> +		# Zoned btrfs only supports SINGLE profile
> +		unsupported+=(
> +			"dup"
> +			"raid0"
> +			"raid1"
> +			"raid1c3"
> +			"raid1c4"
> +			"raid10"
> +			"raid5"
> +			"raid6"
> +		)
> +	fi
> +
>  	if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
>  		# Default configurations to test.
>  		local configs=(
> @@ -222,39 +255,6 @@ _btrfs_get_profile_configs()
>  	for cfg in "${configs[@]}"; do
>  		local supported=true
>  		local profiles=(${cfg/:/ })
> -		if [ "$1" == "replace" ]; then
> -			# We can't do replace with these profiles because they
> -			# imply only one device ($SCRATCH_DEV), and we need to
> -			# keep $SCRATCH_DEV around for _scratch_mount
> -			# and _check_scratch_fs.
> -			local unsupported=(
> -				"dup"
> -			)
> -		elif [ "$1" == "replace-missing" ]; then
> -			# We can't replace missing devices with these profiles
> -			# because there isn't enough redundancy.
> -			local unsupported=(
> -				"single"
> -				"dup"
> -				"raid0"
> -			)
> -		else
> -			local unsupported=()
> -		fi
> -
> -		if _scratch_btrfs_is_zoned; then
> -			# Zoned btrfs only supports SINGLE profile
> -			unsupported+=(
> -				"dup"
> -				"raid0"
> -				"raid1"
> -				"raid1c3"
> -				"raid1c4"
> -				"raid10"
> -				"raid5"
> -				"raid6"
> -			)
> -		fi
>  
>  		for unsupp in "${unsupported[@]}"; do
>  			if [ "${profiles[0]}" == "$unsupp" -o "${profiles[1]}" == "$unsupp" ]; then
> -- 
> 2.35.3
> 

