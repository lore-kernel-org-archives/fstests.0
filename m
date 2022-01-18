Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36576C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 14:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245195AbiAROWk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 09:22:40 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:58008 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbiAROWk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 09:22:40 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JdWFT72QGz1qxHK;
        Tue, 18 Jan 2022 15:22:37 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JdWFT6Tcwz1qqkS;
        Tue, 18 Jan 2022 15:22:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 5g4sa8pAl8MH; Tue, 18 Jan 2022 15:22:36 +0100 (CET)
X-Auth-Info: eKvDi3plGuGWAySbYi4CJDEsKbzV0BJ5fe/pXJ+mQTaYpIXJ7HbPnPbPlhmkqp9B
Received: from igel.home (ppp-46-244-174-214.dynamic.mnet-online.de [46.244.174.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 18 Jan 2022 15:22:36 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 826932C39F0; Tue, 18 Jan 2022 15:22:35 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     xuyang2018.jy@fujitsu.com
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull call
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
        <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
        <YeY6Uh8I7RlsCicw@mit.edu> <61E64FED.2010906@fujitsu.com>
X-Yow:  An air of FRENCH FRIES permeates my nostrils!!
Date:   Tue, 18 Jan 2022 15:22:35 +0100
In-Reply-To: <61E64FED.2010906@fujitsu.com> (xuyang2018.'s message of "Tue, 18
        Jan 2022 05:27:10 +0000")
Message-ID: <87fspl6s44.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Jan 18 2022, xuyang2018.jy@fujitsu.com wrote:

> Now, I use glibc-2.34 and run the following program[1] but the errno is 
> not 0 in the beginning. So is this a known bug on glibc-2.34(Theodore 
> doesn't meet this problem on glicb-2.31)?
>
> [1]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/ext4_resize.c

Note that there is a call to open preceding the strtoull call, so no
guarantees can be made about the value of errno before the latter.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
