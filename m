Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5363C43461
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D9222211
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5RdL0pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgIKTfy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725819AbgIKTfv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 15:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599852950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJFRKKwE6yfCVQgZuOMEE69S+vr95K+7BPt85MLsiCs=;
        b=T5RdL0pIrVaEcPR61AalyQxnZ5JGaIi8omFEMjbeRyCy5Lv9vETdYNBcqa2LA6MCZPjhpc
        xo/C4p6JqyM6OjYX+FS0yUCaoodvnX6SIkH+VFaTxDQe2qZck/kDqt585N2qlHr+G/RdLq
        YSNdEGZGsUPx6OOBwioLxwW7Oohlebg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397--Q75FYuBO_eTwYGRXuXsPA-1; Fri, 11 Sep 2020 15:35:48 -0400
X-MC-Unique: -Q75FYuBO_eTwYGRXuXsPA-1
Received: by mail-wr1-f70.google.com with SMTP id i10so3806695wrq.5
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 12:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJFRKKwE6yfCVQgZuOMEE69S+vr95K+7BPt85MLsiCs=;
        b=pjuc2NPIPrL78sl6OH81iPsQS4d+pcIdePznUQXl/wvW4akI6H3lyF08G6/FV+gOVN
         8PgAiiX5Na3fzM2AwXLsOKYT1CEseZL5M40G658lQODiRwRZRFhnIroFrVuP2ysuEQQL
         /RzzsZq4nOhbPwTs+Xuy7QGT3a94gfJGvU8xkiqTjhkWS3AM+iaV4n/f5Pb/qD8bkqMV
         odlWZ8AEF3ORJ4wlZQjpgAmgLhcaAjmXO3yCxylbNLAbizfCEGo4ZlLcLjmjpSMojAzC
         VZqtpOZ5ioyBZOMZY41SIb3ocW6BXvkKmd6RITtKTDL1chktWvuFO25KPHB/sBdLLJXJ
         FokA==
X-Gm-Message-State: AOAM530h7/TM9yB5oz3CzkCu/b1GYIPszTi6ctXW7aXjpF2yMa0xD5HA
        teOyJpHL1ClkHTpqbZPc9L5faSpEiMLD+VYX27tk/o5fmCQNVse7G/VpUbV8fNiXvao0jVilTvo
        UXvr7AKfNgdoElpIpCg==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr3783412wro.178.1599852947323;
        Fri, 11 Sep 2020 12:35:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVdAa4dPRywnGbEBrT11XaOrBD3JZHaGEf5Do9sisG+x2DcwTlhu0PnPv/Ws+X0EEvwC2uQA==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr3783405wro.178.1599852947138;
        Fri, 11 Sep 2020 12:35:47 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id c205sm5957923wmd.33.2020.09.11.12.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:35:46 -0700 (PDT)
Subject: Re: [PATCH 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        fstests@vger.kernel.org
References: <20200911133855.38997-1-preichl@redhat.com>
 <20200911133855.38997-2-preichl@redhat.com>
 <20200911182346.GH2937@dhcp-12-102.nay.redhat.com>
 <20200911193006.GA7954@magnolia>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <97bd1c15-2361-b870-9c58-888801f6c2c2@redhat.com>
Date:   Fri, 11 Sep 2020 21:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911193006.GA7954@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


>>>  608 auto attr quick dax
>>> +609 auto attr
> 
> "auto quick attr"?  Assuming this test runs in under 30s and doesn't
> crash the kernel, right?
> 

Yes, it runs about 3-4 seconds (~the sleep call), it does not crash the kernel.

OK, I will add the quick group, I wasn't sure about the time limits.

Thanks.

