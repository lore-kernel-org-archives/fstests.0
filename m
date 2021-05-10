Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBAEC433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 10 May 2021 11:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CA2610FA
	for <linux-fstests@archiver.kernel.org>; Mon, 10 May 2021 11:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhEJLnM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 May 2021 07:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238848AbhEJLUL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 May 2021 07:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620645546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7fU8QVP+0P6wcpOiItoUFWrhG3anw9HxqSZXYfedQD0=;
        b=Qy6cg+v1FLQef941hzy9mWqgE52/3YFh0MUDKBzJbv2amd3xzQuQXYIn6dO97l5X8K1iMc
        ZFPzhtP5SvnUR6GEDUC3tTfLR/Df80goia520ntTdejen+puQlp6580VCad5NLb8jhHRuE
        iOHW+eR/ak4gmIAMgkYqFEjMk44iuos=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-3wB98AsJMby08HdeFSPEFQ-1; Mon, 10 May 2021 07:19:03 -0400
X-MC-Unique: 3wB98AsJMby08HdeFSPEFQ-1
Received: by mail-pl1-f198.google.com with SMTP id n18-20020a170902d0d2b02900ed5de16a2dso5824179pln.13
        for <fstests@vger.kernel.org>; Mon, 10 May 2021 04:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fU8QVP+0P6wcpOiItoUFWrhG3anw9HxqSZXYfedQD0=;
        b=r8ma1HaaizfPR+f4Hnw4RC5v7SUUrldOobeH4hvrLlnaHwfejs+1+KNWd439ngkkLL
         BT5DiQtbknDh4xrTFZyuSffzmLehdMm+pXqPzJgz1KSwGriIAF2jCletPtkuElGLEtpu
         Slu69sIxo+KVqdhdOhYcOUj0/mAEGFhl4apsZMjKkCy+7766gWr2fpah8VIvbzqOzYCz
         GRdVITZA4xtdImVNaMxsX9wRfzGQP95ESreU88MX+wCiklApyzNdD1q/f6mUuVHJjGj2
         bbDhYi1wHLDve0iyF6YtY9JT3o+j+pkn2L6gTwSKvWdlWhBem5jXNO0R3a30PXrR0dRj
         pKnw==
X-Gm-Message-State: AOAM531iKlYw6ilaXC1OoRtPp5j/CSY39tUg7SLIWAHMygUh1xr5YPPE
        LkgS72KSPqHoNRrxyGkFyEukgsuWPHrf+L2HQFqHTPyHR2x1mVe5JTEeK3n2chThE/HsqA7VOoK
        NM9y9gWFnGCR9TBJwZg==
X-Received: by 2002:a63:fc11:: with SMTP id j17mr21199077pgi.355.1620645542295;
        Mon, 10 May 2021 04:19:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXH4mrnNNwd0XRV7OJkXrSmiocAyMYMGGVSIHSG5pHQrYYyilyVTkHMwA57DCdqAKV5A4otw==
X-Received: by 2002:a63:fc11:: with SMTP id j17mr21199056pgi.355.1620645542058;
        Mon, 10 May 2021 04:19:02 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 9sm5015501pgy.70.2021.05.10.04.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 04:19:01 -0700 (PDT)
Date:   Mon, 10 May 2021 19:18:51 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v4 0/3] xfs: testcases for shrinking free space in the
 last AG
Message-ID: <20210510111851.GB741809@xiangao.remote.csb>
References: <20210402094937.4072606-1-hsiangkao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210402094937.4072606-1-hsiangkao@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Eryu,

On Fri, Apr 02, 2021 at 05:49:34PM +0800, Gao Xiang wrote:
> Hi,
> 
> Sorry for little delay (yet since xfsprogs side isn't merged, and no
> major changes compared with the previous version...)

ping. This fstests patchset is still valid (I've confirmed with new
kernels / old kernels and old xfsprogs) and
shrinking tail AG functionality has been merged in kernel and xfsprogs.

Thanks,
Gao Xiang

