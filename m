Return-Path: <SRS0=f9yW=AC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF226C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DBB2473D
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Jun 2020 23:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSlH/QDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFUXHk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFUXHk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jun 2020 19:07:40 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF7DC061794
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:07:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g7so11590169oti.13
        for <fstests@vger.kernel.org>; Sun, 21 Jun 2020 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m6cBTGqNRhjDKihfnXC3QCuiYUsTnFmF2iQ7lIODmvs=;
        b=oSlH/QDq9Qg8tNZkKHo0EZth1TOo+YOjT9cTTwL1Y4CxmNY5GzkCCGlOLftbdYHKsd
         Hff3lbIO4Swo8WTOq0TsbuxQQ3RZT0JvnRF+5NPaL2w4FflhMtrzFgF9/cuYCdIyXCsZ
         SKm+CV0XQKHeNBT1zx4GsWGdSJ5QvMocHcyvjdcRg5lAMx9z0hGBS5DAaBWPZAsC+o7L
         Z6pOcvL+VP7Us2qEB3n9whgCAFb9Q6TdahecgOP7WBCrhuKlbDM0ZX9mnav7EOLLrXql
         Nf4MX1nQaX64xZ2uE0yBoNhOG609hqYfAdSqqcbCoTrVU+JS6tH1mrn+OVoppRt8LoFF
         nSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m6cBTGqNRhjDKihfnXC3QCuiYUsTnFmF2iQ7lIODmvs=;
        b=CbdUNFgrjHXaCpQv/MmaViCIJFJwkgFVfPXtQe70z3VYsYUrMDscxnIq07ZfxlajMp
         Y9T3k97PdwhSfEtTfE3UGwXzkW74yXkWAdA8zUrz6LIw6MW00zSydcqZROKZKrQvNuCU
         UzYFhMWIEj2P5El9uVLa1ud4OZWxZ+WO33VeQ0k/FZkleo52PaA6tZiqAHbtdinbdrMP
         j3VI0ryAPivuClzQ4uAtHOMbwT8/UszYuyy0AlIc/79Jvrva+p8Ev8HpTu6eYBhgTZN2
         /bliarnIvd8XycreHHk3qvCpCaUvxFIyUBq6b34hsH2WiKmyB56HasMHlL9z03+kGa+j
         RjvQ==
X-Gm-Message-State: AOAM530T0yjcpoWqWfbfF6HX1Gf2gzsC+Rt2VfoJ/eLqOqSWA4nwxSXm
        Rw9Ajr+GixjSBaR2hL5HxPhgV1umbg==
X-Google-Smtp-Source: ABdhPJzbs6WwWTUJeZ6MsWcOz9Hm1mnyjx406UlccIoJjJbVpp1s/oeh+KmRe4z2bq+fyGbvTh5lvA==
X-Received: by 2002:a9d:65d4:: with SMTP id z20mr11387748oth.84.1592780859280;
        Sun, 21 Jun 2020 16:07:39 -0700 (PDT)
Received: from gmail.com (072-182-049-098.res.spectrum.com. [72.182.49.98])
        by smtp.gmail.com with ESMTPSA id t22sm2906554oth.53.2020.06.21.16.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 16:07:38 -0700 (PDT)
Date:   Sun, 21 Jun 2020 18:07:36 -0500
From:   Arvind Raghavan <raghavan.arvind@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Subject: Re: [PATCH 5/6] src/fssum: Allow single file input
Message-ID: <20200621230736.5fqm64ro6cya6yc7@gmail.com>
References: <cover.1590006879.git.raghavan.arvind@gmail.com>
 <91a82230f5929b45a6093576b7c7afd311fde97a.1590006879.git.raghavan.arvind@gmail.com>
 <CAOQ4uxi5C=XOpTS67hS8YOpb-Fo4f6PA5qsoNiDY_k=58r4qJg@mail.gmail.com>
 <20200522010652.x34k3tx7e47jmzzk@gmail.com>
 <CAOQ4uxi9B5XBay9+VVYoO_f-1h-jTG-JvTijmt_GZpoy=Jq1ZQ@mail.gmail.com>
 <20200531182858.nurku3vcztrzsy43@gmail.com>
 <CAOQ4uxjmgtPMsm2MsA=BjgX63-uCKUpp8swHHCkvwUwgLZvMpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjmgtPMsm2MsA=BjgX63-uCKUpp8swHHCkvwUwgLZvMpQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 05/31, Amir Goldstein wrote:
> > I might be doing something wrong but I can't seem to get
> > AT_EMPTY_PATH to work with fstatat. I don't see it on the man
> > page and when I pass it to fstatat it errors out with invalid
> > argument.
> >
> 
> https://www.man7.org/linux/man-pages/man2/stat.2.html
> 
> Says:
>        AT_EMPTY_PATH (since Linux 2.6.39)
> ... This flag is Linux-specific; define _GNU_SOURCE to obtain its definition.
> 
> And I see that fssum.c does define _GNU_SOURCE, so not sure what the
> problem is.

Ah yes, it is in the documentation, and I've got it working now!
Must've been some other issue I had... I apologize for the delay,
I'll send out a v2 shortly.

Thanks,
Arvind
