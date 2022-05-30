Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C969BC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 30 May 2022 06:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiE3GDK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 May 2022 02:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiE3GDH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 May 2022 02:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F34F25C64
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 23:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653890584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X19Z8d42/APKz8FYZe6w08zaSso1PaLLGa69Ypf9ZRg=;
        b=jJnfQShyq3MGPvqugp8QYndmYaK0AYbspHlX8zCmydFMHR99CkNIobQXtPgxBJ8NMYfsjM
        0Xv7qanCfHqEnsyrlLtUaH8OnWA7p9jXBqYC0JwguCxC9csDNz+ZuPfx2cNI/5xfe3fmev
        yt1FnbsGSSybm+xokXSyj4qLh5JKskE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-g1G10uEqMkW2z1d4K-atPA-1; Mon, 30 May 2022 02:03:01 -0400
X-MC-Unique: g1G10uEqMkW2z1d4K-atPA-1
Received: by mail-ot1-f71.google.com with SMTP id f68-20020a9d2c4a000000b0060af9dffeceso2519740otb.2
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 23:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X19Z8d42/APKz8FYZe6w08zaSso1PaLLGa69Ypf9ZRg=;
        b=qEUljE7nlgX/UBEC2SDUYDbPfmErDetOHD0Dyokk1ZksC4LWYBzKwws3iE5Uw2OOAi
         4xnES4JypRkpCnTXV1p0qHP/28dhfIndbHP2Wps00umym8fq2eAiGS1jqEHqjCnWG9RO
         RcvI7iX1YbAsaOibNsr14HVWbCuHocHwhHJ14qcjp5fsmCatz2A3v5YJ5ladk97xCigB
         8sscTGoKgIH8KLw3u05gdSyyajKYavQC+ZQpGx4rSaEAjY3/KXga+mTwAp9hxZD3POrk
         0mF+o0M1+BYgPdo02oA7+wNBX+ylDhOQeiS4xTnI45loollBZOcW1PO6mmPbOz3CAoM5
         quAA==
X-Gm-Message-State: AOAM531jpbvrMj+l5I8bP+M2oArTN6TrkpEXW9wF/tP6cLDH7n3D8oLx
        fLiFyjqZSQb65y53jGR69eQ4XgFGz4BZVYOL0Hik2YjzX83x/51hK/4rJmWiK2hRSl1iPLoCUiA
        FQK+VSCsd57YjpDawSA==
X-Received: by 2002:a05:6870:d0ce:b0:f3:3856:f552 with SMTP id k14-20020a056870d0ce00b000f33856f552mr1290892oaa.99.1653890580405;
        Sun, 29 May 2022 23:03:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmZwm5nk0/daTtx3ffu5vfCSW+d+nEFwuZW3oXTqVQPGGRF5fgUr2500DJwG3Qcia2Ggt/yA==
X-Received: by 2002:a05:6870:d0ce:b0:f3:3856:f552 with SMTP id k14-20020a056870d0ce00b000f33856f552mr1290887oaa.99.1653890580136;
        Sun, 29 May 2022 23:03:00 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x4-20020a056808144400b003264a325ecdsm4365340oiv.5.2022.05.29.23.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 23:02:59 -0700 (PDT)
Date:   Mon, 30 May 2022 14:02:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 4/5] generic/591: use proper sector size
Message-ID: <20220530060254.kpah3jhyoz6woiov@zlang-mailbox>
References: <20220529105505.667891-1-zlang@kernel.org>
 <20220529105505.667891-5-zlang@kernel.org>
 <20220529235712.GK3923443@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529235712.GK3923443@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 30, 2022 at 09:57:12AM +1000, Dave Chinner wrote:
> On Sun, May 29, 2022 at 06:55:04PM +0800, Zorro Lang wrote:
> > The generic/591 fails if the sector size of TEST_DEV isn't 512:
> > 
> >   splice-test: write: /mnt/test/a: Invalid argument
> > 
> > To fix this issue, this patch help src/splice-test.c to get a specify
> > sector size from the test case. Then let g/591 give it a proper
> > sector size which dio aligned.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  src/dmiperf        | Bin 0 -> 31288 bytes
> >  src/splice-test.c  |  37 +++++++++++++++++++++++++------------
> >  src/t_locks_execve | Bin 0 -> 25904 bytes
> >  tests/generic/591  |   6 ++++--
> 
> I don't think this commit should include built binaries....

That's a ... mistake, sorry, I'll resend.

Thanks,
Zorro

> 
> -Dave
> -- 
> Dave Chinner
> david@fromorbit.com
> 

