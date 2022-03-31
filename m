Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253D6C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 11:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiCaLiB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiCaLhz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 07:37:55 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCBD207A00
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 04:36:08 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id kd21so16561340qvb.6
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZTb/MYyGSUqhXdksnOf5r2+KubGnX7AG5MuM3uilQs=;
        b=bpxSXr/KEq7QZfJJrFQ0Ug6pHExnZncY4fnXhAsXnXefANJm4/sq02AdC7gEUrorc1
         ow22ANqVBDSWz2Uvei344yxouSWZ+7b6KaotrF2PaPxBhNbgFKkEW9gxwCKFpa8pfocO
         BmXGwGO5vEhXcLY/HgsoCS1p/djWgjr2M946T4hFexEiWV5n7mE9mWQ63J2gX96lvLzl
         Nu6aMY9G8DGBH8k9e2ZlhpU6Hz1xSFNklZEp/K9sRjtAADXZo8gUdDziOr9kBihNxl9D
         tEfwjbeYxQuLbwDHGYl2Gv7IiZ2kJoXQkmmce/zjms4A2dZwadgg+//qyBxLl25YitgZ
         IvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZTb/MYyGSUqhXdksnOf5r2+KubGnX7AG5MuM3uilQs=;
        b=ILgTnJI1r7I5jVlV/Frh7zs+ZJQJGxnnbrZAkG58GrfcbE2AxnMWb4a75KjzgNgFkQ
         TmVPUbVGA4DqRoCrokiYKBgJxgPCThixddjMTjJ5kt4/8LvLFWaHKzN7aSZkjh25zKSw
         96/5GXvxs523Q1hfDbpbJmOr0R4eMGFfBWAYOERdwLNq7lOZuSpJGomst5vcD3rDlKD5
         zuL3StCTFC4jUZylchKyXLWLJIVE7sYS4BKKVE8G+/grCQ97O62JtkLIy4YxTSBfnR4d
         XGTxx8DR8rvwKRYxcPA/L3mbZsQB85dqhc9aRWNAPJKjICPahCJKrzmn1f0h3oY+WQQP
         y9nQ==
X-Gm-Message-State: AOAM5318XGEJRvfwfy430X6p/+qBmJVnzhOSzl2Wdc+MerDYbnP+Fb/p
        ECsHolR87x6fD4tyg9jAOdFe6U76Ak8jWsgTM9k=
X-Google-Smtp-Source: ABdhPJw+ijsj036QUFQKRa1J6BzZYiXBdhQeenif+mqr6N2UGqYlhfQR/xUxC2z/ZSYJo0bjDSo59FYeTmd1jZrTP7I=
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id
 g4-20020a0562141cc400b0043535c3f0f1mr3263796qvd.0.1648726567191; Thu, 31 Mar
 2022 04:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220331112318.1377494-1-brauner@kernel.org> <20220331112318.1377494-21-brauner@kernel.org>
In-Reply-To: <20220331112318.1377494-21-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 31 Mar 2022 14:35:55 +0300
Message-ID: <CAOQ4uxj-EndoH7ZT=sWRJ4VpXDXW4AyrFYByug7bYqria7LMPw@mail.gmail.com>
Subject: Re: [PATCH v3] common: allow to run all tests on idmapped mounts
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 2:25 PM Christian Brauner <brauner@kernel.org> wrote:
>
> In addition to the generic and filesystem-specific idmapped mount
> testsuites that already exist upstream today add simple infrastructure
> so any test can be run on idmapped mounts simply by setting
> IDMAPPED_MOUNTS=true in the config file or section. The main user for
> now will be overlay to verify it works correctly on idmapped mounts.
>
> Note that the infrastructure is completely generic so every filesystem that
> supports idmapped mounts can simply run all of their tests idmapped. But
> note that not all ways to create a mount have been converted yet. That
> includes e.g. _dmthin_mount and direct calls to _mount in various tests.
>
> In addition, there will be corner-cases. For example, xfs doesn't allow
> bulkstat on idmapped mounts because it is a filesystem wide operation,
> i.e. you can retrieve information for any inode in the filesystem so the
> operation cannot be scoped reasonably under a single mount. So xfstests
> testing bulkstat will fail as it's blocked. Similar for some btrfs
> ioctl()s.
>
> While we could of course restrict this testmode to -overlay for which we
> know things work correctly we should not do this. It would mean that
> people won't start using it and so we won't see issues unless someone
> sits down and goes through more than 1000 tests and figures out for each
> individual one whether it needs to be skipped or not.
>
> So instead allow this mode but for all filesystems so people can start
> running and reporting failures and we can fix them up or block them as
> we detect them.
>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Eryu Guan <guaneryu@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: <fstests@vger.kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> /* v2 */
> unchanged
>
> /* v3 */
> - Amir Goldstein <amir73il@gmail.com>:
>   - Add more detailed explanation about the current state and
>     expectations of the newly added IDMAPPED_MOUNTS support.

Please document the new envvar in README with a *short* disclaimer
about expectations with and without -overlay and please add an [idmapped]
section to the multi section config example in README.overlay.

Sorry if I wasn't clear about what better documentation of expectations
the text in the commit message is important but is no replacement for
documentation.

Thanks,
Amir.
