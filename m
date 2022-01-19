Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C692C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Jan 2022 08:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349382AbiASIYE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Jan 2022 03:24:04 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:56884 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349923AbiASIYE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jan 2022 03:24:04 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JdzFF3YPyz1sF5C;
        Wed, 19 Jan 2022 09:24:01 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JdzFF2MGJz1qqkD;
        Wed, 19 Jan 2022 09:24:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id PcLP-pvQgxJv; Wed, 19 Jan 2022 09:24:00 +0100 (CET)
X-Auth-Info: VsrE9BWSiI+5lITepI872j6mp4mTr9XqXyeTS4EWrl0oejnqR3n4vvNwlkQdHfaS
Received: from igel.home (ppp-46-244-165-91.dynamic.mnet-online.de [46.244.165.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 19 Jan 2022 09:24:00 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 068582C029B; Wed, 19 Jan 2022 09:23:59 +0100 (CET)
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
        <87fspl6s44.fsf@igel.home> <61E772A4.3030608@fujitsu.com>
X-Yow:  I just bought FLATBUSH from MICKEY MANTLE!
Date:   Wed, 19 Jan 2022 09:23:59 +0100
In-Reply-To: <61E772A4.3030608@fujitsu.com> (xuyang2018.'s message of "Wed, 19
        Jan 2022 02:07:30 +0000")
Message-ID: <87a6fs876o.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Jan 19 2022, xuyang2018.jy@fujitsu.com wrote:

> I just tried, the errno is 1 before open syscall.

Worksforme.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
