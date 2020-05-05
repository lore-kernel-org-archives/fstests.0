Return-Path: <SRS0=9PQ0=6T=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2941C47254
	for <linux-fstests@archiver.kernel.org>; Tue,  5 May 2020 11:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E16206B9
	for <linux-fstests@archiver.kernel.org>; Tue,  5 May 2020 11:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pS3yO39k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgEELXg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 May 2020 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728497AbgEELXf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 May 2020 07:23:35 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CDCC061A0F
        for <fstests@vger.kernel.org>; Tue,  5 May 2020 04:23:35 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id j8so882728iog.13
        for <fstests@vger.kernel.org>; Tue, 05 May 2020 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QzJd9Ko/KYOfpt686hGh4Yb32zqwiGHF6gZGVd6RO2I=;
        b=pS3yO39kv0j+UX5Ibj5UkY6AnRWHvbruwZRjCw5cvDcuVIq1iicAxEAOgLCK3DA8MP
         VI/2qvIU85KfWpNCJG6bbEhQVskIS+CcH4I+4dWjFGKgdeQUUaynLl7lpkIxmswvdWKA
         Jl77PRD4yv4bm4I476Z0HF1JxS7lIYj4c7PLya/pKaWw+d8a8nDn7eLn9hlJGdkAq6+W
         epiXXV7RaL23/GmYtS7N1uFu7X4xrDPFGH5PJ28/ju5yCuyh/B40yjTIA0RfiJQw5GDR
         aPk4u71z54VtP2GuVHwcyYfs6+9EatbPZawMgxbN5qxAFYqoZBm8CHiRMYciX8wE9WP1
         b9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QzJd9Ko/KYOfpt686hGh4Yb32zqwiGHF6gZGVd6RO2I=;
        b=KtQGY0qmpq/nTBZX5o7+EqX4fwqFfBIjft4/0mFzEWlLHAZmtQpJn9f4YUns2xoCd1
         aYDTeyS03Bl45Ch10fbj/HQC9qMMSDzOIDGDB+VH6FE3nnvcSVeFXh5fil/mcuf0V8Q7
         J+IwLCQZmHO4yKIg8ruJEg/MmrT/uvXcBNRMu+qJJAMT483nYl3Q8zN49cbwLtr1pGsy
         rlALpmBAePx/EiipoEFEWVJKfzXzXytfATYU4UEg+kaq+BGG1kpFgU4tUt+/qbo9AxKi
         H3N2HCCM81YHiLZzpZjWo0aY9SaUvOVk81+EUUhX1jMPSrclAP+1TLSwnSZ00QxAZQKQ
         STKg==
X-Gm-Message-State: AGi0PuYrElj0Su1PgR6Z7L/wn1nMu9QIwezlxxHq2Wj3HGcrwveIpI2x
        vV0VQyET2VFVFB1k5RdXOaSVQ22JRAtbYMPB/UxeUgdD
X-Google-Smtp-Source: APiQypKRLLKybsHOk6LaptfEsRf81Y+NcMyFI3uD7ZVjRoQKq5dNUF9XW0uHk1gL2SUeiefkW7xAu+ahFWh1L74gwSk=
X-Received: by 2002:a5e:a90a:: with SMTP id c10mr2831347iod.64.1588677812536;
 Tue, 05 May 2020 04:23:32 -0700 (PDT)
MIME-Version: 1.0
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 May 2020 14:23:21 +0300
Message-ID: <CAOQ4uxgzp-OeVeBfUD+QtXUZS068GfP11xeWqPYg_x02hWxbbg@mail.gmail.com>
Subject: udisks2 causing umount failures
To:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For whom it may concern,

I had recently updated packages on a Centos 7 test machine.
Among many packages updated was:

libudisks2-2.7.3-9.el7.x86_64 =>  2.8.4-1.el7.x86_64

Related or not, after this upgrade xfstest started failing on failures
to unmount.
This was especially tests that mounted loop or dm targets, such as xfs/078
and xfs/311.

And no, UDEV_SETTLE_PROG did not help, neither did an extra 1s delay.

In the end, I bisected this down to disabling udisks2 service.

Just posting in case somebody else gets hit by this.

Thanks,
Amir.
