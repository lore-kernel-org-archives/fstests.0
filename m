Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBDBC4332F
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Nov 2022 14:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiKLOZZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 12 Nov 2022 09:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLOZY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Nov 2022 09:25:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002417E26
        for <fstests@vger.kernel.org>; Sat, 12 Nov 2022 06:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668263067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P5t/rodFzM1KFVwd+xJg1PNhtXLxl4BUfqDw5dunQ1U=;
        b=E6xpLvPpoGsa5CGUtt2wQN7/4RQx84u08dBQaoRpsTVFrZ8S6VX13v5CMUlwDXnIE72nm3
        6nafYfgsePFuWRK3Je6C8QE8OZNEGCvvuot1gpIviH/Kr4cCuDQeQg7qS8o/831XMB60aO
        kZSQTDcaLa+3HLq2mfgQub4DbQAtu4s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-VWRWExE5NlSVTy7FwlnyjA-1; Sat, 12 Nov 2022 09:24:24 -0500
X-MC-Unique: VWRWExE5NlSVTy7FwlnyjA-1
Received: by mail-pj1-f69.google.com with SMTP id m2-20020a17090a730200b0021020cce6adso7079641pjk.3
        for <fstests@vger.kernel.org>; Sat, 12 Nov 2022 06:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5t/rodFzM1KFVwd+xJg1PNhtXLxl4BUfqDw5dunQ1U=;
        b=Ras/g8C4qFLmVlrhJhLMKPQEdQo/XXXbwdM6MzPBLqBJbmo0VsixvVQukPrSrhUrvs
         y9NhZN8nlWcYFlvKgpYwx2oVAJ9gjgBcAqjMcnrcr7EQc6e4Pc3rdxoSbeOHrZEu00GS
         WnTyPW9cpEu62QogLzYf8jZn1i6iHa+SKC9F5N20UcxJTmHnVjJ8W7w2KLnAC/SLy4PL
         J9x4gZkyFxhpkv/iIjoXQOJSKMngtIxSUBoSFQeBhP4P20QA+J6DH+R78kQ/XwbItnJI
         FOk/s2P51btr0HqmRJdqxFtzDnwF6EwuRziUmJeC+PpDDqheuomXU50DiXSoup/mgGRX
         p3Xg==
X-Gm-Message-State: ANoB5pmvuhcxWCJZOHGmVRR//6ywE1jOOLBmLW8a7ST1s4/Wf9Fa99da
        /09W6Ruo3VtKUQutOlawcbREPOQ8s4ToFcr9hUR6XcDgm87TXMJLaWSx9x6uAX7hRLS7brBowsf
        BGYF332BmwI/fQLWIdQ==
X-Received: by 2002:a17:90a:8c0c:b0:218:10c0:1afd with SMTP id a12-20020a17090a8c0c00b0021810c01afdmr6556598pjo.36.1668263062340;
        Sat, 12 Nov 2022 06:24:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Owq2VJ4YG5j+7rADWpf//NUGn+DIWEvI0A8D9B9sZrltD/bvrlHXMXGPhPSo1CAilO1KMBw==
X-Received: by 2002:a17:90a:8c0c:b0:218:10c0:1afd with SMTP id a12-20020a17090a8c0c00b0021810c01afdmr6556575pjo.36.1668263062023;
        Sat, 12 Nov 2022 06:24:22 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001822121c45asm3708550pld.28.2022.11.12.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:24:21 -0800 (PST)
Date:   Sat, 12 Nov 2022 22:24:16 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Catherine Hoang <catherine.hoang@oracle.com>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1] xfstests: test xfs_spaceman fsuuid command
Message-ID: <20221112142416.hhf7dis74rua5xti@zlang-mailbox>
References: <20221109222630.85053-1-catherine.hoang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109222630.85053-1-catherine.hoang@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 09, 2022 at 02:26:30PM -0800, Catherine Hoang wrote:
> Add a test to verify the xfs_spaceman fsuuid functionality.
> 
> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> ---

Hmm... I'm a little confused why we need this tool if we already has a
"xfs_admin -u", and we even expect they get same fsuuid. Even if "xfs_admin -u"
can't work with mountpoint, but it can work on the device which is mounted.
And why not let xfs_admin support that ?

Anyway, I'm care more about if this command is acked by xfs list? If xfs list
would like to have that command, then I'm OK to have this test coverage :)

Thanks,
Zorro

>  tests/xfs/557     | 31 +++++++++++++++++++++++++++++++
>  tests/xfs/557.out |  2 ++
>  2 files changed, 33 insertions(+)
>  create mode 100755 tests/xfs/557
>  create mode 100644 tests/xfs/557.out
> 
> diff --git a/tests/xfs/557 b/tests/xfs/557
> new file mode 100755
> index 00000000..0b41e693
> --- /dev/null
> +++ b/tests/xfs/557
> @@ -0,0 +1,31 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 557
> +#
> +# Test to verify xfs_spaceman fsuuid functionality
> +#
> +. ./common/preamble
> +_begin_fstest auto quick spaceman
> +
> +# real QA test starts here
> +_supported_fs xfs
> +_require_xfs_spaceman_command "fsuuid"
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +expected_uuid="$(_scratch_xfs_admin -u)"
> +actual_uuid="$($XFS_SPACEMAN_PROG -c "fsuuid" $SCRATCH_MNT)"
> +
> +if [ "$expected_uuid" != "$actual_uuid" ]; then
> +        echo "expected UUID ($expected_uuid) != actual UUID ($actual_uuid)"
> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/557.out b/tests/xfs/557.out
> new file mode 100644
> index 00000000..1f1ae1d4
> --- /dev/null
> +++ b/tests/xfs/557.out
> @@ -0,0 +1,2 @@
> +QA output created by 557
> +Silence is golden
> -- 
> 2.25.1
> 

