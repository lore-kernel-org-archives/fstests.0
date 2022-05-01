Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6C2C433F5
	for <linux-fstests@archiver.kernel.org>; Sun,  1 May 2022 11:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiEALuV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 May 2022 07:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiEALuV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 May 2022 07:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91195AE6F
        for <fstests@vger.kernel.org>; Sun,  1 May 2022 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651405614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qA5UTsQ88POAkuV0kv3nP2XI2L/DTC7jQHmIJCgAvkA=;
        b=e6CDti2XGXtJFOlR+Xf32VGg6yR5qsPktMsYVGylnmKnok0fnTLEjRMlPDkWUfUQWpY2rM
        Nx1MPLesPJMT0OPD8bNbzgtuYTbOgCP2muUa73QgVz62Kv0Ggn3CbFQA03R/e7F7CukqiD
        DKdbbPAbRgMQWOfB+o/4Coo0c5Eld/I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-Z-Bz7hrcN7enBvf5qXpGEw-1; Sun, 01 May 2022 07:46:51 -0400
X-MC-Unique: Z-Bz7hrcN7enBvf5qXpGEw-1
Received: by mail-qt1-f197.google.com with SMTP id b11-20020ac85bcb000000b002f398ecec5fso3934179qtb.2
        for <fstests@vger.kernel.org>; Sun, 01 May 2022 04:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=qA5UTsQ88POAkuV0kv3nP2XI2L/DTC7jQHmIJCgAvkA=;
        b=IuhgaW8UZIrGqmLJxZW0V+FqfVkGudxA6UOKhS4aeV2wvUpXmqoXs1utAtWq70hHru
         xt5jo2th6ypGxti4s9yXIcng9VHGabh+O4H5xVEoOXDfCwifbPtF7p5nQB+W4Fb4+9zI
         Czh00fOR1Rvvm4fT/kv5jGOM1kNCtpkJjW+6y9jEtXQFWSqREmEHPRaBwVlaMpCA56li
         B0p4bDeJSbTdAqqPvH6tXptVT+7xyGz4HulwohiNhneHwtO46OqCQmRdEgPaJ6+UVM25
         8q1akXLoliOerp03+G8/xtLJ3VkYnIwwweWfVnk649ATWKAqIbENZy8cXAG4bA54XFda
         mhfQ==
X-Gm-Message-State: AOAM531Q+Qv0RPKzZGRP9wW2x53u9380rX2ICEnU+TmN3+eAXdx30qT+
        q6DeLJMDNHmP1NhUKfB7pFkmG9/y1qADgba34mo6DDg2wUncJco5+oJDBzeR7MA9UxjGuh3zO8V
        Q7jzcM8RTbdE9FUVQEg==
X-Received: by 2002:a05:6214:2aa5:b0:45a:87d8:d83f with SMTP id js5-20020a0562142aa500b0045a87d8d83fmr1228568qvb.2.1651405610340;
        Sun, 01 May 2022 04:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGXn2l1yXf1PPIIBzkNeptbHMCpsJWF+KWDJXqb7F9TN8jGN4UYPe/10V8Sslk0LPBdSTFeg==
X-Received: by 2002:a05:6214:2aa5:b0:45a:87d8:d83f with SMTP id js5-20020a0562142aa500b0045a87d8d83fmr1228555qvb.2.1651405610070;
        Sun, 01 May 2022 04:46:50 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l184-20020a3789c1000000b0069fc13ce21csm2609004qkd.77.2022.05.01.04.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 04:46:49 -0700 (PDT)
Date:   Sun, 1 May 2022 19:46:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/11] rename & split tests
Message-ID: <20220501114643.ypif3dzglroqlce4@zlang-mailbox>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
        fstests <fstests@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20220428151559.947144-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428151559.947144-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 28, 2022 at 05:15:48PM +0200, Christian Brauner wrote:
> From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> 
> Hey everyone,
> 
> As announced multiple times already we need to rename and split the
> idmapped mount testsuite into separate source files and also give it a
> better name to reflect the fact that it covers a lot more than just
> idmapped mounts.
> 
> I have decided against compiling different binaries for now. Instead we
> compile a single vfstest binary that can be called with various command
> line switches to run the various test suites. This is not different than
> what we did for the idmapped-mounts binary. Of course, nothing prevents
> us from using multiple binaries in the future.
> 
> Note that this will have a conflict with Jan's series at:
> https://lore.kernel.org/fstests/20220425131809.qzjrah7cw67mzzcw@zlang-mailbox/T/#m47d8da68ef1aff250918398e8d2228729a6acf97

Hi Christian,

Thanks for your patches! But even without above conflict patches, I still can't
merge your patchset, failures as below [1].
May you rebase your patches on latest fstests for-next branch, and send out
again? As Christoph Hellwig has Acked your patchset, we'd better to make it
work with current fstests at least, for others might want to give it a try.

Thanks,
Zorro

[1]
$ git reset --hard fbc6486b
HEAD is now at fbc6486b generic: test that renaming into a directory fails with EDQUOT
$ git am -s ./20220428_brauner_rename_split_tests.mbx
Applying: src: rename idmapped-mounts folder
Applying: src/vfs: rename idmapped-mounts.c file
Applying: vfstest: rename struct t_idmapped_mounts
Applying: utils: add missing global.h include
Applying: utils: move helpers into utils
error: patch failed: src/vfs/utils.h:51
error: src/vfs/utils.h: patch does not apply
error: patch failed: src/vfs/vfstest.c:35
error: src/vfs/vfstest.c: patch does not apply
Patch failed at 0005 utils: move helpers into utils
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

> 
> If this patch series here is acceptable I'd pick up Jan's patch and
> apply it on top of mine as rebasing will introduce too many conflicts.
> 
> Thanks!
> Christian
> 
> Christian Brauner (11):
>   src: rename idmapped-mounts folder
>   src/vfs: rename idmapped-mounts.c file
>   vfstest: rename struct t_idmapped_mounts
>   utils: add missing global.h include
>   utils: add struct vfstest_info
>   utils: move helpers into utils
>   missing: move sys_execveat() to missing.h
>   utils: add struct test_suite
>   vfstests: split idmapped mount tests into separate suite
>   vfstest: split out btrfs idmapped mounts test
>   vfstest: split out remaining idmapped mount tests
> 
>  .gitignore                                    |     4 +-
>  common/rc                                     |    32 +-
>  src/Makefile                                  |     2 +-
>  src/detached_mounts_propagation.c             |     2 +-
>  src/feature.c                                 |     2 +-
>  src/idmapped-mounts/utils.c                   |   425 -
>  src/idmapped-mounts/utils.h                   |   130 -
>  src/{idmapped-mounts => vfs}/Makefile         |    14 +-
>  src/vfs/btrfs-idmapped-mounts.c               |  3854 +++++
>  src/vfs/btrfs-idmapped-mounts.h               |    15 +
>  .../idmapped-mounts.c                         | 11865 ++++------------
>  src/vfs/idmapped-mounts.h                     |    17 +
>  src/{idmapped-mounts => vfs}/missing.h        |    11 +
>  src/{idmapped-mounts => vfs}/mount-idmapped.c |     0
>  src/vfs/utils.c                               |  1003 ++
>  src/vfs/utils.h                               |   364 +
>  src/vfs/vfstest.c                             |  1952 +++
>  tests/btrfs/245                               |     2 +-
>  tests/generic/633                             |     2 +-
>  tests/generic/644                             |     2 +-
>  tests/generic/645                             |     2 +-
>  tests/generic/656                             |     2 +-
>  tests/xfs/152                                 |     4 +-
>  tests/xfs/153                                 |     2 +-
>  24 files changed, 9952 insertions(+), 9756 deletions(-)
>  delete mode 100644 src/idmapped-mounts/utils.c
>  delete mode 100644 src/idmapped-mounts/utils.h
>  rename src/{idmapped-mounts => vfs}/Makefile (59%)
>  create mode 100644 src/vfs/btrfs-idmapped-mounts.c
>  create mode 100644 src/vfs/btrfs-idmapped-mounts.h
>  rename src/{idmapped-mounts => vfs}/idmapped-mounts.c (50%)
>  create mode 100644 src/vfs/idmapped-mounts.h
>  rename src/{idmapped-mounts => vfs}/missing.h (93%)
>  rename src/{idmapped-mounts => vfs}/mount-idmapped.c (100%)
>  create mode 100644 src/vfs/utils.c
>  create mode 100644 src/vfs/utils.h
>  create mode 100644 src/vfs/vfstest.c
> 
> -- 
> 2.32.0
> 

