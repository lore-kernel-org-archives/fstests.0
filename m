Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1860C32772
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Aug 2022 10:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348371AbiHSKgL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347745AbiHSKgJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Aug 2022 06:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9F4F2C8E
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660905368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gv24X5iUZmQ3lRi/Sd7/xOmeJQuU+u8ddhvFNlFWWPo=;
        b=amGDLJ/hmqZTO7Q3t59azldPYICkCDiwMHFHv3ZsLrAscZFicTa/Ha/kAuERToBVsIDpUk
        6qPpKxn8/cDG4UaL/SukQPutXe3R75eLlumKVNI/9jF11HmJZIoBNvbyFuKc6OWCCBp0tg
        7+HO6d2vqY8ytcR9jRn3pnoyOaUHQ8k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-CypoCsFdPtyNkYZhj2Ml-Q-1; Fri, 19 Aug 2022 06:36:06 -0400
X-MC-Unique: CypoCsFdPtyNkYZhj2Ml-Q-1
Received: by mail-ej1-f71.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso1347706ejc.18
        for <fstests@vger.kernel.org>; Fri, 19 Aug 2022 03:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gv24X5iUZmQ3lRi/Sd7/xOmeJQuU+u8ddhvFNlFWWPo=;
        b=5eZ1uJ9kkYU9lZWBScpEI489+MBRAum6QIY9MOgxq6nvdWSQEyRfctjREhWna7ShGl
         emHe1lL2DwKUHvjY1pccky2eV/VnESxh7fQMQCi2tALYTPJwscVlbY4SWUA17Ny8qR30
         TqC9JhoVyPpA8CRRzl0Wqqrn/H5j4hkgdiVwC1yZEoBy4sC6AptuaGOVJcHkNCmzUIo/
         kl/36h2TBPap91QCMTpzg7n1GUHDfBYwpubrP3HibKho0Va4tm/9RlEZgk0sBETW1I4W
         Pfo3mpycHXoHp7xvb7rx/TbLgxlJ1JUXX01JBCYYqgaKbYwSTNfl9uDH/cajVlQXjr5G
         XDrQ==
X-Gm-Message-State: ACgBeo3DgNmm9QardPuqhDq1YPLoQjYrBS23nm2KzF1hO/uGFMPycnTB
        R7Y1RueATBRMdr08Dk8/+xyOuiHDvznpIPuJujZICF5WUgDKy1ud+naWz47WclK6rG7fQx3SNyE
        2dOLBPf31zw0HOK6QTg==
X-Received: by 2002:a17:906:668b:b0:730:a5b7:8985 with SMTP id z11-20020a170906668b00b00730a5b78985mr4245920ejo.548.1660905365578;
        Fri, 19 Aug 2022 03:36:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR76tAFRrIi+XDGEfhx87egos+SIXoI7+a+DEk2izX9r4jxWvEzOeaPNvOxT9OKqLL46/7FIvw==
X-Received: by 2002:a17:906:668b:b0:730:a5b7:8985 with SMTP id z11-20020a170906668b00b00730a5b78985mr4245915ejo.548.1660905365397;
        Fri, 19 Aug 2022 03:36:05 -0700 (PDT)
Received: from [192.168.100.69] (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id c18-20020a17090618b200b007306a4ecc9dsm2199269ejf.18.2022.08.19.03.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 03:36:04 -0700 (PDT)
Message-ID: <de7b86fd-4228-60ef-01ee-3ff44ba9debe@redhat.com>
Date:   Fri, 19 Aug 2022 12:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] fstests: add missing _require_scratch
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, fstests@vger.kernel.org
References: <20220818025614.47274-1-wangyugui@e16-tech.com>
From:   Pavel Reichl <preichl@redhat.com>
In-Reply-To: <20220818025614.47274-1-wangyugui@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good to me.

Reviewed-by: Pavel Reichl <preichl@redhat.com>

