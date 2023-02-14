Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC525C61DA4
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Feb 2023 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjBNVGL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNVGL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Feb 2023 16:06:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAE2109
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 13:06:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04E8321A4D;
        Tue, 14 Feb 2023 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1676408768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJ1zX96f/1tjWxaa15uMB4l08uETxEa4WRxVEycyZEk=;
        b=IsJ0UvuxJ2wurtNRpulb5SOW4k0sodIUVh2tSQe55Y6jSZzMYlhaSlilKW7UZFoepr6jNM
        TlUwROR2ddWZenkCCnR/y5sTPNos+F13sIeXb0mjHNwUIfJlOzXkhFPfLzajCZddHf0pSF
        uf2+0Pjdiw+N8+ZfofsK2Jh2+siy9Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1676408768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJ1zX96f/1tjWxaa15uMB4l08uETxEa4WRxVEycyZEk=;
        b=2j9KqsBJdpWu+Y8mAQd0Oj9qoAXSmhA0hjZt7vL34cCKdq8MYlh/EN6HfYcJzxNbJr2ZP1
        koOGlPWtGsMgTGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF94213A21;
        Tue, 14 Feb 2023 21:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8EwYNb/362N2egAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 14 Feb 2023 21:06:07 +0000
Date:   Tue, 14 Feb 2023 22:07:28 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v5] btrfs/011: use $_btrfs_profile_configs to limit the
 tests
Message-ID: <20230214220728.000fd5d9@echidna.fritz.box>
In-Reply-To: <20230214153057.23971-1-lan@suse.com>
References: <20230111131833.471ada43@echidna.fritz.box>
        <20230214153057.23971-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

On Tue, 14 Feb 2023 23:30:57 +0800, An Long wrote:

> Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
> profiles. For example, skip raid56 as it's not supported.
> 
> For dup profile, add dup to default profile configs
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  common/btrfs    |  6 ++++++
>  tests/btrfs/011 | 30 +++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ee673a93..e857a40e 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -213,6 +213,12 @@ _btrfs_get_profile_configs()
>  			"raid5:raid5"
>  			"raid6:raid6"
>  		)
> +		if [ "$1" == "dup" ]; then
> +			configs=(
> +				${configs[*]}
> +				"dup:dup"
> +			)
> +		fi

nit: configs+=("dup:dup") can be used for appending to bash arrays.

>  	else
>  		# User-provided configurations.
>  		local configs=(${BTRFS_PROFILE_CONFIGS[@]})
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 6c3d037f..852742ee 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -48,6 +48,7 @@ _require_scratch_dev_pool 5
>  _require_scratch_dev_pool_equal_size
>  _require_scratch_size $((10 * 1024 * 1024)) #kB
>  _require_command "$WIPEFS_PROG" wipefs
> +_btrfs_get_profile_configs dup
>  
>  rm -f $tmp.*
>  
> @@ -237,19 +238,22 @@ btrfs_replace_test()
>  	fi
>  }
>  
> -workout "-m single -d single" 1 no 64
> -# Mixed BG & RAID/DUP profiles are not supported on zoned btrfs
> -if ! _scratch_btrfs_is_zoned; then
> -	workout "-m dup -d single" 1 no 64
> -	workout "-m dup -d single" 1 cancel 1024
> -	workout "-m raid0 -d raid0" 2 no 64
> -	workout "-m raid1 -d raid1" 2 no 2048
> -	workout "-m raid10 -d raid10" 4 no 64
> -	workout "-m single -d single -M" 1 no 64
> -	workout "-m dup -d dup -M" 1 no 64
> -	workout "-m raid5 -d raid5" 2 no 64
> -	workout "-m raid6 -d raid6" 3 no 64
> -fi
> +for t in "-m single -d single:1 no 64" \
> +	"-m dup -d single:1 no 64" \
> +	"-m dup -d single:1 cancel 1024" \
> +	"-m raid0 -d raid0:2 no 64" \
> +	"-m raid1 -d raid1:2 no 2048" \
> +	"-m raid10 -d raid10:4 no 64" \
> +	"-m single -d single -M:1 no 64" \
> +	"-m dup -d dup -M:1 no 64" \
> +	"-m raid5 -d raid5:2 no 64" \
> +	"-m raid6 -d raid6:3 no 64"; do
> +	mkfs_option=${t%:*}
> +	workout_option=${t#*:}
> +	if [[ "${_btrfs_profile_configs[@]}" =~ "${mkfs_option/ -M}"( |$) ]]; then
> +		workout "$mkfs_option" $workout_option
> +	fi
> +done
>  
>  echo "*** done"
>  status=0

With the minor nit above fixed, feel free to add:
Reviewed-by: David Disseldorp <ddiss@suse.de>
