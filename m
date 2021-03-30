Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9908C433C1
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 04:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FDB61580
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 04:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhC3EzX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Mar 2021 00:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229737AbhC3EzW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Mar 2021 00:55:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3EBE61919;
        Tue, 30 Mar 2021 04:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617080122;
        bh=+fz0CJxxvNknCCyXc5N1GxfBWM39yHSq95kNYCDmZV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hu7KSZGylP+IuyPQ66gKicRsNSrN4UjGxoWIKVBJg3a1utW8UK2zA5txdPD/D4cbz
         fGlF2wwt3JVq6O8oxsa+fh62XuSRF1xCLaH1Qves1gBDbVK9WYpRBfP2TuFXDOu1gF
         D8JRmXr4IBssjcZj7l+WvJtD3RDm7eI+wcQgHNY54OhoMu5OP9+FZ8t+xVnZqfFt6s
         IEn39HC5qSDHY+ZwYGQI8yuvHMqLAldlTYDNv3mdedc7wU+MIv+UkTun7m1XohGReL
         w78lQacz/+F5O872Wjv4EZ1BaJruPcYkb1sc8kuTFBZfybaayKfvfn/7UuWmkTWJK8
         iyiQc2WhE5g6Q==
Date:   Mon, 29 Mar 2021 21:55:21 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/233,270: unlimit the max locked memory size
 for io_uring
Message-ID: <20210330045521.GT1670408@magnolia>
References: <20210330005942.536259-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330005942.536259-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 30, 2021 at 08:59:42AM +0800, Zorro Lang wrote:
> The ltp/fsstress always fails on io_uring_queue_init() by returnning
> ENOMEM. Due to io_uring accounts memory it needs under the rlimit
> memlocked option, which can be quite low on some setups, especially
> on 64K pagesize machine. root isn't under this restriction, but
> regular users are. So only g/233 and g/270 which use $qa_user to run
> fsstress are failed.
> 
> To avoid this failure, set max locked memory to unlimited before doing
> fsstress, then restore it after test done.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> V2 removed `ulimit -l $lmem`, due to each case runs in child process, won't
> affect other testing.
> 
> Thanks,
> Zorro
> 
>  tests/generic/233 | 6 ++++++
>  tests/generic/270 | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/tests/generic/233 b/tests/generic/233
> index 7eda5774..cc794c79 100755
> --- a/tests/generic/233
> +++ b/tests/generic/233
> @@ -43,6 +43,12 @@ _fsstress()
>  -f rename=10 -f fsync=2 -f write=15 -f dwrite=15 \
>  -n $count -d $out -p 7`
>  
> +	# io_uring accounts memory it needs under the rlimit memlocked option,
> +	# which can be quite low on some setups (especially 64K pagesize). root
> +	# isn't under this restriction, but regular users are. To avoid the
> +	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
> +	# temporarily.
> +	ulimit -l unlimited
>  	echo "fsstress $args" >> $seqres.full
>  	if ! su $qa_user -c "$FSSTRESS_PROG $args" | tee -a $seqres.full | _filter_num

/me kinda feels like this should be refactored into a common helper, but
somehow when I try to picture that in my head all I can see is a
screeching nightmare of bash goop so feel free to ignore me. :)

--D

>  	then
> diff --git a/tests/generic/270 b/tests/generic/270
> index 3d8656d4..e93940ef 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -37,6 +37,12 @@ _workout()
>  	cp $FSSTRESS_PROG  $tmp.fsstress.bin
>  	$SETCAP_PROG cap_chown=epi  $tmp.fsstress.bin
>  
> +	# io_uring accounts memory it needs under the rlimit memlocked option,
> +	# which can be quite low on some setups (especially 64K pagesize). root
> +	# isn't under this restriction, but regular users are. To avoid the
> +	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
> +	# temporarily.
> +	ulimit -l unlimited
>  	(su $qa_user -c "$tmp.fsstress.bin $args" &) > /dev/null 2>&1
>  
>  	echo "Run dd writers in parallel"
> -- 
> 2.30.2
> 
