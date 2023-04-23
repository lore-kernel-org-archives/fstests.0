Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA16DC6FD18
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Apr 2023 15:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDWPLC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Apr 2023 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDWPLB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Apr 2023 11:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32891701
        for <fstests@vger.kernel.org>; Sun, 23 Apr 2023 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682262606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WkxH+1Pk2LMvn9WcA7WwBfz+qUxTw1THjiL+jwLCif4=;
        b=M9X42s6+8TH2htx3H7+Rk8S6JFNRUb0R0eBdBWO9E9Ua1p2rcnsQ8mDjmFyvFSkxz7TB6c
        VBRC6Lj7ZXFyrSaLq96wlRd7Dct8h70yscCeYFT/UF9GUpWxTNUXIU2pXTudKanfqPbW8+
        9M/NPWDSpz6LBhHSWlZ1KSqyTaS0PJU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-oxvCsCASNa24OGweCe392g-1; Sun, 23 Apr 2023 11:10:05 -0400
X-MC-Unique: oxvCsCASNa24OGweCe392g-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-63d30b08700so18786946b3a.1
        for <fstests@vger.kernel.org>; Sun, 23 Apr 2023 08:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682262604; x=1684854604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkxH+1Pk2LMvn9WcA7WwBfz+qUxTw1THjiL+jwLCif4=;
        b=GRInTzH8QN9N0oEWVxevfCKrlapFoWIrGCUjsCgbH0KarBPw8d4pSGNAvujOlkQqUe
         79xYYlw8Yq+PapvK/N9SdPkU0m/diQzmbLN4ZnHceUbUWhasCW83ITffs2tkX/lznOCN
         mMpP7pcmyWbsnqekB40TvRm8w31oXeUIOTIXUcfxJjoL8YAXxvNizGhdYc3+myzmodBQ
         JIrSH65bXHIMhj9H5ylJmbz66FsiTz36SVq1+DQqXDZBnFU70o1FQcDokcagrLTPYQ9v
         jPhpf3waUEzFU0NLXj3iD4wstqIiSzkbgFqZLt+qqywXqzFV9RUE0lfEzaeMuPrUeAru
         htyA==
X-Gm-Message-State: AAQBX9d2dPpfE1MLBoJu0sCMNcX2KNioBD1Eds0vXvEzNljD2KlG/rm3
        uwM4+R6IpY6vHMFO4nrvOPovhnyDKixtD0JYdr0Th3kUhn84MxrZBu71+gxuMI2B+9JF73L5gVO
        vLbJUuV8aV2ziBbBB6g==
X-Received: by 2002:a05:6a20:938a:b0:f2:1141:9d20 with SMTP id x10-20020a056a20938a00b000f211419d20mr12850454pzh.24.1682262604036;
        Sun, 23 Apr 2023 08:10:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350YISeyW3DC3CUBUUjvoI8WtaOgDfCeIg/UiPVK6eF/+kO/CY6PfQqYqDU2etGh/8qTc2zTx9g==
X-Received: by 2002:a05:6a20:938a:b0:f2:1141:9d20 with SMTP id x10-20020a056a20938a00b000f211419d20mr12850428pzh.24.1682262603625;
        Sun, 23 Apr 2023 08:10:03 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i64-20020a628743000000b0063b89da3adcsm5962216pfe.12.2023.04.23.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 08:10:03 -0700 (PDT)
Date:   Sun, 23 Apr 2023 23:09:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] misc: add duration for recovery loop tests
Message-ID: <20230423150959.agkw6tlnvjbiymbg@zlang-mailbox>
References: <168123682679.4086541.13812285218510940665.stgit@frogsfrogsfrogs>
 <168123684394.4086541.1780469729949319721.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168123684394.4086541.1780469729949319721.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 11, 2023 at 11:14:03AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make it so that we can run recovery loop tests for an exact number of
> seconds.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/rc         |   34 ++++++++++++++++++++++++++++++++++
>  tests/generic/019 |    1 +
>  tests/generic/388 |    2 +-
>  tests/generic/475 |    2 +-
>  tests/generic/482 |    5 +++++
>  tests/generic/648 |    8 ++++----
>  6 files changed, 46 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/common/rc b/common/rc
> index e89b0a3794..090f3d4938 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5078,6 +5078,40 @@ _save_coredump()
>  	$COREDUMP_COMPRESSOR -f "$out_file"
>  }
>  
> +# Decide if a soak test should continue looping.  The sole parameter is the
> +# number of soak loops that the test wants to run by default.  The actual
> +# loop iteration number is stored in SOAK_LOOPIDX until the loop completes.
> +#
> +# If the test runner set a SOAK_DURATION value, this predicate will keep
> +# looping until it has run for at least that long.
> +_soak_loop_running() {
> +	local max_soak_loops="$1"
> +
> +	test -z "$SOAK_LOOPIDX" && SOAK_LOOPIDX=1
> +
> +	if [ -n "$SOAK_DURATION" ]; then
> +		if [ -z "$SOAK_DEADLINE" ]; then
> +			SOAK_DEADLINE="$(( $(date +%s) + SOAK_DURATION))"
> +		fi
> +
> +		local now="$(date +%s)"
> +		if [ "$now" -gt "$SOAK_DEADLINE" ]; then
> +			unset SOAK_DEADLINE
> +			unset SOAK_LOOPIDX
> +			return 1
> +		fi
> +		SOAK_LOOPIDX=$((SOAK_LOOPIDX + 1))
> +		return 0
> +	fi
> +
> +	if [ "$SOAK_LOOPIDX" -gt "$max_soak_loops" ]; then
> +		unset SOAK_LOOPIDX
> +		return 1
> +	fi
> +	SOAK_LOOPIDX=$((SOAK_LOOPIDX + 1))
> +	return 0
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/generic/019 b/tests/generic/019
> index b68dd90c0d..b81c1d17ba 100755
> --- a/tests/generic/019
> +++ b/tests/generic/019
> @@ -30,6 +30,7 @@ _cleanup()
>  }
>  
>  RUN_TIME=$((20+10*$TIME_FACTOR))
> +test -n "$SOAK_DURATION" && RUN_TIME="$SOAK_DURATION"
>  NUM_JOBS=$((4*LOAD_FACTOR))
>  BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
>  FILE_SIZE=$((BLK_DEV_SIZE * 512))
> diff --git a/tests/generic/388 b/tests/generic/388
> index 9cd737e8eb..4a5be6698c 100755
> --- a/tests/generic/388
> +++ b/tests/generic/388
> @@ -42,7 +42,7 @@ _scratch_mkfs >> $seqres.full 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
>  _scratch_mount
>  
> -for i in $(seq 1 $((50 * TIME_FACTOR)) ); do
> +while _soak_loop_running $((50 * TIME_FACTOR)); do
>  	($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p 4 >> $seqres.full &) \
>  		> /dev/null 2>&1
>  
> diff --git a/tests/generic/475 b/tests/generic/475
> index c426402ede..0cbf5131c2 100755
> --- a/tests/generic/475
> +++ b/tests/generic/475
> @@ -41,7 +41,7 @@ _require_metadata_journaling $SCRATCH_DEV
>  _dmerror_init
>  _dmerror_mount
>  
> -for i in $(seq 1 $((50 * TIME_FACTOR)) ); do
> +while _soak_loop_running $((50 * TIME_FACTOR)); do
>  	($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -n 999999 -p $((LOAD_FACTOR * 4)) >> $seqres.full &) \
>  		> /dev/null 2>&1
>  
> diff --git a/tests/generic/482 b/tests/generic/482
> index 28c83a232e..b980826b14 100755
> --- a/tests/generic/482
> +++ b/tests/generic/482
> @@ -62,8 +62,13 @@ nr_cpus=$("$here/src/feature" -o)
>  if [ $nr_cpus -gt 8 ]; then
>  	nr_cpus=8
>  fi
> +
>  fsstress_args=$(_scale_fsstress_args -w -d $SCRATCH_MNT -n 512 -p $nr_cpus \
>  		$FSSTRESS_AVOID)
> +
> +# XXX dm-logwrites pins kernel memory for every write!
> +# test -n "$SOAK_DURATION" && fsstress_args="$fsstress_args --duration=$SOAK_DURATION"

Do you expect the second comment is a comment?

Others looks good to me. I'll test V2 and merge it if no regression from it.

Thanks,
Zorro

