Return-Path: <SRS0=Klg3=23=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4FFC32771
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 11:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6B52072E
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jan 2020 11:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMHm8ET4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgAFLY5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jan 2020 06:24:57 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42625 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgAFLY5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Jan 2020 06:24:57 -0500
Received: by mail-il1-f194.google.com with SMTP id t2so26924318ilq.9
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2020 03:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2aXNxxDuNVZ9iZqrcTDf2fxNYQuyv1y/AL0LjSdqZzs=;
        b=BMHm8ET4prWTwS+nNDWb70KwzSyjIMGrcPXELVGchIV6CQXChewIx2MH4HyHRcpbjo
         YDxMHUIwZdTUioYGeZBKp0fuMVRD3IM4iPE0CfPnzjMEbHmXM0zQ89tL0qLfg9AwXlIH
         kaxZCl0xCihdyhF9cM8G0i+5uQrijqPBhn66LXO4pOGFbWvL2nLCYwmid8258nlszi6X
         iIZePek1WCW+gwILbbcLkghzac/COJSPs4l3IUtKdIvCPVAFu62XyFZPPMCPBSpnbldL
         oG2BS9FIfRnAAh1gZYAYcl3CgSj4nlfS37AbZgMIGVyalcL5hmTR/XKHOuyP2HWsFXxX
         hYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2aXNxxDuNVZ9iZqrcTDf2fxNYQuyv1y/AL0LjSdqZzs=;
        b=t7LQQdyVQHFLCy3l/7FCGJtK+pAZV57wR2klmQsFPdl9tJhQ1KFNFa2S/HRtvpY3zl
         uvkiDrb1zBQHpOd3Gnwxl4Toaf0umVdm+bfnxoA3PVckMXo+rml2dW/Lz2Oy1KeStGB1
         WINDwBCT5Y4gN6GDxXvCZUvhMOo5Nfiq2usdZ3ykEMjvyf01y3j+SMBC9ULQuWFyWX4D
         LuuVoVqoFeqdqKGfeMJCiSJLnM2Vu6EEz4f8PsVnvnBi33cmdMKwgEccUkfcEZCZ8od4
         3ta54a7a7xnExiSDZxjWTlsgLx9KakbjU/tZ7dmmVuuuUe4vuuubM2PXimNJWBe58kpL
         D0dg==
X-Gm-Message-State: APjAAAVAukMtDL+DSVn0xpcn3Foata+vFssd1tXkdpLzW2B9xktgFUgq
        fFF/CFyu10tum7QPAuK7yCWGzsbQXhraJ5Yaqab2wUy+
X-Google-Smtp-Source: APXvYqwrrNxt/9/FuOAcYUaZdUiFHNpX4FfCb+pmEESRIDe866Pv8l/oMFeDoW4QKqMKnsZQd4rYddcJtkLsR1GSleI=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr85135669ilq.250.1578309896343;
 Mon, 06 Jan 2020 03:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20200106070654.13249-1-yangx.jy@cn.fujitsu.com> <20200106070654.13249-2-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20200106070654.13249-2-yangx.jy@cn.fujitsu.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Jan 2020 13:24:45 +0200
Message-ID: <CAOQ4uxh91oRB03UGuqhSgASeY7-OtQD3wMRdOQ-SL0UBgdMPHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fsx: Add '-a' option to skip unsupported keep size automatically
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     eguan@linux.alibaba.com, fstests <fstests@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 6, 2020 at 9:12 AM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> 1) Use '-a' option to skip unsupported keep size automatically even if
>    it's defined by --replay-ops.
> 2) Add $FSX_AVOID to tests which defines keep size by --replay-ops.
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  ltp/fsx.c         | 9 +++++++--
>  tests/generic/456 | 2 +-
>  tests/generic/469 | 2 +-
>  tests/generic/499 | 2 +-
>  tests/generic/511 | 2 +-
>  5 files changed, 11 insertions(+), 6 deletions(-)
>

A very strong NACK!

Why are you making this change?
Did you read the description of the tests and try to understand the sequence
prescribed in the replay-ops file?

Those are reproducers to specific issues that require a very specific sequence
of operations and it seems to me that 'keep_size' is there for a reason in every
one of those tests.

For example, take the test generic/456, which I wrote, it has this link in the
comment above fsxops to a very elaborate email from Ted explaining the
problem: https://marc.info/?l=linux-ext4&m=151137380830381&w=2

You cannot just remove 'keep_size' from the test because then the test
doesn't do what it is intended to do.

Did you read my reply to Eryu's patch which he referred you to?
https://spinics.net/lists/fstests/msg08007.html

Instead of allowing test generic/456 to run on fs which doesn't support
FL_KEEP_SIZE, you should change the test to *require* support for
FL_KEEP_SIZE as well as require support for punch/zero/collapse:

_require_xfs_io_command "falloc" "-k"
_require_xfs_io_command "fpunch"
_require_xfs_io_command "fzero"
_require_xfs_io_command "fcollapse"

Same for the other tests that you changed to ignore keep_size.

Thanks,
Amir.
