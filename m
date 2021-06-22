Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E669BC2B9F4
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 18:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C933F6128C
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Jun 2021 18:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhFVSVF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVSVF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Jun 2021 14:21:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F4C061574
        for <fstests@vger.kernel.org>; Tue, 22 Jun 2021 11:18:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bb20so8395093pjb.3
        for <fstests@vger.kernel.org>; Tue, 22 Jun 2021 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1u8CC3QA7jrUZcmb98lKK5u9LYwITi96Hai5lwcXiPs=;
        b=fQBjoR2y/ANdNBuLFktBzEFPY63uvtShx3yq1Sloxw1meS7tpgz+NqabYFSXq50Rxz
         jvmradX1JQN2UnEzr8OXFFc3xoVnzMA08htn5zVknFxwxVCNBi4d7Of9anFCwu/WfQhJ
         kvYluNFdpwf8fU1fzc/RKP0DWHWw9tfsCcUloFfu9+njcINoe+JKiFwH4+CU7b+nJlwC
         Y7FZ6fTjkEVw9qDhktHshoiEy4KeaoVH18ZTjLyrIYmKIL7KaCIn+7sz/fD8EkIwHfDd
         3qvAe7+kwCXi+96j+dxYQcZnWvgOOhM7oapEoByVt4bD4BVs+r5pcpavv/NVy821rhxP
         C7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1u8CC3QA7jrUZcmb98lKK5u9LYwITi96Hai5lwcXiPs=;
        b=VrF0oFKUxKB3HP85BQN/mm9ayO5V7OGLpEQQww4rJPtg017ecxPoH4cxmRUlyI57GX
         axH2azGEPs1MgDOjU1/f1RQYz/RT5DacZHIipH8TPp5wE7UQ1XXNgIinz5/6KpWb53fy
         BtbAZ4U3CLFuCS8qB6cXwESSgPcjzLiGaHDKjmmG/KACu95AANSV/YZSQeSrn2UJjo2y
         8T4R17pmxdZz0CBfTcng2bMPCc7qlCVUcDhoOqHswdQdWOzwRcXLT4sAKFgkvc6e0kja
         kKBScAzzQIzWdO57eaKdo/tHUXxUjzD3im4yk8+MrwpiwcAmvUqB+soXvzJ07Rv/VvQs
         XPWQ==
X-Gm-Message-State: AOAM532BeDg6bBNRqZwX7BNhnawsTxaBd1awmQ7FAtSibpvLJZMgogJ0
        N5mgYuEPlL3loZbihfdNRcfj6FCdYPsGTw==
X-Google-Smtp-Source: ABdhPJwkmonRcUlxxyyQBjolkp2Z5L30p2jps3wzYMOI2HNdqxb2VRQcOi2eZGlTt7zxCNm7oz3RRw==
X-Received: by 2002:a17:90b:789:: with SMTP id l9mr5394380pjz.157.1624385927560;
        Tue, 22 Jun 2021 11:18:47 -0700 (PDT)
Received: from google.com ([2601:647:4701:18d0:56fd:b475:56:403a])
        by smtp.gmail.com with ESMTPSA id s63sm3062660pjj.35.2021.06.22.11.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 11:18:47 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:18:45 -0700
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Message-ID: <YNIphT6xiluxLrOm@google.com>
References: <20210621164851.1808923-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621164851.1808923-1-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 21, 2021 at 12:48:51PM -0400, Theodore Ts'o wrote:
> ext4/048 will fail when running on older kernels that don't support
> the filename wipe feature.  The journal checkpoint ioctl is a related
> feature, and landed just a little bit after filename wipe feature, so
> use support for the journal checkpoint ioctl as a proxy for support
> for the filename wipe feature.
> 
> Without this change, this test will fail when tesing 5.10, 5.4, and
> other LTS kernels.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  tests/ext4/048 | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/ext4/048 b/tests/ext4/048
> index 51189618..35e6aa7f 100755
> --- a/tests/ext4/048
> +++ b/tests/ext4/048
> @@ -93,6 +93,14 @@ _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
>  # create scratch dir for testing
>  # create some files with no name a substr of another name so we can grep later
>  _scratch_mount >> $seqres.full 2>&1
> +
> +# Use the presence of the journal checkpoint ioctl as a proxy of filename
> +# wipe being supported
> +if test -x $here/src/checkpoint_journal && \
> +	! $here/src/checkpoint_journal $SCRATCH_MNT --dry-run ; then
> +    _notrun "filename wipe not supported"
> +fi

What if checkpoint_journal is not there? Should the test be
skipped in that case as well? 

-Leah

> +
>  blocksize="$(_get_block_size $SCRATCH_MNT)"
>  mkdir $testdir
>  file_num=1
> -- 
> 2.31.0
> 
