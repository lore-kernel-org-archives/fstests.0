Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10706EB64DC
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Jul 2023 15:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGCPTn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Jul 2023 11:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGCPTn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Jul 2023 11:19:43 -0400
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 08:19:40 PDT
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7194FFD
        for <fstests@vger.kernel.org>; Mon,  3 Jul 2023 08:19:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id 38CAD5EA9D;
        Mon,  3 Jul 2023 18:12:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id lCTfOl2DbuQ0-4dwVidaB;
        Mon, 03 Jul 2023 18:12:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688397168;
        bh=EaiwTQAKBuPjNWvb60VVxvh+CP3J5ooRmI0JBSD+Q88=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=dAFon8Y8upyildNRYUbJSUOkmCx2QWIG0xJBi+6q41sBrT3n34fbjuihXaUWvyi5n
         hgsY0iSB2J5dUbMgXd2Q+fNO07rWIma4LEU58C/cmSQUX3v6Gx3zyqmJd9iegFh4UP
         h+6LV2jP6grTX51dVt8hpd06QC42CZNkFj9/P6EM=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <d2358bee-34f3-373f-6635-bc3a91f772b6@yandex.ru>
Date:   Mon, 3 Jul 2023 20:12:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: generic/478: why eval is so fast?
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
References: <817817a1-2f2d-1ee1-0898-f86801586d65@yandex.ru>
 <20230703150513.tgxij5svjxucpib5@zlang-mailbox>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <20230703150513.tgxij5svjxucpib5@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


03.07.2023 20:05, Zorro Lang пишет:
> I didn't find out why it run faster, but I'm sure we can't merge a
> patch which only say "it's faster, but don't know why". Especially
> that "faster" is really unnormal.
>
> One thing I'm confused is about that background process, if you add eval to
> that line, can you sure the later "$!" (in "wait $!") is the t_ofd_locks
> process number?
>
> The second eval with "| tee -a  $seqres.full" confused me too, I'm not
> so familar with eval, can't what kind of problem it brings in, but I
> doubt something wrong at there.
>
> Anyway, I can't merge a patch like this. But I don't mind if anyone
> can answer this question :)
Hi, no, this wasn't a merge request, just
a question. But the problem is that I need
to merge another (not yet posted) patch
that needs 1 of these evals to properly
parse spaces in an arguments.
The eval I need, is only in a line with "| tee"
stuff, not the one for the process that would
be later wait'ed for.
Still, seeing such a huge speed-up, I was
afraid to post the patch itself, and decided
to ask first.

Anyway, the patch in question waits for
an approval of the semaphore fixing patch.
It adds a new test, but the synchronization
needs to work properly first.
