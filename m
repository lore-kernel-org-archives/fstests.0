Return-Path: <SRS0=zmF6=AT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ADEC433E0
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jul 2020 08:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDCE20672
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jul 2020 08:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StEvcjCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGHIP1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:15:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22052 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbgGHIP1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Jul 2020 04:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594196125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLvkiubmFCm+FNVolsxKbcHrIDdjk+ut3Xzgk62ypV8=;
        b=StEvcjCd+U2Jk9Itj9ezqZ4bWiqn+X8OSfza6L1QhfrI5CUb26wafJX6i8GTcSj4Qo6WyO
        74uTU1+L5GHeiKBpXXiwDB9gU5BzVdD64ng4AkJJla/xSQpZSZkW7AVpGJdx1pZTGQcel2
        DJ1zZU6OD6Rr0uBgF3e2lys6rZMbwwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-ukOfUYIoOYeBsjH7P5s65A-1; Wed, 08 Jul 2020 04:15:24 -0400
X-MC-Unique: ukOfUYIoOYeBsjH7P5s65A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24EBBBFC2;
        Wed,  8 Jul 2020 08:15:23 +0000 (UTC)
Received: from work (unknown [10.40.192.254])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3394B5D9C9;
        Wed,  8 Jul 2020 08:15:21 +0000 (UTC)
Date:   Wed, 8 Jul 2020 10:15:18 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: add CLI option to repeat tests
Message-ID: <20200708081518.4oqe4menrpifbags@work>
References: <20200708053513.3259990-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708053513.3259990-1-david@fromorbit.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 08, 2020 at 03:35:13PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Frequently when trying to reproduce a problem I want to run a set of
> specific tests in a loop, over and over again. I run fstests from a
> set of run scripts that have non-trivial overhead (e.g. patterning
> block devices before the runs start), so if all I want to do is run
> the same test 100x, using a shell loop over the entire run
> scripts reduces the iteration rate substantially.
> 
> Hence add an option to check to allow fstests to loop a number of
> times over the configured test set without stopping.

Hi Dave,

this is useful as I am often doing the same. However what I am really
missing is the ability to end the loop when a test fails and the ability
to run tests in infinite loop (or until the test fails).

It should be easy modification to make, what do you think ?

-Lukas

> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/check b/check
> index 2e148e57..2676b619 100755
> --- a/check
> +++ b/check
> @@ -26,6 +26,7 @@ subdir_xfile=""
>  brief_test_summary=false
>  do_report=false
>  DUMP_OUTPUT=false
> +iterations=1
>  
>  # This is a global variable used to pass test failure text to reporting gunk
>  _err_msg=""
> @@ -66,6 +67,7 @@ check options
>      -n			show me, do not run tests
>      -T			output timestamps
>      -r			randomize test order
> +    -i <n>		iterate the test list <n> times
>      -d			dump test output to stdout
>      -b			brief test summary
>      -R fmt[,fmt]	generate report in formats specified. Supported format: [xunit]
> @@ -297,7 +299,7 @@ while [ $# -gt 0 ]; do
>  
>  	-n)	showme=true ;;
>          -r)	randomize=true ;;
> -
> +	-i)	iterations=$2; shift ;;
>  	-T)	timestamp=true ;;
>  	-d)	DUMP_OUTPUT=true ;;
>  	-b)	brief_test_summary=true;;
> @@ -525,7 +527,10 @@ else
>  	trap "_wrapup; exit \$status" 0 1 2 3 15
>  fi
>  
> -for section in $HOST_OPTIONS_SECTIONS; do
> +function run_section()
> +{
> +	local section=$1
> +
>  	OLD_FSTYP=$FSTYP
>  	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
>  	get_next_config $section
> @@ -540,7 +545,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  			fi
>  		done
>  		if $skip; then
> -			continue
> +			return
>  		fi
>  	fi
>  
> @@ -554,7 +559,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  			fi
>  		done
>  		if $skip; then
> -			continue
> +			return
>  		fi
>  	fi
>  
> @@ -700,6 +705,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  		seqres="$REPORT_DIR/$seqnum"
>  
>  		mkdir -p $RESULT_DIR
> +		rm -f ${RESULT_DIR}/require_scratch*
> +		rm -f ${RESULT_DIR}/require_test*
>  		echo -n "$seqnum"
>  
>  		if $showme; then
> @@ -858,6 +865,12 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  
>  	_test_unmount 2> /dev/null
>  	_scratch_unmount 2> /dev/null
> +}
> +
> +for ((iters = 0; iters < $iterations; iters++)) do
> +	for section in $HOST_OPTIONS_SECTIONS; do
> +		run_section $section
> +	done
>  done
>  
>  interrupt=false
> -- 
> 2.26.2.761.g0e0b3e54be
> 

