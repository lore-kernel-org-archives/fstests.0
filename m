Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA043C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 04:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiEXEpV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 00:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiEXEpT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 00:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0204A8BD0C
        for <fstests@vger.kernel.org>; Mon, 23 May 2022 21:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653367516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVpIvJUvnqhOyn4AeRtvH6vizmpDjWylYJ1wgPnXUMQ=;
        b=EX01f+OfhFTyKtv13t82/GAwrroU7KakmQZb97ngVl+OTtcyBOr52cdQjAWGxCzunNoC3H
        0YUJckxgWwkXPdu0hPQ2zZI92w9iOhSxFaMAyAtle7dJjK39/xl4VuN3EgfuVpqnYfsT3G
        HeMZO2qLyliZlfvqG07V/Tu/ATxDoNA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-2wC8Bt0NNO-w5N2qmb04DA-1; Tue, 24 May 2022 00:45:14 -0400
X-MC-Unique: 2wC8Bt0NNO-w5N2qmb04DA-1
Received: by mail-oo1-f69.google.com with SMTP id b4-20020a4a98c4000000b00362174f7ae2so8130787ooj.0
        for <fstests@vger.kernel.org>; Mon, 23 May 2022 21:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aVpIvJUvnqhOyn4AeRtvH6vizmpDjWylYJ1wgPnXUMQ=;
        b=7Z2gfY1xxNpVN+4/2ekAkag/oCKuXA2MTik7Lm1xNu1acsxT0aOJr4bjEo2+WiIgqB
         JdDSXhNRInWEVY74rTLA49nu8oiD/wYlHq3ZpBZcbp3hXCyCaCL6zqoG7TQ6nk0G5bE1
         Py7mA9kGvbYN6wnUD5GTlGq8Q1FDvz+mAroLMSkNraVIorsEWueXq3AnaL3apeNHH671
         9sBpZ6uMklcSiIF0xxq/tVS7g0EWcIp7EK3IBuZi27aLedgx0IJpYL7b7wuu0aU0u9X5
         hBu7DiDjNCxFbp174NV3H3PhEbNx9at8U29ZIOXGuvn0IJJHzMF1LRA0b65NF3LI9U0r
         PfIg==
X-Gm-Message-State: AOAM533U/iAdeYFuAxSVWNhpJ6GQ3UzO/4rdh4TFBfaJRLaVacdQ3Wuq
        x29s7YdnKQDYiNGXmxgUsxTHKO1KJ1t6EflYq8+qQdlXUUXKe3C3RvJgNi/Xlu/v8/jvja+coP4
        m5jI5nqq4T5R32AzEGQ==
X-Received: by 2002:a54:4f19:0:b0:325:338e:ff52 with SMTP id e25-20020a544f19000000b00325338eff52mr1379590oiy.98.1653367513608;
        Mon, 23 May 2022 21:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqxOdFwOKtDVttxKN/N0z5Z5reMYC6DHtGqyobe+Ts98GSz6ZT+4Sd25ukE1lS7/eFVGkapg==
X-Received: by 2002:a54:4f19:0:b0:325:338e:ff52 with SMTP id e25-20020a544f19000000b00325338eff52mr1379586oiy.98.1653367513380;
        Mon, 23 May 2022 21:45:13 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u2-20020a05687004c200b000f23d04cd56sm2906251oam.44.2022.05.23.21.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 21:45:12 -0700 (PDT)
Date:   Tue, 24 May 2022 12:45:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] ceph/001: skip metrics check if no copyfrom mount option
 is used
Message-ID: <20220524044507.m3drhwpn2orfp7my@zlang-mailbox>
References: <20220520105055.31520-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520105055.31520-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 20, 2022 at 11:50:55AM +0100, Luís Henriques wrote:
> Checking the metrics is only valid if 'copyfrom' mount option is
> explicitly set, otherwise the kernel won't be doing any remote object
> copies.  Fix the logic to skip this metrics checking if 'copyfrom' isn't
> used.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---

The code logic looks good to me, but I'm not familiar with cephfs, so if there's
not review points or objection from ceph-fs, I'll merge this patch this week.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  tests/ceph/001 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/ceph/001 b/tests/ceph/001
> index 7970ce352bab..2e6a5e6be2d6 100755
> --- a/tests/ceph/001
> +++ b/tests/ceph/001
> @@ -86,11 +86,15 @@ check_copyfrom_metrics()
>  	local copies=$4
>  	local c1=$(get_copyfrom_total_copies)
>  	local s1=$(get_copyfrom_total_size)
> +	local hascopyfrom=$(_fs_options $TEST_DEV | grep "copyfrom")
>  	local sum
>  
>  	if [ ! -d $metrics_dir ]; then
>  		return # skip metrics check if debugfs isn't mounted
>  	fi
> +	if [ -z $hascopyfrom ]; then
> +		return # ... or if we don't have copyfrom mount option
> +	fi
>  
>  	sum=$(($c0+$copies))
>  	if [ $sum -ne $c1 ]; then
> 

