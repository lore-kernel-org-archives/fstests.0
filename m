Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168C1C433FE
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Nov 2022 12:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiKFMLo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Nov 2022 07:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiKFMLn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Nov 2022 07:11:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AECDE98
        for <fstests@vger.kernel.org>; Sun,  6 Nov 2022 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667736639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/AYguhDDjAiXGEyUSpFE54KjLO8An9FvEOwXkRHJM3M=;
        b=F+Bs67LqemD+tg/k+1TGAfjcd9ovnTwqq2aY+RqiDT+sWn0t00Z/58pXDVyWQ8NAsmAHVQ
        KawtNYkxZu818CzissWBeA3FpxXjJThK7O2kOBXV32yfcnDNhyqslNBS4UH7xpUUTO5cwU
        aor6IdEovyNIGA3NwwQS5DtVjQCEuso=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-491-4Mam2oVENaCgfaG6x7mdiw-1; Sun, 06 Nov 2022 07:10:38 -0500
X-MC-Unique: 4Mam2oVENaCgfaG6x7mdiw-1
Received: by mail-qk1-f197.google.com with SMTP id j13-20020a05620a410d00b006e08208eb31so8033198qko.3
        for <fstests@vger.kernel.org>; Sun, 06 Nov 2022 04:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AYguhDDjAiXGEyUSpFE54KjLO8An9FvEOwXkRHJM3M=;
        b=QH3kD6bhdVXrUXYGsnpXPmf1cXYDDXiynAY9A9NXPoLq55adt9wznSGON9hRoL/rfI
         9JALTDcpFetL8E4dvzjbQLpXLcOe8C2dggx3MZJclYbJ1H7owQYJaHklRc2AEyAofu5R
         vZse8rwzwzbEt4eqF1JJ/X6e5+2cz/oIMi9190OB+2KaBPofL0qQg0A4e6ccY+i88gQP
         DV2W88rm6AsEoAqDOJ1xk0ZZxYt+IlJM9kDKEi+iU6NXQP8ytZd3uVBSZAmk9dOaCOOj
         GxZswwtFqWHm/AZOfdvtufgqhuadlZ6j73uVcBgl2OQj251LTgXMhcTGORXxR37atkY0
         bUAg==
X-Gm-Message-State: ACrzQf1RlXUO1nLs18LXuncLEWjsNyIUD+cWoOWQY6YytD3lRfwUno0c
        8mMbeTZyUCsotpNe0YK8TsICGEwVAREpaI5kbCEvtM5I8AdY1slGPkNrrak3/pHkJEX3Dckt9JN
        k99ixC5RbHM0Gps0ZuA==
X-Received: by 2002:a05:622a:99b:b0:3a5:1984:bdc4 with SMTP id bw27-20020a05622a099b00b003a51984bdc4mr33876635qtb.239.1667736637574;
        Sun, 06 Nov 2022 04:10:37 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6wc1jHf9EEU7yBruRPGtlJvLEBihANIlhWcZNfeSaPZ2G0qrsAc7P8wTM7oR3GFJ2tJ9Fs9A==
X-Received: by 2002:a05:622a:99b:b0:3a5:1984:bdc4 with SMTP id bw27-20020a05622a099b00b003a51984bdc4mr33876620qtb.239.1667736637302;
        Sun, 06 Nov 2022 04:10:37 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w11-20020a05620a424b00b006f474e6a715sm4080625qko.131.2022.11.06.04.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 04:10:36 -0800 (PST)
Date:   Sun, 6 Nov 2022 20:10:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
References: <20221105182918.24099-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105182918.24099-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Nov 05, 2022 at 02:29:18PM -0400, Theodore Ts'o wrote:
> From: Eric Whitney <enwlinux@gmail.com>
> 
> generic/455 fails when run on an ext4 bigalloc file system.  Its
> fsx invocations can make insert range and collapse range calls whose
> arguments are not cluster aligned, and ext4 will fail those calls for
> bigalloc.  They can be suppressed by adding the FSX_AVOID environment
> variable to the fsx invocation and setting its value appropriately in
> the test environment, as is done for other fsx-based tests.  This
> avoids the need to exclude the test to avoid failures and makes it
> possible to take advantage of the remainder of its coverage.
> 
> [ Also fix generic/457, as requested by Dave Chinner -- TYT]
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
> 
> This is a respin of "generic/455: add $FSX_AVOID" which Eric posted here:
> https://lore.kernel.org/r/20221021211950.510006-1-enwlinux@gmail.com
> it adds a similar fix for generic/457, as requested by Dave and Zorro.

Thanks Ted, actually I'm going to merge this patch (with g/457 fix by myself)
this week.

But looks like you missed the change on g/457 (might forgot to commit). Anyway,
I think it's not worth wasting one more week for this small change, I'll help
to change g/457 when I merge this patch.

Thanks,
Zorro

> 
>  tests/generic/455 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/455 b/tests/generic/455
> index 649b54108..c13d872c6 100755
> --- a/tests/generic/455
> +++ b/tests/generic/455
> @@ -77,7 +77,7 @@ FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
>  seeds=(0 0 0 0)
>  # Run fsx for a while
>  for j in `seq 0 $((NUM_FILES-1))`; do
> -	run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
> +	run_check $here/ltp/fsx $FSX_OPTS $FSX_AVOID -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
>  done
>  wait
>  
> -- 
> 2.31.0
> 

