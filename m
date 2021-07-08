Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37AC07E96
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 16:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15DC61876
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 16:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhGHQjN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 8 Jul 2021 12:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhGHQjN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Jul 2021 12:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625762190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=832mfoVoJ+yA47d9+hU4pvcinumCHFtkU1nrSJigL2Q=;
        b=c/CBcMk02MT6oqI0pdpGG8Fwx87NV6WuKGylNHWC3I4JXlJuA173gOZzkHlyJqU8APXqSh
        JIRwdtni1SJbpCxX0eTOdp12aIGjF3w4zW8BcxF2OYIzT06rUNmRtYNUmp0u7s37KvxbaK
        +9G5DbZI+AP4pbaR5k1Yutn1TtnH+rk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-P5t3z_BaMLGfuaFXXUDEgQ-1; Thu, 08 Jul 2021 12:36:29 -0400
X-MC-Unique: P5t3z_BaMLGfuaFXXUDEgQ-1
Received: by mail-ej1-f72.google.com with SMTP id q14-20020a1709066aceb029049fa6bee56fso2071254ejs.21
        for <fstests@vger.kernel.org>; Thu, 08 Jul 2021 09:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=832mfoVoJ+yA47d9+hU4pvcinumCHFtkU1nrSJigL2Q=;
        b=cqpJA1jXIcrnOrkAm1cgcU3iEXhM6O6uv1aBQuCWih/fuHYKqBKdEjXyZsY0tp8ZbT
         CiCuYRqOnMSA+IqtyUmlg0XsDFUgPbrff4OCYuAhGWdnZLK3t+lu6kxFZ0hs5iUbrKNB
         lp3LlU0Ksl0AEUy4yKbW3rspiNGWYMsuF9biDP2X+wgj3XNNe2eQ3mNZjoGDV1LIDsUH
         aHyRkXAK0JcKsuTvV7ub1TGrMfMoZzU4kes1FtV02iiLpfjd6NUPzj1l3y9hi8Bg0rZ5
         RAEqwidKDF2VOvEtP7B7Sq8LsnkzfBhNTPIyqFdcjux2WNTvLB7CQNX5Rbkp04WVDqqL
         T8XQ==
X-Gm-Message-State: AOAM531khdDUBGCqGIbZwk9jfazXVgjI+9VTESsnUKD2vPkRb7HKVk2F
        SLJ+tUCnhahTJQwHFm2NkjuUzVWl1ivuUCT+pkr5TwpDYdXcfx9YYB/JtFbuIYAMAuTbk/aUnYl
        dpqkGGmKBlhW6MTkjCtDwImlewU7tPxmuErNS1Uu84aTyE+QXqN0fGGmjF+fHYSrSnDkI
X-Received: by 2002:a50:85cc:: with SMTP id q12mr39598879edh.182.1625762188105;
        Thu, 08 Jul 2021 09:36:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyDxu+LjZcPkMloj/ue4BPXIRAM3KnSlBRoi+ekXpzfLAB0vTlR9muK6fl+eb361hTVOCpXQ==
X-Received: by 2002:a50:85cc:: with SMTP id q12mr39598862edh.182.1625762187969;
        Thu, 08 Jul 2021 09:36:27 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id b25sm1584584edv.9.2021.07.08.09.36.27
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 09:36:27 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] generic/{453,454}: Do NOT run for FSs restricting
 names
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
References: <20210707223227.32053-1-preichl@redhat.com>
Message-ID: <d3a80e73-7e4d-47f2-8643-891369230407@redhat.com>
Date:   Thu, 8 Jul 2021 18:36:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707223227.32053-1-preichl@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello, please ignore this revision as there's already revision #3 on the 
list. Thanks.

