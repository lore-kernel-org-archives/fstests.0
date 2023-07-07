Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF5AEB64D9
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jul 2023 13:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjGGNUV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGNUR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jul 2023 09:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6360113
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M/VAWBereIFqY0Yn0TWpxNF3FJMc3IqXEQA+wkQ6EKI=;
        b=VXPZmknTbW/52412tzJNfl9DpALT7vJvjRnwtFF+4bIDDG3j/i7Xyd9ZKcakYmoU199q/q
        hhJPki8rwOeiw1QzU1SPI3nd8NSCicudbfQ5L/B+yBEb4Oiuvb5grP3nISgxE64UiT1mUv
        YqdVzs5RGJiMn3E9Aj9Ng7862zAGWZQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153--2hCX6vcPDKPhvG8Jy0cjQ-1; Fri, 07 Jul 2023 09:19:21 -0400
X-MC-Unique: -2hCX6vcPDKPhvG8Jy0cjQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b8810af3adso1340216a34.1
        for <fstests@vger.kernel.org>; Fri, 07 Jul 2023 06:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735959; x=1691327959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/VAWBereIFqY0Yn0TWpxNF3FJMc3IqXEQA+wkQ6EKI=;
        b=IN7qpWFOmDPq5wbajPewF1LiSYp3svT2VUVH2uLipgUca7NIqSBAxEwj4XDPkujHvs
         f6fLRS8Q2FII0a9hVqgPxoDggsCeN/jGf+elMV9o5/gxmniJHylOLcB1KWaaSBt3DiQL
         O6iiI6YYtmrLD5lsTmpVR6bYdkYAc59uAHQ1KiCee+KMGM+jbA+p23pU8SioEu7nRYxS
         UPmdKF4xrB0ZXwMM8PhdI4Eyqc8/XeSZz97EUeJubD9Rtr2tWCCg7EoWyN1SJGtXfUPt
         8KqSmXP3ZLj7U0WL1MK7SL2/m283dwVk7KRnq76ytaL83IWXz31pbPVBNokAjAvolN9Q
         pQhA==
X-Gm-Message-State: ABy/qLYoyN3IRFGa3OO2j3I+17dstaQKobaRFDy/M4NyfJv+p/CP7lr/
        3Zf+HPArqJfvdpwJUVeyNV/ovs8Mk4kKHyYcanwYUIsXNx6zVrYgmEISRYvvhOpxilhtfd9ryEC
        8CjljDQSrjdOyh3/MYw==
X-Received: by 2002:a05:6830:1252:b0:6b9:107b:5ea9 with SMTP id s18-20020a056830125200b006b9107b5ea9mr2388735otp.5.1688735958844;
        Fri, 07 Jul 2023 06:19:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHODbullLLme81Kqv5ForpMCFSzEaP9JP4kOFgSYEUQwkSHWrg3RN7QT6N3Kj7KqwToVvMsFw==
X-Received: by 2002:a05:6830:1252:b0:6b9:107b:5ea9 with SMTP id s18-20020a056830125200b006b9107b5ea9mr2388711otp.5.1688735958542;
        Fri, 07 Jul 2023 06:19:18 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g14-20020a63b14e000000b00553b9e0510esm2894610pgp.60.2023.07.07.06.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:19:18 -0700 (PDT)
Date:   Fri, 7 Jul 2023 21:19:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     yuezhang.mo@foxmail.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] check: fix excluded tests are only expunged in the
 first iteration
Message-ID: <20230707131914.x67xh76pasvbwyee@zlang-mailbox>
References: <tencent_BAC515047634B24F4B5D5052B5FCD6D23B09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BAC515047634B24F4B5D5052B5FCD6D23B09@qq.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 05, 2023 at 07:49:55AM +0800, yuezhang.mo@foxmail.com wrote:
> From: Yuezhang Mo <Yuezhang.Mo@foxmail.com>
> 
> If iterating more than once and excluding some tests, the
> excluded tests are expunged in the first iteration, but run in
> subsequent iterations. This is not expected.
> 
> The problem was caused by the temporary file saving the excluded
> tests being deleted by `rm -f $tmp.*` in _wrapup() at the end of
> the first iteration.
> 
> This commit saves the excluded tests into a variable instead of a
> temporary file.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@foxmail.com>
> ---

This version looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  check | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/check b/check
> index e36978c1..cb4b23bf 100755
> --- a/check
> +++ b/check
> @@ -27,6 +27,7 @@ DUMP_OUTPUT=false
>  iterations=1
>  istop=false
>  loop_on_fail=0
> +exclude_tests=()
>  
>  # This is a global variable used to pass test failure text to reporting gunk
>  _err_msg=""
> @@ -46,7 +47,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
>  # by default don't output timestamps
>  timestamp=${TIMESTAMP:=false}
>  
> -rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
> +rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
>  
>  SRC_GROUPS="generic shared"
>  export SRC_DIR="tests"
> @@ -302,13 +303,15 @@ while [ $# -gt 0 ]; do
>  		;;
>  	-e)
>  		xfile=$2; shift ;
> -		echo "$xfile" | tr ', ' '\n\n' >> $tmp.xlist
> +		readarray -t -O "${#exclude_tests[@]}" exclude_tests < \
> +			<(echo "$xfile" | tr ', ' '\n\n')
>  		;;
>  
>  	-E)	xfile=$2; shift ;
>  		if [ -f $xfile ]; then
> -			sed "s/#.*$//" "$xfile" >> $tmp.xlist
> -	        fi
> +			readarray -t -O ${#exclude_tests[@]} exclude_tests < \
> +				<(sed "s/#.*$//" $xfile)
> +		fi
>  		;;
>  	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
>  	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
> @@ -383,7 +386,7 @@ if [ -n "$subdir_xfile" ]; then
>  	for d in $SRC_GROUPS $FSTYP; do
>  		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
>  		for f in `sed "s/#.*$//" $SRC_DIR/$d/$subdir_xfile`; do
> -			echo $d/$f >> $tmp.xlist
> +			exclude_tests+=($d/$f)
>  		done
>  	done
>  fi
> @@ -570,13 +573,14 @@ _check_filesystems()
>  _expunge_test()
>  {
>  	local TEST_ID="$1"
> -	if [ -s $tmp.xlist ]; then
> -		if grep -q $TEST_ID $tmp.xlist; then
> +
> +	for f in "${exclude_tests[@]}"; do
> +		if [ "${TEST_ID}" == "$f" ]; then
>  			echo "       [expunged]"
> -			return 1
> +			return 0
>  		fi
> -	fi
> -	return 0
> +	done
> +	return 1
>  }
>  
>  # retain files which would be overwritten in subsequent reruns of the same test
> @@ -878,8 +882,7 @@ function run_section()
>  		echo -n "$seqnum"
>  
>  		if $showme; then
> -			_expunge_test $seqnum
> -			if [ $? -eq 1 ]; then
> +			if _expunge_test $seqnum; then
>  				tc_status="expunge"
>  			else
>  				echo
> @@ -902,8 +905,7 @@ function run_section()
>  		rm -f $seqres.out.bad $seqres.hints
>  
>  		# check if we really should run it
> -		_expunge_test $seqnum
> -		if [ $? -eq 1 ]; then
> +		if _expunge_test $seqnum; then
>  			tc_status="expunge"
>  			_stash_test_status "$seqnum" "$tc_status"
>  			continue
> -- 
> 2.25.1
> 

