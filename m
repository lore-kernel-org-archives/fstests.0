Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9960EEE57C3
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Sep 2023 05:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjIHF23 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Sep 2023 01:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjIHF21 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Sep 2023 01:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEED1BDA
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 22:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694150854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKCsrqis+BsCzL1au9M77zkgSqfPeD5/UYOFu7ubnBU=;
        b=EaGlqUkYFt/8IQIOj4xbiRPc+dspVgt4NxIK4XRejHUqVE5GalUDD++i9E1ptgPmWzo+mf
        /ey6m2Crc9k8Cn6mJW0k2w0nhiw/sug5kVsdW7JdWbc86i3RxjIGSmwPJK5q7VUi38fz6m
        s54Dyf9BrBwo8kCThDfvQ4+pkIeMMak=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-u6W4m8nNOeyv4rhKAvA9IQ-1; Fri, 08 Sep 2023 01:27:32 -0400
X-MC-Unique: u6W4m8nNOeyv4rhKAvA9IQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c0aaf4caaaso22541995ad.2
        for <fstests@vger.kernel.org>; Thu, 07 Sep 2023 22:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694150852; x=1694755652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKCsrqis+BsCzL1au9M77zkgSqfPeD5/UYOFu7ubnBU=;
        b=jVhdHXDuy2kSe5wzGLEPKTensJS+cKAT2AsXp7+7pdlcW8eaewa25aTgeYI/eunvD4
         hUqtzbCxkNuwRojcWgl7Uy+08WQssnqR1rZi3FPBJ76RJ5CBqLRTXuGNdq6VGUZ799pg
         Abe8WHFL3A8F3kpTc/YjXOY8QZ4AibzYzoTgzZ0UauF+njFNc+6qtl+uoK5pt80iDVLw
         R7P3YAUKcS3X46ovqFNr1A1EeC3toyq9HesA/78PnxaXTipPqB9ZJBmn5Lz4m6NJXdAC
         NzFqpawu6+DjpxB8SQsx8sny3qALagq0NcmiQZunpg82yN3j43DP+/FyRNX4yktGGfQU
         8QDA==
X-Gm-Message-State: AOJu0Yyhhy+Xw0JKBSFTA9DHmSn2ng4njiem+3ZOa03d+hk/QhieGEol
        5+8eRYH6hC1JId7Zpgr+V9n0G/WUdAdG1XM1OPmG16s1+Ct3qpolL9kujCdmLTfrj200nEP0OvP
        TKzlksrzOVipOe4ct7Q==
X-Received: by 2002:a17:902:c945:b0:1bb:32de:95c5 with SMTP id i5-20020a170902c94500b001bb32de95c5mr1976915pla.65.1694150851695;
        Thu, 07 Sep 2023 22:27:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ40qCvKRfoIkm0b84FGgfTzvKoPpRC2DfetekChbsCofR092otCbVr1txAVQ/nG9XCDpMRg==
X-Received: by 2002:a17:902:c945:b0:1bb:32de:95c5 with SMTP id i5-20020a170902c94500b001bb32de95c5mr1976899pla.65.1694150851352;
        Thu, 07 Sep 2023 22:27:31 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jf20-20020a170903269400b001b80760fd04sm646012plb.112.2023.09.07.22.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 22:27:30 -0700 (PDT)
Date:   Fri, 8 Sep 2023 13:27:27 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, aalbersh@redhat.com,
        chandan.babu@oracle.com, amir73il@gmail.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] check: add support for --start-after
Message-ID: <20230908052727.ccyxadtibouis74h@zlang-mailbox>
References: <20230907221030.3037715-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907221030.3037715-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 07, 2023 at 03:10:30PM -0700, Luis Chamberlain wrote:
> Often times one is running a new test baseline we want to continue to
> start testing where we left off if the last test was a crash. To do
> this the first thing that occurred to me was to use the check.time
> file as an expunge file but that doesn't work so well if you crashed
> as the file turns out empty.
> 
> So instead add super simple argument --start-after which let's you
> skip all tests until the test infrastructure has "seen" the test
> you want to skip. This does obviously work best if you are not using
> a random order, but that is rather implied.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  check | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/check b/check
> index 71b9fbd07522..1ecf07c1cb37 100755
> --- a/check
> +++ b/check
> @@ -18,6 +18,8 @@ showme=false
>  have_test_arg=false
>  randomize=false
>  exact_order=false
> +start_after=false
> +start_after_test=""
>  export here=`pwd`
>  xfile=""
>  subdir_xfile=""
> @@ -80,6 +82,7 @@ check options
>      -b			brief test summary
>      -R fmt[,fmt]	generate report in formats specified. Supported formats: xunit, xunit-quiet
>      --large-fs		optimise scratch device for large filesystems
> +    --start-after	only start testing after the test specified

This option conflicts with "-r" option.

>      -s section		run only specified section from config file
>      -S section		exclude the specified section from the config file
>      -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
> @@ -313,6 +316,11 @@ while [ $# -gt 0 ]; do
>  				<(sed "s/#.*$//" $xfile)
>  		fi
>  		;;
> +	--start-after)
> +		start_after=true
> +		start_after_test="$2"

Do we really need two variables at here?

> +		shift
> +		;;
>  	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
>  	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
>  	-l)	diff="diff" ;;
> @@ -591,6 +599,15 @@ _expunge_test()
>  {
>  	local TEST_ID="$1"
>  
> +	if $start_after; then
> +		if [[ "$start_after_test" == ${TEST_ID}* ]]; then
> +			start_after=false
> +		fi
> +		echo "       [skipped]"
> +		return 0
> +
> +	fi

I can't understand how you use the --start-after. I though you'd like to remove
all cases before the "start-after" from the running list. But when I saw here,
I'm a little confused.

Thanks,
Zorro

> +
>  	for f in "${exclude_tests[@]}"; do
>  		# $f may contain traling spaces and comments
>  		local id_regex="^${TEST_ID}\b"
> -- 
> 2.39.2
> 

