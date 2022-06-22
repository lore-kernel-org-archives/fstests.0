Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E072C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jun 2022 05:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiFVFDt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jun 2022 01:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiFVFDs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jun 2022 01:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6207D35876
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 22:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655874224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qwnYaolPCbFLHrrxsgzmacvTKlppNFFiox70SA/o/Ds=;
        b=EwlRltkL1VSD8KJDlXw+Rm5ybQjJY5EBydMaF2cDYPwk7NNZ+cj/Hh4Rq9hDIa8BJA1jas
        s/49CS/qgQeOrCQpkD119X6ITkcPDU/Uxm6FwRKd9WRhVBvkkhgb30BJI/GvYqihbzg7bY
        Xgc6wC8dhWa+E6qknynfx8ophzSrNms=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-5LpaRmBqPmCW-tu716_mxw-1; Wed, 22 Jun 2022 01:03:42 -0400
X-MC-Unique: 5LpaRmBqPmCW-tu716_mxw-1
Received: by mail-qv1-f69.google.com with SMTP id mr11-20020a056214348b00b004705c0cb439so2086660qvb.19
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 22:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qwnYaolPCbFLHrrxsgzmacvTKlppNFFiox70SA/o/Ds=;
        b=d9afyXq850hVpumDyM2LAxpq7XxjKysxtinhuHBR6Gba4457G7aI0vukVMX5lkcKfb
         o1fyT80uixy2iDhYwePMGCgz7RsYo2pPL8D0AsHdj+bSYEb6WDjiYq0PPhngqyrdpCP8
         ZvKJmTVuUznaXZAzpamuUmba535p9UlPJ/iQc3+0IGbKs14dHy+DAcaJtkrweegbSOuj
         BssAhjuYe4osW176lze5Z5i1KbEVEierARSxCKOt+IwQMNce0l3oXbjibdRjxR4YxBuP
         3Nu/ui/ubWglgGYNZFn94/SYxvYJ2Gqa+Z3F2yIm6IRDG37ilTqf3FdLEMuMf3W+MxH4
         pMKA==
X-Gm-Message-State: AJIora+EvZRFsNRnmkbquJB0io5o0lfMvLKGLmZ81en9UVt2tl5Icga1
        A/MWbhUQDwxtMYPC6mdIb1GAQ67BpRgbnru3EB8meDnHYP2GcmL4QRIYMk16wGG99N9eQYwZqMC
        505lchI5m+tORIO8Mgg==
X-Received: by 2002:ac8:5996:0:b0:305:1041:372e with SMTP id e22-20020ac85996000000b003051041372emr1412322qte.520.1655874221163;
        Tue, 21 Jun 2022 22:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tDAe+rCgDw5UiaeG7Tw/L4JcUR8tZuH9Mf/Looo5S933KthbKqLrqAxMPHqBlFehhj2UtGwQ==
X-Received: by 2002:ac8:5996:0:b0:305:1041:372e with SMTP id e22-20020ac85996000000b003051041372emr1412316qte.520.1655874220911;
        Tue, 21 Jun 2022 22:03:40 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a410600b006a6d3a6d597sm16958545qko.71.2022.06.21.22.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 22:03:40 -0700 (PDT)
Date:   Wed, 22 Jun 2022 13:03:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 4/6] report: fix xunit tests count
Message-ID: <20220622050335.rdm3vfa3cnj2uxw7@zlang-mailbox>
References: <20220620192934.21694-1-ddiss@suse.de>
 <20220620192934.21694-5-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620192934.21694-5-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 09:29:32PM +0200, David Disseldorp wrote:
> The xunit "section report" provides a tests attribute, which according
> to https://llg.cubic.org/docs/junit/ represents:
> tests=""     <!-- The total number of tests in the suite, required. -->
> 
> The current value is generated as a sum of the $n_try and $n_notrun
> counters. This is incorrect as the $n_try counter already includes tests
> which are run but complete with _notrun.
> One special case exists for $showme (check -n), where $n_try remains
> zero, so $n_notrun can be used as-is.

Thanks for fixing it. So the n_total of xunit report is wrong. I think this
change won't affect anyone's regular testing, but just notice that if someone
use the xunit report, especially depends on the n_total number.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  check         | 13 ++++++-------
>  common/report | 14 +++++++++-----
>  2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/check b/check
> index 43c072d2..a5183d3a 100755
> --- a/check
> +++ b/check
> @@ -430,13 +430,12 @@ _wrapup()
>  	seq="check"
>  	check="$RESULT_BASE/check"
>  
> -	if $showme; then
> -		if $needwrap; then
> -			if $do_report; then
> -				_make_section_report
> -			fi
> -			needwrap=false
> +	if $showme && $needwrap; then
> +		if $do_report; then
> +			# $showme = all selected tests are notrun (no tries)
> +			_make_section_report "$n_notrun" "0" "$n_notrun"
>  		fi
> +		needwrap=false
>  	elif $needwrap; then
>  		if [ -f $check.time -a -f $tmp.time ]; then
>  			cat $check.time $tmp.time  \
> @@ -495,7 +494,7 @@ _wrapup()
>  		fi
>  		echo "" >>$tmp.summary
>  		if $do_report; then
> -			_make_section_report
> +			_make_section_report "$n_try" "$n_bad" "$n_notrun"
>  		fi
>  		needwrap=false
>  	fi
> diff --git a/common/report b/common/report
> index bf05afa9..84d9e0a7 100644
> --- a/common/report
> +++ b/common/report
> @@ -49,9 +49,11 @@ _xunit_add_property()
>  _xunit_make_section_report()
>  {
>  	# xfstest:section ==> xunit:testsuite
> +	local tests_count="$1"
> +	local bad_count="$2"
> +	local notrun_count="$3"
>  	local sect_name=$section
>  	local sect_time=`expr $sect_stop - $sect_start`
> -	local n_total=`expr $n_try + $n_notrun`
>  
>  	if [ $sect_name == '-no-sections-' ]; then
>  		sect_name='global'
> @@ -62,9 +64,8 @@ _xunit_make_section_report()
>  	if [ -z "$date_time" ]; then
>  		date_time=$(date +"%F %T")
>  	fi
> -	local dtime=`echo $date_time| tr  " " 'T'`
> -	local stats="failures=\"$n_bad\" skipped=\"$n_notrun\" tests=\"$n_total\" time=\"$sect_time\""
> -	local hw_info="hostname=\"$HOST\" timestamp=\"$dtime\" "
> +	local stats="failures=\"$bad_count\" skipped=\"$notrun_count\" tests=\"$tests_count\" time=\"$sect_time\""
> +	local hw_info="hostname=\"$HOST\" timestamp=\"${date_time/ /T}\" "
>  	echo "<testsuite name=\"xfstests\" $stats  $hw_info >" >> $REPORT_DIR/result.xml
>  
>  	# Properties
> @@ -149,10 +150,13 @@ _xunit_make_testcase_report()
>  #  Common report generator entry points
>  _make_section_report()
>  {
> +	local tests_count="$1"
> +	local bad_count="$2"
> +	local notrun_count="$3"
>  	for report in $REPORT_LIST; do
>  		case "$report" in
>  		"xunit")
> -			_xunit_make_section_report
> +			_xunit_make_section_report "$tests_count" "$bad_count" "$notrun_count"
>  			;;
>  		*)
>  			_dump_err "format '$report' is not supported"
> -- 
> 2.35.3
> 

