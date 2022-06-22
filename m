Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7538C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jun 2022 05:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiFVFPP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jun 2022 01:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356650AbiFVFPO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jun 2022 01:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 270E21139
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 22:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655874912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hFdYkDy+FDoMfcLqbQQJDWUOmFPvbgWqNignNdD+nRY=;
        b=WnXol9cwYRFedplOZpfEkl1rD5D136ng1rsLOSM7J7tbswQXdH6Sc85JbZbxOWNArL0E4w
        21+VzzAWM60hYu/9WPjKlbVk6Fir292v4p/ZHS4+HHquYJ0orzMBPZA4jNjlzI49G0tymK
        pXBJ4VcqdVoAsukvxiDWwRM5XQAd81M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-nRJP6wq1MzW90FccpGtmgg-1; Wed, 22 Jun 2022 01:15:09 -0400
X-MC-Unique: nRJP6wq1MzW90FccpGtmgg-1
Received: by mail-qk1-f198.google.com with SMTP id w22-20020a05620a445600b006a6c18678f2so18813680qkp.4
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 22:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hFdYkDy+FDoMfcLqbQQJDWUOmFPvbgWqNignNdD+nRY=;
        b=f3JFR5LKjob1mGpeD+nk0W7HBvYRkVmnpZpG4O4Ur5Xau9ljJAMwae+XmGGPOP0bQR
         k1s5CCZbYsff+aM5+gxj7BMUflPpyl5DUfAX30n0QDJVeYryRPwKVUnlByIGKXRC1oUL
         f3K0i/DNLwqF4FGVRA/TQlzet8WRC3e5/q6mRKBR2315s6cQ34BOulzgi48shi+SSjbV
         r2MIqwRC+0RvyKHGR/CNpVFVrvtBOgIhDuZbGoyORkel0jikO5EzcCAnhiNq2RdnWRNJ
         ioc9h339Vg94YmjU0ldpBqdNytIJv1KqJ22KIHhxV7ZoFKBK/Jz8XKvp6fT2MtlSA47e
         ZbRg==
X-Gm-Message-State: AJIora+wVpYC/9GnGvomM5Lq4DcRhSKNYT6XbMGAnE9rR19n0KQMKMrb
        JvqbZ8+WGEr2++1uoqnppmN9nsXzD/9VAfW3cXDpHifTA2VL+k2dPeU0KTvWIl++oLJWa5z8uaw
        CMg0AAUVPt2kiTHByvQ==
X-Received: by 2002:a05:6214:29e6:b0:470:44d9:1ec5 with SMTP id jv6-20020a05621429e600b0047044d91ec5mr10861348qvb.95.1655874909052;
        Tue, 21 Jun 2022 22:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vt/rKfqUEytgGkHH4tnXQReyivH+jT+VezifecgL6KD5cWZVKILIpuFsBCGC6L/BTbDk1euQ==
X-Received: by 2002:a05:6214:29e6:b0:470:44d9:1ec5 with SMTP id jv6-20020a05621429e600b0047044d91ec5mr10861339qvb.95.1655874908745;
        Tue, 21 Jun 2022 22:15:08 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bq9-20020a05620a468900b006a700aad48bsm17185483qkb.91.2022.06.21.22.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 22:15:08 -0700 (PDT)
Date:   Wed, 22 Jun 2022 13:15:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 6/6] check: remove err and first_test variables
Message-ID: <20220622051503.n25iwnilfnk7u36n@zlang-mailbox>
References: <20220620192934.21694-1-ddiss@suse.de>
 <20220620192934.21694-7-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620192934.21694-7-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 09:29:34PM +0200, David Disseldorp wrote:
> tc_status can be used for both of these.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---

Make sense.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  check | 41 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/check b/check
> index 8423d7a1..2ea2920f 100755
> --- a/check
> +++ b/check
> @@ -725,23 +725,17 @@ function run_section()
>  	seqres="$check"
>  	_check_test_fs
>  
> -	err=false
> -	first_test=true
> +	local tc_status="init"
>  	prev_seq=""
>  	for seq in $list ; do
>  		# Run report for previous test!
> -		if $err ; then
> +		if [ "$tc_status" == "fail" ]; then
>  			bad+=("$seqnum")
> -			tc_status="fail"
>  		fi
> -		if $do_report && ! $first_test ; then
> -			if [ $tc_status != "expunge" ] ; then
> -				_make_testcase_report "$prev_seq" "$tc_status"
> -			fi
> +		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
> +			_make_testcase_report "$prev_seq" "$tc_status"
>  		fi
> -		first_test=false
>  
> -		err=false
>  		prev_seq="$seq"
>  		if [ ! -f $seq ]; then
>  			# Try to get full name in case the user supplied only
> @@ -845,7 +839,7 @@ function run_section()
>  		if [ -f core ]; then
>  			_dump_err_cont "[dumped core]"
>  			mv core $RESULT_BASE/$seqnum.core
> -			err=true
> +			tc_status="fail"
>  		fi
>  
>  		if [ -f $seqres.notrun ]; then
> @@ -870,15 +864,15 @@ function run_section()
>  			_scratch_unmount 2> /dev/null
>  			rm -f ${RESULT_DIR}/require_test*
>  			rm -f ${RESULT_DIR}/require_scratch*
> -			err=true
> +			tc_status="fail"
>  		else
>  			# The test apparently passed, so check for corruption
>  			# and log messages that shouldn't be there.  Run the
>  			# checking tools from a subshell with adjusted OOM
>  			# score so that the OOM killer will target them instead
>  			# of the check script itself.
> -			(_adjust_oom_score 250; _check_filesystems) || err=true
> -			_check_dmesg || err=true
> +			(_adjust_oom_score 250; _check_filesystems) || tc_status="fail"
> +			_check_dmesg || tc_status="fail"
>  		fi
>  
>  		# Reload the module after each test to check for leaks or
> @@ -892,7 +886,7 @@ function run_section()
>  
>  		# Scan for memory leaks after every test so that associating
>  		# a leak to a particular test will be as accurate as possible.
> -		_check_kmemleak || err=true
> +		_check_kmemleak || tc_status="fail"
>  
>  		# test ends after all checks are done.
>  		$timestamp && _timestamp
> @@ -900,7 +894,7 @@ function run_section()
>  
>  		if [ ! -f $seq.out ]; then
>  			_dump_err "no qualified output"
> -			err=true
> +			tc_status="fail"
>  			continue;
>  		fi
>  
> @@ -909,7 +903,7 @@ function run_section()
>  		# version.
>  		sed -i "s/\`/\'/g" $tmp.out
>  		if diff $seq.out $tmp.out >/dev/null 2>&1 ; then
> -			if ! $err ; then
> +			if [ "$tc_status" != "fail" ]; then
>  				echo "$seqnum `expr $stop - $start`" >>$tmp.time
>  				echo -n " `expr $stop - $start`s"
>  			fi
> @@ -926,10 +920,10 @@ function run_section()
>  				echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
>  					" to see the entire diff)"
>  			fi; } | sed -e 's/^\(.\)/    \1/'
> -			err=true
> +			tc_status="fail"
>  		fi
>  		if [ -f $seqres.hints ]; then
> -			if $err; then
> +			if [ "$tc_status" == "fail" ]; then
>  				echo
>  				cat $seqres.hints
>  			else
> @@ -939,14 +933,11 @@ function run_section()
>  	done
>  
>  	# make sure we record the status of the last test we ran.
> -	if $err ; then
> +	if [ "$tc_status" == "fail" ]; then
>  		bad+=("$seqnum")
> -		tc_status="fail"
>  	fi
> -	if $do_report && ! $first_test ; then
> -		if [ $tc_status != "expunge" ] ; then
> -			_make_testcase_report "$prev_seq" "$tc_status"
> -		fi
> +	if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
> +		_make_testcase_report "$prev_seq" "$tc_status"
>  	fi
>  
>  	sect_stop=`_wallclock`
> -- 
> 2.35.3
> 

