Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDCC433FE
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Nov 2022 10:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiKGK1H (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Nov 2022 05:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiKGK1G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Nov 2022 05:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C91186FA
        for <fstests@vger.kernel.org>; Mon,  7 Nov 2022 02:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667816761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxwQDssiql9I3GB3yrQc0hejeaVt0PGO2th8ldHy2tY=;
        b=jSdodWu09869X5NUeJ6zx1pdhtmeAeYPd13NblSyxSzBA9ztO/+z+RB0dWjBOwVvivtO2O
        nd2VdyloTLIKic8lJvNbJ9DGbFHSJZ5FNOrv4MhPFCSjov10W6QEnIbvai1Fvv2FONrPCG
        XI6eaH4v7yYxvBRw1NzbMA27Tvx1sCE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-17-OUK7dcrEPNK7BU_Til4QGg-1; Mon, 07 Nov 2022 05:26:00 -0500
X-MC-Unique: OUK7dcrEPNK7BU_Til4QGg-1
Received: by mail-ed1-f69.google.com with SMTP id h9-20020a05640250c900b00461d8ee12e2so8069198edb.23
        for <fstests@vger.kernel.org>; Mon, 07 Nov 2022 02:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxwQDssiql9I3GB3yrQc0hejeaVt0PGO2th8ldHy2tY=;
        b=NagByN1A/VsyP1aofYd+HIju9vrhLdu6NV09a67qN/LR+rseGcih/tUlR3/UwP7OXK
         pPI1WWn/f/QbipV2vbM+rLQ0hTo4FSauQfpdfhRenV6+P0tcffsG/lTJdVV5VWzZMHGR
         nP1vPWQ8fB+ZGdebJeCIHvowJeulG1UySmnuCfjiehfov+VfbHUWgURTlezm6bKgXs5v
         9waz7NPeUtwfkaj9hibF72Rjmu6sr2p9Cv5kMUVMM99GPPp0Fp/oFW7LABitA3u3maLc
         wB/qaezx4osrONXsBBQ89c0q3ifKXgfJ+j6V7XMdVKYF/5O9b7zDPtfU4LBXY6r2SGwO
         1LqQ==
X-Gm-Message-State: ACrzQf1q4a9Wi4CSqwlQmU1BOz37SJScm3Wojxd15oszWQOAbR4hzlAt
        d9DjJztOgbOxUT2/tnHeYfueFrLDwmNR1yi3f5GCSggDTfX7yIOTHfbyO4Z9+2VPnqM8VqCFgFR
        IIJu8VgKgqs0WbsKR
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id ww3-20020a170907084300b0073a5b0e8352mr47922585ejb.438.1667816759016;
        Mon, 07 Nov 2022 02:25:59 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6n1v5UWV1Dama6zaZ5UqJKAgO5UWmpoPefosVV9dLP9zqrs6BtdC4xGuv3bTQQLY0Olox9Rw==
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id ww3-20020a170907084300b0073a5b0e8352mr47922575ejb.438.1667816758809;
        Mon, 07 Nov 2022 02:25:58 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7ca55000000b004616cce0a26sm3956819edt.24.2022.11.07.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 02:25:58 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:25:56 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] nfs: test files written size as expected
Message-ID: <20221107102556.bo5vemsuuaentkor@aalbersh.remote.csb>
References: <20221105032329.2067299-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105032329.2067299-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Nov 05, 2022 at 11:23:29AM +0800, Zorro Lang wrote:
> Test nfs and its underlying fs, make sure file size as expected
> after writting a file, and the speculative allocation space can
> be shrunken.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Hi,
> 
> The original bug reproducer is:
> 1. mount nfs3 backed by xfs
> 2. dd if=/dev/zero of=/nfs/10M bs=1M count=10
> 3. du -sh /nfs/10M                           
> 16M	/nfs/10M 
> 
> As this was a xfs issue, so cc linux-xfs@ to get review.
> 
> Thanks,
> Zorro
> 
>  tests/nfs/002     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/nfs/002.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/nfs/002
>  create mode 100644 tests/nfs/002.out
> 
> diff --git a/tests/nfs/002 b/tests/nfs/002
> new file mode 100755
> index 00000000..3d29958d
> --- /dev/null
> +++ b/tests/nfs/002
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 002
> +#
> +# Make sure nfs gets expected file size after writting a big sized file. It's
> +# not only testing nfs, test its underlying fs too. For example a known old bug
> +# on xfs (underlying fs) caused nfs get larger file size (e.g. 16M) after
> +# writting 10M data to a file. It's fixed by a series of patches around
> +# 579b62faa5fb16 ("xfs: add background scanning to clear eofblocks inodes")

_fixed_by_kernel_commit?

-- 
- Andrey

