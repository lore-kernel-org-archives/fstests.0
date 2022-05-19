Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A4C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 19 May 2022 04:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiESE4a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 00:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiESE41 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 00:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B3C369719
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 21:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652936183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYfIqGfERh8bjjZqE1vFTpzT5vD5ieB7DjabHOjanZE=;
        b=POMff/HksGk0ROmVgdT5BT+zi9gIpqU0rkg/PDfe0NgkBk1pU699HfrXBSoPbtcgc00uVj
        kvcfzbmJTVzYmgtZ2/cZQhwUSlyargvF6+23kMJMcXW60RClixFkFJQiD9ArxSIOQDcxsY
        O+SOPcAjInNkKR9c+I5DTjywuK5dPjg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-icaTsERXOm6gp9NlDg-IiQ-1; Thu, 19 May 2022 00:56:21 -0400
X-MC-Unique: icaTsERXOm6gp9NlDg-IiQ-1
Received: by mail-qt1-f200.google.com with SMTP id m6-20020ac866c6000000b002f52f9fb4edso3359451qtp.19
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 21:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fYfIqGfERh8bjjZqE1vFTpzT5vD5ieB7DjabHOjanZE=;
        b=MltZ+mgDO59f1T6y3GttOmWEy75Xh85hO6PmOFFKouwmpCFCNSea66bpUyqtm5Sv+q
         55m5T+i4XdDRUgRBVbR1mQVeEBdAhUs21ErDVYnnHkRFVyKE0MjCVGjmG7GQXRkQdEdy
         K4upQAWJkkeznnxpSAqLZe+mgpef20WgmTJGmKPoeusrDi+5T7Nw1AEP8p5RrxpuOCaM
         xFQEiVQQlNvcF9hbaihAKvYPdBa7x9xfgm2OaGjzJBpvHD4PMeol2MCB1h1p4uL01Vwq
         s/eN0cMD1pP9DvslJyZ4VNaCbfL43gCuZW2JC9t4Jae3IlW7+DH++wYbpcSTjPzp6QQA
         4l5Q==
X-Gm-Message-State: AOAM530ukr2KTRjouzT9gM7s198OJHBxyPunID+LfhBu3XaacD+rFjzo
        YBTl6F3pAGiqT197AJxzhLTYG1mr2nDu/S8A1ZL4zc5h4xl33Z2AlmfibQGhvGq+jtve28VFCWP
        ool2uzirD8N9Nre4XfA==
X-Received: by 2002:a05:622a:494:b0:2f3:c0b0:599c with SMTP id p20-20020a05622a049400b002f3c0b0599cmr2611158qtx.95.1652936180874;
        Wed, 18 May 2022 21:56:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNZOH+JcFOvEKor5E6WB6TvKpJQvOX/aIgxYQ9X9vsEtbaDy7g0y3Cd/f+asce49WiW2DJDA==
X-Received: by 2002:a05:622a:494:b0:2f3:c0b0:599c with SMTP id p20-20020a05622a049400b002f3c0b0599cmr2611148qtx.95.1652936180609;
        Wed, 18 May 2022 21:56:20 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q28-20020a37f71c000000b0069fc13ce1d4sm836453qkj.5.2022.05.18.21.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 21:56:20 -0700 (PDT)
Date:   Thu, 19 May 2022 12:56:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] xfs: add memory failure test for dax mode
Message-ID: <20220519045615.cg35r7t7gcqwrnjv@zlang-mailbox>
References: <20220513031411.2369314-1-ruansy.fnst@fujitsu.com>
 <20220513031411.2369314-2-ruansy.fnst@fujitsu.com>
 <20220518183846.k6est3gobhh5jxrm@zlang-mailbox>
 <7ee2d82f-655c-c3ee-6bf9-9353abb8f64a@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ee2d82f-655c-c3ee-6bf9-9353abb8f64a@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 19, 2022 at 09:53:23AM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2022/5/19 2:38, Zorro Lang 写道:
> > On Fri, May 13, 2022 at 11:14:09AM +0800, Shiyang Ruan wrote:
> > > Make sure memory failure mechanism works when filesystem is mounted with
> > > dax option.
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >   .gitignore                      |   1 +
> > >   src/Makefile                    |   3 +-
> > >   src/t_mmap_cow_memory_failure.c | 157 ++++++++++++++++++++++++++++++++
> > >   tests/xfs/900                   |  48 ++++++++++
> > >   tests/xfs/900.out               |   9 ++
> > >   5 files changed, 217 insertions(+), 1 deletion(-)
> > >   create mode 100644 src/t_mmap_cow_memory_failure.c
> > >   create mode 100755 tests/xfs/900
> > >   create mode 100644 tests/xfs/900.out
> > > 
> ...
> > > diff --git a/tests/xfs/900.out b/tests/xfs/900.out
> > > new file mode 100644
> > > index 00000000..d861bf1f
> > > --- /dev/null
> > > +++ b/tests/xfs/900.out
> > > @@ -0,0 +1,9 @@
> > > +QA output created by 900
> > > +Format and mount
> > > +Create the original files
> > > +Inject memory failure (1 page)
> > > +Inject posion...
> > 
> > As your program is: printf("Inject poison...\n");
> > 
> > So I think this place should be "poison".
> 
> My bad. I forgot to fix this typo in .out file.

Never mind. I'd like to merge these tests after your kernel patchset about
"Add reflink&dedupe support for fsdax" be merged at first. To avoid you
might add/change something. And I need to see the test works on offical
kernel at least, before merging it. So feel free to ping me, if I forget
this patchset at that time :)

Thanks,
Zorro

> 
> > 
> > > +Process is killed by signal: 7
> > > +Inject memory failure (2 pages)
> > > +Inject posion...
> > 
> > same as above. And other 2 patches might have same issue.
> 
> Thanks!  Will fix them.
> 
> 
> --
> Ruan.
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > +Process is killed by signal: 7
> > > -- 
> > > 2.35.1
> > > 
> > > 
> > > 
> > 
> 
> 

