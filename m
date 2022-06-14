Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC124C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jun 2022 04:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348730AbiFNEZd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jun 2022 00:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350513AbiFNEZb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2022 00:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E50AB2B264
        for <fstests@vger.kernel.org>; Mon, 13 Jun 2022 21:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655180726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ML6JUChcTgBAwbw3aaoIPFDSr9wvt2wuxs4NnpCqNM=;
        b=RrkLYyDrUFPOQiisu9Cr6MF/RN6lQJu7cuA5ElXHNSsw+RhFolFWspf7mXdFoRQaWfFITE
        CN3RBMQQ4mXHVd03KrsSsZuhvE99QJK+QJvSoK0tVzNE2zJBXeQ0AGqQRgfsdAcMKQ2WCF
        EXGG4sKkYrJHlKx9q2YnE4I/xdvag0I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-6RP59y46Oiu93LxtxFpC8Q-1; Tue, 14 Jun 2022 00:25:25 -0400
X-MC-Unique: 6RP59y46Oiu93LxtxFpC8Q-1
Received: by mail-qk1-f200.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so6580195qkb.23
        for <fstests@vger.kernel.org>; Mon, 13 Jun 2022 21:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ML6JUChcTgBAwbw3aaoIPFDSr9wvt2wuxs4NnpCqNM=;
        b=cjxMsYjxEhrukjvx2qehRgLsUapsWBv7eUym7+PqC5dfb5Hvi+aPEsAQWaBItxfM2Z
         d/oA5vq1yd6waMGsAxukW07AFiLnA3+Cl8Yz4fSjxB+SmkPrYVsVxciMHHdQZJODSOnc
         FgfWkQPjNW6+hVDegPJgx7RsI8Nx/OgSBkiZ7BpdrClXVLIXorW2kl6MaVX0+gHoB6Rt
         +XgVFItAmtslOymJ6/a/1g5jVTXv09q4wvthW77yNw7k6tX0gUZFTjF6QI9eIllmNsA3
         KszCqb0ZrYFqeTJNxeIIygKSL0gSAYjAypVPEsy9Gf8txa4YJSxMggzGYVipDCu6pXmU
         M32w==
X-Gm-Message-State: AOAM531MWRO/KfzNBbFXL8ca1Gmzf02xnTc+9YcIUbdTBBhd5Gc/GMEK
        bzvaKNYh6LqvdKqDsNszolzF/yOTQrgwroaPVmPq0H/NsgesLERYKFBOOqF7uTmJymhicfeeriL
        4B8KxmSTSrY+hcgn/lg==
X-Received: by 2002:a05:622a:489:b0:305:1e7f:53cf with SMTP id p9-20020a05622a048900b003051e7f53cfmr2584248qtx.605.1655180724349;
        Mon, 13 Jun 2022 21:25:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuRnkSLwnIfoHQe+MMkHH4Ge9SbVh0boAjP3FdZ8kkPuMOXpK6m+R7e9j/AOgbn7HBwSyxQw==
X-Received: by 2002:a05:622a:489:b0:305:1e7f:53cf with SMTP id p9-20020a05622a048900b003051e7f53cfmr2584238qtx.605.1655180724097;
        Mon, 13 Jun 2022 21:25:24 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z17-20020ae9c111000000b006a6f68c8a87sm7756844qki.126.2022.06.13.21.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 21:25:23 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:25:16 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] generic/692: test group ownership change
Message-ID: <20220614042516.a6eyaajeiyg6irbh@zlang-mailbox>
References: <20220613152314.2235940-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613152314.2235940-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 13, 2022 at 05:23:14PM +0200, Christian Brauner wrote:
> When group ownership is changed a caller whose fsuid owns the inode can
> change the group of the inode to any group they are a member of. When
> searching through the caller's groups we failed to use the gid mapped
> according to the idmapped mount otherwise we fail to change ownership.
> Add a test for this.
> 
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: <fstests@vger.kernel.org>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---

Thanks for this test, a few of small review points as below ...

>  tests/generic/692     | 74 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/692.out |  3 ++
>  2 files changed, 77 insertions(+)
>  create mode 100755 tests/generic/692
>  create mode 100644 tests/generic/692.out
> 
> diff --git a/tests/generic/692 b/tests/generic/692
> new file mode 100755
> index 00000000..825c836a
> --- /dev/null
> +++ b/tests/generic/692
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
> +#
> +# FS QA Test 692
> +#
> +# Test that users can changed group ownership of a file they own to a group
> +# they are a member of.
> +#
> +# Regression test for commit:
> +#
> +# 263de29d8397 ("fs: account for group membership")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick perms attr idmapped mount
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	$UMOUNT_PROG $TEST_DIR/target-mnt

Do you need to filter out the errors by "2>/dev/null"?

> +	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +# . ./common/filter

I think you didn't use any filter, right? If so, this can be removed.

> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
     ^^^
This line can be removed too.

> +_supported_fs generic
> +_require_test
> +_require_chown
> +_require_idmapped_mounts
> +_require_user fsgqa
> +_require_group fsgqa
> +_require_group fsgqa2
> +
> +uqid=`id -u fsgqa`
> +gqid=`id -g fsgqa`
> +uqid2=`id -u fsgqa2`
> +gqid2=`id -g fsgqa2`
> +
> +setup_tree()
> +{
> +	mkdir -p $TEST_DIR/source-mnt
> +	chmod 0777 $TEST_DIR/source-mnt
> +	touch $TEST_DIR/source-mnt/dir1
> +	chown 65534:65534 $TEST_DIR/source-mnt
> +	chown 65534:65535 $TEST_DIR/source-mnt/dir1
> +
> +	mkdir -p $TEST_DIR/target-mnt
> +	chmod 0777 $TEST_DIR/target-mnt
> +}
> +
> +setup_idmapped_mnt()
> +{
> +	$here/src/vfs/mount-idmapped \

You might need:
  _require_test_program "vfs/mount-idmapped"

due to _require_idmapped_mounts doesn't guarantee that.

Thanks,
Zorro

> +		--map-mount=u:65534:$uqid:1 \
> +		--map-mount=g:65534:$gqid:1 \
> +		--map-mount=u:65535:$uqid2:1 \
> +		--map-mount=g:65535:$gqid2:1 \
> +		$TEST_DIR/source-mnt $TEST_DIR/target-mnt
> +}
> +
> +setup_tree
> +setup_idmapped_mnt
> +stat -c '%U:%G' "$TEST_DIR/target-mnt/dir1"
> +_user_do "chgrp $gqid $TEST_DIR/target-mnt/dir1"
> +stat -c '%U:%G' "$TEST_DIR/target-mnt/dir1"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/692.out b/tests/generic/692.out
> new file mode 100644
> index 00000000..c963f7f4
> --- /dev/null
> +++ b/tests/generic/692.out
> @@ -0,0 +1,3 @@
> +QA output created by 692
> +fsgqa:fsgqa2
> +fsgqa:fsgqa
> 
> base-commit: 568ac9fffeb6afec03e5d6c9936617232fd7fc6d
> -- 
> 2.34.1
> 

