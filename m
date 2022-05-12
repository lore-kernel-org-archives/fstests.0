Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4152C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 18:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346644AbiELSN1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbiELSN0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 14:13:26 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6012220D577
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 11:13:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v11so5406797qkf.1
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 11:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dz7155n2kQQd0c1UbuMiQXhtSD6QdwrkLW9SvbYgLQ=;
        b=obyMqgD76B396FupgjkzClTttJ8zZUYdRNqUusVdxxHhxA2F33XKJQeHsxnaS+yhvH
         j+XJ4IZzIJPC4GPV6Lc6tn/dzdyue3wAnnsPtCOp1I/jGdpKX5+tDNHWMQjNgC9hK/is
         jLdw8HMKvWJWRXNtrMDaFy2y0k5y1jbgTUWODUlb/d84VSR0AoWBiOeULb2X7KZe8Zkf
         Xgu2Q41rA9Yn1bhSsb2PHNKh2ycZ1jYXF9+77miYVtrRMoCuncAT/yHGiHM+ZBm9JfCf
         qrbU4pRGjmIm3PiL5NiDCNc+L2TUJ+/CRFHmqtP39V3DGxUP/t7Kb7XskqFkNPvUqtcU
         hUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dz7155n2kQQd0c1UbuMiQXhtSD6QdwrkLW9SvbYgLQ=;
        b=bDiqV/sWeDSXxysOvuBj/F0N/UNiBeZaO50LRRRIbOReJ1wPDZvgfi9IMkekvu63Sy
         PCE2olmDgYRgUCO+ArJyUoSZVYm/jcP2CSzE+LB5AIcVuetaWwoleQZHkPw1ieyo+orG
         gm8hc+e5O27Yjo+s4htALO/n8CRGx+VJnr5d7EraEEGuUELiCcJA/AJUEqU2qeiN3mBN
         v2tWM1ZcIFdW4rmTkDujVzn6J4fjIQemY9Emy6hs4YKV+PsYKd9ARKp18J388GY2tjAK
         hFbhazVYgU4e9iQMldyj4qL6/Ecraad2m2MI7yP4ifb2K0nB4dp/keA16AC+FIaRv9NZ
         wGzg==
X-Gm-Message-State: AOAM532LHYpmIW88RKLjPy8K86PkoMY7hkoHKOupfoKOnedB3JkUqav+
        4XAkMFtu933wydhjA5r4ifvHT5AjXpTKY1rz3PEbyAcz
X-Google-Smtp-Source: ABdhPJyZi7kkfMCkrP6ND7QEr1FUvV/BYRQhKFQK4vJO4syowhfqW2v01l1lpNhP1LJEsGvHXzl0rScCFzn0OsCPV1M=
X-Received: by 2002:a05:620a:1aa0:b0:6a0:a34:15e0 with SMTP id
 bl32-20020a05620a1aa000b006a00a3415e0mr936486qkb.19.1652379106337; Thu, 12
 May 2022 11:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220512175603.2833164-1-zlang@kernel.org>
In-Reply-To: <20220512175603.2833164-1-zlang@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 May 2022 21:11:34 +0300
Message-ID: <CAOQ4uxjW=8PvV8ANnCz-7+=DFgUjyd-7N73ZMhEW+92wpLgHNg@mail.gmail.com>
Subject: Re: [PATCH] common/overlay: source base fs specific common file
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 12, 2022 at 8:56 PM Zorro Lang <zlang@kernel.org> wrote:
>
> When tests overlayfs, sometimes we need the underlying fs specific
> helpers, e.g. common/rc has:
>   _filesystem_timestamp_range $OVL_BASE_TEST_DEV $OVL_BASE_FSTYP
>
> So when we source common/overlay, better to source then OVL_BASE_FSTYP
> too.
>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>
> The generic/402 always fails on overlayfs as:
>
>   QA output created by 402
>   ./common/rc: line 2441: _xfs_timestamp_range: command not found
>   ./common/rc: line 2403: [: syntax error: '-1' unexpected
>   ./common/rc: line 2408: [: -le: unary operator expected
>   ./common/rc: line 2441: _xfs_timestamp_range: command not found
>   0;0 != 1;1
>   0;0 != 1;1
>   Silence is golden
>
> Due to if FSTYP is overlay, we only source common/overlay file. But we
> still need the helpers of the underlying filesystem. So I think we need
> to source the common/$OVL_BASE_FSTYP in common/overlay. What do you think?

That makes sense.
I don't know why I have never hit this.
Maybe because I am not running with multi section config or
because I am runing with kvm-xfstests runner.

Thanks,
Amir.
