Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E163C636CC
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 14:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjAaO1A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjAaO06 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 09:26:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847B03B3C1
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 06:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675175151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TaPyatPX67P60N36mnNA6Lmoqw6W6e1HQDBwyRXMPA=;
        b=M2621luLN7ERg0U2dKjL/xsHGminvHFQ9PoTg6VsqV2P2biOWhnA6TIZ4LcfFW8Fbdn7YO
        IhE5XQKop5nwhU71tz/+xJ35CIVU36lWxzGMqu+FHb9EjW/KQ2TalzGV4818AZ8X7dDVP7
        UMdaFvzqpKLApSVhlrA/K4QsaxruvLo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-PxKv5xDCMEaAubzQcco8Ug-1; Tue, 31 Jan 2023 09:25:50 -0500
X-MC-Unique: PxKv5xDCMEaAubzQcco8Ug-1
Received: by mail-pl1-f197.google.com with SMTP id y9-20020a1709027c8900b00195e237dc8bso8374227pll.13
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 06:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TaPyatPX67P60N36mnNA6Lmoqw6W6e1HQDBwyRXMPA=;
        b=uUVsNEy5HIF3y149hrjp1TK9Keua6q+NK6bWi82H+PfIfGBnnl/FzIM6KyqbPeAFq9
         8HLuIyQ1QCQGQvejKZEBT41EzD0L3K4UOlVLcmhE2Is2aqNJjBjFpEQeaynGHegbY0xh
         g6KI4X9YpAKxyTPjJ45XG6eDlRMqS8p0bDTo2tQYCbSlkQlLVt1ouB4G7dZGMQFO02sT
         47osJL6SIFfzmquVL8SvJQ088k4VW2yyFXJcCBYWcjmmz6aEccicAQ7Ci6RjGLZJzfjS
         NWBUu0ZH6UqMD4npV0ZwZzKmLKLhvi8h+kupuJzO3P83iNedT5XWLCMmB6AgVIzyti93
         2aNQ==
X-Gm-Message-State: AO0yUKUuvHqmTX3XGoqSASCpJEx+tVIbvlc+QKTiqHEMZGsvKeNr5U4v
        BrBkGHJKHy9Cz5dd2l1k0qePrcWdcbTxWOtv6+Sw4R6EvQnCrFTIvcgDxmZzwIJeJieRRfdh4U6
        c6QxyT09uL4rfNB0M7Q==
X-Received: by 2002:a17:90b:3a83:b0:22c:b9e8:48d with SMTP id om3-20020a17090b3a8300b0022cb9e8048dmr5658391pjb.0.1675175148772;
        Tue, 31 Jan 2023 06:25:48 -0800 (PST)
X-Google-Smtp-Source: AK7set84E5FVXTQpE0YBEfkpCU+i4RFi00P6xmvf5psdAdfHmBoRuXLyani8jMiams9bSJSRJKP+Fw==
X-Received: by 2002:a17:90b:3a83:b0:22c:b9e8:48d with SMTP id om3-20020a17090b3a8300b0022cb9e8048dmr5658372pjb.0.1675175148374;
        Tue, 31 Jan 2023 06:25:48 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s62-20020a17090a69c400b00228e56d375asm8672206pjj.33.2023.01.31.06.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:25:47 -0800 (PST)
Date:   Tue, 31 Jan 2023 22:25:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/707: Test moving directory while being grown
Message-ID: <20230131142544.dwlk7kwdpznatlt3@zlang-mailbox>
References: <20230131125416.16120-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131125416.16120-1-jack@suse.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 31, 2023 at 01:54:16PM +0100, Jan Kara wrote:
> Test how the filesystem can handle moving a directory to a different
> directory (so that parent pointer gets updated) while it is grown. Ext4
> and UDF had a bug where if the directory got converted to a different
> type due to growth while rename is running, the filesystem got
> corrupted.
> 
> Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Thanks, this version looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/707     | 70 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/707.out |  2 ++
>  2 files changed, 72 insertions(+)
>  create mode 100755 tests/generic/707
>  create mode 100644 tests/generic/707.out
> 
> diff --git a/tests/generic/707 b/tests/generic/707
> new file mode 100755
> index 000000000000..ad1592a1b957
> --- /dev/null
> +++ b/tests/generic/707
> @@ -0,0 +1,70 @@
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
> +_fixed_by_kernel_commit f950fd052913 \
> +	"udf: Protect rename against modification of moved directory"
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"ext4: fix possible corruption when moving a directory"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
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
> +	unset BGPID
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

