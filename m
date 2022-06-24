Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BADCC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiFXQGZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiFXQGY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 12:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 087E954FB1
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656086782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wHbakCgDGjabA+iPG+zWlC2WOLbOHqKLwELSvFqZtIc=;
        b=blGFMBDZaLjRo4JhnW3SFV1ha6ERYJGAuAMtzRb851t8wrsJ4ZSF6lMQV8r48e4cDF7r2/
        L7JHHUVtUcK3rKEaOdn0XmhgbJ8evuR9UeMJrFbg1Vv1ITVWXJwooxBG0n0kCKA7TCOrAU
        UbQr0WZkVVhTdvELQBClmnvH6mTaD1o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-c6NDl5WINI2LSCIOsYsQKg-1; Fri, 24 Jun 2022 12:06:20 -0400
X-MC-Unique: c6NDl5WINI2LSCIOsYsQKg-1
Received: by mail-qk1-f199.google.com with SMTP id g194-20020a379dcb000000b006aef700d954so3102410qke.1
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 09:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHbakCgDGjabA+iPG+zWlC2WOLbOHqKLwELSvFqZtIc=;
        b=WMtgghi9fm6tB3LcBvUT8ZvZ+F+DEd7hPYz5bH4yEt6BC9A6q82rmJP8hXbX5OCR7b
         n9vyi6G0ynC5CQ+oxt0fI9bLi16Sfkt86Ya5fp40p9bQwNwFcMCV85X1vvVte0eb91OW
         PBSDHE9LRlwf4U8Bzz5nUq4+3pzSU6s25X8QqMmIk4xET4QErCMOZCdfTCcYvyP+RL4S
         U1c3I1763Tx8CvvkPSjE1sTaV5gGXeak+8tZsu3VgydSsv9tW4pqRno1yg/SBCTTnixA
         y05zBsJgO4orlhWJLQfJBcg0mRqhOJeY/qSTsxRzzT8GvSdw71+aHliqNkKMBm7eM5PH
         6/Uw==
X-Gm-Message-State: AJIora8pBhfwzfGHc0MSf+j+MogxnjObhFLv/SndF4/evEZnCbsqFt58
        35NUoWLtSPeVsb1bBb2E+V6YSrKdKApxJ/AAqS2RmmK3Vv/E1zf8f75oGPj7c7a95n/+l5uot9I
        zQFtiEpo9jo0JCciMgda9wa0HJ6yAINrkF1p5APDEMpuVNPLAffv7Z1VxRjETM5kq2w==
X-Received: by 2002:ac8:5c43:0:b0:315:a78a:4cbe with SMTP id j3-20020ac85c43000000b00315a78a4cbemr13720740qtj.420.1656086779735;
        Fri, 24 Jun 2022 09:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tTY1mV9stPPjHkFyXuALUPRyQLtHWYcs6cep9F20fAWIkZx9eE/unW+v+NtoMotEGwFJ8cSw==
X-Received: by 2002:ac8:5c43:0:b0:315:a78a:4cbe with SMTP id j3-20020ac85c43000000b00315a78a4cbemr13720702qtj.420.1656086779330;
        Fri, 24 Jun 2022 09:06:19 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006a75a0ffc97sm2232735qko.3.2022.06.24.09.06.17
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:06:18 -0700 (PDT)
Date:   Sat, 25 Jun 2022 00:06:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/3] fstests: unfreeze fs on cleanup routines
Message-ID: <20220624160613.brkkcfb55w2vlpmj@zlang-mailbox>
References: <20220621173729.2135249-1-amir73il@gmail.com>
 <20220621173729.2135249-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621173729.2135249-3-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 21, 2022 at 08:37:28PM +0300, Amir Goldstein wrote:
> Many of tests that freeze fs do not make sure that fs is unfrozen on
> test termination.
> 
> Some tests also need to kill and wait for writer processes after
> unfreezing the fs.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

The changes look good, and I didn't find regression issue from it for now.
Please tell me your cencern if anyone has, or I'll merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/068 | 14 ++++++++++----
>  tests/generic/085 |  3 +++
>  tests/generic/280 | 13 ++++++++++++-
>  tests/generic/390 |  8 +++++++-
>  tests/generic/459 |  2 ++
>  tests/generic/491 |  9 +++++++++
>  tests/xfs/011     |  3 ++-
>  tests/xfs/119     |  9 +++++++++
>  tests/xfs/297     | 11 +++++++++++
>  tests/xfs/318     |  3 ++-
>  tests/xfs/325     |  3 ++-
>  tests/xfs/438     |  2 ++
>  12 files changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/generic/068 b/tests/generic/068
> index 56262cd7..eeddf6d1 100755
> --- a/tests/generic/068
> +++ b/tests/generic/068
> @@ -17,9 +17,12 @@ ITERATIONS=10
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -    cd /
> -
> -    trap 0 1 2 3 15
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> +	[ -n "$pid" ] && kill -9 $pid 2>/dev/null
> +	wait $pid
> +	cd /
> +	rm -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -60,6 +63,7 @@ touch $tmp.running
>      rm -r $STRESS_DIR/*
>      rmdir $STRESS_DIR
>  } &
> +pid=$!
>  
>  # start fstest -m loop in a background block; this gets us mmap coverage
>  {
> @@ -75,6 +79,7 @@ touch $tmp.running
>      rm -rf $FSTEST_DIR/*
>      rmdir $FSTEST_DIR
>  } &
> +pid="$pid $!"
>  
>  i=0
>  let ITERATIONS=$ITERATIONS-1
> @@ -103,6 +108,7 @@ done
>  rm $tmp.running
>  
>  # wait for fsstresses to finish
> -wait
> +wait $pid
> +unset pid
>  
>  exit 1
> diff --git a/tests/generic/085 b/tests/generic/085
> index 20cf875a..786d8e6f 100755
> --- a/tests/generic/085
> +++ b/tests/generic/085
> @@ -25,6 +25,8 @@ cleanup_dmdev()
>  {
>  	# in case it's still suspended and/or mounted
>  	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
> +	[ -n "$pid" ] && kill -9 $pid 2>/dev/null
> +	wait $pid
>  	$UMOUNT_PROG $lvdev >/dev/null 2>&1
>  	_dmsetup_remove $node
>  }
> @@ -75,6 +77,7 @@ done &
>  pid="$pid $!"
>  
>  wait $pid
> +unset pid
>  
>  status=0
>  exit
> diff --git a/tests/generic/280 b/tests/generic/280
> index 07144555..8e1ae4d2 100755
> --- a/tests/generic/280
> +++ b/tests/generic/280
> @@ -10,6 +10,17 @@
>  . ./common/preamble
>  _begin_fstest auto quota freeze
>  
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> +	[ -n "$pid" ] && kill -9 $pid 2>/dev/null
> +	wait $pid
> +	cd /
> +	rm -f $tmp.*
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/quota
> @@ -34,7 +45,7 @@ pid=$!
>  sleep 1
>  xfs_freeze -u $SCRATCH_MNT
>  wait $pid
> -_scratch_unmount
> +unset pid
>  
>  # Failure comes in the form of a deadlock.
>  
> diff --git a/tests/generic/390 b/tests/generic/390
> index 20c66e22..e8f6a5dc 100755
> --- a/tests/generic/390
> +++ b/tests/generic/390
> @@ -14,8 +14,12 @@ _begin_fstest auto freeze stress
>  _cleanup()
>  {
>  	cd /
> -	# Make sure $SCRATCH_MNT is unfreezed
> +	# Kill freeze loops and make sure $SCRATCH_MNT is unfreezed
> +	[ -n "$freeze_pids" ] && kill -9 $freeze_pids 2>/dev/null
> +	wait $freeze_pids
>  	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> +	[ -n "$fsstress_pid" ] && kill -9 $fsstress_pid 2>/dev/null
> +	wait $fsstress_pid
>  	rm -f $tmp.*
>  }
>  
> @@ -62,7 +66,9 @@ done
>  
>  wait $fsstress_pid
>  result=$?
> +unset fsstress_pid
>  wait $freeze_pids
> +unset freeze_pids
>  
>  # Exit with fsstress return value
>  status=$result
> diff --git a/tests/generic/459 b/tests/generic/459
> index 57d58e55..7be39089 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -24,6 +24,8 @@ _begin_fstest auto freeze thin
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
>  	cd /
>  	rm -f $tmp.*
>  	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/generic/491 b/tests/generic/491
> index e6e57dcd..797b08d5 100755
> --- a/tests/generic/491
> +++ b/tests/generic/491
> @@ -12,6 +12,15 @@
>  . ./common/preamble
>  _begin_fstest auto quick freeze mount
>  
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> +	rm -f $tmp.*
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  
> diff --git a/tests/xfs/011 b/tests/xfs/011
> index d6e9099e..ed44d074 100755
> --- a/tests/xfs/011
> +++ b/tests/xfs/011
> @@ -16,10 +16,11 @@ _begin_fstest auto freeze log metadata quick
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
>  	$KILLALL_PROG -9 fsstress 2>/dev/null
>  	wait
>  	cd /
> -	_scratch_unmount 2>/dev/null
>  	rm -f $tmp.*
>  }
>  
> diff --git a/tests/xfs/119 b/tests/xfs/119
> index b6f96601..5ffbce25 100755
> --- a/tests/xfs/119
> +++ b/tests/xfs/119
> @@ -11,6 +11,15 @@
>  . ./common/preamble
>  _begin_fstest log v2log auto freeze
>  
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> +	cd /
> +	rm -f $tmp.*
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  
> diff --git a/tests/xfs/297 b/tests/xfs/297
> index ca482e06..07f84c25 100755
> --- a/tests/xfs/297
> +++ b/tests/xfs/297
> @@ -11,6 +11,17 @@
>  . ./common/preamble
>  _begin_fstest auto freeze
>  
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
> +	$KILLALL_PROG -q -9 $FSSTRESS_PROG
> +	wait
> +	cd /
> +	rm -f $tmp.*
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  
> diff --git a/tests/xfs/318 b/tests/xfs/318
> index be93f9ab..5798f9a3 100755
> --- a/tests/xfs/318
> +++ b/tests/xfs/318
> @@ -12,8 +12,9 @@ _begin_fstest auto quick rw freeze
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
>  	cd /
> -	_scratch_unmount > /dev/null 2>&1
>  	rm -rf $tmp.*
>  }
>  
> diff --git a/tests/xfs/325 b/tests/xfs/325
> index c6861fbc..43fb09a6 100755
> --- a/tests/xfs/325
> +++ b/tests/xfs/325
> @@ -13,8 +13,9 @@ _begin_fstest auto quick clone freeze
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
>  	cd /
> -	_scratch_unmount > /dev/null 2>&1
>  	rm -rf $tmp.*
>  }
>  
> diff --git a/tests/xfs/438 b/tests/xfs/438
> index cfe75bd8..0425c5b1 100755
> --- a/tests/xfs/438
> +++ b/tests/xfs/438
> @@ -26,6 +26,8 @@ _begin_fstest auto quick quota freeze
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	# Make sure $SCRATCH_MNT is unfreezed
> +	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
>  	[ -z "${interval}" ] || \
>  		sysctl -w fs.xfs.xfssyncd_centisecs=${interval} >/dev/null 2>&1
>  	cd /
> -- 
> 2.25.1
> 

