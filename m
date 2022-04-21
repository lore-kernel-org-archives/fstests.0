Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EDCC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 05:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384513AbiDUFoU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 01:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbiDUFoT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 01:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4218E12748
        for <fstests@vger.kernel.org>; Wed, 20 Apr 2022 22:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650519690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=696Tjo9pEdNveBEZCNvoCiykYH3c+8q/Jnxg6WKB5lg=;
        b=iMvz78fTjUknUFbnIfRZRYa133EOALfajZwc4HowHta/x8xQJvn2vis4cXaR+gC8kBxS0d
        a88oENfw1oOP36JPpaKxy0pBoskJnOjIwzkC9Os1RNlDkrKYFijgJ+45uCaP7PFibm4Jhu
        U9glaIcYfLKHoFAeYTBHcSW0VllAPAg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-Ev6_0trgOqWGP0ybLVzf2A-1; Thu, 21 Apr 2022 01:41:28 -0400
X-MC-Unique: Ev6_0trgOqWGP0ybLVzf2A-1
Received: by mail-qv1-f72.google.com with SMTP id bt18-20020ad455d2000000b004465db1865dso3155235qvb.11
        for <fstests@vger.kernel.org>; Wed, 20 Apr 2022 22:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=696Tjo9pEdNveBEZCNvoCiykYH3c+8q/Jnxg6WKB5lg=;
        b=UQYfLUHFEBfr1a/jIeaG/7ToEokoFD8tgDmOkTjN3fk7v8knJxGXGxYqNWsybndyV5
         3f5jXBr+/sSAvngyQYlJRujHkQ6tjK2BUwIpfm1xbGGvT5AxS0bOGOiqPP49pstMp3V/
         pmKVsl/JxCmRR8cOM/yPbE5KLgz9yywZg1wNzpGDZAf96UmYZITtwtyA+N8zxiI71/Q6
         cRs13wH0O2LloHq/FjH/YT3MvSgtx6lODG7QWqwvOI1kIns4o/MDdCjUPgcNCxXEHteR
         rN4WTpHlsCWqPbv5MolgiuyBJJHsgSrE5+DPs/OIukGPPPTtGvj34jjZFYqTs0Ze7QNU
         Pozw==
X-Gm-Message-State: AOAM531OIfi96IZBqIfcMn2bk/piTAcNSKnyo2ClaBYl5Qky+ozFxcbk
        fUsDYY8dNNeLFBJ1TY7qxvUysw+o+3YarCgPImZ/ACy+vkzIU2PgwRLBtB4k3tC+sDyitEX+Ujp
        78uv7bCxjdwEJakvR1Q==
X-Received: by 2002:ac8:4e81:0:b0:2f3:4a7b:2282 with SMTP id 1-20020ac84e81000000b002f34a7b2282mr1340013qtp.474.1650519688226;
        Wed, 20 Apr 2022 22:41:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkl2uIqobQSt1oqlQGTdQhJSb68WWX/iiDQPfHjeXs1BA1gFCaIgvoICZ4XRNRHxB0m/L3WA==
X-Received: by 2002:ac8:4e81:0:b0:2f3:4a7b:2282 with SMTP id 1-20020ac84e81000000b002f34a7b2282mr1340005qtp.474.1650519688010;
        Wed, 20 Apr 2022 22:41:28 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a138e00b002f335c3dbf2sm2937015qtk.37.2022.04.20.22.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 22:41:27 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:41:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
Message-ID: <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org
References: <20220419131423.2367795-1-brauner@kernel.org>
 <20220420175221.2502964-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420175221.2502964-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 20, 2022 at 07:52:22PM +0200, Christian Brauner wrote:
> Add a regression test for commit 705191b03d50 ("fs: fix acl translation").
> This tests whether setting POSIX ACLs on a tmpfs mounted in a
> non-initial user and mount namespace works as expected.
> 
> Note, once again the idmapped mount testsuite is grossly misnamed at
> this point. It has morphed into a full-blown generic vfs feature
> testsuite.

Hi,

Good to know that, the idmapped-mounts things already been extended to 15k+
lines[1] code, it's even much more than the unionmount-testsuite[2]. So I
think it's time to think about shifting it from fstests/src to be an independent
testsuit, we can learn what 35c7a37928fd ("overlay: run unionmount testsuite test
cases") did, maintain idmapped-mounts testsuite outside, then let fstests to be a
wrapper to run it.


[1]
$ wc -l src/idmapped-mounts/*.[ch]
 14113 src/idmapped-mounts/idmapped-mounts.c
   151 src/idmapped-mounts/missing.h
   201 src/idmapped-mounts/mount-idmapped.c
   425 src/idmapped-mounts/utils.c
   130 src/idmapped-mounts/utils.h
 15020 total

[2]
https://github.com/amir73il/unionmount-testsuite

> 
> Cc: Eryu Guan <guaneryu@gmail.com>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Zorro Lang <zlang@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
> Hey,
> 
> As promised yesterday in
> https://lore.kernel.org/linux-fsdevel/20220419131423.2367795-1-brauner@kernel.org
> this adds a regression test to xfstests.
> 
> Thanks!
> Christian
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 140 +++++++++++++++++++++++++-
>  tests/generic/683                     |  32 ++++++
>  tests/generic/683.out                 |   2 +
>  3 files changed, 173 insertions(+), 1 deletion(-)
>  create mode 100755 tests/generic/683
>  create mode 100644 tests/generic/683.out
> 

[snip]

> diff --git a/tests/generic/683 b/tests/generic/683
> new file mode 100755
> index 00000000..397548ed
> --- /dev/null
> +++ b/tests/generic/683
> @@ -0,0 +1,32 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
> +#
> +# FS QA Test No. 683
> +#
> +# Test that setting POSIX ACLs in userns-mountable filesystems works.
> +#
> +# Regression test for commit:
> +#
> +# 705191b03d50 ("fs: fix acl translation")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick perms
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_require_test

Better to have _require_idmapped_mounts at here. I'd like to leave idmapped-mounts.c
part for vfs reviewing.

Thanks for this new testing coverage,
Zorro

> +_require_user fsgqa
> +_require_group fsgqa
> +
> +echo "Silence is golden"
> +
> +$here/src/idmapped-mounts/idmapped-mounts --test-setxattr-fix-705191b03d50 \
> +	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
> +
> +status=$?
> +exit
> diff --git a/tests/generic/683.out b/tests/generic/683.out
> new file mode 100644
> index 00000000..7f2a2ace
> --- /dev/null
> +++ b/tests/generic/683.out
> @@ -0,0 +1,2 @@
> +QA output created by 683
> +Silence is golden
> 
> base-commit: fbc6486be09c93a68d3863ebf7e3ed851fc4721c
> -- 
> 2.32.0
> 

