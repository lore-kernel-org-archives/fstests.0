Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28264C001B0
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Aug 2023 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjHKOsA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHKOsA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Aug 2023 10:48:00 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4B2702
        for <fstests@vger.kernel.org>; Fri, 11 Aug 2023 07:47:59 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76d072daea2so156206885a.1
        for <fstests@vger.kernel.org>; Fri, 11 Aug 2023 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691765279; x=1692370079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ9BvxHm6bXPkxel2nnteSQQICojHj+VlgU1XNz3+Q8=;
        b=FGEoggp5UeSvGn7xd4cOLSg9aFg4mJYHxA1oTyXz7tJszfemjN/6djULBtzqsoDtTu
         2EaOU6MflTycWkXinUWrhIs2VrpMAcUAenK+guhbtYkCp0jZsVCrqiudq8dILTzyOoAN
         xC1yELgrmAWFz052ei5+entKNK2PmbLWrfCkrlhCNwyx+Xw4G8X9NFwrV+VZXQFiNxRX
         SWUcctapBCevGZzBmLRfs8aht7iUjUp3jf3NQtNR1z8ZUDjasgZyZsSOS5ldTXY/xHO7
         7HwboOCyaOuQL/gbFm1xpOaiAtA4is3yIvYSn+CoC1PL/TOxUJoxTe/PhehzWi45yzrc
         rdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691765279; x=1692370079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ9BvxHm6bXPkxel2nnteSQQICojHj+VlgU1XNz3+Q8=;
        b=XGSRO0LWhTvKoy0rSazS57q9gpGb0HRmfLoJIEhN1mYpUbiKIbUwoU//CTS6fuI6E+
         q7oIxRqRTPBKKs1SQtGA2F1aaRm+nSQ9K+nJnnvQMBjLE87GU4FpSWTuh+s38VS3Bwcg
         DayrGnq6TkLfqlvMlL5EgXSI8DFGtBlA0ybTcF16HN7djfaJMhHLis5AIId38XVniLtf
         sBIKeLqGoqC6f2YRZjncWxUYA4VXOGsNK0Z4prPDBHSoIiIOEDCPrJe6Cz1p8A8l/swo
         ARS/wLzYKz3GEz/N5HUZQ15qRSWpMpEW/aof9oo0h/zIPeqvYqLpDdkaoyGwaf7cy0j0
         CcHQ==
X-Gm-Message-State: AOJu0Ywj32k6WgqVH8Knh7VkMlcqpD7JfGf3eiS5CkByzmokApK960x8
        HRnLcyHOKDDK2p1LtmYRjZyv6pSbdh8IIasTq3KFMg==
X-Google-Smtp-Source: AGHT+IFvgKzT3E0OCN2Zct3tBcZ2wLkr4F9wLTxafrxvjUCdBtIXiKenJAhIOtbnkDxjY1ooFp9j+Q==
X-Received: by 2002:a05:620a:2991:b0:765:a651:a11d with SMTP id r17-20020a05620a299100b00765a651a11dmr2781228qkp.36.1691765278706;
        Fri, 11 Aug 2023 07:47:58 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a005a00b0076d1e149701sm1226717qkt.115.2023.08.11.07.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:47:58 -0700 (PDT)
Date:   Fri, 11 Aug 2023 10:47:57 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Lee Trager <lee@trager.us>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: Vertify dir permissions when creating a stub
 subvolume
Message-ID: <20230811144757.GC2724906@perftesting>
References: <20230811011519.1811259-1-lee@trager.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811011519.1811259-1-lee@trager.us>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 10, 2023 at 06:15:19PM -0700, Lee Trager wrote:
> btrfs supports creating nesting subvolumes however snapshots are not
> recurive. When a snapshot is taken of a volume which contains a subvolume
> the subvolume is replaced with a stub subvolume which has the same name and
> uses inode number 2. This test validates that the stub volume copies
> permissions of the original volume.
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
>  tests/btrfs/300     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/300.out | 18 ++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100755 tests/btrfs/300
>  create mode 100644 tests/btrfs/300.out
> 
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> new file mode 100755
> index 00000000..3a34f8c0
> --- /dev/null
> +++ b/tests/btrfs/300
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 300
> +#
> +# Validate that snapshots taken while in a remapped namespace preserve
> +# the permissions of the user.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol snapshot
> +
> +_supported_fs btrfs
> +
> +_require_test
> +_require_user
> +_require_group
> +_require_unix_perm_checking
> +_register_cleanup "cleanup"
> +
> +test_dir="${TEST_DIR}/$(basename $0)"
> +cleanup() {
> +    [ -d "$test_dir" ] && rm -rf $test_dir
> +}
> +
> +mkdir $test_dir
> +chown fsgqa:fsgqa $test_dir
> +
> +_user_do "
> +cd ${test_dir};
> +unshare --user --keep-caps --map-auto --map-root-user;

I'm not sure how well supported these operations are, generally we want to make
sure that the commands exist and the options work.  Can you extract out the
require_unshare() helper from tests/overlay/020 into a actual helper in
common/rc, and then add

_require_unshare --user --keep-caps --map-auto --map-root-user

to your test, that way we don't get false failures if the environment doesn't
support these capabilities.

> +$BTRFS_UTIL_PROG subvolume create subvol;
> +touch subvol/{1,2,3};
> +$BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
> +touch subvol/subsubvol/{4,5,6};
> +$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
> +"

I assme you have to do this all in one fell swoop because of the unshare part?
Normally I'd prefer if we did one line per command, ie

_user_do "cd"
_user_do "unshare"
_user_do "subvol create"

but if that doesn't work it would be good to have a comment explaining that it
has to be done in one fell swoop.  If it does work then I'd prefer the above
pattern.  Thanks,

Josef
