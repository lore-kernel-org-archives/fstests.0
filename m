Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88320C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Oct 2021 10:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664BD61090
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Oct 2021 10:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhJYKhy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhJYKhw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Oct 2021 06:37:52 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061DC061745
        for <fstests@vger.kernel.org>; Mon, 25 Oct 2021 03:35:30 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bj31so11357519qkb.2
        for <fstests@vger.kernel.org>; Mon, 25 Oct 2021 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+4rCop3n3GBW7j7hetL/Hu4npvlr9cPmXrrgFTZYpTY=;
        b=CMJQLGT/GkAWifLuOdbVKGZ0QYMBA3/Sf6izKKmcIHajaI+RE6p3XklOLgK/XifvbR
         m8pjmZoZYjRUb6EAqwIgu9teJ6MxlGV3cUEwi9xxNZmLRhFhBhRsZzh0trm0rhCqgw2M
         1kVqd/bUZZwLQFLPvaIcIaOqufmHWRCDcIDzREX22VdaLKysvWeJLtRs/wjIwj8sZQNB
         xccgeBH8SnGQLKStU/tRRjxi7Xot+l+LFizYM005KygkR4gjus7SvHDg/sbaerK6ZGWr
         A9TpeRyhipvp/nTCAEl9qLa58rFVfLk81nrKC3w5Q+/33iHKdssqwqZzNIgK2KO1R1S8
         S/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+4rCop3n3GBW7j7hetL/Hu4npvlr9cPmXrrgFTZYpTY=;
        b=Zn85QcOULZVqLKfMSwX12bPoMSvVL9YyPftw5y58cGFQcCpyqTjzDJvd2YwhxwhJXs
         CRD8QNNqmVVlBpQYFx8sw/iPO9ljb++fZ9mTMsyA8PUkCVor1YArDkkfGO9D9vtQHeXH
         ceN59IXPwU7X6DHnrPuINfYuiEzWh9hp2cUf62NQamcztfQXCpdO3dnq/noKesarFpfm
         PdtPxocVsUXQ4Zh46iD71YByTHOISfMr9REKu5Zqr/0wFpXXjgPA33Cbnn4kyNuAvmW3
         00bylywoLVe2VRCFQtNV85/tlI8Moh5SxEwlrG8kIHHG3NDBsiKhf4N/JldVE57yQmsB
         JC3Q==
X-Gm-Message-State: AOAM531kxRkRTSixCXju/l0tRTLgDY6yWuv5Q/2sBRUawr8Sppp7T+1J
        P3QAiPw2SA8OVDf7R65sq48+k8vB1Fe4xJgFw/S4yqBj
X-Google-Smtp-Source: ABdhPJyHuY8wr6uiGi7ifkOQ3Rgc34sXLb6hodQSVfEQgff8G55J1reX8Su6uGe9T9wYgWPJCqQyN6skvxlS1kCB43M=
X-Received: by 2002:a37:8287:: with SMTP id e129mr12908163qkd.415.1635158130161;
 Mon, 25 Oct 2021 03:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211025032256.61557-1-yifeix.zhu@intel.com>
In-Reply-To: <20211025032256.61557-1-yifeix.zhu@intel.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 25 Oct 2021 11:34:54 +0100
Message-ID: <CAL3q7H4qhjMyiQ4hwX505V=U4wnkb-V2pEANhZYE2M4=FjArrg@mail.gmail.com>
Subject: Re: [PATCH v2 xfstests-dev] tests/btrfs/012: check size after mounted
To:     Zhu Yifei <yifeix.zhu@intel.com>
Cc:     Eryu <guan@eryu.me>, fstests <fstests@vger.kernel.org>,
        Philip Li <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 25, 2021 at 4:26 AM Zhu Yifei <yifeix.zhu@intel.com> wrote:
>
> move '_require_fs_space'  after mounted.
>
> =3D=3Dbefore patch=3D=3D
> btrfs/012       [not run] This test requires at least 0GB free on /fs/scr=
atch to run
>
> =3D=3Dafter patch=3D=3D
> btrfs/012 189s ...  194s
> Ran: btrfs/012
> Passed all 1 tests
>
> Signed-off-by: Zhu Yifei <yifeix.zhu@intel.com>

Looks good,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

In the future, for any changes related to btrfs tests, can you also
please cc linux-btrfs@vger.kernel.org?

Thanks.

> ---
>  tests/btrfs/012 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index 3040a655..29552b14 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -31,8 +31,6 @@ _require_command "$E2FSCK_PROG" e2fsck
>  # ext4 does not support zoned block device
>  _require_non_zoned_device "${SCRATCH_DEV}"
>
> -_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_P=
ROG} '{print $1}')
> -
>  BLOCK_SIZE=3D`_get_block_size $TEST_DIR`
>
>  # Create & populate an ext4 filesystem
> @@ -41,6 +39,8 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqre=
s.full 2>&1 || \
>  # Manual mount so we don't use -t btrfs or selinux context
>  mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
>
> +_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | ${AWK_P=
ROG} '{print $1}')
> +
>  cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT
>  _scratch_unmount
>
> --
> 2.20.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
