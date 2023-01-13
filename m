Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26343C3DA78
	for <linux-fstests@archiver.kernel.org>; Fri, 13 Jan 2023 19:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjAMT4S (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 Jan 2023 14:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjAMT4R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 Jan 2023 14:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF8588A02
        for <fstests@vger.kernel.org>; Fri, 13 Jan 2023 11:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673639732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fanVzNUfL6eqnhnG4asoO4Rw1PuKiZnS4peRY6i51I=;
        b=AqRkMdNKyPHwiLWWQpZ3YLX2lBtZSjlwOEl02JDF+yZe4sac2lvdBF9vHSflRzgFaGI/WW
        KUt2w6ChJtWeaVEwLpkg0J1LOnCZsMwq8gOiwWJpnmRuaowQ4WOeen1CFQS2csoOHK+Ng3
        gKVslh9Pga/9bIUQGw8jP8pqvZZDd1A=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-2Bv2DdPOMwCY2cEnEcylaQ-1; Fri, 13 Jan 2023 14:55:30 -0500
X-MC-Unique: 2Bv2DdPOMwCY2cEnEcylaQ-1
Received: by mail-pf1-f200.google.com with SMTP id 24-20020aa79118000000b00580476432deso10769734pfh.23
        for <fstests@vger.kernel.org>; Fri, 13 Jan 2023 11:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fanVzNUfL6eqnhnG4asoO4Rw1PuKiZnS4peRY6i51I=;
        b=BgAlltJ0I7oC2cZXitXeFoVm/2XmZYudlKuBUAS5VdjHeD9zaGL5/F+grPzuO/JaHR
         kyUCHYMyavVohp/w1/ExsAxOPZQWAKtp02ZH3sT51txIQAip7MLKtLjXmjizzSEXPIxa
         TUfs5pY67xW+7AuNuAQpJynkTxDoaYYFHPKBMu4YwwRrv8M4EHjsPiw6fDiHBNyeAGG8
         6l8Eu6uq6P1p3DMRPXqvQmgmAYyfNIpmxd8CJ6kAcEeUe1LKQ0VnXtw9Ifq0b3SdoDcj
         HzWWGK5LvQDFjSFHVJzhUEod1n6VSQWR5DyRVNVso2qEM8fA1JaaXSret/Xpp00NNNBw
         a76g==
X-Gm-Message-State: AFqh2kqXRmqGRRdD5B3lbJm4n7wZUp+TXNB22LiGokaQ4PdPUXRE3Wfq
        TojwRFk2nPnt9C/5KO3TM91heFZt/zOthvLXNGpedSfH3VkIjewN/5TO8w5sJXz05updBLPqsg4
        qsNQFIMwzO4sCPDWgNA==
X-Received: by 2002:a17:902:7889:b0:192:6bc9:47ba with SMTP id q9-20020a170902788900b001926bc947bamr70368886pll.31.1673639729706;
        Fri, 13 Jan 2023 11:55:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt/HrFYraak3iyQ1RA7fsDCTMhAchPDVCurquktp0gMu56GuIQFYPKbHFa9jfnLOzcW6PVYEg==
X-Received: by 2002:a17:902:7889:b0:192:6bc9:47ba with SMTP id q9-20020a170902788900b001926bc947bamr70368866pll.31.1673639729403;
        Fri, 13 Jan 2023 11:55:29 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c19-20020a170902c1d300b00186b138706fsm14669807plc.13.2023.01.13.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:55:29 -0800 (PST)
Date:   Sat, 14 Jan 2023 03:55:25 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 12/16] fuzzy: increase operation count for each fsstress
 invocation
Message-ID: <20230113195525.74tcppiq4cpf4mi5@zlang-mailbox>
References: <167243837296.694541.13203497631389630964.stgit@magnolia>
 <167243837460.694541.14076101650568669658.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167243837460.694541.14076101650568669658.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 30, 2022 at 02:12:54PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> For online fsck stress testing, increase the number of filesystem
> operations per fsstress run to 2 million, now that we have the ability
> to kill fsstress if the user should push ^C to abort the test early.
> This should guarantee a couple of hours of continuous stress testing in
> between clearing the scratch filesystem.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/fuzzy |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/common/fuzzy b/common/fuzzy
> index 01cf7f00d8..3e23edc9e4 100644
> --- a/common/fuzzy
> +++ b/common/fuzzy
> @@ -399,7 +399,9 @@ __stress_scrub_fsstress_loop() {
>  	local end="$1"
>  	local runningfile="$2"
>  
> -	local args=$(_scale_fsstress_args -p 4 -d $SCRATCH_MNT -n 2000 $FSSTRESS_AVOID)
> +	# As of March 2022, 2 million fsstress ops should be enough to keep
> +	# any filesystem busy for a couple of hours.
> +	local args=$(_scale_fsstress_args -p 4 -d $SCRATCH_MNT -n 2000000 $FSSTRESS_AVOID)

Can fsstress "-l 0" option help?

>  	echo "Running $FSSTRESS_PROG $args" >> $seqres.full
>  
>  	while __stress_scrub_running "$end" "$runningfile"; do
> 

