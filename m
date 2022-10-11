Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E7C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Oct 2022 15:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiJKPQ0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiJKPQB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Oct 2022 11:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7615D2CDB
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665500761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXMZZdh6NjS+r+ofi184f8RBFzNdr2aR6ikiyQJi35Y=;
        b=hAGGmpUtaVqDSk0OR4EQ6Bx389dCM1HSr6irM97Od8F23FucovAoIny9rzXEcBQtHwrsPj
        bUSl76fOPFzsrOQby35zzalYhJYvZv1nxjSeHxEuWlVyWKIRaMMG58d/OuOpWh+cszDtwl
        gaJ2PLc14mkgxdMyoNITNu8L6QoNBT4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-zmeL6Y1SMFKtffo2-okg5w-1; Tue, 11 Oct 2022 11:02:17 -0400
X-MC-Unique: zmeL6Y1SMFKtffo2-okg5w-1
Received: by mail-qv1-f72.google.com with SMTP id y2-20020a0ce802000000b004b1ce1c4a70so8042894qvn.9
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 08:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXMZZdh6NjS+r+ofi184f8RBFzNdr2aR6ikiyQJi35Y=;
        b=dF13BIds3fpot+bTJ4mkX2ujS8MV5RFjt0bTqCNIevQN+Chxz/tGpWLx1vmik71yMC
         zCIyNMJx1Fk04T2uU12xe80X4bc1BU+UHFOl0K4l14ayX22fjIqyQ6NHI+zNEkc9ALkL
         gqm4lrQq2D6WYWzPTId9Vq0S8jhSfW2ERsDeQ610Q+YLROaqhGdftVNpE6l4Lt86jWXu
         QZJVtRwqo8MOr0ggT6MLmQAg/c2kBZrxL3KKzhNkEL8yXR+rIx7WzNo8TxRdwDT+kfGD
         /rgO6Pcn9JXqRjFxXFEjMuzq4/m86v6hr0/lewnJSv0wNRqaTMPC16D/PhIXlHxPl66w
         facw==
X-Gm-Message-State: ACrzQf3GOrRkJNvdV+RnSkfiE3PKBFnGOIqh1z2S4tCDCQVXWxQvdJFG
        eoQ5wvLrFH6pHJw6yMV5oRcDTwkO/15CEpNWWx6/hz5asqGvW+b0KprLe8s1mqwEk3TlwaXK0t/
        tKst+1Uv7kN2v0l2cBA==
X-Received: by 2002:a05:620a:138b:b0:6ee:671e:4b17 with SMTP id k11-20020a05620a138b00b006ee671e4b17mr4514119qki.652.1665500537053;
        Tue, 11 Oct 2022 08:02:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5DtS18t0PUTz+rk7eacKGyub+N/aPcJ45FbAo0f4rCG9xRNukUXwKtY2ChAreGmpIJVBnXCA==
X-Received: by 2002:a05:620a:138b:b0:6ee:671e:4b17 with SMTP id k11-20020a05620a138b00b006ee671e4b17mr4514092qki.652.1665500536755;
        Tue, 11 Oct 2022 08:02:16 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x14-20020ac87a8e000000b003988b3d5280sm6997587qtr.70.2022.10.11.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:02:16 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:02:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] seek_sanity_test: drop unused pagesz
Message-ID: <20221011150211.ppl34tfylauind54@zlang-mailbox>
References: <20221011092340.24857-1-ddiss@suse.de>
 <20221011092340.24857-3-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011092340.24857-3-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 11, 2022 at 11:23:40AM +0200, David Disseldorp wrote:
> b91889d7 ("seek_sanity_test: use XFS ioctls to determine file allocation
> unit size") left this unused, resulting in:
> 
> seek_sanity_test.c: In function 'get_io_sizes':
> seek_sanity_test.c:70:6: warning: unused variable 'pagesz'
>   int pagesz = sysconf(_SC_PAGE_SIZE);
>       ^~~~~~
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---

OK, finally we can't stand this warning :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/seek_sanity_test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index 78f835e8..8a586f74 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -67,7 +67,6 @@ static int get_io_sizes(int fd)
>  	off_t pos = 0, offset = 1;
>  	struct stat buf;
>  	int shift, ret;
> -	int pagesz = sysconf(_SC_PAGE_SIZE);
>  
>  	ret = detect_xfs_alloc_unit(fd);
>  	if (!ret)
> -- 
> 2.35.3
> 

