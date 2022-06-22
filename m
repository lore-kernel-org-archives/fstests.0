Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D9C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jun 2022 04:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347603AbiFVEcM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356725AbiFVEcJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jun 2022 00:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C52935842
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 21:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655872328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UhAnDMoOyoLWKdKBlxP+/B8HfYWB+27EA/1Ujhr/+pw=;
        b=cqd/M5+ZTjrKEU7JxSCYAZZTjmEbplvldDGBb8yGY5sb6x/QCra9Y0np8+2M2fQLklw1xE
        bwVwUGlPco/UrBXZDC41CR90FmlojaBeypJh1BsOUjLW3iniXLpedhI452oi3ENmJVhCbk
        /Woh+XEcqtBNJFySjtXP5lyTjopUzAE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-TTZ6ok-ZNH2xXP77kr6uNA-1; Wed, 22 Jun 2022 00:32:06 -0400
X-MC-Unique: TTZ6ok-ZNH2xXP77kr6uNA-1
Received: by mail-qk1-f197.google.com with SMTP id br35-20020a05620a462300b006aedc7ab317so655335qkb.6
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 21:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UhAnDMoOyoLWKdKBlxP+/B8HfYWB+27EA/1Ujhr/+pw=;
        b=Qtq5pA3zLFvsP0wEXPBLZNfffQWQoQ2BDeYOIakeH4hA0NK/nsX5H1Imx5LIu9DTCz
         l38abQDJRV4iqnq7zLHfErWONSqhBV+63qgcJM3j+wHo0iBL71oHnh+ewhFjzofqv5sA
         JF6ZRoBjXY9NU8DRHCAyE/3PqZbjZMNdLlVgB75El8F7XMEDV+rV5fOpF9tlvWFFwWOq
         65TyO9vqRYNIPUa2h+f9yWMo82jBfUzSdYQJTJg5LymByIzXW95ZUYqPU49DT/9Shcxk
         m6O97t8MtYFVTKxhDEVrOSXMalSQeaUTsCdYhNv95giY1ZBYJ94uA1u1Qbrlztgd6wpz
         Js2Q==
X-Gm-Message-State: AJIora9K5+6jjhqKXTviV0K0EyDFVkY9fvLVqmP6jGMAXfvMZnaX1Z4j
        wVajjMklVpFQh3V9T3SzKUcWSp7E94vYTwGTcooTtieUSWSbfeyhSed0M+1PvsNEVXBDMJ4Fzuf
        yWR+WtpaZAMg4556UNw==
X-Received: by 2002:a05:622a:1302:b0:305:1e02:4fee with SMTP id v2-20020a05622a130200b003051e024feemr1470458qtk.242.1655872325249;
        Tue, 21 Jun 2022 21:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tRSU+HKyjbJh/9ThVWbp+e2NhmaTT/m7nLFlywZ4tJWAacP/qtt7JoBIXaaaEOehW1JOys6g==
X-Received: by 2002:a05:622a:1302:b0:305:1e02:4fee with SMTP id v2-20020a05622a130200b003051e024feemr1470447qtk.242.1655872324989;
        Tue, 21 Jun 2022 21:32:04 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s2-20020a05620a29c200b006a6278a2b31sm16648116qkp.75.2022.06.21.21.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:32:04 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:31:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/6] check: simplify check.time parsing
Message-ID: <20220622043159.cve27fmnl2a7n7e2@zlang-mailbox>
References: <20220620192934.21694-1-ddiss@suse.de>
 <20220620192934.21694-3-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620192934.21694-3-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 09:29:30PM +0200, David Disseldorp wrote:
> There's no need to use grep and awk when the latter can do all that's
> needed, including the pretty printing.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  check | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/check b/check
> index 42925e09..43c072d2 100755
> --- a/check
> +++ b/check
> @@ -819,13 +819,9 @@ function run_section()
>  		try="$try $seqnum"
>  		n_try=`expr $n_try + 1`
>  
> -		# slashes now in names, sed barfs on them so use grep
> -		lasttime=`grep -w ^$seqnum $check.time | awk '// {print $2}'`
> -		if [ "X$lasttime" != X ]; then
> -			echo -n " ${lasttime}s ... "
> -		else
> -			echo -n "	" # prettier output with timestamps.
> -		fi
> +		awk 'BEGIN {lasttime="       "} \
> +		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
> +		     END {printf "%s", lasttime}' "$check.time"

I'm not good at 'awk' so much, but this change looks not break old format.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  		rm -f core $seqres.notrun
>  
>  		start=`_wallclock`
> -- 
> 2.35.3
> 

