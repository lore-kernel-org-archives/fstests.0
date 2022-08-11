Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD932C25B0C
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Aug 2022 16:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiHKQuU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Aug 2022 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiHKQt5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Aug 2022 12:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 143969D8E8
        for <fstests@vger.kernel.org>; Thu, 11 Aug 2022 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660234991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlT7Sic8QO1AMTJC4OHa6oG5D/j9d4B9LH00c/lFNEY=;
        b=LMKRy79eYpxWbzMPZzrgwK+cbjVcrIBA5G9SndoaKmoVIL0o0/6er/Y303c6Wi48Ry9ujL
        QbAseOgvszxyQMQJ8PNF/ab7g5TXO7ssxWsoN36rDIQGVGPBImdUD5U1xBoN9AWgcTklKu
        awlC8wdInOI6Kv9bml7Iygl2kWUDBW4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-InuE6C4-MAW7iE-2oNKpHg-1; Thu, 11 Aug 2022 12:23:10 -0400
X-MC-Unique: InuE6C4-MAW7iE-2oNKpHg-1
Received: by mail-qk1-f199.google.com with SMTP id bp14-20020a05620a458e00b006b959ef9d51so8833910qkb.12
        for <fstests@vger.kernel.org>; Thu, 11 Aug 2022 09:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GlT7Sic8QO1AMTJC4OHa6oG5D/j9d4B9LH00c/lFNEY=;
        b=iDNF/G6IXhr0fWj+p8cBtXCmkpScASgLeF6X9VECfnF/4Rupk4yOUTUIUmle33xycs
         zgHJIlt0aCOdVjap8d0z02clW8BffhBHNehv1HkA2T1/hahZPEjDdICjqAL2mlNbwE6+
         TzdSWd0SWWU1WesPv4ohuDfZA2xQ3L+2YBhx8bPrPwmZymbmJCDCl476G6XA2DWFei4w
         5CBQNXv9YwNNAbm5qMmcYsS1uP3djb2Q83k+lRN6lAKMs6V1CD17zn6hophBR3Pinj3J
         sUZOfcbi2KbKpaTTp5QxoTBbeCT5yAJl9N1TgmeSoB2VQN+oq3s0KTIAS4sKkq5lUUfq
         Cz/A==
X-Gm-Message-State: ACgBeo2dNGGOYcT0Q9H9GZqhJY9pnCjaPgXSKsdWXiG03nv7nuxGBjmh
        CzYL/fPJEd0Yp/2ykC4X03JMuV8657tzGVmZjJVHFV7HjgqtXsO1XrmtzZBQc4IBnwTZC+px1hZ
        vulyOluQXO0bN32/2Dg==
X-Received: by 2002:a05:620a:4901:b0:6ba:15c1:beae with SMTP id ed1-20020a05620a490100b006ba15c1beaemr1883260qkb.516.1660234990074;
        Thu, 11 Aug 2022 09:23:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4yT3ubSXo2cVxDNK9V5RCYyWvQCpUpZslOCNokBU7WUhVeLg0OfXJT4oU326i5KodhzmmmXA==
X-Received: by 2002:a05:620a:4901:b0:6ba:15c1:beae with SMTP id ed1-20020a05620a490100b006ba15c1beaemr1883240qkb.516.1660234989798;
        Thu, 11 Aug 2022 09:23:09 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a29cc00b006af147d4876sm2567969qkp.30.2022.08.11.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:23:09 -0700 (PDT)
Date:   Fri, 12 Aug 2022 00:23:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH v6 0/2] generic: test HCTR2 filename encryption
Message-ID: <20220811162303.7fn5kexteoc7haov@zlang-mailbox>
References: <20220809184037.636578-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809184037.636578-1-nhuck@google.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 09, 2022 at 11:40:35AM -0700, Nathan Huckleberry wrote:
> HCTR2 is a new wide-block encryption mode that can used for filename encryption
> in fscrypt.  This patchset adds a reference implementation of HCTR2 to the
> fscrypt testing utility and adds tests for filename encryption with HCTR2.
> 
> More information on HCTR2 can be found here: "Length-preserving encryption with
> HCTR2": https://ia.cr/2021/1441
> 
> The patchset introducing HCTR2 to the kernel can be found here:
> https://lore.kernel.org/linux-crypto/20220520181501.2159644-1-nhuck@google.com/
> 
> Changes in v6:
> * Remove unused variable
> * Rework cover letter

I've merged your v5 patchset. So feel free to send bug fix patches if you
found more issues.

Thanks,
Zorro

> 
> Changes in v5:
> * Added links to relevant references for POLYVAL and HCTR2
> * Removed POLYVAL partial block handling
> * Referenced HCTR2 commit in test



> 
> Changes in v4:
> * Add helper functions for HCTR2 hashing
> * Fix accumulator alignment bug
> * Small style fixes
> 
> Changes in v3:
> * Consolidate tests into one file
> 
> Changes in v2:
> * Use POLYVAL multiplication directly instead of using GHASH trick
> * Split reference implementation and tests into two patches
> * Remove v1 policy tests
> * Various small style fixes
> 
> Nathan Huckleberry (2):
>   fscrypt-crypt-util: add HCTR2 implementation
>   generic: add tests for fscrypt policies with HCTR2
> 
>  common/encrypt           |   2 +
>  src/fscrypt-crypt-util.c | 357 ++++++++++++++++++++++++++++++++-------
>  tests/generic/900        |  31 ++++
>  tests/generic/900.out    |  16 ++
>  4 files changed, 349 insertions(+), 57 deletions(-)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
> 
> -- 
> 2.37.1.559.g78731f0fdb-goog
> 

