Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7626EB64D7
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Jun 2023 02:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjFUCYw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Jun 2023 22:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFUCYu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Jun 2023 22:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA5186
        for <fstests@vger.kernel.org>; Tue, 20 Jun 2023 19:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687314243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2RfrmtSZBB4th4dJkv10h4Ne8vOKSYuAZ6zaF1wMt2s=;
        b=fWpPdwI6tvGSJL5fkGCDnUw6BeG4IkzswsjgzoYzuSC9t4ktllVaPsSJ3pC/g+Jk4UWJFR
        TcPLjQ5sr17lkP/mWevrlVPKiErmMkx49YvTChGRU8DydA/nezzB9ZysgcuckxR8iB/3Qd
        +jC7y+sm4pB6bDMPdY+YcA2GJM+Godo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-L_nXpexENoeL4HgURxWoIg-1; Tue, 20 Jun 2023 22:24:01 -0400
X-MC-Unique: L_nXpexENoeL4HgURxWoIg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b521321885so28925065ad.2
        for <fstests@vger.kernel.org>; Tue, 20 Jun 2023 19:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314240; x=1689906240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RfrmtSZBB4th4dJkv10h4Ne8vOKSYuAZ6zaF1wMt2s=;
        b=hmy0daZAPgDuT5HsQAKFLyLQQ+YsW6pUjpmxefC+Wb9rzPRRGvyIWvcR1DNNIRZakd
         408aNH9WActe29Mov34ehgaX1NaS3/YOc2XNpOb4uZdlweg8ATuWH/KNTHARVu4m+lcy
         quAzOFJewN/uQbphMaV4R29BW4zBL4jme7hVxf4jCb84AR7XhhhJlzV6sPRxP3/Jduls
         5MVRy3GDMAsOvDBsYbhs88NK8H75SXDcgqdgqC4VlPPxyBreuNtKUA0zmEtuWWi4y8Zq
         I2hWDFqT8ygtGDc6S3xsiW14EmVNhZ0ZPETO5/qA8jUkmQjN/AdInRA2Yo0cGpwNiaGs
         9qLg==
X-Gm-Message-State: AC+VfDx4IBW7YxAmD89S6VvXLZ6KBqL7ulIfwAPj4h488OFDSaJN6LLZ
        fM74OUw1EApO4dj26C3Mlbrup3DShmW0T8rb8N5IbJNfQw/G7HbcGpNVZ/GSHvBV1+I0GgmVz5c
        eJzHBWPtQ0+I6SY19S1VKllRBBtbp
X-Received: by 2002:a17:902:e5cb:b0:1a6:b23c:3bf2 with SMTP id u11-20020a170902e5cb00b001a6b23c3bf2mr13217680plf.10.1687314239692;
        Tue, 20 Jun 2023 19:23:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UWq7Huxxtru8iTNKBM0HY6SBucO0ZWAIKZQpDPKxTghMy7FP8/KEScKZoNofQhHVbYQC3jQ==
X-Received: by 2002:a17:902:e5cb:b0:1a6:b23c:3bf2 with SMTP id u11-20020a170902e5cb00b001a6b23c3bf2mr13217673plf.10.1687314239354;
        Tue, 20 Jun 2023 19:23:59 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709029b9000b001b66e3a77easm2237218plp.50.2023.06.20.19.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 19:23:58 -0700 (PDT)
Date:   Wed, 21 Jun 2023 10:23:55 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: reduce runtime of check -n
Message-ID: <20230621022355.yk7dy2e6sghcuzrp@zlang-mailbox>
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

Actually I'm not sure what's this line for. We get $list by "cd $SRC_DIR; echo $1",
is there any chance to have "$SRC_DIR" in $t (or $test_dir) ?

> +				test_dir=${t%/*}
> +				test_name=${t#*/}

This change looks isn't related with the "check -n". Any reason to change
that? Does the 'dirname' and 'basename' have poor performance, or some systems
miss them?

I prefer the 'dirname' and 'basename' ways, if there's not a specific reason
to change that. Due to they can deal with more complicated path name, e.g.
"xfs//001". But the "$(cd $SRC_DIR; echo $1)" looks won't generate a path name
likes that, so if you have a proper reason to make this change, that's fine.

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

Hmm, this code logic looks more concise.

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

Nice catch, loop running these lines really takes much time.

Thanks,
Zorro

>  		rm -f $seqres.out.bad $seqres.hints
>  
>  		# check if we really should run it
> -- 
> 2.34.1
> 

