Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE1FC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 09:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiGUJPT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiGUJPS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 05:15:18 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B301101D8
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 02:15:16 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id j1so970497vsr.4
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yaqDU2czr0oCQvIvCw+fiZww3UYzWUMKWQyhdMpK+iQ=;
        b=fszTfbfpAQLcQieY+obbyreHseziokWBDwGmFTuUFwU8VyVdW4YAgClmje72D//oac
         kL61u3UYopM8T0n3HcrmJ6/cKU5CuUp9mGe4DSjbsxpSzP7t2pIBymEmE5HG/XYFkR3h
         L8y8NseCDonFInN6ySfkSAH6omIJxEtKzAbxEOiPb3hkzqAZdd66GZr8hh7k9ImmjuIM
         LAgXj3DTfEm4hI15+9oSkcvUfuf4H2ytxnomQ0i1JKZt8IeTYnjY56i7QW2QaxcvaYU5
         m/fQ8HIrH6S0TATY+B40OxwPFa79Ylmg/Svj2A2E6hKtHvGQ1RU6VDbitaYUx04xd4Sh
         XCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yaqDU2czr0oCQvIvCw+fiZww3UYzWUMKWQyhdMpK+iQ=;
        b=m7S1IqdORWxpsp7FZrP7/A3LLG2Ll3lf9iseawNraBNT/ilIOxywW+8jy7itGdOQeh
         yWJBhBvd8McxAZtuQ1p+I51tfAPerUvFJIQbkWVPH188FwjT13Kbky5lgA8wnxx0tTXq
         eQotn1agU20Dzudff6xCft3rc5ndGF22sB/YZXcQ0+s2z57FX5FF1/otR2jS+EUM5GCL
         /Y1iF4aLd504R5VjEA2YVkfhCXWBeISkTpZ6GWPdOPLvqGHUvFdqN5ArK/wVBXrdEBrg
         dny+JOEe/xBfBDhQLo1TzfEJIxCurzzqu4KBqxsie4C/LvGzhmpckjq2nWDZ8kUtudRP
         D9Yw==
X-Gm-Message-State: AJIora9iZHT7z3b0iU/COFEraJfn2099KnHleZ35gJf6ZvqIekvgHo9+
        L1mN5LPX2I1UQpbPJBnI6PVpl//XbnzzBCOJ4L8OH6VSTvEywQ==
X-Google-Smtp-Source: AGRyM1vt7Ncz4vXEa5FZyQw93hLo9OzZGGdzacM/7mWDTF3mxr0z5pQoWU/UGEWcFPYRvLuu+SA0vCWlTf7RRES0MAk=
X-Received: by 2002:a67:c110:0:b0:357:6c34:9643 with SMTP id
 d16-20020a67c110000000b003576c349643mr15804717vsj.3.1658394915374; Thu, 21
 Jul 2022 02:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <YpjVcHuxhEQwPusN@bombadil.infradead.org> <CAOQ4uxi0eY3ybXbL6TEZv27HUoBaSTcthjC7aHRCTzACfyq52w@mail.gmail.com>
 <CAB=NE6XAL1+OXV0X5zBZCMWsqsy-xz9E6rkwPkGOHRXyG4sohg@mail.gmail.com> <CAOQ4uxjbJWt06bx_iE2mh=JemuM+fAAGU2WGYV7vOWQzvY4wMQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjbJWt06bx_iE2mh=JemuM+fAAGU2WGYV7vOWQzvY4wMQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Jul 2022 11:15:04 +0200
Message-ID: <CAOQ4uxjHp5iz4kP1qRbQtXSu3frVUhvxr23Gc0jzW9nY+_ep3A@mail.gmail.com>
Subject: Collaborating updates of kdevops xfstests repo
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     chandanrmail@gmail.com, Josef Bacik <josef@toxicpanda.com>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Luis,

I have been on vacation and partly still on vacation.
Quick question.

Soon I will want to update the shared xfstetsts repo - it has not been
updated since v2022.07.10
I am still waiting on the SGID tests [1] to land, which may take a few more
weeks, because I have a bunch of 5.10 backports related to SGID fixes
that I would like to validate with those tests.

My question is, at the moment, who are the active kdevops users that you
know of that will be affected by an update like that?

Updating the kdevops clone of xfstests repo is going to have an immediate
side effect of "destabilizing" all the established baselines.

I will announce it on fstests lists, but wanted to give a heads up
and collaborate the update with the active kdevops users first.

Thanks,
Amir.

[1] https://lore.kernel.org/fstests/bc3f8e56-d5fa-bee2-741f-d2950ca6e304@fujitsu.com/
