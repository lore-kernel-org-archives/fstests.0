Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA3DC49EA3
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 14:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06EA761C7E
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Jun 2021 14:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhF1OXX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 10:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233430AbhF1OWW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Jun 2021 10:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624889995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+e+dcyiZnu2+OzNUZhbyBRXn1udCvHX32R0g7/MRrJk=;
        b=T096nLSX+P8BDRh2fx8NufCjKCU36gaMY9Dl4+feqewZ/4om0wnQ0f7C6VAinPSWirXGqy
        W5YRwaqUewJp8Bbl4HEaiX6npHVAtL4Gpw3+ICIAdRzN7zCSjZT2AmXUFIolSLqCz9YHhM
        xS/fNaeGmt9emeCH18R4H59VWTvrCE4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-P4ZMv4RWNmeZyRbQUPn_Yg-1; Mon, 28 Jun 2021 10:19:54 -0400
X-MC-Unique: P4ZMv4RWNmeZyRbQUPn_Yg-1
Received: by mail-pl1-f199.google.com with SMTP id g9-20020a1709029349b0290128bcba6be7so1548596plp.18
        for <fstests@vger.kernel.org>; Mon, 28 Jun 2021 07:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=+e+dcyiZnu2+OzNUZhbyBRXn1udCvHX32R0g7/MRrJk=;
        b=DNlLrAyLDjnhqTPZRnrnALtnk/9BJUXbKKjs4+2Wt3qmbh+LpLjfrzr8sEG41QNiqU
         /5A5xI3VOzK+sFCJ3K6bXIgQamJmxh6f4rzZGy+hq/FguRzvyc9YwmeiZpzDxfy3b5HZ
         D/OYsUmmEJOR3unpM4XEn0VhUlGx4ybfv+VxsmZfucky6cuh56WiAiZes0Qw4QRiAjEh
         SjmrRz2mZOPcaMo5/nWBhK5GNCf/TVobP7u8qFaGgnGdhe6x+y8S84Wz/GecHnF491EB
         rNF8ivfPWPdYxzZ8jBbnmHzXd2IMfn00nRzROeTc9p3NhRYQbg8WL8H20/zKHJNOGOG1
         4DGg==
X-Gm-Message-State: AOAM532OUOtA++9dPFklgxMok49KHxAMMTb7u9X7QXApzcXRmqbZ6iJ3
        rg4yXutWRIZ8eti680OzcaDEO1H9zTbVr+0A153uD/xUIr78t2wWr0YSAMctKBUE3XFi5mol8/Y
        EGMpfK7yu3M7W9NeqKw==
X-Received: by 2002:a62:7c05:0:b029:306:2f0c:b5dd with SMTP id x5-20020a627c050000b02903062f0cb5ddmr25520819pfc.75.1624889993240;
        Mon, 28 Jun 2021 07:19:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrcwK+zo/8Ht2nT2O0Hsq0glEybwwCxQOqT0MhVF/vv2XcPjjl8QBh/9nbMe7KJGuVXhGiKA==
X-Received: by 2002:a62:7c05:0:b029:306:2f0c:b5dd with SMTP id x5-20020a627c050000b02903062f0cb5ddmr25520795pfc.75.1624889992954;
        Mon, 28 Jun 2021 07:19:52 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12sm2359742pfl.27.2021.06.28.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 07:19:52 -0700 (PDT)
Date:   Mon, 28 Jun 2021 22:19:49 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/515: Check xfsprogs version for testing
 xfs_quota commands
Message-ID: <20210628141949.m2uvjlp2dyiwx4ts@fedora>
Mail-Followup-To: Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        fstests@vger.kernel.org
References: <20210628085259.120666-1-anju@linux.vnet.ibm.com>
 <20210628085259.120666-4-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628085259.120666-4-anju@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 28, 2021 at 02:22:59PM +0530, Anju T Sudhakar wrote:
> xfs_quota command 'limit' is reformated in xfsprogs version v5.5.0, to
> make it suitable for this(xfs/515) test case. So the test case will
> flag failure while running with xfsprogs version less than v5.5, even
> though `limit` is documented in xfs_quota manpage. So skip this test for
> xfsprogs versions less than v5.5.
> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> ---
>  tests/xfs/515 | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/515 b/tests/xfs/515
> index 32216fe6..5eb97aff 100755
> --- a/tests/xfs/515
> +++ b/tests/xfs/515
> @@ -27,6 +27,11 @@ _require_test
>  echo "Silence is golden"
>  
>  MANPAGE=$($MAN_PROG --path xfs_quota)
> +# xfs_quota command 'limit' is reformated in xfsprogs version v5.5.0,
> +# to make it suitable for this test case. For xfprogs versions less than
> +# v5.5.0, this test case can not detect the command 'limit'.
> +req_version=$($XFS_DB_PROG -V | cut -d" " -f3)
> +req_command="limit"

It's similar as the patch of [2/3], and I have similar review points. And
checking program version isn't a good way to judge the expect behavior of
a program, especially downstream always backport patches of upstream.

Thanks,
Zorro

>  
>  case "$MANPAGE" in
>  *.gz|*.z\|*.Z)	CAT=zcat;;
> @@ -36,8 +41,14 @@ case "$MANPAGE" in
>  esac
>  _require_command `which $CAT` $CAT
>  
> -for COMMAND in `$XFS_QUOTA_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`; do
> -  $CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
> +for COMMAND in `$XFS_QUOTA_PROG -x -c help $file | awk '{print $1}' | grep -v "^Use"`;
> +do
> +	if [ "$req_version" \< "5.5.0" ]; then
> +		if [ "$COMMAND" == "$req_command" ];then
> +			continue
> +		fi
> +	fi
> +	$CAT "$MANPAGE" | egrep -q "^\.B.*$COMMAND" || \
>  	echo "$COMMAND not documented in the xfs_quota manpage"
>  done
>  
> -- 
> 2.31.1
> 

