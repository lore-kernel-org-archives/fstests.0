Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0344CC6FD1C
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Mar 2023 10:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCNKmU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Mar 2023 06:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCNKmC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2023 06:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AA692BF6
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678790352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8aQjnh6+e6LabqeykcKhDMTaGuuF7g6X5zEwJA1JJg=;
        b=dgJvggIjRnSZvbHRRJUsxKDjvPflhEKrDsMcDvky3gFqhN1wHchx+hlMXy6/Ope57tDNU+
        Gj9SPNFDypogMqpjTXC8JN6RnBEOdp1QGpx9kCzAEYXgWZ9XIK6tdB0TFt0eqe+Q3418Hz
        dDLtLWjtwC9ND8wTM9zRAFetKxNB2AA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-311LDnUXMD2lY5EbLrfE7w-1; Tue, 14 Mar 2023 06:39:10 -0400
X-MC-Unique: 311LDnUXMD2lY5EbLrfE7w-1
Received: by mail-pl1-f197.google.com with SMTP id s8-20020a170902b18800b0019c92f56a8aso8738042plr.22
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 03:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678790350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8aQjnh6+e6LabqeykcKhDMTaGuuF7g6X5zEwJA1JJg=;
        b=IRl5BfJkc7fhQn6PKHt2iuKc9+UWI5OG9gqFDWB2asuSYPcfMc8HqB6/EKPCXvthml
         zRZnzv8aFXBWiwSO5ivNDVlR/78+4YrEE74KwWIVjJRRgDEqFOL6PssN66Ca4kNYvIN5
         KF01g5QqP5X0CMshJvW6ZXnbHU1PPrQWo9wfgTNXkP656t2u7CpXDsIUI7Oez5UB0l0Z
         iN0F7xjQRFCxBgdqbKxqV0oDkIPPLrJ2cy/veY5pjXK7bk0/lWBmzdWOgQsJoQyIUijt
         8IgoaTZH8tfDszJeHYdN85FOc08Md3If6iWEWy3h8z/K5htrhqcczNz3zJhCCmmXWZDe
         WXLQ==
X-Gm-Message-State: AO0yUKV2tyCT3awoOMy5cZWIqrRGGUmbkk0fpvwzQA/tYRNOFB+Eb6DT
        BnS0vvAR6duaF6tHI4Wxu6hKwYN35Unu5ielT4qxwmwaqQbJrU9uVXnoVZjgUkvW4n6rD3bpxs8
        GNIT8lww39vAumiYanA==
X-Received: by 2002:a17:902:c1d4:b0:1a0:6e4:4936 with SMTP id c20-20020a170902c1d400b001a006e44936mr7081193plc.50.1678790349892;
        Tue, 14 Mar 2023 03:39:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set8yZ/JXG9AkmintN2QHo+Xi6IReYgAxwG3NDZ8v7gkNL/x4GFQqOKgv78q56zNtw9YCH87cWQ==
X-Received: by 2002:a17:902:c1d4:b0:1a0:6e4:4936 with SMTP id c20-20020a170902c1d400b001a006e44936mr7081172plc.50.1678790349453;
        Tue, 14 Mar 2023 03:39:09 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b0019f232619d7sm1428854pla.173.2023.03.14.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 03:39:09 -0700 (PDT)
Date:   Tue, 14 Mar 2023 18:39:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH v3 9/9] vfs: Add tmpfs tests for idmap mounts
Message-ID: <20230314103905.iegn4sqhechxzqew@zlang-mailbox>
References: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
 <20230313190330.94229-10-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313190330.94229-10-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 13, 2023 at 08:03:30PM +0100, Rodrigo Campos wrote:
> This patch calls all tests in the suite s_idmapped_mounts, but with a
> tmpfs directory mounted inside a userns. This directory is setup as the
> mount point for the test that runs nested.
> 
> This excercises that tmpfs mounted inside a userns works as expected
> regarding idmap mounts.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---
>  src/vfs/Makefile                |   4 +-
>  src/vfs/tmpfs-idmapped-mounts.c | 305 ++++++++++++++++++++++++++++++++
>  src/vfs/tmpfs-idmapped-mounts.h |  15 ++
>  src/vfs/utils.h                 |   2 +
>  src/vfs/vfstest.c               |  13 +-
>  tests/tmpfs/001                 |  27 +++
>  tests/tmpfs/001.out             |   2 +
>  tests/tmpfs/Makefile            |  24 +++
>  8 files changed, 389 insertions(+), 3 deletions(-)
>  create mode 100644 src/vfs/tmpfs-idmapped-mounts.c
>  create mode 100644 src/vfs/tmpfs-idmapped-mounts.h
>  create mode 100755 tests/tmpfs/001
>  create mode 100644 tests/tmpfs/001.out
>  create mode 100644 tests/tmpfs/Makefile
> 

[snip]

> diff --git src/vfs/tmpfs-idmapped-mounts.h src/vfs/tmpfs-idmapped-mounts.h
> new file mode 100644
> index 00000000..038d86a9
> --- /dev/null
> +++ src/vfs/tmpfs-idmapped-mounts.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __TMPFS_IDMAPPED_MOUNTS_H
> +#define __TMPFS_IDMAPPED_MOUNTS_H
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#include "utils.h"
> +
> +extern const struct test_suite s_tmpfs_idmapped_mounts;
> +
> +#endif /* __TMPFS_IDMAPPED_MOUNTS_H */
> +
   ^^
A blank line at EOF


> diff --git src/vfs/utils.h src/vfs/utils.h
> index f1681737..872fd96f 100644
> --- src/vfs/utils.h
> +++ src/vfs/utils.h
> @@ -45,6 +45,8 @@
>  #define DIR2 "dir2"
>  #define DIR3 "dir3"

[snip]

> diff --git tests/tmpfs/Makefile tests/tmpfs/Makefile
> new file mode 100644
> index 00000000..b464b22b
> --- /dev/null
> +++ tests/tmpfs/Makefile
> @@ -0,0 +1,24 @@
> +#
> +# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.

Is the copyright what you want?

> +#
> +
> +TOPDIR = ../..
> +include $(TOPDIR)/include/builddefs
> +include $(TOPDIR)/include/buildgrouplist
> +
> +GENERIC_DIR = generic
> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GENERIC_DIR)

Above two lines are wrong, that'll cause tmpfs/001 can't be installed correctly.
You can change them to:
  TMPFS_DIR = tmpfs
  TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(TMPFS_DIR)

Thanks,
Zorro

> +DIRT = group.list
> +
> +default: $(DIRT)
> +
> +include $(BUILDRULES)
> +
> +install:
> +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> +	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> +
> +# Nothing.
> +install-dev install-lib:
> -- 
> 2.39.2
> 

