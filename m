Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68861C54EAA
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 05:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjA3FBR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 00:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjA3FBQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 00:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCDB17156
        for <fstests@vger.kernel.org>; Sun, 29 Jan 2023 21:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675054828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/bjD4P/4LAXrIHPoaPaYhmoOec0i/m/AToOjuW8QyxM=;
        b=My4u+K6eMTlrKbQf1BlvPyrWHJPp42gEV3mdiZ0gt0NWIXFL8kCFW8BcPi4r9cpajTCV5+
        s5WE/bIgeeP36cSIyGeJEZ0/rJ0NpfPC3cnRP1JXvQ/jWEbbfeWPAxJo+KLdcKO82w0TRO
        cxewxhJ36r3hUQqriGv7dAwWv3JFRGc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-OG3rGK81NeqHty-czdlzOg-1; Mon, 30 Jan 2023 00:00:24 -0500
X-MC-Unique: OG3rGK81NeqHty-czdlzOg-1
Received: by mail-pf1-f200.google.com with SMTP id l7-20020a62be07000000b0058de3976793so4825354pff.18
        for <fstests@vger.kernel.org>; Sun, 29 Jan 2023 21:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bjD4P/4LAXrIHPoaPaYhmoOec0i/m/AToOjuW8QyxM=;
        b=KawpROw+ey0rcXhFAdNOaBR6uk2IkBvLD3TOrd/WO2E8rbme0vtR94HHBdOAD+TF7d
         dcbr1+QXAKiGRE8y6G/XBYRxAYbH6qtCryFhw+89OnPq9L7+QGagUyO0tJrkuLhfDulq
         9RsYFLzzBLrbJo2ZuDy4xKoUlTYuJyZ9AArjmjePQl5ZTRaW/YLpbhOu/SoPVeFKTAOc
         A3OIXKl3m7IbOyZEXwN6183jO1Zc9XQF8Hg6NJlAOxOU36YZWeoubt33Z9lU8RWhNp7c
         dT/E37DaBO+LgWKvK00lQngG0fyEj7JuMhNv0fI3oCiyU3MEuEMzXGjHN0IMSTX3SPnS
         3qpA==
X-Gm-Message-State: AO0yUKXzpTw1lFzLnnDLqkmDvvq65aKH3zbkDYuZmH2eJlxJhRJ3hB4J
        0arS/M4SOYfME+UV4QdotOnoGUNDgeD+/lKnbxw0+WfdKec9eirZ6Ftp36EhRrwOJ51V5gwNa7v
        N/I4dOW9T/Uu5Yf13/w==
X-Received: by 2002:a17:902:e74c:b0:196:42eb:a4b3 with SMTP id p12-20020a170902e74c00b0019642eba4b3mr9363160plf.62.1675054823130;
        Sun, 29 Jan 2023 21:00:23 -0800 (PST)
X-Google-Smtp-Source: AK7set/Psp/gm4HhzCSOMV2kc8p1B9doAnK+9UV6KSZRkKKwqIrgUcYKQkVLOAlmnZ8yooxWvVFEHw==
X-Received: by 2002:a17:902:e74c:b0:196:42eb:a4b3 with SMTP id p12-20020a170902e74c00b0019642eba4b3mr9363138plf.62.1675054822829;
        Sun, 29 Jan 2023 21:00:22 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902a9c800b001967cfc81a0sm1612144plr.287.2023.01.29.21.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 21:00:22 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:00:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/707: Test moving directory while being grown
Message-ID: <20230130050018.5tta53zaxlhmlmy4@zlang-mailbox>
References: <20230126151512.5438-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126151512.5438-1-jack@suse.cz>
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

Is this necessary? Generally we use absolute path, e.g.

xxxfile=$SCRATCH_MNT/xxxxxxx
touch $xxxfile



> +
> +# Loop multiple times trying to hit the race
> +loops=100
> +files=500
> +moves=500

You might would like to try LOAD_FACTOR or TIME_FACTOR parameters?

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

Use absolute path can help save the pushd&popd operations.

> +	create_files &

If there're background processes, we should deal with it in _cleanup() clearly.

Thanks,
Zorro

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

