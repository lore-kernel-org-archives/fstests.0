Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3412BEE4993
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Aug 2023 17:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjHVROv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Aug 2023 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjHVROv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Aug 2023 13:14:51 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F130E0
        for <fstests@vger.kernel.org>; Tue, 22 Aug 2023 10:14:48 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34ca6863743so3448535ab.1
        for <fstests@vger.kernel.org>; Tue, 22 Aug 2023 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692724488; x=1693329288;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=kNYblONfReRyJq7g7OEhF+TlYM4YdYvXCQGHeDUi1wCgD92KgYK7PY9CARP3Bdh5VP
         PDMrjdPCUfLYHxRAET0Jc9pERReaAINB1FppoNqKD/blZw6POWTHU6KDNhWA3jEHLVY+
         hXiNAMhRIJcnwQbNU1O2jV5bKfAnPdtF1Y7UOYDqSLdE0v9C0sYzWCBM9j/zTkJw2o0D
         TEPF5WH8NgyHXviHK/DFVxGII/dXs1KaLjfnbWIZP9NAnfmufK8SJU0ZD5lIG4EUUDbo
         WDLmHytFO+kkOpp9LWmumwW2sfqENaAEKUTYTx4atB5J3nrgqDOQI5VnRi788UFXUfoy
         7H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692724488; x=1693329288;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=XLmhDWfK2pKwz5rLHODeTflRC5h1/qtAgaW93YE6bnn1VWtd5Ao2q2RxEZaFwo19UP
         lgkbnpH7G1ZL9HOxWhFq1AZprsZa1FkFIezzDl/LeidB69kfKYZwKgnXvl6d/xU//AEj
         l58tdAmjb7MkbmfMsCSwHhrrWOOXK5vqV3xCTQ0+9uochaUjAGcTurRWr6K8687IBeW7
         2Z8mKi2MUmexrvp6KUrq8ty3ehrO92e3hly3DNNd5axL2AxSGoXqM/fbgPVWELvmlZGA
         Ly2DgR1soZpafo6nluZHrp+9a4LxhIGSZhzqmCihKglLgSB+uGBfamQ3PT71nVni32XV
         AQrQ==
X-Gm-Message-State: AOJu0Yz6C0uH9E06E7FBieDRyDZhDTZvMUFvrRwYjlLtWhq0gSlCBtZJ
        gWKkWcR74xek3W8yl9aZfzJx9wAaAArpPTbpwCg=
X-Google-Smtp-Source: AGHT+IFAlCaF9ctMT0Esl3E69mMUSWRJhC0j0UNBoNDQoe1XqnKm7ErzikmB56GFeh1KLdeV2HOZTw==
X-Received: by 2002:a6b:3bca:0:b0:791:e6b3:cd0e with SMTP id i193-20020a6b3bca000000b00791e6b3cd0emr12728757ioa.1.1692724488193;
        Tue, 22 Aug 2023 10:14:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t17-20020a05663801f100b0042b2959e6dcsm3191395jaq.87.2023.08.22.10.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:14:46 -0700 (PDT)
Message-ID: <11084f04-47ae-4aec-b9cf-572029e542b4@kernel.dk>
Date:   Tue, 22 Aug 2023 11:14:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: fsstress: wait interrupted aio to finish
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230821230129.31723-1-wqu@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230821230129.31723-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

