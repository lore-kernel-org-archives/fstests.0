Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35A3C05027
	for <linux-fstests@archiver.kernel.org>; Thu, 26 Jan 2023 15:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjAZPic (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 Jan 2023 10:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAZPib (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Jan 2023 10:38:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C9BEC7A
        for <fstests@vger.kernel.org>; Thu, 26 Jan 2023 07:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674747463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJNMiph/+boJd+n7sUBbDLii5PmpMUUjIqWdM5FlBB0=;
        b=AGvExnEwG49znEADPPckzcHrnlZNBSNGGMBYSX89Jd5qpugPzyYj+Kl0wyCYabKXa7yXsD
        b2ZowS3RbgkodFvfc7v3En9dfXC+TcbxcFdO0Lt45YJBLMEcy2rGKqyP9j9RLMMcA1q5OT
        GjjtkUmnJj3PIJrO/5v8+m05ZRHiC74=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-k64fLzoIMueYkfZQAcoiPw-1; Thu, 26 Jan 2023 10:37:40 -0500
X-MC-Unique: k64fLzoIMueYkfZQAcoiPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2A993C01DF0;
        Thu, 26 Jan 2023 15:37:39 +0000 (UTC)
Received: from redhat.com (unknown [10.22.16.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9F8D2026D4B;
        Thu, 26 Jan 2023 15:37:39 +0000 (UTC)
Date:   Thu, 26 Jan 2023 09:37:38 -0600
From:   Bill O'Donnell <billodo@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/707: Test moving directory while being grown
Message-ID: <Y9KeQrgMktFoKUZr@redhat.com>
References: <20230126151512.5438-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126151512.5438-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 26, 2023 at 04:15:12PM +0100, Jan Kara wrote:
> Test how the filesystem can handle moving a directory to a different
> directory (so that parent pointer gets updated) while it is grown. Ext4
> and UDF had a bug where if the directory got converted to a different
> type due to growth while rename is running, the filesystem got
> corrupted.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks fine to me.

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  tests/generic/707     | 54 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/707.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/generic/707
>  create mode 100644 tests/generic/707.out
> 
> diff --git a/tests/generic/707 b/tests/generic/707
> new file mode 100755
> index 000000000000..25cbb7e98a23
> --- /dev/null
> +++ b/tests/generic/707
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Jan Kara, SUSE Linux.  All Rights Reserved.
> +#
> +# FS QA Test 707
> +#
> +# This is a test verifying whether the filesystem can gracefully handle
> +# modifying of a directory while it is being moved, in particular the cases
> +# where directory format changes
> +# 
> +. ./common/preamble
> +_begin_fstest auto
> +
> +_supported_fs generic
> +_require_scratch
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +cd $SCRATCH_MNT
> +
> +# Loop multiple times trying to hit the race
> +loops=100
> +files=500
> +moves=500
> +
> +create_files()
> +{
> +	# We use slightly longer file name to make directory grow faster and
> +	# hopefully convert between various types
> +	for (( i = 0; i < $files; i++ )); do
> +		touch somewhatlongerfilename$i
> +	done
> +}
> +
> +for (( i = 0; i <= $moves; i++ )); do
> +	mkdir dir$i
> +done
> +
> +for (( l = 0; l < $loops; l++ )); do
> +	mkdir dir0/dir
> +	pushd dir0/dir &>/dev/null
> +	create_files &
> +	popd &>/dev/null
> +	for (( i = 0; i < $moves; i++ )); do
> +		mv dir$i/dir dir$((i+1))/dir
> +	done
> +	wait
> +	rm -r dir$moves/dir
> +done
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/707.out b/tests/generic/707.out
> new file mode 100644
> index 000000000000..8e57a1d8c971
> --- /dev/null
> +++ b/tests/generic/707.out
> @@ -0,0 +1,2 @@
> +QA output created by 707
> +Silence is golden
> -- 
> 2.35.3
> 

