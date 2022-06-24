Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792DDC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 02:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiFXC0P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 23 Jun 2022 22:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXC0P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 23 Jun 2022 22:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F750562C5
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 19:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656037573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kQRtRSOkA2bIK2861EWipnyNuVYwl1sEb+A44HUB5Cw=;
        b=fs815r3JKu8S2evtXC99A+QnjZxxUQw+ZAjWToH6RnUN63kBaCPMBmPi6Wm5oC4ht8A//6
        YluUrZk5UZlbh6tkSmC/7qhHWhKHPTupPIP2JFYSotBtnKrKRxmuWrLVjlMKnc7TsjE9mr
        HQV2p2DwmJLapRXod+sWJwYSCWsd+zE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-cZLIBTVzO2qLUFkQMhDvxA-1; Thu, 23 Jun 2022 22:26:04 -0400
X-MC-Unique: cZLIBTVzO2qLUFkQMhDvxA-1
Received: by mail-qk1-f198.google.com with SMTP id x4-20020a05620a448400b006ac665e1dfeso1162596qkp.17
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 19:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kQRtRSOkA2bIK2861EWipnyNuVYwl1sEb+A44HUB5Cw=;
        b=j3m/S+uoXv2luFmVyYwd3eMaweEmPQh+oncrHW60E+NsNjnSsoyayUsy8qppZ4uG8L
         GQUpSAWPv3fiZr4k9wdWAu80EcunLzeKwL2ZV22xYwy2wML8Zeuvf9YlZmySN7IVcRDY
         M/nWEGRrFicRCjrfv14ammk2tUB0YUMngtan01gQB936Hub1kAABeRjy/jkZTRsnLTYV
         5iR6AYUVIDTpTDjkbjL8Xx7MJBv2mvUzChRogP438tm6BBjlo/k/zgc724f+RgkLMPmU
         LJq+oMwM+grCqRpusfRALFsVwbWUZ5bYchmZ84PXczRT6Zlu3TyRBf0Fmxq1DIGG6BRs
         lmyQ==
X-Gm-Message-State: AJIora+OvQnITx4TQhOzPgoMIIWdIrzMccnyRdZ7Fc7SZsL10N2qXyxY
        Cjw4nrewfjTs6JDxGUdVDeR8ogsD2eBJMCanzV0Hq45JwsP4jW1xQwYwGPiD+N0qxqzSKFaobMK
        tBQdLY4lKa6XmZb9YMw==
X-Received: by 2002:a05:6214:20a4:b0:470:2b47:a2f6 with SMTP id 4-20020a05621420a400b004702b47a2f6mr27697474qvd.85.1656037564235;
        Thu, 23 Jun 2022 19:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umgALhSvRbML6BmQH6LeinNqce5XrwL4sfLQOXJ2vEp3PKpLvb9guuxiINx9Bm/Ko7yO7d5Q==
X-Received: by 2002:a05:6214:20a4:b0:470:2b47:a2f6 with SMTP id 4-20020a05621420a400b004702b47a2f6mr27697469qvd.85.1656037563975;
        Thu, 23 Jun 2022 19:26:03 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g19-20020a37e213000000b006a6bd7028d5sm979532qki.18.2022.06.23.19.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 19:26:03 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:25:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: test read repair on a corrupted compressed
 extent
Message-ID: <20220624022558.ds66n4bhaq6njkpl@zlang-mailbox>
References: <20220622045844.3219390-1-hch@lst.de>
 <20220622045844.3219390-5-hch@lst.de>
 <20220622092140.GA26204@lst.de>
 <20220622124118.mkawtc3n2quhi42l@zlang-mailbox>
 <20220622130745.GA29960@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622130745.GA29960@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 22, 2022 at 03:07:45PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 22, 2022 at 08:41:18PM +0800, Zorro Lang wrote:
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> >                    ^^^^^^^^^^^
> > Is it a wrong copy&paste ?
> 
> A lot of the test is copied from btrfs/141, so I wanted to keep the
> copyright intact.

Oh, there're some cases copy from old cases in fstests, but they are changed
a little to have different coverage. Generally they metioned they copy from
which one case (number). I don't mind if you'd like to keep original
Copyright name, but the copyright time is old for a new test case, I don't
know if we'd better to update it. Hmm... sorry, not good at these copyright
things...

> 
> > > +#
> > > +# FS QA Test 270
> > > +#
> > > +# Regression test for btrfs buffered read repair of compressed data.
> > 
> > If this's a regression test, I'd like to see the fix be reviewed/acked
> > at first :)
> 
> Heh.  Actually I'm not sure it is a regression, this was copy and
> pasted as well.  I think it actually has been broken since day 1.
> 

