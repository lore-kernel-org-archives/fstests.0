Return-Path: <SRS0=bQMt=4U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD28C3F2CD
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Mar 2020 02:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F422465E
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Mar 2020 02:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="RjtZkgtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCCCD1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:03:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46666 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgCCCD1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Mar 2020 21:03:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id o24so619511pfp.13
        for <fstests@vger.kernel.org>; Mon, 02 Mar 2020 18:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c5XhxkRtr+jOr2z5VSpThoKySzSfBrlt3gTTK5z0Dkc=;
        b=RjtZkgtYXe14tTrQA8Jh8i/4HQQ+3DupkN2vzKaEsBtXQXMMCsXdeQygIZ8dg69Pra
         +i8/7P7/qkthqNccHvBt4TKqq3s1GK6yJQeCOIhOviCNOOj+7GJesRQYO1GnF2PNJyJq
         3rNc+U6rMuUDko3/1TFnLNWg3MjuI6zdl+WduxaMcR7ULJAeqkiGnO6nohKNew0aLobw
         HkWv+/7vWGdiZU1C2osFZTCKnTkIrtjqaLJ/jFDd7i/7vIpspjGl4v+5b3IO5HhaoOxg
         2BY1UIyOxZbuU2BrC9Mu+wHL//wKDjcVRd8QhZ5Z+Ewc66iKFXugLHOpZoPw0E3Q7/Rc
         UHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c5XhxkRtr+jOr2z5VSpThoKySzSfBrlt3gTTK5z0Dkc=;
        b=bBIuU1aVjYjPgFKSG643w6PI7v/E9nees9jNIxav0gX7IDV7W8NHW9h8o7fSvbo2U5
         s/Mx2SyXQKDE/gBvJx9AGwlY230T5MvpA/HZRMO+U+Uq+yJ3pVO3lMCOhMtur5Bf88tX
         cccYR1m1V6abxzvtvn/vCoPzRC/sW/G4okCL8lBq4r/9nnCZyzbMnGrSel5OQT2d4hto
         3gjXEBMQikMAO3EW67CyoleXyNgc/DC/ehajCgTx6ttMlwMS+AaNhLzKl6LlbbI+pjwX
         Fr50k7xHod0RPTuue9i0T5F12pm6FoIHKYTtrChzTizR6xEhpg45UQ5WFqPjkfii1EZB
         q7ug==
X-Gm-Message-State: ANhLgQ1xhuLZqyzWwEtOkYudxIoj0gkHgGaubyuTIvKZXlCNltLodw01
        O8p81dP8AsWMCQGkvy/sKboWhasc9z0=
X-Google-Smtp-Source: ADFU+vs+XLjL85KnRCBXpaKj6M5jDdRxtcjiVRxaoxR1duJwGkV8j2vvQqgJrMaBjE2W5iloTOHzJw==
X-Received: by 2002:a63:a351:: with SMTP id v17mr1756240pgn.319.1583201004738;
        Mon, 02 Mar 2020 18:03:24 -0800 (PST)
Received: from vader ([172.58.44.228])
        by smtp.gmail.com with ESMTPSA id q6sm22126774pfh.127.2020.03.02.18.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 18:03:24 -0800 (PST)
Date:   Mon, 2 Mar 2020 18:03:21 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: Re: [PATCH fstests] btrfs: add test for large direct I/O reads w/
 RAID
Message-ID: <20200303020321.GA215148@vader>
References: <f9a293a382e81ba55e2a321634cb1548d7f69627.1583186857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9a293a382e81ba55e2a321634cb1548d7f69627.1583186857.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 02, 2020 at 02:08:45PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Apparently we don't have any tests which exercise the code path in Btrfs
> that has to split up direct I/Os for RAID stripes. Add one to catch the
> bug fixed by "btrfs: fix RAID direct I/O reads with alternate csums".
> ---
> I also had to fix up the tests/btrfs/group file, which had a renumbering
> issue that was preventing me from adding a new test.
> 
>  tests/btrfs/207     | 58 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/207.out |  2 ++
>  tests/btrfs/group   |  3 ++-
>  3 files changed, 62 insertions(+), 1 deletion(-)
>  create mode 100755 tests/btrfs/207
>  create mode 100644 tests/btrfs/207.out
> 
> diff --git a/tests/btrfs/207 b/tests/btrfs/207
> new file mode 100755
> index 00000000..99e57cb8
> --- /dev/null
> +++ b/tests/btrfs/207
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 207
> +#
> +# Test large DIO reads with various profiles. Regression test for patch "btrfs:
> +# fix RAID direct I/O reads with alternate csums".

Hmm, I might as well make this test also exercise direct I/O writes, not
just reads. I'll send a v2.
