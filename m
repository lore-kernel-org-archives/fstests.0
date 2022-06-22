Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A4C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jun 2022 05:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356084AbiFVFMM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jun 2022 01:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiFVFMJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jun 2022 01:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98E5335DC5
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 22:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655874727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DmQgI9oZ4FEsT/GdLmebCMyDofLpQdaq4nJRwb3I0nk=;
        b=NBvC0e3Wp7+NKQnckaF6wM8J94iX8FvSWRAGvu919Yz7zyZtdu2khkxACsARE9GuzJiAay
        +xX+bkq6W61cwsk3ylJ3NZt23R8vy69ECCOHF7/5lKMZOAsGi6JJnChkKiPvC11Lz6cQyS
        0JdcSC2Ye0nIIYrsSehcYcuLpex77iQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-lA-rZixsPWqTy6uosSyXnQ-1; Wed, 22 Jun 2022 01:12:05 -0400
X-MC-Unique: lA-rZixsPWqTy6uosSyXnQ-1
Received: by mail-qk1-f199.google.com with SMTP id o10-20020a05620a2a0a00b006a77a64cd23so18745006qkp.21
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 22:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmQgI9oZ4FEsT/GdLmebCMyDofLpQdaq4nJRwb3I0nk=;
        b=6zVhQMJEOiEJ4vZT5og54B0pC0VOVqMQ4HU0bXRMCx/N2ScYklTAVTovvc2PjGpETS
         HIvtUB/oa9LJIj+1vANMlcTwXBCD2qdVhFz7r7E2UtvnUrtl+G7pTREp/PlBmVR6sohB
         tS7lANO1gx0XMcoY/RpV+Y1MsIxwy7mEEroLGqJE1XSR0U7LTtJgffjYZon0IzQgx4Xx
         RbGORt4stAAX4Wcf7duCyQ3leY715cC4EbLS9bjQq5L3eT0dSs2PD6FBk9A5dtlCR74q
         mAweYNp6k9MyTv8RCKIoHlBVb4jJlEB0HHX5DSG+Q7t16vrgtG1+Q50irfs29roOLe3x
         KBKQ==
X-Gm-Message-State: AJIora9n7//relZK5+JKYe31+D6SqtEe35O2sXH1sHnOZc2h9bJO/Wqu
        B2o5TPk9L9z3fInqRa87TMJUIrjdJVQFnZOxCZ4/kXb+aKADOGRk/RhHRujseymd2G5cK8u9kxj
        Px6af645xvNX8QFcZtg==
X-Received: by 2002:a37:9cd0:0:b0:6ae:d801:8bc0 with SMTP id f199-20020a379cd0000000b006aed8018bc0mr1028513qke.456.1655874724669;
        Tue, 21 Jun 2022 22:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sTkhOiwNIla94RWd5HByPiIeuNcIT/Evtd3JgXkZAbc7i8kk02bG2Yi07wlhW2Z9s6n68QbA==
X-Received: by 2002:a37:9cd0:0:b0:6ae:d801:8bc0 with SMTP id f199-20020a379cd0000000b006aed8018bc0mr1028505qke.456.1655874724373;
        Tue, 21 Jun 2022 22:12:04 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m19-20020a05620a24d300b006a67eb4610fsm17196156qkn.116.2022.06.21.22.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 22:12:03 -0700 (PDT)
Date:   Wed, 22 Jun 2022 13:11:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 5/6] check: use arrays instead of separate n_ counters
Message-ID: <20220622051158.rfpnp7mnuvhpj4t2@zlang-mailbox>
References: <20220620192934.21694-1-ddiss@suse.de>
 <20220620192934.21694-6-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620192934.21694-6-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 09:29:33PM +0200, David Disseldorp wrote:
> The separate n_try, n_bad and n_notrun counters are unnecessary when
> the corresponding lists are switched to bash arrays.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---



>  check | 72 ++++++++++++++++++++++++++---------------------------------
>  1 file changed, 32 insertions(+), 40 deletions(-)
> 
> diff --git a/check b/check
> index a5183d3a..8423d7a1 100755
> --- a/check
> +++ b/check
> @@ -8,13 +8,10 @@ tmp=/tmp/$$
>  status=0
>  needwrap=true
>  needsum=true
> -n_try=0
> -try=""
> -n_bad=0
> +try=()
>  sum_bad=0
> -bad=""
> -n_notrun=0
> -notrun=""
> +bad=()
> +notrun=()
>  interrupt=true
>  diff="diff -u"
>  showme=false
> @@ -412,10 +409,9 @@ fi
>  
>  _wipe_counters()
>  {
> -	n_try="0"
> -	n_bad="0"
> -	n_notrun="0"
> -	unset try notrun bad
> +	try=()
> +	notrun=()
> +	bad=()
>  }
>  
>  _global_log() {
> @@ -433,7 +429,7 @@ _wrapup()
>  	if $showme && $needwrap; then
>  		if $do_report; then
>  			# $showme = all selected tests are notrun (no tries)
> -			_make_section_report "$n_notrun" "0" "$n_notrun"
> +			_make_section_report "${#notrun[*]}" "0" "${#notrun[*]}"
>  		fi
>  		needwrap=false
>  	elif $needwrap; then
> @@ -458,12 +454,12 @@ _wrapup()
>  
>  		echo "SECTION       -- $section" >>$tmp.summary
>  		echo "=========================" >>$tmp.summary
> -		if [ ! -z "$n_try" -a $n_try != 0 ]; then
> +		if ((${#try[*]} > 0)); then
>  			if [ $brief_test_summary == "false" ]; then
> -				echo "Ran:$try"
> -				echo "Ran:$try" >>$tmp.summary
> +				echo "Ran: ${try[*]}"
                                          ^
No objection from me. And you even took into account the head space in original
format :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +				echo "Ran: ${try[*]}" >>$tmp.summary
>  			fi
> -			_global_log "Ran:$try"
> +			_global_log "Ran: ${try[*]}"
>  		fi
>  
>  		$interrupt && echo "Interrupted!" | tee -a $check.log
> @@ -472,34 +468,34 @@ _wrapup()
>  				${REPORT_DIR}/check.log
>  		fi
>  
> -		if [ ! -z "$notrun" ]; then
> +		if ((${#notrun[*]} > 0)); then
>  			if [ $brief_test_summary == "false" ]; then
> -				echo "Not run:$notrun"
> -				echo "Not run:$notrun" >>$tmp.summary
> +				echo "Not run: ${notrun[*]}"
> +				echo "Not run: ${notrun[*]}" >>$tmp.summary
>  			fi
> -			_global_log "Not run:$notrun"
> +			_global_log "Not run: ${notrun[*]}"
>  		fi
>  
> -		if [ ! -z "$n_bad" -a $n_bad != 0 ]; then
> -			echo "Failures:$bad"
> -			echo "Failed $n_bad of $n_try tests"
> -			_global_log "Failures:$bad"
> -			_global_log "Failed $n_bad of $n_try tests"
> -			echo "Failures:$bad" >>$tmp.summary
> -			echo "Failed $n_bad of $n_try tests" >>$tmp.summary
> +		if ((${#bad[*]} > 0)); then
> +			echo "Failures: ${bad[*]}"
> +			echo "Failed ${#bad[*]} of ${#try[*]} tests"
> +			_global_log "Failures: ${bad[*]}"
> +			_global_log "Failed ${#bad[*]} of ${#try[*]} tests"
> +			echo "Failures: ${bad[*]}" >>$tmp.summary
> +			echo "Failed ${#bad[*]} of ${#try[*]} tests" >>$tmp.summary
>  		else
> -			echo "Passed all $n_try tests"
> -			_global_log "Passed all $n_try tests"
> -			echo "Passed all $n_try tests" >>$tmp.summary
> +			echo "Passed all ${#try[*]} tests"
> +			_global_log "Passed all ${#try[*]} tests"
> +			echo "Passed all ${#try[*]} tests" >>$tmp.summary
>  		fi
>  		echo "" >>$tmp.summary
>  		if $do_report; then
> -			_make_section_report "$n_try" "$n_bad" "$n_notrun"
> +			_make_section_report "${#try[*]}" "${#bad[*]}" "${#notrun[*]}"
>  		fi
>  		needwrap=false
>  	fi
>  
> -	sum_bad=`expr $sum_bad + $n_bad`
> +	sum_bad=`expr $sum_bad + ${#bad[*]}`
>  	_wipe_counters
>  	rm -f /tmp/*.rawout /tmp/*.out /tmp/*.err /tmp/*.time
>  	if ! $OPTIONS_HAVE_SECTIONS; then
> @@ -735,8 +731,7 @@ function run_section()
>  	for seq in $list ; do
>  		# Run report for previous test!
>  		if $err ; then
> -			bad="$bad $seqnum"
> -			n_bad=`expr $n_bad + 1`
> +			bad+=("$seqnum")
>  			tc_status="fail"
>  		fi
>  		if $do_report && ! $first_test ; then
> @@ -794,7 +789,7 @@ function run_section()
>  			start=0
>  			stop=0
>  			tc_status="list"
> -			n_notrun=`expr $n_notrun + 1`
> +			notrun+=("$seqnum")
>  			continue
>  		fi
>  
> @@ -815,8 +810,7 @@ function run_section()
>  		fi
>  
>  		# record that we really tried to run this test.
> -		try="$try $seqnum"
> -		n_try=`expr $n_try + 1`
> +		try+=("$seqnum")
>  
>  		awk 'BEGIN {lasttime="       "} \
>  		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
> @@ -861,8 +855,7 @@ function run_section()
>  			$timestamp && echo " [not run]" && \
>  				      echo -n "	$seqnum -- "
>  			cat $seqres.notrun
> -			notrun="$notrun $seqnum"
> -			n_notrun=`expr $n_notrun + 1`
> +			notrun+=("$seqnum")
>  			tc_status="notrun"
>  
>  			# Unmount the scratch fs so that we can wipe the scratch
> @@ -947,8 +940,7 @@ function run_section()
>  
>  	# make sure we record the status of the last test we ran.
>  	if $err ; then
> -		bad="$bad $seqnum"
> -		n_bad=`expr $n_bad + 1`
> +		bad+=("$seqnum")
>  		tc_status="fail"
>  	fi
>  	if $do_report && ! $first_test ; then
> -- 
> 2.35.3
> 

