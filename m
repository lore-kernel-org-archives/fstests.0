Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A8EC43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 00:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26750207DE
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 00:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ptf3sA/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIPApf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 20:45:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25400 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726421AbgIONAY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 09:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600174804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0Ehq+kzaVIIls3l8QyGvlgCZ9lsHRNO9CpAmdDSWa0=;
        b=Ptf3sA/8Vp8TtW0pyMA3CZj2B+IAnzeQaJE4NT9t11s4x7ArzB5f6nMqiGII/8Zqzezo2o
        Oz5UyUZvxV0uEVTtpoCCNeJswFBt4b/7fqh+IZg4h9KhG8jnTYhnvAP2Xi/xlsnSLcYZdU
        A6GGs7PzJB/zq1MoVFYgYEJUvIt+Jec=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-HsLoQgYfNheuVlqVOiZXsw-1; Tue, 15 Sep 2020 09:00:02 -0400
X-MC-Unique: HsLoQgYfNheuVlqVOiZXsw-1
Received: by mail-wr1-f72.google.com with SMTP id b7so1200232wrn.6
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 06:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K0Ehq+kzaVIIls3l8QyGvlgCZ9lsHRNO9CpAmdDSWa0=;
        b=XFMbsv+oNxTwa1TR2eF3TC7KMZpetqVIEphtS4Z81UKkY0ChSXFcdqqrscwFHeQidx
         ggVuV+yrdgWLEqIbgBbNOcOu9dbhQYBH1wqM7ELm19TELEuMSyXNm/mhZ6kOOkNUGHIj
         /N0cO3xp6H7sz4l4NLKjZeFajg+vyiOcnfaW7BNVHAbxboCwQk0rjW4cS5G+LJIMSEu/
         zeDxFCNScqZeeMbHs315rwuNq6taF0DwE0J+R/eNn29Te4VyE7uiSei21wTvpGfpxBy+
         VpXU+bcPEAodc0hDfSVQX7bcLo9yJaNySJ/esY9y6NqJ8f8c99hlvjYfJl+l6YGxZgI6
         KH7w==
X-Gm-Message-State: AOAM5311nRX3oZr5uVKpihIseKUFn+cceqgrrX1kNOxXa+iwRNMT4cpo
        rJhizU29muTJN6wfBUcipQRISfmF6PMOTijlZ9SKSFnG6talxTnUkErHnDOW6VHucO4Z27hX5oF
        1ieHSlC0dWKZn3pTW1g==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr4554136wmj.5.1600174801427;
        Tue, 15 Sep 2020 06:00:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx07g/2h99wWdLuX2NHjt8JE52rtrceFm2X8zhf7hv2+3BtR9p0ynQQuw59b/R5YfL/W1KyEQ==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr4554122wmj.5.1600174801267;
        Tue, 15 Sep 2020 06:00:01 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id g12sm25983421wro.89.2020.09.15.06.00.00
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:00:00 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
To:     fstests@vger.kernel.org
References: <20200914153213.76894-1-preichl@redhat.com>
 <20200914153213.76894-2-preichl@redhat.com>
 <20200915115612.GP2937@dhcp-12-102.nay.redhat.com>
 <5ab30d99-6a9e-8751-d60b-57ceb89846fe@redhat.com>
 <20200915123536.GQ2937@dhcp-12-102.nay.redhat.com>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <42210904-e7eb-d411-54d2-6080f81d7818@redhat.com>
Date:   Tue, 15 Sep 2020 14:59:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915123536.GQ2937@dhcp-12-102.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 9/15/20 2:35 PM, Zorro Lang wrote:
> On Tue, Sep 15, 2020 at 01:50:11PM +0200, Pavel Reichl wrote:
>>
>>>
>>> If you don't need fsck at here, the _scratch_unmount (and the comment) isn't
>>> needed either :)
>>
>> Hi, thanks for the comment. I guess it's not important for the test itself...should I fix it and send another revision of the patch?
> 
> I think that depends on if Eryu would like to help to change it when he merges
> your patch :)
> 
>>
> 
Oh, np, I send next revision in a minute.

Bye.

