Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F1EC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 04:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiFUECP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 00:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiFUECP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 00:02:15 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6753721804
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 21:02:14 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id g6so12581410vsb.2
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 21:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jI9/UDW7Gl0ZVA8cHE7AdkuuJUZKFdhtz32eOoRi8vY=;
        b=kqD3CtgRB+0NtfaST6HhFBk7p4mBpxmVJZQKiTMA+76PgwvLZtSG+qdG0R5zE2CC45
         v6fjrllBAu59H8Tq/Hb0u0b6ejh6bB1mAH9Nl7bsmr2gs96XuYGNW3aeyqsqwvmpl9dK
         1mUl2BRTlCIBu+T6z6qyG6EX1SI0/y9aCHIy4ca3t44AWSgyobYTX8bsbYa4tJKx7oTR
         UmOID0wrjXBjLS2OXF0to3pEkdmpaM7UGertvuLE8/giMkQB1CxxmkZ/B6muTU2hsXEW
         7NYrspffMm/P6fnOw+3k7goWAfw/rqO05pnhIUIWBWGLtdw6U++SbE5UoqbDamahSw4y
         BpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jI9/UDW7Gl0ZVA8cHE7AdkuuJUZKFdhtz32eOoRi8vY=;
        b=lwhWsrx6sXjF2KStaTdxl3KA1VLehr0/GHx76+0c6x8b8yrR7hz4ERiB8nSlcEVwXv
         L1uELK3H8+TH80QlmKgUItDps1SvzKnIfJAD5H0z6WU6TcPEYFsXYx/s+NumZzDOliLd
         MO3aEYRdFDx26D71xXX1r4ESk3NR6smzFSpUNkH/0FPi02uVcNrLs/vMcE74baYfiw10
         yNW39WBp9mAnS5j77UzBz4xAwLux8IZHpXppD6KY7CXUAlLlxX7SN3HcwYfHO937T58j
         N9S7f3zHHrkqj9DN6J2l4OTf7L+9lk49I466In5vDHclQnFmp7hh6pAQI+FyOkHus/gE
         v+KA==
X-Gm-Message-State: AJIora98F5AMHMAOLP2aFT9Tuzhq8JgXY6TjgQ0jLR6O9EWvrBvahCpm
        VnrByE//rr94Mby5bwMbu4rys1UbMinxdu9VVXE=
X-Google-Smtp-Source: AGRyM1vasNPePzycfp5MRSGNVRAgS8Dd8Uix2ohNJ8tPj5/EnjkCK2g8uL3UQtNmv9B58U4BjREjQQWJu/ndY6Cf9KE=
X-Received: by 2002:a05:6102:1489:b0:354:24ba:1478 with SMTP id
 d9-20020a056102148900b0035424ba1478mr4410031vsv.72.1655784133550; Mon, 20 Jun
 2022 21:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220619134657.1846292-1-amir73il@gmail.com> <20220619134657.1846292-4-amir73il@gmail.com>
In-Reply-To: <20220619134657.1846292-4-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jun 2022 07:02:02 +0300
Message-ID: <CAOQ4uxj350-k2bzCSD_j35XCH5E-VcdtfHmW3d_ZrSzHxWA5CQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] xfs/{422,517}: add missing killall to _cleanup()
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jun 19, 2022 at 4:47 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Those tests failed to cleanup background jobs after test
> is interrupted.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  tests/xfs/422 | 8 ++++++++
>  tests/xfs/517 | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/tests/xfs/422 b/tests/xfs/422
> index a83a66df..8e9a3576 100755
> --- a/tests/xfs/422
> +++ b/tests/xfs/422
> @@ -13,6 +13,14 @@ _begin_fstest dangerous_scrub dangerous_online_repair freeze
>
>  _register_cleanup "_cleanup" BUS
>
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1
> +       cd /
> +       rm -rf $tmp.*
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/fuzzy
> diff --git a/tests/xfs/517 b/tests/xfs/517
> index 961668e3..18404248 100755
> --- a/tests/xfs/517
> +++ b/tests/xfs/517
> @@ -14,6 +14,7 @@ _register_cleanup "_cleanup" BUS
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +       $KILLALL_PROG -9 $XFS_IO_PROG $FSSTRESS_PROG > /dev/null 2>&1

Besides the missing wait, this cleanup is still racy, because stress_loop
can spawn a new fstress process after killall /proc iteration.

Worst, freeze_loop can freeze after killall /proc iteration.

The correct solution (I think) is to record the pid of the XXX_loop
sub-shells and kill those, which should also solve the "Terminated"
false positive error.

Will give that a shot.

Thanks,
Amir.
