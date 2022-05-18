Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FF0C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 18 May 2022 18:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbiERSQW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 May 2022 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiERSQT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 May 2022 14:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50CAC2A243
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652897776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSStIx9A83ZgIdMdAhop9DurpOs3VaVQ8CwItY2at+c=;
        b=JYI+rAxdDmucY4MBuPF6r6+nKq7w6OvoHC3KYeg+Uk8LtwKojcn4ERPz+eW6ZmE7FeB/8m
        +x0agWEGZV/rNcV7ly74j+xxIc+oXrffOrtmw5a73sRB1lCBDg2JnJUm2tOfXF8VAqmQfA
        1w2SIdV3C59LcGfOziyhJl2PMM7TYWw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-2uzmxvK5Of2pDVy35hZO2Q-1; Wed, 18 May 2022 14:16:15 -0400
X-MC-Unique: 2uzmxvK5Of2pDVy35hZO2Q-1
Received: by mail-qt1-f199.google.com with SMTP id b20-20020ac85bd4000000b002f3bb93df03so2239449qtb.16
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 11:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BSStIx9A83ZgIdMdAhop9DurpOs3VaVQ8CwItY2at+c=;
        b=Xbc/4ITiJXFp5zMEJstd63EFnkg7cehxT95zNUkomvUdPk9urBP6VPlidCwqi5NuL3
         h7tBFNkIXCTVX5qAR0sjlChamk6BMOJSANboe71zSgkRYh9kh9qqQSzcAKJhHMwsK507
         3LnKyiPHJuZpxHmR/sbIRIxkkbCMCSidMi3q7jIBjaGWsPDy11+zzeZ1czwxsqWBa9Z6
         CoFR4y/scPRtaf9DR49psAZbKCXz7kqP3BCjOXgnww8v4kE0AEdF9SRrDacO0MmM1glQ
         2iBI72d04Hu+WXQyxq8NxmgCARt8rBZyWio1/woOcJvXK2eYYBUwOKtSSZLmpzdi0U4R
         ES+Q==
X-Gm-Message-State: AOAM531Ocz59pcHw2Xr/U4wGMiST3JJEsgQw7rLT0oHXKMQgeXnYkdf1
        LLoJhhFDeopb1t097Vo5aby8F0tONDZ9vwksAjg2X1RSw18oGXnYJH76JDyTak7VUsOJW+C6oJA
        gBJD4ybfl5JkFVZjd7g==
X-Received: by 2002:a05:6214:21e4:b0:45b:127b:7dca with SMTP id p4-20020a05621421e400b0045b127b7dcamr1023448qvj.98.1652897774396;
        Wed, 18 May 2022 11:16:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8Gjy2lAAo1TOKMoTFROtc9deKkpfIbRjCGcgcYQmuwg4L10OMbVzgSQKWQ7Awk1FkYk4u+w==
X-Received: by 2002:a05:6214:21e4:b0:45b:127b:7dca with SMTP id p4-20020a05621421e400b0045b127b7dcamr1023417qvj.98.1652897774068;
        Wed, 18 May 2022 11:16:14 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e4-20020a376904000000b0069fe1fc72e7sm1905664qkc.90.2022.05.18.11.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:16:13 -0700 (PDT)
Date:   Thu, 19 May 2022 02:16:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH 0/2] update test_dummy_encryption testing in
 ext4/053
Message-ID: <20220518181607.fpzqmtnaky5jdiuw@zlang-mailbox>
Mail-Followup-To: Eric Biggers <ebiggers@kernel.org>,
        fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20220501051928.540278-1-ebiggers@kernel.org>
 <20220518141911.zg73znk2o2krxxwk@zlang-mailbox>
 <YoUu60S2AjP2fEOk@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUu60S2AjP2fEOk@sol.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 18, 2022 at 10:37:47AM -0700, Eric Biggers wrote:
> On Wed, May 18, 2022 at 10:19:11PM +0800, Zorro Lang wrote:
> > On Sat, Apr 30, 2022 at 10:19:26PM -0700, Eric Biggers wrote:
> > > This series updates the testing of the test_dummy_encryption mount
> > > option in ext4/053.
> > > 
> > > The first patch will be needed for the test to pass if the kernel patch
> > > "ext4: only allow test_dummy_encryption when supported"
> > > (https://lore.kernel.org/r/20220501050857.538984-2-ebiggers@kernel.org)
> > > is applied.
> > > 
> > > The second patch starts testing a case that previously wasn't tested.
> > > It reproduces a bug that was introduced in the v5.17 kernel and will
> > > be fixed by the kernel patch
> > > "ext4: fix up test_dummy_encryption handling for new mount API"
> > > (https://lore.kernel.org/r/20220501050857.538984-6-ebiggers@kernel.org).
> > > 
> > > This applies on top of my recent patch
> > > "ext4/053: fix the rejected mount option testing"
> > > (https://lore.kernel.org/r/20220430192130.131842-1-ebiggers@kernel.org).
> > 
> > Hi Eric,
> > 
> > Your "ext4/053: fix the rejected mount option testing" has been merged. As the
> > two kernel patches haven't been merged by upstream linux, I'd like to merge
> > this patchset after the kernel patches be merged. (feel free to ping me, if
> > I forget this:)
> 
> Yes, I'm waiting for them to be applied.

Thanks, I'll review this patches after your kernel patches be merged. Please
remind me, if I don't notice that in time.

> 
> > 
> > And I saw some discussion under this patchset, and no any RVB, so I'm wondering
> > if you are still working/changing on it?
> > 
> 
> I might add a check for kernel version >= 5.19 in patch 1.  Otherwise I'm not
> planning any more changes.

Actually I don't think the kernel version check (in fstests) is a good method. Better
to check a behavior/feature directly likes those "_require_*" functions.

Why ext4/053 need >=5.12 or even >=5.19, what features restrict that? If some
features testing might break the garden image (.out file), we can refer to
_link_out_file(). Or even split this case to several small cases, make ext4/053
only test old stable behaviors. Then use other cases to test new features,
and use _require_$feature_you_test for them (avoid the kernel version
restriction).

Thanks,
Zorro

> 
> - Eric
> 

