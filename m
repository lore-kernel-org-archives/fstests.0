Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DA3C4708E
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Jan 2023 00:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbjADAeB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 3 Jan 2023 19:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbjADAdl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 3 Jan 2023 19:33:41 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA3C15F11
        for <fstests@vger.kernel.org>; Tue,  3 Jan 2023 16:33:41 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-43ea87d0797so458540267b3.5
        for <fstests@vger.kernel.org>; Tue, 03 Jan 2023 16:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7trkWcxoBYgfVWytDtcBu7ZmkagzNlrlLr/1Wg+ysoM=;
        b=Dy5ArQWxb7TugSORlc/r8cjOaKI84PYPVesfpPfQaPu0zlSV3unxkIkJ/4EvwbmooF
         iVzQQbWWhhkNkTnJOP//tpPlvNu8kMQ+6/rj2+L6FtYKpd49nKaBlZ0m41QlYaRs3kah
         H7WRmGvlHXWybRjDlzgtvjAbteL0iMjZVFoLFbLUIm3THScEiDxdUyZobpCHheTeNuyL
         FVEMnO8BfvU0/gXXlnC103w8/zUFDvmJfejSsXmpDuLG3eKPk6/Y6C1aTmfZxVYZACk2
         s9NTkVcAgwl2Uo1rFE/GwytzYfXqe/MD0llpTdblDTKxMftYlhBffu5XhxzZdcWNdwLJ
         pXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7trkWcxoBYgfVWytDtcBu7ZmkagzNlrlLr/1Wg+ysoM=;
        b=ihSXEvTb7l5/2H2J5Wgc1IGoOtLB+kMxfenjvFY2/HJgdvMFvBGDxy7SBOa1vPHnCn
         9V5R0k0Axs/Dy+MOddkjZAqPE/7650q/OgFGz8pnG1oawxn2YkZLSkYw3l9Ao6KyDsH7
         b9ME5EeX1FxpLdnO5IeT46xJj1zFOkIRhDtu6FuaW0Qb0Hw1DBY+WXXkD6wKMxPeA8RE
         YUJtzF+Qh0p1/eBxblRfl5tqO8GSzYosEaYZdJ6JnUITiNFyBdr+kjPSBeVm2W9cHvem
         IbAVc8xTrQWdR6dPNtf8gzJnXbc+V72RHCvQm9LM29tyoRquBBQ7CU3hFEvSy7TrTwbH
         WP4g==
X-Gm-Message-State: AFqh2kqyQqIxveU/MhOfKRB+0ILBhmB3M4FRg3K4RpNq8Mj9SI+Yu1xT
        MzZTPLIvteSeZU3zbbEmcWG7nHOh8fdcqllV7mU=
X-Google-Smtp-Source: AMrXdXthsB/bRva8OrzTz9Exy3m3MzFfzMzbyqpr5JzhQoFI+/v0qXfLehU+Ss7/4Xqs3o44b/NmsqXPjDCvmeyWeh8=
X-Received: by 2002:a81:198c:0:b0:3b5:8832:31eb with SMTP id
 134-20020a81198c000000b003b5883231ebmr5450960ywz.46.1672792420335; Tue, 03
 Jan 2023 16:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20221229134434.1513212-1-libaokun1@huawei.com>
In-Reply-To: <20221229134434.1513212-1-libaokun1@huawei.com>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Wed, 4 Jan 2023 08:33:29 +0800
Message-ID: <CADJHv_vQ6og11x13-KaWJrhCc0x4Z+gUhdkRUAeLvG6BOUfzWg@mail.gmail.com>
Subject: Re: [PATCH] overlay: avoid to use NULL OVL_BASE_FSTYP for mounting
To:     Baokun Li <libaokun1@huawei.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, guaneryu@gmail.com,
        amir73il@gmail.com, hsiangkao@linux.alibaba.com,
        yi.zhang@huawei.com, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks! This fixed my original issue.

On Thu, Dec 29, 2022 at 9:24 PM Baokun Li <libaokun1@huawei.com> wrote:
>
> Generally, FSTYP is used to specify OVL_BASE_FSTYP. When we specify FSTYP
> through an environment variable, it is not converted to OVL_BASE_FSTYP.
> In addition, sometimes we do not even specify the file type. For example,
> we only use `./check -n -overlay -g auto` to list overlay-related cases.
> If OVL_BASE_FSTYP is NULL, mounting fails and the test fails.
>
> To solve this problem, try to assign a value to OVL_BASE_FSTYP when
> specifying -overlay. In addition, in the _overlay_base_mount function,
> the basic file system type of the overlay is specified only when
> OVL_BASE_FSTYP is not NULL.
>
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  check          | 1 +
>  common/overlay | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/check b/check
> index 1ff0f44a..22062935 100755
> --- a/check
> +++ b/check
> @@ -283,6 +283,7 @@ while [ $# -gt 0 ]; do
>                 FSTYP="${1:1}"
>                 ;;
>         -overlay)
> +               [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
>                 FSTYP=overlay
>                 export OVERLAY=true
>                 ;;
> diff --git a/common/overlay b/common/overlay
> index e35419d0..20cafeb1 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -85,7 +85,12 @@ _overlay_base_mount()
>                 return 1
>         fi
>
> -       _mount -t $OVL_BASE_FSTYP $* $dev $mnt
> +       if [ $OVL_BASE_FSTYP ]; then
> +               _mount -t $OVL_BASE_FSTYP $* $dev $mnt
> +       else
> +               _mount $* $dev $mnt
> +       fi
> +
>         _idmapped_mount $dev $mnt
>  }
>
> --
> 2.31.1
>
