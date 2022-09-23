Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976B1ECAAD8
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Sep 2022 11:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiIWLvf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Sep 2022 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiIWLvf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Sep 2022 07:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A78138F06
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2022 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663933893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1AmHxgIX4bBiixIX1uf3FE+irCeEkT7RYhq475rMlWU=;
        b=HDy1xfPDw70fJhmmm1pI/5S5P974Cmo8ore6bJZYRD8clf8IVhc5wqbQz1iCLtqHuLX4Ph
        sSpLsN8tr2B9IAJY0bUFlJPZIOFwPkCvtlUSP7iYEBH4vFr8yIUc7TVkut6UQplkn0x/qQ
        uYZPokV3kpz+V2wPJD1qo1W5YgJCerw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-130-l1JMQGdYO5yxOGKfRy6SHw-1; Fri, 23 Sep 2022 07:51:32 -0400
X-MC-Unique: l1JMQGdYO5yxOGKfRy6SHw-1
Received: by mail-pf1-f200.google.com with SMTP id a3-20020aa795a3000000b0054b94ce7d12so6952854pfk.17
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2022 04:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1AmHxgIX4bBiixIX1uf3FE+irCeEkT7RYhq475rMlWU=;
        b=KsB/jl7dk+qONjsnqPHSnqAQxghLQRytb1B4Y20e+D+rB7gY6aSHozli3dNHQnlRXI
         uKsdZIzkrYOUr2J+WGIxkQH78MA+743H+Lt4uAabVBcPfB1PPygQ12e0XoiQNRLtZCNQ
         twOnAe0K0HL/VSr2jehBAMLyXIRjQugjXzMl/QoMfIXG7jZx2J3rX3a22Fwiw1QuEGuj
         Mlh25DjKb55HS3RnvYiEtgdPDIL7igNarEyIPRMWvPW1M5TzlJed2Pq5nSBD3gLYBcOm
         pyJdOzp8EPYKtx4ys9zUcdcpSrlBfNuxYN8a960jMSsyEyLifsOJVv0gYwGECbenGlZu
         8+YQ==
X-Gm-Message-State: ACrzQf13GSKhPwXOjVHCMTvwwWkCmXPj/Xd7bVx2cJR1T6KvVsT1YXRQ
        6ydc7W+1lrGKWgaEP8/GT8rD6CJriNll1zVtj3+sesoluwuto8sO4lWWKypem3trFJK3eDE+pJ6
        jXx3nmW0HsrnfD3gdVA==
X-Received: by 2002:a17:90b:3149:b0:202:e9e9:632f with SMTP id ip9-20020a17090b314900b00202e9e9632fmr21061164pjb.96.1663933890954;
        Fri, 23 Sep 2022 04:51:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7tPyxwAMKGdSq/hxjkHP25KQTpB05cc7/mDcewWqPiK+uBM2aCpr09C4R1ic7qwzFl+8UfCg==
X-Received: by 2002:a17:90b:3149:b0:202:e9e9:632f with SMTP id ip9-20020a17090b314900b00202e9e9632fmr21061128pjb.96.1663933890550;
        Fri, 23 Sep 2022 04:51:30 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b7-20020a170903228700b0016c78f9f024sm5915335plh.104.2022.09.23.04.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 04:51:30 -0700 (PDT)
Date:   Fri, 23 Sep 2022 19:51:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Message-ID: <20220923115126.s3ctf4erpepa3zy7@zlang-mailbox>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
 <97ede9bba67f0848fc0b706d757170d7dfacb7fd.1663825728.git.naohiro.aota@wdc.com>
 <20220922154132.dpadkhaccwzysq4d@zlang-mailbox>
 <PH0PR04MB741656D7881D11281ECBBD489B519@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741656D7881D11281ECBBD489B519@PH0PR04MB7416.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 23, 2022 at 08:02:10AM +0000, Johannes Thumshirn wrote:
> On 22.09.22 17:42, Zorro Lang wrote:
> >> --- /dev/null
> >> +++ b/common/zbd
> > I don't like this abbreviation :-P If others don't open this file and read the
> > comment in it, they nearly no chance to guess what's this file for.
> > 
> 
> zbd is a well known abbreviation for zoned block devices. I think most
> people in storage and filesystems know it.

OK, but we haven't been that "a single character is worth a thousand
pieces of gold", so we can use a longer name, likes common/zone,
common/zoned, common/zoned_block, common/zoned_device or something likes
that. Anyway, that's just my personal opinion, if most of people prefer
using "common/zbd", I'm fine to have that :) 

But I hope you can move all zoned block device related helpers to the new
common file if you'd like to bring in this file, likes what Darrick did in:

commit 67afd5c742464607994316acb2c6e8303b8af4c5
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Tue Aug 9 14:00:46 2022 -0700

    common/rc: move ext4-specific helpers into a separate common/ext4 file

Thanks,
Zorro

> 
> 

