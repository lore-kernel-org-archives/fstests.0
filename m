Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA3C433E0
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Jan 2021 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47D322A83
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Jan 2021 15:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbhAKPvO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Jan 2021 10:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbhAKPvO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Jan 2021 10:51:14 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA9DC061795
        for <fstests@vger.kernel.org>; Mon, 11 Jan 2021 07:50:33 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e15so1571378qte.9
        for <fstests@vger.kernel.org>; Mon, 11 Jan 2021 07:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yeojcisLuU8d2k0Ck4Gduo97wdZD2Oi9SWZI2+gN5ks=;
        b=LJEqAESOWAWKgSTL3qmGOgSp1axVNU0dX4rrzSrlcT2dWI+O4Dsz6Y5Vzk5W+OjlbS
         ZvpM6YMPIA1e8wvCH7GY7tzyDv65jjMt1TIqTrWTxQczHRFyl7DnYOfZMFv+ojkbMm1h
         6EAjuOyEy5HfR2FLa42Z/pYJOasBEtQezonMcxxi8yMqIVEoyq6tO5EqFHJZepxurSrW
         +wuHSUiNjdGbk58YDyayB0LSisS+u3PksntCj0AABb8VgITx0aS/ZhkNTgIMDRgV6rfF
         xMPWvCnS5Qo3VcDcJsOyOQ57gL2WHRr/3S51sV0ARYTMSAhG9x8CFSZvCMLjVezXfM4c
         cs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yeojcisLuU8d2k0Ck4Gduo97wdZD2Oi9SWZI2+gN5ks=;
        b=Os0RcybLl9Itv1qV4WNXgriXFW6gIxgby2HfU2/7REJkRhMYH1VJXgL8bmV8duWQ4X
         20MfESOYJ7LSZOvNsJ+DHgDNXsOxy4j9Egl+4X6KTmOdflfjAesiYLHdLa6VSDZ62Tdy
         pgo0lehI1cJAmeSmHhfxLLxUoUlsmF02X4GUTCHhMZs29AahNUFnVUekCWBXSKI2vgDP
         GOTZwHQjccCeuBxN3SoY3qNWLpHV4CZ2p5i1PlF2/wplH7p+4mb24lhPHWnO54QN0j+a
         z+/RUsmBRzE6XV0MbgfStmumtgxfPBXQ+BAdD5mt+wXZU4GQU9Gok01JXVeEQJjvZC45
         eFDA==
X-Gm-Message-State: AOAM530QBOQ9AuY8Mc1oCDHM8iRnUHKZPlk6WjQ8+YwfELMpBHSnCMC0
        87hGDpBO4OOZudQXeCoIIWFNpQ==
X-Google-Smtp-Source: ABdhPJxncpHLjrhCJavD03O85IrojkW9zJz/q1eqZqCZ5IVKeTh3ufpEJw0uPiXLapGLfqlimOlFbQ==
X-Received: by 2002:aed:2ea1:: with SMTP id k30mr261289qtd.32.1610380233077;
        Mon, 11 Jan 2021 07:50:33 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b11sm2090239qtc.5.2021.01.11.07.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 07:50:32 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: Add test 154
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20210111091742.393039-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a0cdd790-288c-8631-ec01-d0ac61b5f7d0@toxicpanda.com>
Date:   Mon, 11 Jan 2021 10:50:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111091742.393039-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 1/11/21 4:17 AM, Nikolay Borisov wrote:
> This test verifies btrfs' free objectid management. I.e it ensures that
> the first objectid is always 256 in an fs tree.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Will you add this to our staging branch so it gets picked up by the nightly runs 
as well?  Thanks,

Josef
