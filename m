Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD01C636CD
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Feb 2023 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjBGKBr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjBGKBP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Feb 2023 05:01:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8BE10C1
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2023 02:01:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 842C6377D2;
        Tue,  7 Feb 2023 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675764059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HE+uS3CHkxRsskYh2UtHW/HNaCrnzBU3JI42NNM3+UI=;
        b=FpOmH+T2ZIPqygqG/oWhSmegLzMRbnTWjlbBw8Seb1mJeXZ5Hkvb2vC4zcKgdwfSjoVJuZ
        ZKulhgkFvVE3gFV/Rg5/4nHwz/IJQI3Qfjwu8gAmYuKDckl/pHB6r+LeWgiR0y0MV8vM8m
        VPvBARpqwXbbyuqDDosT9N2dVe+xylY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6324F13A8C;
        Tue,  7 Feb 2023 10:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mMi0Flsh4mPVFwAAMHmgww
        (envelope-from <gabriel.niebler@suse.com>); Tue, 07 Feb 2023 10:00:59 +0000
Message-ID: <bae014d8-aabe-8f80-260a-d2767019f49e@suse.com>
Date:   Tue, 7 Feb 2023 11:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] common/btrfs: avoid reinitialization of unsupported
 profile array
Content-Language: en-US
To:     David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
References: <20230111105827.16852-1-ddiss@suse.de>
From:   Gabriel Niebler <gabriel.niebler@suse.com>
In-Reply-To: <20230111105827.16852-1-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Am 11.01.23 um 11:58 schrieb David Disseldorp:
> The _btrfs_get_profile_configs() unsupported array doesn't change
> between configs, so avoid reinitializing it on each loop iteration.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>   common/btrfs | 66 ++++++++++++++++++++++++++--------------------------
>   1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ee673a93..9531c914 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -201,6 +201,39 @@ _btrfs_get_profile_configs()
>   		return
>   	fi
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
>   	if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
>   		# Default configurations to test.
>   		local configs=(
> @@ -222,39 +255,6 @@ _btrfs_get_profile_configs()
>   	for cfg in "${configs[@]}"; do
>   		local supported=true
>   		local profiles=(${cfg/:/ })
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
>   		for unsupp in "${unsupported[@]}"; do
>   			if [ "${profiles[0]}" == "$unsupp" -o "${profiles[1]}" == "$unsupp" ]; then

This seems like a good change.

It only makes sense and in my local testing it reduced btrfs test run 
time by 10-17 seconds overall.

Not a huge amount, but every little helps.

-- 
Gabriel Niebler (he/him/his)
Senior Full-Stack Web Developer

SUSE

gabriel.niebler@suse.com

www.suse.com
