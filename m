Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E16CA0FE3
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Sep 2023 02:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348040AbjIACQS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Aug 2023 22:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbjIACQR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Aug 2023 22:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADDDE6E
        for <fstests@vger.kernel.org>; Thu, 31 Aug 2023 19:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693534529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2m6NIfRWGU81FmC4veM1riQ8LgQZRLXR/87iheQ744s=;
        b=DRy8yu0m2vhySb5swePNMm4Ra7Cc5jaqNHz/aTnK+AIwygEh1ZvmajgiBFTlPiH/qA3Szh
        aimmXADPG+/MTcHSNPE089IR1cItqazZYHykassusfFSIzVrWDggQt+m99AbMZJeRy2WJi
        kawgsGt5EHX6YC6wb3OHTO5nKOXY2k8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-RzxTHzs0OUmiKKifo88D5Q-1; Thu, 31 Aug 2023 22:15:28 -0400
X-MC-Unique: RzxTHzs0OUmiKKifo88D5Q-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c0aaf4caaaso16520765ad.2
        for <fstests@vger.kernel.org>; Thu, 31 Aug 2023 19:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693534527; x=1694139327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m6NIfRWGU81FmC4veM1riQ8LgQZRLXR/87iheQ744s=;
        b=ehcpSrpBfgSIp0+cyc3MLHm/IzXaYEYm5MCVStgyJ74Pc8DC39dmsjlm5lOs0/qElR
         C9KxPkJq1HopNmZ0RDankRKGI+EQy740osq6O1L81ttHVpVF3yz7vgmdcw5iP1mViAcR
         ADf6SH5d+YW1U1TSuiUE1sZ1YBSnTB10FKZasWEgLXcIjPVIhhiRU4zi0OZRE+UfALMm
         NM/+/6lMwkky6INn35tVDVUHQDMWcLjtE1CWX635DvLqCvq6BOoLLSvtrQpIHrfGIG7H
         6To+L0KiXAkOAhoRe7dQN+4Qu6r1NbSgo2lbgAi+O+lH9OQuWZ2h0gsjEr1XZEwpw1oa
         clwA==
X-Gm-Message-State: AOJu0Yw67uyfvJfC5Q70Jn2/Zmb/1HExmRwsvqjsdZ5M9ADDD5LTbtK3
        SMJ0ZNq4K2LR04Ajs/GOwCbVROMUSosLQoFQD8MsiGGEPV+l8fyGXOAcgwTZa6iU7IS80C1q4BP
        K3+vmLjCjqdXEdmqFJA==
X-Received: by 2002:a17:902:cec5:b0:1b7:e49f:1d with SMTP id d5-20020a170902cec500b001b7e49f001dmr1657590plg.62.1693534526967;
        Thu, 31 Aug 2023 19:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx/IJbocd1YEkOLvgyP4KFjhmhiNB/+KDSKaRO+S0AvMTeO30g5cw8wAk37UysjUP0jy9LBQ==
X-Received: by 2002:a17:902:cec5:b0:1b7:e49f:1d with SMTP id d5-20020a170902cec500b001b7e49f001dmr1657577plg.62.1693534526508;
        Thu, 31 Aug 2023 19:15:26 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902bcc900b001b87bedcc6fsm1833684pls.93.2023.08.31.19.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 19:15:26 -0700 (PDT)
Date:   Fri, 1 Sep 2023 10:15:22 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/650: race mount and unmount with cpu hotplug
 too
Message-ID: <20230901021522.oczewijtf5dbb7dr@zlang-mailbox>
References: <169335047228.3523635.3342369338633870707.stgit@frogsfrogsfrogs>
 <169335048358.3523635.7191015334485086811.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169335048358.3523635.7191015334485086811.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 29, 2023 at 04:08:03PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Ritesh Harjani reported that mount and unmount can race with the xfs cpu
> hotplug notifier hooks and crash the kernel.  Extend this test to
> include that.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me, and it helps to avoid this test takes too long time to run.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/650 |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/tests/generic/650 b/tests/generic/650
> index 05c939b84f..773f93c7cb 100755
> --- a/tests/generic/650
> +++ b/tests/generic/650
> @@ -67,11 +67,18 @@ fsstress_args=(-w -d $stress_dir)
>  nr_cpus=$((LOAD_FACTOR * nr_hotplug_cpus))
>  test "$nr_cpus" -gt 1024 && nr_cpus="$nr_hotplug_cpus"
>  fsstress_args+=(-p $nr_cpus)
> -test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
> +if [ -n "$SOAK_DURATION" ]; then
> +	test "$SOAK_DURATION" -lt 10 && SOAK_DURATION=10
> +	fsstress_args+=(--duration="$((SOAK_DURATION / 10))")
> +fi
>  
> -nr_ops=$((25000 * TIME_FACTOR))
> +nr_ops=$((2500 * TIME_FACTOR))
>  fsstress_args+=(-n $nr_ops)
> -$FSSTRESS_PROG $FSSTRESS_AVOID -w "${fsstress_args[@]}" >> $seqres.full
> +for ((i = 0; i < 10; i++)); do
> +	$FSSTRESS_PROG $FSSTRESS_AVOID -w "${fsstress_args[@]}" >> $seqres.full
> +	_test_cycle_mount
> +done
> +
>  rm -f $sentinel_file
>  
>  # success, all done
> 

