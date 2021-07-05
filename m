Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C48C07E9B
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 11:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD686135A
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 11:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhGELHV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Jul 2021 07:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231151AbhGELHV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Jul 2021 07:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625483084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWoYsoJKjzGjmREgIM/MeAqTL/TGcpKq1kT+5WO3HwA=;
        b=abNXFzRpNnlLGBsAjs3mdWIRHvocO3f7SezYtuqZFqGgLXYLEsx65xp5ni2f6FBCDoWtRX
        +4tve4owsR4kEORSxWGU3fKiinQ8M+rGkyC6IOa5nW1a1QQdi4ldK/kOaWYhxvgA/IstdP
        LWbycuLHAS6OL0Q1JFHTGFrh6W0pah8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-JWP-3vYhOjuLWZg8kyI_Dw-1; Mon, 05 Jul 2021 07:04:40 -0400
X-MC-Unique: JWP-3vYhOjuLWZg8kyI_Dw-1
Received: by mail-pf1-f197.google.com with SMTP id 11-20020a62150b0000b029031c6298f275so2925577pfv.14
        for <fstests@vger.kernel.org>; Mon, 05 Jul 2021 04:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=LWoYsoJKjzGjmREgIM/MeAqTL/TGcpKq1kT+5WO3HwA=;
        b=IRbGRBfQN9zfx6wu7SZ1mMOcX7ZQSzaN5YHXpa7A9DIX8Z/Mjdckr78sJjQuvbBNT2
         auqPcnZxCd/cTyyYQXOB3UmFLvq+rGgbBlTjG1BQdccDEjpxoIyf0kZd4JgGDHbN57uB
         YgIP8IDI1yBRSQN5FkM8r0D8TT+34taBpJKYbLeBnaMVNouAGrU+cGqWgCHME2Y3Kyv1
         px3JwGMW83g35o6XkuQsrC/kc2V9pFaVD1aX0WRLfHDN+U/klgymoSXLC7TVtjTgFbM6
         lI5ffizs328TQ4MvpKRk207nPT4hwizcX6N4gWEI4DBaG23oZM5FQzy0KCihAYKW9GoR
         R4ag==
X-Gm-Message-State: AOAM530nIWxbwT0KYEibYT2py2ffi0+Ps44sH0mhSa83/DbLMcgYSNAq
        d+pOCqwkRjC0/EAVzdzeAXd9zcVLmQlhQKuL5PtIlkJ50fFipYzEN7+46Sx+lNrqzbqlj56hV2N
        GXOWfadwZ/SGTPk7mGg==
X-Received: by 2002:a63:d60b:: with SMTP id q11mr15024342pgg.270.1625483079859;
        Mon, 05 Jul 2021 04:04:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylD8JExfwrAvDe9yD1C293Dowb93S+gceEWN0cPC/R685ommzkTrNTFNV9mj745QWDvFYwHQ==
X-Received: by 2002:a63:d60b:: with SMTP id q11mr15024322pgg.270.1625483079623;
        Mon, 05 Jul 2021 04:04:39 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a31sm13995142pgm.73.2021.07.05.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 04:04:39 -0700 (PDT)
Date:   Mon, 5 Jul 2021 19:04:34 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        aweits@rit.edu, dhowells@redhat.com, willy@infradead.org
Subject: Re: [PATCH v3] generic: add a test to ensure that page is properly
 filled before write
Message-ID: <20210705110434.wlc2gooeykoc6xcj@fedora>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        aweits@rit.edu, dhowells@redhat.com, willy@infradead.org
References: <20210702134024.24233-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702134024.24233-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 02, 2021 at 09:40:24AM -0400, Jeff Layton wrote:
> We had a broken optimization in cephfs and netfs lib that could cause
> part of a page to be improperly zeroed-out when writing to an offset
> that was beyond the EOF but in an existing page.
> 
> Add a simple test that would have caught this.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  tests/generic/639     | 39 +++++++++++++++++++++++++++++++++++++++
>  tests/generic/639.out |  5 +++++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/generic/639
>  create mode 100644 tests/generic/639.out
> 
> v3: adapt to new test template
> 
> diff --git a/tests/generic/639 b/tests/generic/639
> new file mode 100755
> index 000000000000..c30f7644a2fc
> --- /dev/null
> +++ b/tests/generic/639
> @@ -0,0 +1,39 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021, Jeff Layton <jlayton@redhat.com>
> +#
> +# FS QA Test No. 639
> +#
> +# Open a file and write a little data to it. Unmount (to clean out the cache)
> +# and then mount again. Then write some data to it beyond the EOF and ensure
> +# the result is correct.
> +#
> +# Prompted by a bug in ceph_write_begin that was fixed by commit 827a746f405d.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +
> +testfile="$TEST_DIR/test_write_begin.$$"
> +
> +# write some data to file and fsync it out
> +$XFS_IO_PROG -f -c "pwrite -q 0 32" $testfile

Looks good to me, if you've used this case to reproduce that issue.

Just one question, the comment says "fsync it out", does that mean we need an
explicit "fsync" call (e.g. -c "pwrite -q 0 32" -c "fsync") to reproduce this
bug? Or there's an implicit "fsync" somewhere?

Thanks,
Zorro

> +
> +# cycle the mount to clean out the pagecache
> +_test_cycle_mount
> +
> +# now, write to the file (near the end)
> +$XFS_IO_PROG -c "pwrite -q 32 32" $testfile
> +
> +# dump what we think is in there
> +echo "The result should be 64 bytes filled with 0xcd:"
> +hexdump -C $testfile
> +
> +status=0
> +exit
> diff --git a/tests/generic/639.out b/tests/generic/639.out
> new file mode 100644
> index 000000000000..9bf0bac96864
> --- /dev/null
> +++ b/tests/generic/639.out
> @@ -0,0 +1,5 @@
> +QA output created by 639
> +The result should be 64 bytes filled with 0xcd:
> +00000000  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> +*
> +00000040
> -- 
> 2.31.1
> 

