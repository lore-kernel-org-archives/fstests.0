Return-Path: <SRS0=0kg8=ZD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746EC17447
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 22:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3862184C
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 22:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSBUSLdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKKWck (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:32:40 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40378 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKWcj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Nov 2019 17:32:39 -0500
Received: by mail-io1-f67.google.com with SMTP id p6so16395071iod.7;
        Mon, 11 Nov 2019 14:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzLR9tv4i3WF8MkXry3d9TxP8TpxcQKmqeN/RPf6iq4=;
        b=eSBUSLdHo8P3Ygobhlt4Xmco16afJOm2jYijrD6uLEs9DYuAycWqmGN6tYvtxq4ddv
         hqtPKFuYFWKsWmwHo6jnSIIZbNBBrX5TOyMyGOIQtBfrWhAVGBIzkVIblXw6hqT6+iSc
         xU/pl+Pz2E+LtoS5oHZCj0zXLUR9XgU1sJdet4MAQ/nzDUmzi0xgetdrZi49zw+EVpzN
         DpPmpxBz7nrJmhb/nkwqiRkGVJDjSxM6FWEKgk9s+RSevlGt8+EWu3T1Kd1E1JEQ5fsu
         gilhw86mW9I5k0sAz38PzAVCnKq1Pu4gGBC9s+bYIE+cMGJzskY06k/BKu2yZJg+ojVA
         UMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzLR9tv4i3WF8MkXry3d9TxP8TpxcQKmqeN/RPf6iq4=;
        b=J/je1b68VskbCwg9mn3cTszaW7XX4CstEcrw2U9F7nfEH26ojR2aqsb/d33E3svBNl
         KiL3MvJvVMcItFe4Q2oVTWsJmI4PDhap00i79yd3Pn2zczZL3iKkWxnpBMW9RztWWOFQ
         DWpSq7kR8UWFrZMrQBJPcYfeLwwn5VXj95wdlCWavzAF3Xg885iqwfWJRe1nYAZUWOpP
         M/smtcIB7BssdIVZGNV0eJ3wfn2QFsm9naPJRcGi7YMF/ZfZAWA9G0VFg7wGb6Nsk1Ts
         9OaiZncVhmbAsl/amYfaXsUR5h4b2fQn9ab99UY/ZpL/zkVJXVbxnjL7Pl1puDnlpJ3X
         HDQA==
X-Gm-Message-State: APjAAAXI7HnNCasgxvrHmnajKRYzyt6sFczJ/jf8fhUIqLpX4bZQe2Xi
        MOQTg7J4h2DGISSm2OU33vy4lmMBDibg0xUXItVjzg==
X-Google-Smtp-Source: APXvYqxO0suayAMv4ao/CR8q25jhS3dgwMJF4+BoRk/uKEZGgK1tzMeQ/sOKJHdi5tYOyPSPIiJA9pcD6CWN2ZG9kr0=
X-Received: by 2002:a02:a402:: with SMTP id c2mr13791407jal.5.1573511558430;
 Mon, 11 Nov 2019 14:32:38 -0800 (PST)
MIME-Version: 1.0
References: <20191111074010.3738-1-amir73il@gmail.com>
In-Reply-To: <20191111074010.3738-1-amir73il@gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 11 Nov 2019 14:32:26 -0800
Message-ID: <CABeXuvo8SADSgtQYbJHE-afU5EYzCFZp17BoVLpeiYvqJ6RiCw@mail.gmail.com>
Subject: Re: [PATCH] overlay: support timestamp range check
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Nov 10, 2019 at 11:40 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Overlayfs timestamp range is the same as base fs timestamp range
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Eryu,
>
> This change will cause the test to start running and failing on upstream
> kernel with overlayfs over some fs (e.g. xfs/ext4).
>
> The kernel fix is posted:
> https://lore.kernel.org/linux-fsdevel/20191111073000.2957-1-amir73il@gmail.com/T/#u

The patch seems ok to me.
Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
