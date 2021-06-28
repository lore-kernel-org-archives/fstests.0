Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F28CC2B9F4
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 14:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A5161C76
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 14:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhF1OTV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 10:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232095AbhF1OTV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Jun 2021 10:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624889814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2ghFAa+LawCjVZyJgyOmOgNsJF0xRVVr6DXnDI6b8M=;
        b=fYKapaqUz4XAA8uXM/z7A2IhvDpPgXzmRajrZXJfJym5zNS0FSuIeJJCYUDeltloWb98xs
        BMvfcohqmX1cIHin6tpA+xJkrRhx46rXUu3Cyt/syqku1U0GWa00ip2UB2hFjB0nP05rYT
        O8hFUfYZBQ36SItnqWTgcK/OuBfda3A=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-6HS0e5RnNd2GpZOS8__MHA-1; Mon, 28 Jun 2021 10:16:52 -0400
X-MC-Unique: 6HS0e5RnNd2GpZOS8__MHA-1
Received: by mail-pf1-f197.google.com with SMTP id y29-20020a056a00181db02903062cdadd92so9380097pfa.3
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 07:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=k2ghFAa+LawCjVZyJgyOmOgNsJF0xRVVr6DXnDI6b8M=;
        b=aGLYhyKSIS0doGzXzCiX0SDeS5x4W4p3tDcC5NuRs+di7CcbRlnhiar9FjTz9oyOYU
         jzbTvNtPcfvdHV6bRh50FSg4V85cpn3ndv2QYWelqb1msyivaLrrxKPpJKi4EUckYaQm
         +f4hFk2trV1/+88uuyuFGZhpCgzw9OyOD1LcOjrsRyusmD+e0AjHUCvCXEaqt1l+bkPN
         idFp6Q3WqButqjL8Mfdzapgb5nW4lgLkhK/cXKqBwfbnTpCSZ3bvOC81tF98O/DFd1yn
         kA3tfnLqTV+u4J9tnB6aErKTd72PMlgOEXft51E5e9HIIRrxILtAkdfXvN4B8ShZQAlw
         wO9A==
X-Gm-Message-State: AOAM532zEUaTLdItUay7jBlR6T+QDLU1ReuS7bJdp3g0Ib3kkv12p+MX
        1H7Bf5IaGN2G+te8w46w064INAnCA4p3vh+yr1qj4olPsEds+KfBARG4Gy1sd6z9+8X6/vf2XJU
        4DW/Kvb1EhagXriwUsQ==
X-Received: by 2002:a17:90b:19d4:: with SMTP id nm20mr37439822pjb.134.1624889811941;
        Mon, 28 Jun 2021 07:16:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZkLYPwNQ/+BRP1LxL5GLw3I4wx3jlLrkx6FNVJL5RXY3MoRMQZQeu/IfVaxaY12FnTGNhmQ==
X-Received: by 2002:a17:90b:19d4:: with SMTP id nm20mr37439804pjb.134.1624889811737;
        Mon, 28 Jun 2021 07:16:51 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p4sm14789256pff.148.2021.06.28.07.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 07:16:51 -0700 (PDT)
Date:   Mon, 28 Jun 2021 22:16:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs/514: Check xfsprogs version for verifying the
 xfs_db commands
Message-ID: <20210628141648.bk5fub27mwbefewi@fedora>
Mail-Followup-To: Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        fstests@vger.kernel.org
References: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
 <20210628085259.120666-3-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628085259.120666-3-anju@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 28, 2021 at 02:22:58PM +0530, Anju T Sudhakar wrote:
> xfs_db commands like `attr_remove, attr_set, btheight, and logformat`,
> are documented only in xfsprogs version v5.5 and later. So skip checking
> for these commands in xfs_db manpage,if the test is running with
> xfsprogs version less than v5.5.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
> Query: The reason to add this check is, while running xfstest with an         
> older version of xfsprogs, this test case flags as failure, though         
> xfs_db is not expected to have those commands. Otherwise upon failure we   
> should ask the user to use the latest version of xfsprogs.                 
> OR is there any better solution for this?     
> 
>  tests/xfs/514 | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/514 b/tests/xfs/514
> index a9c67645..8da66f41 100755
> --- a/tests/xfs/514
> +++ b/tests/xfs/514
> @@ -27,6 +27,11 @@ _require_test
>  echo "Silence is golden"
>  
>  MANPAGE=$($MAN_PROG --path xfs_db)
> +# xfs_db commands - attr_remove, attr_set, btheight, and logformat
> +# are documented in 5.5.0 and later versions only. So skip checking for
> +# those commands if the version is less than 5.5.0.
> +command_list="attr_set attr_remove btheight logformat"
> +req_version=$($XFS_DB_PROG -V | cut -d" " -f3)

Generally I think it's a known "bug"(doc missing), and this case hit this bug
in old xfsprogs, that's as expected.

Thanks,
Zorro

>  
>  case "$MANPAGE" in
>  *.gz|*.z\|*.Z)	CAT=zcat;;
> @@ -41,7 +46,12 @@ truncate -s 128m $file
>  $MKFS_XFS_PROG $file >> /dev/null
>  
>  for COMMAND in `$XFS_DB_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`; do
> -  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> +	if [ "$req_version" \< "5.5.0" ]; then
> +		if (echo $command_list | tr ' ' '\n' | grep -F -x -q "$COMMAND");then
> +			continue
> +		fi
> +	fi
> +	$CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
>  	echo "$COMMAND not documented in the xfs_db manpage"
>  done
>  
> -- 
> 2.31.1
> 

