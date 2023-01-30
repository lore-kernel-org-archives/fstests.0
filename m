Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53036C54EED
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjA3QFE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 11:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjA3QE6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 11:04:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8B93D4
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 08:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675094649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0yql6QJ/eptVhI+ychK/69PZAqvj0bG1iWTWB4Epaw=;
        b=EDwAYdFS8U06NW41M+2w3bDV2QjT1IqBpLUzfXSUPDz+sx3y50VblJG9JV/MWqHbNnnyyX
        n/8mPhwPO8gnRSA1ltx2+pXvz1hANro6l1s3nM4pTQBES6QLHLQZCH2OhmvsnDF4RF870p
        iX8iJ7l8uPYVFlKIigapvZMZuiebtqw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-511-dDmNApqZPH6yusIxgQbWaw-1; Mon, 30 Jan 2023 11:04:07 -0500
X-MC-Unique: dDmNApqZPH6yusIxgQbWaw-1
Received: by mail-pf1-f200.google.com with SMTP id v11-20020a62a50b000000b00593b72f9027so1720279pfm.20
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 08:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0yql6QJ/eptVhI+ychK/69PZAqvj0bG1iWTWB4Epaw=;
        b=n++vKHfkOcsENe3RSpCFeV5URZd+W/LuSvafJrg/73d74P+VxvQ+gxo/oGqthv67WI
         V2B0mS04gGHwNDD6pofr1XV1sPj6bM26InDi9rlo5VA1zcwMLJVwXSNIqDZK7rb4jooE
         jBSR5FwezAEgjkKMFN+tPKxghsfLrmxBYuDy3yUOkZeGQxYXaH9FmWZghg4ULdtnGqO6
         XKJKXMbizsMjFhA8SbPg8CrX+4lk38Rqo6gaEkHQODA79KRCGgHgriomj2JW5lRHbv4h
         ESUom4xXNidR3tuwJarsRRv+n2xxYl6Iih9Bw5+V/hHMCuREVudeZmUc4dVExxjE/IoQ
         7kug==
X-Gm-Message-State: AO0yUKUQ5tfN/FvUcrT979gVwbyIv4TJexfCeDPDzL17pZuWLX33DOB+
        DKMJEsobNNHlbVzz8KVu2w9SCl48MjIOmZ6Xpnaiz1bL/yAOz+P2yoSsMDSaLsPS7D4Cq+gojTi
        x1nbVynLw5DcoNQqigg==
X-Received: by 2002:a05:6a21:6d84:b0:bc:e7c0:7d99 with SMTP id wl4-20020a056a216d8400b000bce7c07d99mr5941434pzb.10.1675094646602;
        Mon, 30 Jan 2023 08:04:06 -0800 (PST)
X-Google-Smtp-Source: AK7set9tcrCh6is2LYtHSzTVdk0ZukZiK4TPlx5OsvTiE6GLgdPDldLpW7joOYR8RW4A5k6w57ypFg==
X-Received: by 2002:a05:6a21:6d84:b0:bc:e7c0:7d99 with SMTP id wl4-20020a056a216d8400b000bce7c07d99mr5941394pzb.10.1675094645964;
        Mon, 30 Jan 2023 08:04:05 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h6-20020a62b406000000b0056d7cc80ea4sm7611550pfn.110.2023.01.30.08.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:04:05 -0800 (PST)
Date:   Tue, 31 Jan 2023 00:04:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org, Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [PATCH v2] generic/707: Test moving directory while being grown
Message-ID: <20230130160401.aeqxpsn5ndbhiraf@zlang-mailbox>
References: <20230130145639.30027-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130145639.30027-1-jack@suse.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 30, 2023 at 03:56:39PM +0100, Jan Kara wrote:
> Test how the filesystem can handle moving a directory to a different
> directory (so that parent pointer gets updated) while it is grown. Ext4
> and UDF had a bug where if the directory got converted to a different
> type due to growth while rename is running, the filesystem got
> corrupted.
> 
> Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  tests/generic/707     | 63 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/707.out |  2 ++
>  2 files changed, 65 insertions(+)
>  create mode 100755 tests/generic/707
>  create mode 100644 tests/generic/707.out
> 
> Changes since v1:
> * Added TIME_FACTOR multiplier
> * Handle background process in _cleanup
> * Use absolute paths where possible
> 
> diff --git a/tests/generic/707 b/tests/generic/707
> new file mode 100755
> index 000000000000..d1d299563813
> --- /dev/null
> +++ b/tests/generic/707
> @@ -0,0 +1,63 @@
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
    ^
A trailing whitespace at here :)


> +. ./common/preamble
> +_begin_fstest auto
> +
> +_supported_fs generic
> +_require_scratch
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +_cleanup()
> +{
> +	if [ -n "$BGPID" ]; then
> +		# Stop background process
> +		kill -9 $BGPID &>/dev/null
> +		wait
> +	fi

Neet to keep the code in common/preamble:_cleanup(), if you cover it:

        cd /
        rm -f $tmp.*

especially you use pushd and popd.

I forgot to ask, is this case written for someone known fix or change? If so,
better to use _fixed_by_kernel_commit or _wants_kernel_commit.

> +}
> +
> +# Loop multiple times trying to hit the race
> +loops=$((100*TIME_FACTOR))
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
> +	mkdir $SCRATCH_MNT/dir$i
> +done
> +
> +for (( l = 0; l < $loops; l++ )); do
> +	mkdir $SCRATCH_MNT/dir0/dir
> +	pushd $SCRATCH_MNT/dir0/dir &>/dev/null
> +	create_files &
> +	BGPID=$!
> +	popd &>/dev/null
> +	for (( i = 0; i < $moves; i++ )); do
> +		mv $SCRATCH_MNT/dir$i/dir $SCRATCH_MNT/dir$((i+1))/dir
> +	done
> +	wait
> +	BGPID=""

unset BGPID might be better, but anyway :)

Others looks good to me.

Thanks,
Zorro

> +	rm -r $SCRATCH_MNT/dir$moves/dir
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

