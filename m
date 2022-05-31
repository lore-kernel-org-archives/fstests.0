Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED12C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 31 May 2022 19:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbiEaTdV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 May 2022 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347298AbiEaTdU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 May 2022 15:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4B159A98B
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654025598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYvM+DjLdbW9FAA0uag5ZaxyY3UTDz5o1E6qwsuN23g=;
        b=OCeshO/gSGgKackuSrs98NbXfWM1v0FufQZJS7YPyg76TPvqI+hZ3soMWAvvLdJH8b8BRc
        KNPGaLve39clTTt86P4BGtVZ0qEoMcprTnJv/xwOwc+NoSeRfI15pih+YR6BM8OGW5dVZd
        dS5R/pjwEUk6Fco1TxITfObM8rGiFQY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-wu3V_i7KP-KQEYqSRDSYhQ-1; Tue, 31 May 2022 15:33:17 -0400
X-MC-Unique: wu3V_i7KP-KQEYqSRDSYhQ-1
Received: by mail-qk1-f200.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so11202480qkb.23
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 12:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYvM+DjLdbW9FAA0uag5ZaxyY3UTDz5o1E6qwsuN23g=;
        b=vam13aSme1KMciyjSSCPEljigV1zknaDZXayKuRCbyCeIzKItutHFu0iqyu2l1vhvJ
         dulqg6umYyvRxZb17jhSc4VIsOnFdqTMnHToz+jVE4p9iVa3fS3r3feZSQgQydgVY1bG
         24WFyXnXLhQTK1qM0PLJ1s135uHoeO20nfvVKUnGbmKicU7za5/Ke4pwhfBESjph6yFo
         9PS9E2XnHwfUxDPjTpW1ZbNFWAFh12es1lp42PIOooyR5h+16kJZGBT6cj9G1SOJqWsv
         i9WVswFXbS+vIwsEy1lImHycOIR77721SEVhfkIio19Rl7tw1YohPillwgswmS79ZPZu
         6VJw==
X-Gm-Message-State: AOAM532CugxMS+dLYdGRoc4Xy3PMxrdKCW84DYpL7Aih48GJrypUrWmD
        AO1AritLcXkaq1FfbslhOql6bFi9HGKEBpXDYk8cNCmXeTKCrm+pv0+ZSJ6h7+C7M5jj4hTzXJx
        coXKCnDlwuuUgk0fEWA==
X-Received: by 2002:a05:6214:802:b0:462:4eb0:1ec2 with SMTP id df2-20020a056214080200b004624eb01ec2mr34236644qvb.92.1654025596453;
        Tue, 31 May 2022 12:33:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4EEJsXvGLrMvs7pE/FecElyRmbrkICUtE9svhiwD+muhTARiVb87zXs5ulS/1olzHu8pgBA==
X-Received: by 2002:a05:6214:802:b0:462:4eb0:1ec2 with SMTP id df2-20020a056214080200b004624eb01ec2mr34236626qvb.92.1654025596232;
        Tue, 31 May 2022 12:33:16 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y12-20020ac8524c000000b002f39b99f685sm9428214qtn.31.2022.05.31.12.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 12:33:15 -0700 (PDT)
Date:   Wed, 1 Jun 2022 03:33:10 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Chao Yu <chao@kernel.org>
Cc:     fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] generic: adjust strict SPO recovery testcases for f2fs
Message-ID: <20220531193310.4xdwvefqdvay4mhc@zlang-mailbox>
References: <20220521031621.3494402-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521031621.3494402-1-chao@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 21, 2022 at 11:16:21AM +0800, Chao Yu wrote:
> Testcases like generic 342/502/526/527 expect that filesystems will
> recover all related metadata changes to the file which was fsynced
> before sudden power off.
> 
> This patch adjusts to use "fsync_mode=strict" mountoption for f2fs
> to pass these testcases.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

I don't have better idea, so it's good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

I'm thinking about is there only f2fs has this kind of requirement? If this's
not a single problem, we can help a common helper for that. But if only f2fs,
I think this change is fine.

Welcome better ideas if anyone else has. If no more, I'll merge it.

Thanks,
Zorro

>  tests/generic/342 | 5 +++++
>  tests/generic/502 | 5 +++++
>  tests/generic/526 | 5 +++++
>  tests/generic/527 | 5 +++++
>  4 files changed, 20 insertions(+)
> 
> diff --git a/tests/generic/342 b/tests/generic/342
> index 676b876b..cdffaaf3 100755
> --- a/tests/generic/342
> +++ b/tests/generic/342
> @@ -31,6 +31,11 @@ _require_dm_target flakey
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
> +
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
> +fi
> +
>  _init_flakey
>  _mount_flakey
>  
> diff --git a/tests/generic/502 b/tests/generic/502
> index b0f9077f..b5589b81 100755
> --- a/tests/generic/502
> +++ b/tests/generic/502
> @@ -34,6 +34,11 @@ _require_dm_target flakey
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
> +
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
> +fi
> +
>  _init_flakey
>  _mount_flakey
>  
> diff --git a/tests/generic/526 b/tests/generic/526
> index dc7cb36c..ada4dbee 100755
> --- a/tests/generic/526
> +++ b/tests/generic/526
> @@ -32,6 +32,11 @@ _require_dm_target flakey
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
> +
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
> +fi
> +
>  _init_flakey
>  _mount_flakey
>  
> diff --git a/tests/generic/527 b/tests/generic/527
> index 40cd1c6a..de09d171 100755
> --- a/tests/generic/527
> +++ b/tests/generic/527
> @@ -32,6 +32,11 @@ _require_dm_target flakey
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _require_metadata_journaling $SCRATCH_DEV
> +
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
> +fi
> +
>  _init_flakey
>  _mount_flakey
>  
> -- 
> 2.25.1
> 

