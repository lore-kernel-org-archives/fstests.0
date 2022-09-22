Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAF6C54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 15:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiIVPIX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 11:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIVPIW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 11:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FE3E118B
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663859299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuPIksFpqIz7/6+YKfUafOJxqtO2Vfj6GB3KC4TDRb8=;
        b=ctex1jy4jBJVm4+8NudbUgwgzQORQVElXabVYMNjjAYNNMwOZXPkyD7RkdVlTxZTa6EMke
        QbLSd4BinLVqJNQfGDCpQWOwbbRrApfqA8JtVaKyVLIe0WNO7soglk/2Bb2kHvgGotnQdT
        TXKcaFunKkSW2FtyIfvc7o5pue/l1A4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-RZvHX2ANPmq8kcIIf8z1_A-1; Thu, 22 Sep 2022 11:08:17 -0400
X-MC-Unique: RZvHX2ANPmq8kcIIf8z1_A-1
Received: by mail-qk1-f197.google.com with SMTP id j13-20020a05620a288d00b006be7b2a758fso6789916qkp.1
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 08:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xuPIksFpqIz7/6+YKfUafOJxqtO2Vfj6GB3KC4TDRb8=;
        b=Its9P2FBLMJCoOl24lId+CbILnI8DmFWn6t7XbKMLmwq48iHHKoa2aiPNGEoauO/4I
         9oZ6Y0qTRuDSeIbkuUFUy2cISpWKNH/q4fuEbTL++v1qgJ+u0bc5d+GwD0b0fqqo+ci2
         fj8xkHK2G7XLVSp3SguNTThsmDmWIalGgMC1q1jnYVPMoKcvCBwqTgIDKEzr9FiK3rot
         txZK1t75xB0tVSqzx6ASsbRPXlhvNhDpv3cGOFO2fqzi5L2FL8xHQIUT7agGlqBvSLBi
         zp8J3ffoLDOqZ5jO/WE64DgVLSxJUuTuVq+S9RePtD2WlZYv/4vYKmXypqGcbypNnDVI
         IuhQ==
X-Gm-Message-State: ACrzQf3B9EiYVsMnvAA2XWmygk3MsFEwl6hN6pqBpFHtUFJOH6eXMNOl
        Dmw7lfi58rXC22QSr4bzrTzeRMqdmLht/2Ye0dKRYH2N4FQCptycU1mM4LZjxDycA+8F6OyZPzM
        Ej+/y+woC9TmXDcMRcw==
X-Received: by 2002:a05:620a:905:b0:6ce:604c:3187 with SMTP id v5-20020a05620a090500b006ce604c3187mr2461871qkv.523.1663859297397;
        Thu, 22 Sep 2022 08:08:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM553wWOGK67T0wFOu3jpAiny49dPc7NZe/ua27jBE9NIQuNbhseQROEOem1qc2hD1FEpkTndQ==
X-Received: by 2002:a05:620a:905:b0:6ce:604c:3187 with SMTP id v5-20020a05620a090500b006ce604c3187mr2461837qkv.523.1663859297117;
        Thu, 22 Sep 2022 08:08:17 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bm17-20020a05620a199100b006c73c3d288esm4071956qkb.131.2022.09.22.08.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:08:16 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:08:12 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/4] generic: cleanup test files
Message-ID: <20220922150812.b3tp2cdue7bklxvs@zlang-mailbox>
References: <20220922134822.1020119-1-preichl@redhat.com>
 <20220922134822.1020119-3-preichl@redhat.com>
 <20220922143638.ruwujtwblv43sgfo@zlang-mailbox>
 <91ec6d59-5014-2e3e-8e80-aac162b8ffc1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ec6d59-5014-2e3e-8e80-aac162b8ffc1@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 04:55:17PM +0200, Pavel Reichl wrote:
> 2) If these $BASE_TEST_FILE* files won't take too much space, and won't affect
>    later testing, how about keeping them in $TEST_DIR, then remove these
>    specific _cleanup(). From my testing, after running g/285, g/436, g/445 and
>    g/448, I got [1]. Looks like they only takes ~25M space.
> 
>    Hi,
> 
>    as I mentioned in the commit message - in my case I'm getting:
>    8.0G  seek_sanity_testfile10
>    So I think it's good idea to solve it somehow.

OK, you can combine patch 1,3,4 into one patch, due to they all take too
much space on filesystem which doesn't support sparse file, so we make
sure these files be cleanup.

