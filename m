Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C5C54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 16:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIVQsG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIVQsF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 12:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B8C9958
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663865284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LT5++F9AfzySNOS+jrq2DqgbuSjqCBy35/CEn57RddM=;
        b=OYVBTIK9JIJByd0GRl1l6H3mIUMgAbfqtw5lCPBaYOlRxKWVY/5TPqb9cAa8h8GLFr5Y8e
        tqVfJfBJIeysxCg2UrkMVqntuPCI/c7F8b7VHcmGxtBffcgHgF5bqD4KfAlBTQQ4CwCYDB
        4yms32g3F3wFidV9TALyGR4bU1tli9o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-BrPZzomdOwucq4d8hmOQZw-1; Thu, 22 Sep 2022 12:48:02 -0400
X-MC-Unique: BrPZzomdOwucq4d8hmOQZw-1
Received: by mail-ed1-f72.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so7030862eda.19
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 09:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LT5++F9AfzySNOS+jrq2DqgbuSjqCBy35/CEn57RddM=;
        b=X+mElcoCUstzme/lXaXNWmJU63739AocC4RUkK5NzByVFi4MB+fiNeG6GdRTkbKEka
         LfJnI/7349XdWa64FRI0QGXj5HBHEns6SbzIzBbxR2qoiPrC9SaUBKcaG1CGHI+TW0z5
         fmV9wy+9q2SIZarvqHRktD8I3jf8ZY2lPpDz1dyaQRETzVKh1/NbHYpTIvtSHfZTFOLk
         mXZ06n15IsEm3HOpGgHYK5fkszMZyQAb4jDrmmxL9Iy3roo8C2fegY+ygUjNAmfug/ZZ
         cD+Igk+Gl5P48S1ixHNzpGI6IZlWj2o2jJEahq3fLnl51keQNoacc4LDRVAVvBtZs7bT
         HtVg==
X-Gm-Message-State: ACrzQf16bF7dI3SUJoNysuKx4Pc1aSENNkbgvcAXhJB+EWkCNlozPuVU
        ieh4kf75JHaAJTkfBd3LXCupIpM+e8KI546rKchZn/bgGeKxUYCtGR/S/2F8gEVyzr31/hgUAfW
        N9fOlRAnXHQZoiOSpOA==
X-Received: by 2002:a17:907:3da9:b0:77b:9672:3f7f with SMTP id he41-20020a1709073da900b0077b96723f7fmr3678395ejc.636.1663865281232;
        Thu, 22 Sep 2022 09:48:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM580I+yFLPEA65K0P9VXHnRTGOlyxjunQUoSuTk69/cXPXyBXuMXGPjZzvJ+yiuT+0H9yvUnw==
X-Received: by 2002:a17:907:3da9:b0:77b:9672:3f7f with SMTP id he41-20020a1709073da900b0077b96723f7fmr3678383ejc.636.1663865281064;
        Thu, 22 Sep 2022 09:48:01 -0700 (PDT)
Received: from [192.168.100.69] (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id 5-20020a508745000000b0044bfdbd8a33sm4029203edv.88.2022.09.22.09.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 09:48:00 -0700 (PDT)
Message-ID: <d59dcff1-29dc-71fb-48a8-76450b19a66d@redhat.com>
Date:   Thu, 22 Sep 2022 18:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 1/2] common: new helper to alloacate fixed size files
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
References: <20220922063836.974796-1-preichl@redhat.com>
 <20220922063836.974796-2-preichl@redhat.com> <YyyL1mWHw2vd+QSm@magnolia>
From:   Pavel Reichl <preichl@redhat.com>
In-Reply-To: <YyyL1mWHw2vd+QSm@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 9/22/22 18:22, Darrick J. Wong wrote:
> On Thu, Sep 22, 2022 at 08:38:35AM +0200, Pavel Reichl wrote:
>> Helper that creates files of specified size using falloc if supported,
>> otherwise pwrite is used.
>>
>> Signed-off-by: Pavel Reichl <preichl@redhat.com>
>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Technically speaking, I only RVB-tagged the second patch, not this first
> one...
Oh, sorry about that - my bad.

