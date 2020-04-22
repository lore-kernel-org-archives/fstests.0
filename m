Return-Path: <SRS0=NJCV=6G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7911BC55186
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Apr 2020 08:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55082206D6
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Apr 2020 08:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDGsMxjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgDVIdo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgDVIdn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Apr 2020 04:33:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA20C03C1A6
        for <fstests@vger.kernel.org>; Wed, 22 Apr 2020 01:33:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id w4so1456164ioc.6
        for <fstests@vger.kernel.org>; Wed, 22 Apr 2020 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UixwMrfUL/IgOMwpj9D54FqUJdkqOOvQZPIGPQB998I=;
        b=lDGsMxjAHnVrUO+ixYbksKV+7W2pAgKAhyMApI7CnqpnakOfeLxwGMYv6/Bq+qWEO5
         eYDtCjraT/vcHZ93jOjFPaTX3ecKnCh7TtWEc0pNG0Ws/ztb/ADEU+OLiLVnaKbSzIJL
         11hg/zjkfyj6Whu72iIrHOMmgPuRm0+IjJ1fNn3EkX3Y6U69JBDft5JLBREGr3YND3CH
         bykui4HF+XjCQ5a8RPn8Bpl9Kz1UyEWw9SdHc2a5gst05pbfXAlXxBxVQyFeFcgSytPu
         a8wehaO2WXRta52xo1/u43c/lkXXYsBBREPwL3Fu5asQHrzy4i7BFawHQHkR+w73fNem
         Ineg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UixwMrfUL/IgOMwpj9D54FqUJdkqOOvQZPIGPQB998I=;
        b=o7a2zBHBdI0+w+D0J93q5JtAqDuFfbG46OevVZphSuVyEYsjJ2BWOzd8zyAZ5e8RVx
         pGCVIvj8cTHXijntQOjyV19GO4PyAdiEVRqlhYM5Qrp0Bp/Se+tILvWw/Zasgg7BymTG
         2I8qDj2Qf5ZS12KHT6fHAOr1iCGemzBMFY5CuMOoIHnp2yOQdglzf2nIqiUnCkrz2cgk
         lF/rEoniubuVtdaSbHbxtVO6+tvaEcEe/xMPVzjNlEhMBQSKMVcucdAX+9SqaB7Wdx/c
         XrlufFjrbrhQV8SK61y/HkElXfncQTPkX0A3rLgInah0GXAxcztwWzqgLEeGekmm5Vhu
         UB8w==
X-Gm-Message-State: AGi0PuZFkar30sf0JzFmsHQkPvk1nR0+5VAnVQ0bXIWe1H3+06maZlKW
        BZATU6oLfbfkky+bE4GoQw3HppgtFq9D6aE2wbMv1/Hh
X-Google-Smtp-Source: APiQypL9lrBE2HjoyL4eq0MhnrGA+/+wbUdWpwhaN4tScmv8i8I8rSRXh3D8T9dEzy7Gil11Tcb25J3lUFFSnSfoloo=
X-Received: by 2002:a5d:8417:: with SMTP id i23mr24476673ion.186.1587544422380;
 Wed, 22 Apr 2020 01:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2wg3RX8rKzFw+s=Z03gQpWsDcXQqhcan5vNRaw0BFz7URzFQ@mail.gmail.com>
In-Reply-To: <CAM2wg3RX8rKzFw+s=Z03gQpWsDcXQqhcan5vNRaw0BFz7URzFQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Apr 2020 11:33:31 +0300
Message-ID: <CAOQ4uxhOHXFJatXqnxL1PtmMc9wzMhYR0WVj35AAvcd=DFabcA@mail.gmail.com>
Subject: Re: Additional Crashmonkey Tests
To:     Arvind Raghavan <raghavan.arvind@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Jayashree Mohan <jayashree2912@gmail.com>,
        Vijay Chidambaram <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 21, 2020 at 1:39 AM Arvind Raghavan
<raghavan.arvind@gmail.com> wrote:
>
> Hi all,
>
> I'm working with the Crashmonkey [1] team at UT, and I wanted to
> follow up on an a patch [2] Jayashree sent a while back.  The
> patch added a test combining 37 test cases for hard link behavior
> into a single test. In that email, she noted there were also
> similar Crashmonkey tests for other operations (falloc, unlink,
> rename, etc.) that she could port if you all were interested. We
> have now built an adapter that would allow us to port these
> Crashmonkey tests over to xfstest.  Is this something that you
> guys would find valuable?

Speaking for myself, yes, I find this valuable.
Jayashree's test was merged, so I think that means that community also
finds this valuable.

How many tests you intend to add?
How many test cases in each test?
More importantly and how much time each test runs on a typical system?

Thanks,
Amir.
