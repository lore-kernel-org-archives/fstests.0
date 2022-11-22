Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC6C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Nov 2022 14:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiKVOZP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiKVOZO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Nov 2022 09:25:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F72DF7B
        for <fstests@vger.kernel.org>; Tue, 22 Nov 2022 06:25:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EFDA61728
        for <fstests@vger.kernel.org>; Tue, 22 Nov 2022 14:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF20C433C1
        for <fstests@vger.kernel.org>; Tue, 22 Nov 2022 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669127111;
        bh=YDMZtDgGdEr2fkV7ZbBmvHdIRj2vTDfSaKnxHXdFtL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GGmj8+hyI8IZajUc4RXj7mbHxXWdcx6AhXyR/hGmBQ33F5YdZS4k4932PI8KFOLcO
         /UlC1l4Zk56JwgFPgLMFB79RNmIgetCRc1XqcZRE2LFs39FgU/o6eDGMqq8sW2HVV8
         Rd/YLHAUvURsQ/Xs8QCUiYnXgRb3ohrZjXB7083aspkfcyehjuMSdXWxshdGFhV15y
         RI4XbM7/twfILajmylxFyJvPdZrJXt+fP4Kcg/FQA9TbCTzMRdCHJbKTBTiq/UfxZj
         s28oAFhVg/jJiSYpx3krRmFwNaGAa9FlmCoVA0z6r/jEq0brovs1wp9fb2u8s4HqmT
         b1toSQSWKRKlA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-14286d5ebc3so14096748fac.3
        for <fstests@vger.kernel.org>; Tue, 22 Nov 2022 06:25:11 -0800 (PST)
X-Gm-Message-State: ANoB5pnLhe1ZyZ6n4zJIjAlhjZ9blQ5Mmzo3rcTKtGdrt828SXv/d0n9
        tdSfMKiJdpohVgSUPMc3axItW82TZSIpjaBT374=
X-Google-Smtp-Source: AA0mqf4+hc+zQMw5RD76RpZuuDhS2h7RaFcr0Z5yxud1sAkJpL2GcXGJj5mLSbsILjM6DYXYfzEAnzzDrrkrvGmbpzY=
X-Received: by 2002:a05:6870:cc89:b0:12b:fbe7:b793 with SMTP id
 ot9-20020a056870cc8900b0012bfbe7b793mr15476848oab.92.1669127110891; Tue, 22
 Nov 2022 06:25:10 -0800 (PST)
MIME-Version: 1.0
References: <20221122141219.20325-1-jack@suse.cz>
In-Reply-To: <20221122141219.20325-1-jack@suse.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 22 Nov 2022 14:24:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7sM0j+iKAuM0mP1tWinaB7C9QkNdJsL-eZ+weycpoRhQ@mail.gmail.com>
Message-ID: <CAL3q7H7sM0j+iKAuM0mP1tWinaB7C9QkNdJsL-eZ+weycpoRhQ@mail.gmail.com>
Subject: Re: [PATCH] generic/614: Run test only for filesystems supporting delalloc
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Nov 22, 2022 at 2:12 PM Jan Kara <jack@suse.cz> wrote:
>
> Simple filesystems such as ext2 or udf do not support delayed
> allocation. Thus they allocate data blocks for mmap writes only during
> writeback. This makes test generic/614 fail because it checks exactly
> whether the blocks for the write are reserved before writeback happens.
> Make the test depend on delayed allocation support.
>
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good. I wasn't aware that a _require_scratch_delalloc helper
existed already.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  tests/generic/614 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/generic/614 b/tests/generic/614
> index 06630f2249c7..3e2a587c8f90 100755
> --- a/tests/generic/614
> +++ b/tests/generic/614
> @@ -16,6 +16,7 @@ _begin_fstest auto quick rw
>  # real QA test starts here
>  _supported_fs generic
>  _require_scratch
> +_require_scratch_delalloc
>
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> --
> 2.35.3
>
