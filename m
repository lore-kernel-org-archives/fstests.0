Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3CCEB64D7
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jun 2023 01:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjFUBON (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Jun 2023 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFUBOM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Jun 2023 21:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E37510D0
        for <fstests@vger.kernel.org>; Tue, 20 Jun 2023 18:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687310004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XmddsCl4LxAp90uqfpuwqG5H0+eikf9m3wLMFq+yZRY=;
        b=Qij/tcDMsDWWK+iGidAHUrEfSaJo+uMMIGkfPMRSLjdY56mxfrSK0/QlhVcZPDTIfq7pke
        Aj9ZvLvcUaMJd1GC2KjjBdEq43xvvbiBYKl0RMBoiGrMSPJLnZcn2F8YetrJ+XW0EQfO2h
        DvoZtWVMWcDKAjeOne9yCe2yUubgh58=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-CmHt5qyPM9qkJupNt2Dyag-1; Tue, 20 Jun 2023 21:13:22 -0400
X-MC-Unique: CmHt5qyPM9qkJupNt2Dyag-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-66871648c25so2762400b3a.1
        for <fstests@vger.kernel.org>; Tue, 20 Jun 2023 18:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687310001; x=1689902001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmddsCl4LxAp90uqfpuwqG5H0+eikf9m3wLMFq+yZRY=;
        b=Fox0uIP4J+ONhVbqh6y0wX6x7mC7Mfi8hS3AfhL1HNuUjwkxeNqZVeK1/EvJiP3O6V
         GPzJ50xtBLUd5/eaXrJ5ZYBwl8jT5FXJCWnCSCG4P2ZGxVhC/5VV5CQFA67inpoW78Fp
         /mVaFb2fa+rDuPmkgx3DeskofwxYEylj8P85gc5YxOQuyx6rIMILDiorl+Hsmkjqltrv
         n700oessz6YDXhzaIXnopHXMFa3jm+iwp8pjGmK6wOvA6a/l87sHvcjCbstsyhXOLthC
         dctgoQoi2BFW3Pzaabb2ZxGzQVFVK/+5gBRYO6VVlwirkoFXrls2O748VZpL2UXyQgu5
         VKBg==
X-Gm-Message-State: AC+VfDyOkZEnNkuL2lobXr4P2Ommqwc5RVs6VPNJKc3FEP15a3RJI8K/
        aVclYrSdqZ05Epu7RRvM91wdLRVF5Sp0oeM6QTuV1cnNXMWD43WGxiec3IKR/FxpWtaexa2YUnx
        C9orLAgodV1MJ+l8q7rdLd5xY+M+q
X-Received: by 2002:a05:6a21:9984:b0:11e:e940:441d with SMTP id ve4-20020a056a21998400b0011ee940441dmr17882764pzb.22.1687310000935;
        Tue, 20 Jun 2023 18:13:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MSuyFZJGtpy6/jfZt6r/pm8NOfdQLYRsIB/gi8BE7VDlSkY8pj0y5+GwyIVhdtfMRlAnSUA==
X-Received: by 2002:a05:6a21:9984:b0:11e:e940:441d with SMTP id ve4-20020a056a21998400b0011ee940441dmr17882745pzb.22.1687310000532;
        Tue, 20 Jun 2023 18:13:20 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j2-20020a62b602000000b00660d80087a8sm1798098pff.187.2023.06.20.18.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 18:13:20 -0700 (PDT)
Date:   Wed, 21 Jun 2023 09:13:16 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: reduce runtime of check -n
Message-ID: <20230621011316.g6omv4j66jltoma2@zlang-mailbox>
References: <20230619105058.2711467-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619105058.2711467-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 19, 2023 at 01:50:58PM +0300, Amir Goldstein wrote:
> kvm-xfstests invokes check -n twice to pre-process and generate the
> tests-to-run list, which is then being passed as a long list of tests
> for invkoing check in the command line.
> 
> check invokes dirname, basename and sed several times per test just
> for doing basic string prefix/suffix trimming.
> Use bash string pattern matching instead which is much faster.
> 
> Note that the following pattern matching expression change:
> < test_dir=${test_dir#$SRC_DIR/*}
> > t=${t#$SRC_DIR/}
> does not change the meaning of the expression, because the
> shortest match of "$SRC_DIR/*" that is being trimmed is "$SRC_DIR/"
> and removing the tests/ prefix is what this code intended to do.
> 
> With check -n, there is no need to cleanup the results dir,
> but check -n is doing that for every single listed test.
> Move the cleanup of results dir to before actually running the test.
> 
> These improvements to check pre-test code cut down several minutes
> from the time until tests actually start to run with kvm-xfstests.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Zorro,
> 
> Just to clarify, this change is not expected to change behavior -
> only to improve runtime of check -n and the things that happen
> before the first test is invoked.

Hi Amir,

Sure, it's good to me to improve the performace of 'check -n'. But as this patch
changes the common logic of check file, I need to make sure it won't bring in
regression at first by some testing. If it works fine, I'll ack and merge it.

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 
>  check | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/check b/check
> index e36978c1..1a16eccb 100755
> --- a/check
> +++ b/check
> @@ -399,9 +399,9 @@ if $have_test_arg; then
>  		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
>  			list=$(cd $SRC_DIR; echo $1)
>  			for t in $list; do
> -				test_dir=`dirname $t`
> -				test_dir=${test_dir#$SRC_DIR/*}
> -				test_name=`basename $t`
> +				t=${t#$SRC_DIR/}
> +				test_dir=${t%/*}
> +				test_name=${t#*/}
>  				group_file=$SRC_DIR/$test_dir/group.list
>  
>  				if grep -Eq "^$test_name" $group_file; then
> @@ -849,18 +849,14 @@ function run_section()
>  
>  		# the filename for the test and the name output are different.
>  		# we don't include the tests/ directory in the name output.
> -		export seqnum=`echo $seq | sed -e "s;$SRC_DIR/;;"`
> -
> -		# Similarly, the result directory needs to replace the tests/
> -		# part of the test location.
> -		group=`dirname $seq`
> +		export seqnum=${seq#$SRC_DIR/}
> +		group=${seqnum%/*}
>  		if $OPTIONS_HAVE_SECTIONS; then
> -			export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;${RESULT_BASE}/$section;"`
>  			REPORT_DIR="$RESULT_BASE/$section"
>  		else
> -			export RESULT_DIR=`echo $group | sed -e "s;$SRC_DIR;$RESULT_BASE;"`
>  			REPORT_DIR="$RESULT_BASE"
>  		fi
> +		export RESULT_DIR="$REPORT_DIR/$group"
>  		seqres="$REPORT_DIR/$seqnum"
>  
>  		# Generate the entire section report with whatever test results
> @@ -872,9 +868,6 @@ function run_section()
>  					     "" &> /dev/null
>  		fi
>  
> -		mkdir -p $RESULT_DIR
> -		rm -f ${RESULT_DIR}/require_scratch*
> -		rm -f ${RESULT_DIR}/require_test*
>  		echo -n "$seqnum"
>  
>  		if $showme; then
> @@ -899,6 +892,9 @@ function run_section()
>  		fi
>  
>  		# really going to try and run this one
> +		mkdir -p $RESULT_DIR
> +		rm -f ${RESULT_DIR}/require_scratch*
> +		rm -f ${RESULT_DIR}/require_test*
>  		rm -f $seqres.out.bad $seqres.hints
>  
>  		# check if we really should run it
> -- 
> 2.34.1
> 

