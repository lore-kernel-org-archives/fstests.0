Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F7C77B7D
	for <linux-fstests@archiver.kernel.org>; Wed, 10 May 2023 12:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbjEJMqK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 10 May 2023 08:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbjEJMqJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 May 2023 08:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2CEE5D
        for <fstests@vger.kernel.org>; Wed, 10 May 2023 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683722722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlfXvFTTYNBYEhaE1u958kYZLZR0hq9KH8C895ArNdI=;
        b=NFZ+36LuDunFx0VKcDqKnwXGGLwVeFJSKDUd1mXbpTQw9RGjkXojygM+yH9SsNyzSDQWZy
        PT+Sp1GHwDz9jZD8du8nnpHYd5U7tbEIzOWlePg20xJYixg+OCYviZurE2lFo9MyC5l5Ua
        kpIEs8bXuuV5wxmcSQCnwwEFfGTAaHw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-gI0S7N9BPCK10Tsf3x6Gmg-1; Wed, 10 May 2023 08:45:18 -0400
X-MC-Unique: gI0S7N9BPCK10Tsf3x6Gmg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-24e1d272afaso3859883a91.3
        for <fstests@vger.kernel.org>; Wed, 10 May 2023 05:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683722716; x=1686314716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlfXvFTTYNBYEhaE1u958kYZLZR0hq9KH8C895ArNdI=;
        b=acsBFJ1wkERJ6lvIMQl255VCXPrYuHEKnU4oC79MlCjDolBp/E4zWEfbvvvX2V7SAS
         VyfM+x3xS99gr0yr6rg6djumkZx74y7DwtCihA4Dzgn+waoigvHmcEtubQR7OEqfqWOb
         ZLddTMqeuUGgqg1ASxcKK22vN7vGI89P4G0XWvnkEqwQnWJyTWOkFXCkYFEO9++wdwjW
         Lsxrbp2W19xJ+OiliacJp7B9tzGY9fXvAqdAVMmjqdZTw5mmqmisHMlttHFtvaH//F5D
         Meh6onftG6NmMdnHBwc6HGmDrzj7O2Q5Rvc2CpLlun9xxkEAJ8Vw1J26PuE2RXi1t1BL
         yI5A==
X-Gm-Message-State: AC+VfDz5fupczvw6Xb3uPloXXGY6cRU/Bx8Y1FSBAXiu6ZOnEwzBN25r
        JEwdjZh1iym0HPzekw9jpU3+XHu5dxS+3pbUSaf8ziYlMFIdhAbEYsrm1gItKl5QehU+wSi6qxK
        J8U/j9yF4zjcsoBuQROxBtaUPzILw
X-Received: by 2002:a17:90b:342:b0:24e:3b7b:ca3 with SMTP id fh2-20020a17090b034200b0024e3b7b0ca3mr16974973pjb.20.1683722716390;
        Wed, 10 May 2023 05:45:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56/2hFm5Z89VwspNMTSPgJBgw37CrONay/Ky5mFExV+LCN1cXx7LqJzqSFDr4JrMQfboeNiQ==
X-Received: by 2002:a17:90b:342:b0:24e:3b7b:ca3 with SMTP id fh2-20020a17090b034200b0024e3b7b0ca3mr16974951pjb.20.1683722715912;
        Wed, 10 May 2023 05:45:15 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090ac08f00b0024b79a69361sm13503296pjs.32.2023.05.10.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 05:45:15 -0700 (PDT)
Date:   Wed, 10 May 2023 20:45:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/728: Add a test for xattr ctime updates
Message-ID: <20230510124511.wcgy63menqywvt34@zlang-mailbox>
References: <20230505172427.94963-1-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505172427.94963-1-anna@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 05, 2023 at 01:24:27PM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> The NFS client wasn't updating ctime after a setxattr request. This is a
> test written while fixing the bug.
> 
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> ---
> v2:
>  - Move test to generic/
>  - Address comments from the mailing list
> ---
>  tests/generic/728     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/728.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/generic/728
>  create mode 100644 tests/generic/728.out
> 
> diff --git a/tests/generic/728 b/tests/generic/728
> new file mode 100755
> index 000000000000..ab2414c151db
> --- /dev/null
> +++ b/tests/generic/728
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> +#
> +# FS QA Test 728
> +#
> +# Test a bug where the NFS client wasn't sending a post-op GETATTR to the
> +# server after setting an xattr, resulting in `stat` reporting a stale ctime.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +# Import common functions
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_attrs
> +
> +rm -rf $TEST_DIR/testfile
> +touch $TEST_DIR/testfile
> +
> +
> +_check_xattr_op()
> +{
> +  what=$1
> +  shift 1
> +
> +  before_ctime=$(stat -c %z $TEST_DIR/testfile)
> +  $SETFATTR_PROG $* $TEST_DIR/testfile

Hi Anna,

If there's not objection from you, I'll add below codes at here, and merge
this case in next fstests release:

+       # There might be filesystem's timestamp granularity, so sleep 2 seconds
+       # for most filesystems can capture a different timestamp across a
+       # setxattr operation
+       sleep 2s

BTW, is there a known git commit which fix the issue of this case trying to
test?

Thanks,
Zorro

> +  after_ctime=$(stat -c %z $TEST_DIR/testfile)
> +
> +  test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change after $what."
> +}
> +
> +_check_xattr_op setxattr -n user.foobar -v 123
> +_check_xattr_op removexattr -x user.foobar
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/728.out b/tests/generic/728.out
> new file mode 100644
> index 000000000000..ab39f45fe5da
> --- /dev/null
> +++ b/tests/generic/728.out
> @@ -0,0 +1,2 @@
> +QA output created by 728
> +Silence is golden
> -- 
> 2.40.1
> 

