Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD02C54EED
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjA3QMk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 11:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjA3QMk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 11:12:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47D29435
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 08:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675095112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BbNO2wiN2xEhmeOfyZPdVWY2NH3G2A9MFIejRpSF550=;
        b=AYT2ShJ057ZILqaV4TQtqD1ZIbN6zxfZwUTXO/A1U3saAbC9ouXml6IuuMZIgXK3Thd6ih
        MoXcoZWcR2OweAHpW9Ko6rSbManiHpUP9XBsLnfumIrRsfLt6BopgqvCEh3yd/txcegjXG
        dl4JoRbkNjgyC9XSOc43O//AAT64PXQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-xAgq-nsBO4CU_4Gh5ZZMDA-1; Mon, 30 Jan 2023 11:11:49 -0500
X-MC-Unique: xAgq-nsBO4CU_4Gh5ZZMDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FFEE858F09;
        Mon, 30 Jan 2023 16:11:49 +0000 (UTC)
Received: from redhat.com (unknown [10.22.16.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27E5E2026D4B;
        Mon, 30 Jan 2023 16:11:49 +0000 (UTC)
Date:   Mon, 30 Jan 2023 10:11:47 -0600
From:   Bill O'Donnell <billodo@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/707: Test moving directory while being grown
Message-ID: <Y9fsQyWe9bVr5XIT@redhat.com>
References: <20230130145639.30027-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130145639.30027-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

With Zoro's suggested changes, this looks fine.

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

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

