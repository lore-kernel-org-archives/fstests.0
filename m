Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F3C61DA4
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Feb 2023 06:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBRGIw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Feb 2023 01:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBRGIu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Feb 2023 01:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADF225E02
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676700484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mYl3xgQmfHJrQuQGTp05sZIuCxqd2Qi6lTzFd1HFIjQ=;
        b=cDpzLIZEOeI+nSyAyZR9BT3j0DwiY9xjEndAWgG85k96R5qSCMj6BO8wQBxUDPSfvXup5h
        u/lBTW3UI+nyN/UhfznkztxmeiYhUBAyYLJu7NXJd+TOyKxpxORk5/Cd62xsJPnK/v3ZfN
        lgKyG5Rc5rJq2bpsrL/WMtiKcRM7oFI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-142-zZ0xss1OM4-_WWp69Yc3kw-1; Sat, 18 Feb 2023 01:08:02 -0500
X-MC-Unique: zZ0xss1OM4-_WWp69Yc3kw-1
Received: by mail-pf1-f199.google.com with SMTP id j10-20020a056a00130a00b0059085684b50so152491pfu.16
        for <fstests@vger.kernel.org>; Fri, 17 Feb 2023 22:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYl3xgQmfHJrQuQGTp05sZIuCxqd2Qi6lTzFd1HFIjQ=;
        b=BLlioLzuchCnczXOW6p0Xanr2jPTL4PA63JR4ZDU6AqO74SOvqh2iiMmq2iUGcpMpY
         VxEAqmFG/Ev0FxCkdn8vdHBLDu+iuLkKLdYDSyxKuyuzO9xRFg4Ks/Bky58i/d1yABft
         Zq/GClh7pBqdjY0osdECjGvG6sp31zCgUsdYVcuAo2oHzq5VotGzBvGmQ2XWtZTmharp
         w9gx7sDaOAdS+Dv9bwCGZxTwbIcF8EMKotT8HYuDYPmzjW6CskKgwhOFtCsF45Vf8gTJ
         10n8IpZ99CTnJjvWe+uJyBCl4J/v5M+UVILau81FvfRe406spGLukRoLyNpIdmBmMUqa
         h7zQ==
X-Gm-Message-State: AO0yUKUOtIpXstM2PccIinY1PQ0Z/D6Z3ssUFK2GqXPKnBoBXwhO+6gm
        n75u9cog/eLKOzNp2fyX35Xxzx49xGnHCVzzSvp7XG9mmdiF8ts5CJr+dT+yPfrCsVFnIomjC7K
        EAooNQiDzNBhpSbZrxA==
X-Received: by 2002:a05:6a21:360b:b0:c7:1bf1:4b28 with SMTP id yg11-20020a056a21360b00b000c71bf14b28mr6699563pzb.12.1676700481470;
        Fri, 17 Feb 2023 22:08:01 -0800 (PST)
X-Google-Smtp-Source: AK7set/vl5JfD74q2Hn1+siUD7/LJ+uTu76K2IHO5H43HRrAYmx3b6tP6ceBjtgIlbf4XC2d0Iu2kQ==
X-Received: by 2002:a05:6a21:360b:b0:c7:1bf1:4b28 with SMTP id yg11-20020a056a21360b00b000c71bf14b28mr6699551pzb.12.1676700481140;
        Fri, 17 Feb 2023 22:08:01 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g1-20020a62e301000000b005a75d85c0c7sm3949231pfh.51.2023.02.17.22.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 22:08:00 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:07:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCHSET v24.0 0/4] fstests: online repair of file fork mappings
Message-ID: <20230218060757.23q4a4k63axxhmdd@zlang-mailbox>
References: <Y69Unb7KRM5awJoV@magnolia>
 <167243875835.725760.8458608166534095780.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167243875835.725760.8458608166534095780.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 30, 2022 at 02:19:18PM -0800, Darrick J. Wong wrote:
> Hi all,
> 
> In this series, online repair gains the ability to rebuild data and attr
> fork mappings from the reverse mapping information.  It is at this point
> where we reintroduce the ability to reap file extents.
> 
> Repair of CoW forks is a little different -- on disk, CoW staging
> extents are owned by the refcount btree and cannot be mapped back to
> individual files.  Hence we can only detect staging extents that don't
> quite look right (missing reverse mappings, shared staging extents) and
> replace them with fresh allocations.
> 
> If you're going to start using this mess, you probably ought to just
> pull from my git trees, which are linked below.
> 
> This is an extraordinary way to destroy everything.  Enjoy!
> Comments and questions are, as always, welcome.
> 
> --D

Ack, will merge this patchset

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> kernel git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-file-mappings
> 
> xfsprogs git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=repair-file-mappings
> 
> fstests git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=repair-file-mappings
> ---
>  tests/xfs/746     |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/746.out |    2 +
>  tests/xfs/807     |   37 +++++++++++++++++++++++
>  tests/xfs/807.out |    2 +
>  tests/xfs/808     |   39 ++++++++++++++++++++++++
>  tests/xfs/808.out |    2 +
>  tests/xfs/828     |   38 ++++++++++++++++++++++++
>  tests/xfs/828.out |    2 +
>  tests/xfs/829     |   39 ++++++++++++++++++++++++
>  tests/xfs/829.out |    2 +
>  tests/xfs/840     |   72 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/840.out |    3 ++
>  tests/xfs/846     |   39 ++++++++++++++++++++++++
>  tests/xfs/846.out |    2 +
>  14 files changed, 364 insertions(+)
>  create mode 100755 tests/xfs/746
>  create mode 100644 tests/xfs/746.out
>  create mode 100755 tests/xfs/807
>  create mode 100644 tests/xfs/807.out
>  create mode 100755 tests/xfs/808
>  create mode 100644 tests/xfs/808.out
>  create mode 100755 tests/xfs/828
>  create mode 100644 tests/xfs/828.out
>  create mode 100755 tests/xfs/829
>  create mode 100644 tests/xfs/829.out
>  create mode 100755 tests/xfs/840
>  create mode 100644 tests/xfs/840.out
>  create mode 100755 tests/xfs/846
>  create mode 100644 tests/xfs/846.out
> 

