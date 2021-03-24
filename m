Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057D0C433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 07:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26BC619E1
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 07:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhCXHlU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 03:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCXHlC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Mar 2021 03:41:02 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F09DC061763
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 00:41:02 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id j26so20477911iog.13
        for <fstests@vger.kernel.org>; Wed, 24 Mar 2021 00:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axMLytJvwrMbhFBPSvRtGIf44uvNqB4NlVi0Bt1p2rc=;
        b=c68/cs+Ooqkei7XoovxP+MRuNAJ79t7M7BvwZGo9Gmb+NQvMnvzx0MJ0Exxlh+O23A
         zIcqV3NPGbVSP70xMsVF+mTGqC7Uomc18ysuUrezuwxqpuhbXYRF++J8O/lnxCQx1yk9
         aEUuEjKkgAf/pWwCh3T7dMC/S6dtGw1hQCjRcckrP5q6sdLiPCEsTT1jkvEswW0ZpPo2
         FE51FFsGx7bYwZW16wlAK442qjWIyUfFXhUv3McfpSx7meyOZxkW0skoUFjaJXN8Qgxi
         81GwSnF8vN7/PJqEHu/lakQIlDB1yxnuDXca1nmvIg0IWhbbnPL3gGaqoKh+v/ploub2
         VUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axMLytJvwrMbhFBPSvRtGIf44uvNqB4NlVi0Bt1p2rc=;
        b=ilqcKCZeycMgWy7ldImytsFEr0KIF8YK9HUnMNwuhNCyOChaPXasZpxEt7NV3HnqyQ
         L2IjjLQaQ1RneYO2McAwCxcoXaamXLseLalaO5mz0v2ZMEV9QwZ5/PyV/YSn1Yq7rkCA
         97Mlr2MlBo84c9vg69wecRNBJwRr90kuqlx7OsyjbDrpY+NxcEkgQAgBx0reot30dzIr
         WcSn8wCb65CU7gLhda+Dt4z57lbeXPQ1V/oARODu27dNwoW2dBh+Xhzx4EyG19zomNkF
         pkzEAJCwrf+fU3P+Mo8gF4e85n0wTv0B+KG+WfUdN/c5ge3ApkeAVycd8Y7eArFjML3T
         PGlg==
X-Gm-Message-State: AOAM533DMugEwe7V6ops3uTwJyN0CAijFdhFPdmdynziL200sm+z8Mq0
        pMdR8Axe+NY5zct4zBrdKtvfQONRzUzotSjNYdA=
X-Google-Smtp-Source: ABdhPJxbvBnNlVIyssUrHPWjW93i32plnH7P2gQ7MX2xhkLq1mViOJu0zhjt5lhG4JuTvmKYfBTz+aJSncCpwaY3K6I=
X-Received: by 2002:a5e:8d01:: with SMTP id m1mr1454106ioj.72.1616571661554;
 Wed, 24 Mar 2021 00:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210322134522.916512-1-brauner@kernel.org> <20210322134522.916512-2-brauner@kernel.org>
In-Reply-To: <20210322134522.916512-2-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 09:40:50 +0200
Message-ID: <CAOQ4uxg6KyJLT9NnxFEnFPAkc02A0mmWSZphEd5to625x1cKxw@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] generic/631: add test for detached mount propagation
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eryu Guan <guan@eryu.me>, fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 22, 2021 at 3:46 PM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Regression test to verify that creating a series of detached mounts,
> attaching them to the filesystem, and unmounting them does not trigger an
> integer overflow in ns->mounts causing the kernel to block any new mounts in
> count_mounts() and returning ENOSPC because it falsely assumes that the
> maximum number of mounts in the mount namespace has been reached, i.e. it
> thinks it can't fit the new mounts into the mount namespace anymore.
>
> The test is written in a way that it will leave the host's mount
> namespace intact so we are sure to never make the host's mount namespace
> unuseable!
>
> Link: https://git.kernel.org/torvalds/c/ee2e3f50629f17b0752b55b2566c15ce8dafb557
> Cc: Eryu Guan <guan@eryu.me>
> Cc: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v1 - v8 */
> patch not present
>
> /* v9 */
> - Christian Brauner <christian.brauner@ubuntu.com>:
>   - Rebased on current master.
>
> /* v10 */
> - Eryu Guan <guan@eryu.me>:
>   - Add missing checks whether test is supported.
>   - Move status=$? assignment up.
> ---

Technical nit: why did you add this extra --- line?
It causes all the patch changelog to appear in the commit message.
I don't think that was your intention? and I don't think it adds valuable
into to git log.

Thanks,
Amir.
