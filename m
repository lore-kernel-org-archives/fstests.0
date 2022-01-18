Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3373C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 12:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbiARMND (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:13:03 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:44719 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbiARMND (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 07:13:03 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 07:13:03 EST
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JdSBJ5H5mz1sCwg;
        Tue, 18 Jan 2022 13:04:40 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JdSBJ4782z1qqkC;
        Tue, 18 Jan 2022 13:04:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id f8Lsj4g_z5YX; Tue, 18 Jan 2022 13:04:39 +0100 (CET)
X-Auth-Info: P88uBDI11YgGikyMe/UM8uESEKmBYR1719Mf6Y7DiodsIdE4cQKWYTDG07mu49+J
Received: from igel.home (ppp-46-244-174-214.dynamic.mnet-online.de [46.244.174.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 18 Jan 2022 13:04:39 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 3AE192C39EC; Tue, 18 Jan 2022 13:04:37 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull call
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
        <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
        <YeY6Uh8I7RlsCicw@mit.edu> <61E64FED.2010906@fujitsu.com>
        <eef02950-b7c2-8ab8-1e19-165383fa99b9@linaro.org>
        <87wnixjndg.fsf@oldenburg.str.redhat.com>
        <496a3521-5a0c-b3ae-29bb-02fd0056525b@linaro.org>
X-Yow:  I have many CHARTS and DIAGRAMS..
Date:   Tue, 18 Jan 2022 13:04:37 +0100
In-Reply-To: <496a3521-5a0c-b3ae-29bb-02fd0056525b@linaro.org> (Adhemerval
        Zanella's message of "Tue, 18 Jan 2022 08:49:40 -0300")
Message-ID: <875yqh8d2i.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Jan 18 2022, Adhemerval Zanella wrote:

> I think this is a implementation detail, I am not aware that either C or
> POSIX now states it should initialized to any specific value (in fact, 
> POSIX at Issue 5 [1] has removed the 'The value of errno is 0 at program 
> start-up' on its description).

It's still part of the C standard, though.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
