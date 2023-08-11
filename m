Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD75C001B0
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Aug 2023 11:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHKLxx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Aug 2023 07:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjHKLxx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Aug 2023 07:53:53 -0400
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE810F
        for <fstests@vger.kernel.org>; Fri, 11 Aug 2023 04:53:50 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id E5DCA5EA19;
        Fri, 11 Aug 2023 14:53:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jrZ7hwNDZa60-ZJwafauc;
        Fri, 11 Aug 2023 14:53:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1691754826;
        bh=VXm7bdtPDA3KYE8ly0T4GNj+uzB13VBsa+3pGhd4Esw=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=k+eHXlGQtZe9Vi0NU7+jk4LBx1tuIxbGuJNFQdiEyy5j0hStHiUZkBcPhxVJZK4xH
         XAn/kH4XgMjQFwLjlqprzzft5UssJoVz6bqEp3APdt2HbDarQxa627SPiyEsqHTlG3
         mnfxyPbKhGVlk4xoJNM8RoWnWFvyus1+XNzsTCAE=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d11ea13c-3817-4d59-bdb9-0dc93cea2645@yandex.ru>
Date:   Fri, 11 Aug 2023 16:53:44 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] t_ofd_locks: fix stalled semaphore handling
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org
Cc:     Murphy Zhou <xzhou@redhat.com>, Zorro Lang <zlang@redhat.com>
References: <20230801175220.1558342-1-stsp2@yandex.ru>
 <20230801175220.1558342-2-stsp2@yandex.ru>
 <39b107687d005752cdf41bc4be33d9bb5e7908cc.camel@kernel.org>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <39b107687d005752cdf41bc4be33d9bb5e7908cc.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


11.08.2023 16:39, Jeff Layton пишет:
> Given that you're now creating the semaphore before launching the test
> program, do you need to clean it up if the shell script dies
> abnormally?

I'd rather say "no" or at least I wasn't
planning that. Unlike the current impl
in C code, ipcmk creates the sem with
random ID, so the clash is no longer a
threat. As such we don't care about any
previous invocations, were they
successful or faulty. Which is yet another
advantage of this approach. rm_sem()
is here just for "politeness", whereas
in prev approach you have to deal with
the results of the past invocations.



> Seems like a reasonable change overall, and I like not having to
> micromanage the semaphore inside the C program. The cleanup thing can be
> fixed after the fact if it's even necessary.
>
> Reviwed-by: Jeff Layton <jlayton@kernel.org>
Thank you!
