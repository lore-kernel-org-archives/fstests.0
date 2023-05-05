Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE37C77B7D
	for <linux-fstests@archiver.kernel.org>; Fri,  5 May 2023 04:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjEEEpx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 May 2023 00:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEEEpx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 May 2023 00:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E38124A4
        for <fstests@vger.kernel.org>; Thu,  4 May 2023 21:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683261905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dtinxNP6pyEAADcAheaRiWg2W9bzRumM0aISKTp3vB4=;
        b=BFCfv/UHnq9ratDXNpnd2JIWsir4lkQSlvMcJmBJvuphZtomcE9huihaxiuJ6KJNaVpU9h
        tc6TD1kSq3uk2Yw1pebE0qnsFR+BhQKVjj/7guFpyV1zEE4IuPlkkjsrnIukgDQ36HgYYT
        EOuyGThtB1y9qilHpvb5gzbpoC+GyIU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-bLAtRPP4MV22tLB3lQGs7Q-1; Fri, 05 May 2023 00:45:04 -0400
X-MC-Unique: bLAtRPP4MV22tLB3lQGs7Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24df4ef0603so643659a91.2
        for <fstests@vger.kernel.org>; Thu, 04 May 2023 21:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683261903; x=1685853903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtinxNP6pyEAADcAheaRiWg2W9bzRumM0aISKTp3vB4=;
        b=aKq+3eAyw2u7Gkcxu3AqjrlyL1y76yk8o1nS6serfaqUwTH6vqqI3sRhgVjMUM6NOh
         zGDtsfRKbDVZ/yORtDNyPOby7XIKCgW6YEz50/r2TmjQGhCxQLpWPoOQFb6swqKJuU4E
         yZAkOKF511x9TTAP896fmaZOAhdI4bCqsbhFlrnq6DEQ5k1fwBrAuWG3NmNwQyfKcS48
         1ZDUld2J397//GF/YuTfa8MnAA1+5i4ryDqohlVgd7F/NFLBKCUz38zLrpp1HCz0fOpb
         FhuTHU5wyEe80qmt7RTR6ErKX63d1RamllvIWUwfcgvEM3d0OxFxV6JwDiR+lLPpMyca
         VvfA==
X-Gm-Message-State: AC+VfDzZrzBjvDqdgQaKglAzE/JJY+tp4UE25rqS9l9j0tIVVsH1sf5a
        SLHC84uZq5zCso98x/HsHoTeKErpNebIAKQSncckk8nBLYIYpEGfGgbF0BSIztqoB6bg0pqqPB4
        ufIa3nkpRNbeGFB8dLQ==
X-Received: by 2002:a17:90b:4f8e:b0:24f:fdaa:53a8 with SMTP id qe14-20020a17090b4f8e00b0024ffdaa53a8mr153129pjb.37.1683261903160;
        Thu, 04 May 2023 21:45:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ669p8ANY0Serq4RD9to3ecYl3IrYiZldJRvOf6ym7gbyuYh/ea49QCsKWXQ7/IPQAfJ8m3lw==
X-Received: by 2002:a17:90b:4f8e:b0:24f:fdaa:53a8 with SMTP id qe14-20020a17090b4f8e00b0024ffdaa53a8mr153113pjb.37.1683261902785;
        Thu, 04 May 2023 21:45:02 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bg7-20020a1709028e8700b001ab12ccc2a7sm544485plb.98.2023.05.04.21.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:45:02 -0700 (PDT)
Date:   Fri, 5 May 2023 12:44:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] nfs/002: Add a test for xattr ctime updates
Message-ID: <20230505044458.wrvhvamrkcuqin3z@zlang-mailbox>
References: <20230504204847.405037-1-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504204847.405037-1-anna@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 04, 2023 at 04:48:47PM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> The NFS client wasn't updating ctime after a setxattr request. This is a
> test written while fixing the bug.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  tests/nfs/002     | 39 +++++++++++++++++++++++++++++++++++++++
>  tests/nfs/002.out |  2 ++
>  2 files changed, 41 insertions(+)
>  create mode 100755 tests/nfs/002
>  create mode 100644 tests/nfs/002.out
> 
> diff --git a/tests/nfs/002 b/tests/nfs/002
> new file mode 100755
> index 000000000000..5bfedef6c57d
> --- /dev/null
> +++ b/tests/nfs/002
> @@ -0,0 +1,39 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> +#
> +# FS QA Test 002
> +#
> +# Test a bug whene the NFS client wasn't sending a post-op GETATTR to the
> +# server after setting an xattr, resulting in `stat` reporting a stale ctime.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +# Import common functions
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs nfs

Great, a new nfs test case!

> +_require_test_nfs_version 4.2

But I'm wondering if this case can be a generic test case, due to the operations
in this case are common (need xattr and ctime support), don't depend on
any nfs specific features/operations.

Not sure why nfs4.2 is necessary, can it be removed or replaced ?

Thanks,
Zorro

> +_require_attrs
> +
> +touch $TEST_DIR/testfile
> +
> +before_ctime=$(stat -c %z $TEST_DIR/testfile)
> +$SETFATTR_PROG -n user.foobar -v 123 $TEST_DIR/testfile
> +after_ctime=$(stat -c %z $TEST_DIR/testfile)
> +
> +test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
> +
> +
> +before_ctime=$after_ctime
> +$SETFATTR_PROG -x user.foobar $TEST_DIR/testfile
> +after_ctime=$(stat -c %z $TEST_DIR/testfile)
> +
> +test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/nfs/002.out b/tests/nfs/002.out
> new file mode 100644
> index 000000000000..61705c7cc203
> --- /dev/null
> +++ b/tests/nfs/002.out
> @@ -0,0 +1,2 @@
> +QA output created by 002
> +Silence is golden
> -- 
> 2.40.1
> 

