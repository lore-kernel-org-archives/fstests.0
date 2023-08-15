Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8DEC001B0
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Aug 2023 11:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbjHOLul (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Aug 2023 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbjHOLuM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Aug 2023 07:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B22171F
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692100144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vRgFjnNlIOm+Tt5GKZwlOVDALHShEsGZQySpq52qLwo=;
        b=HgqteoDCuTML2Qef3a5y+jEhs6mKcSV4LjVJ+1JXnFP6FQXuGnQE3woBYQWHGwvQ64cdkj
        hK6a3KFxrooICaCpFfnrkzyTA5pHqtTlKrbTCslKytRPz5Siv1t2OxOTiSTYJSxZJhzp9l
        LLBF5s75vFWwwIYG/APlYQXalXa84FY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-DnD5S5FLOM-YhSH0w_uwzg-1; Tue, 15 Aug 2023 07:49:02 -0400
X-MC-Unique: DnD5S5FLOM-YhSH0w_uwzg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bdae10c645so74399955ad.3
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2023 04:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100141; x=1692704941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRgFjnNlIOm+Tt5GKZwlOVDALHShEsGZQySpq52qLwo=;
        b=ijEFKcfDNlkvV+PYbGpwccamuknEo1tjBCa4mXw/sk5aflPvWY2CKRnniMpByZF7kq
         QQTH5MLvkbK0qIyyTEFe33UyrldwHJzsGl4XFwTH4kmUSRzTovJnrCi7sKqzUOe06+IB
         sDM55DSh4ZuncMUJKQdzz3f8O8Ysxz1yUXndSSfB+sipXxnjsTpm84Zvh4o69rBEEtkh
         1V/aI9zA5CnT38ccQGkYhwEeYeI0CufU2yiQ5CcLhOqZ+x2WgELnKq7a+WRgCmfbKwDx
         CkEzW8T+O10xFpAyy0CxcyAXW7uj5/RM7eDTJQkcyZEKRNWONYoAQcUVVX7WtspDepMc
         CS6w==
X-Gm-Message-State: AOJu0YyaTl6nml+X0lMNaITzJk8zLocA4YjT48GFD1NU4oMUIqSReXnt
        VwaIpVwyqjkfpVaFopu58YGBqA+G0h1YJkcXOj7qdpmxE9A1AIt9eP3BCRCStIFCuuGy0K3X+Mk
        qyV+E/IALbJQLCUfK1/APH1uGu3rQYDE=
X-Received: by 2002:a17:903:1249:b0:1bc:2bd:852a with SMTP id u9-20020a170903124900b001bc02bd852amr19129127plh.42.1692100141730;
        Tue, 15 Aug 2023 04:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4kK3jvS1kfUOfqsHhj/mapP/iKr6gWoYtbuei/bsdBetyeZ7Jc6sz9lHX/3KkOm/El3lAjw==
X-Received: by 2002:a17:903:1249:b0:1bc:2bd:852a with SMTP id u9-20020a170903124900b001bc02bd852amr19129110plh.42.1692100141392;
        Tue, 15 Aug 2023 04:49:01 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001bc445e249asm10896866plg.124.2023.08.15.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 04:49:00 -0700 (PDT)
Date:   Tue, 15 Aug 2023 19:48:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/{175,297,298}: fix use of uninitialized var
Message-ID: <20230815114858.aw4s6rt4yla6g6pe@zlang-mailbox>
References: <20230815082835.790906-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815082835.790906-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 15, 2023 at 11:28:35AM +0300, Amir Goldstein wrote:
> The truncate command in those tests use an uninitialized variable i.
> in kdevops, i must contain some leftover, so we get errors like:
> /data/fstests-install/xfstests/tests/generic/298: line 45: /dev/loop12):
>            syntax error: operand expected (error token is "/dev/loop12)")
> 
> Apparently, noone including the author of the tests knows why this
> truncate command is in the test, so remove the wrong truncate command.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Changes since v1:
> - Remove the unneeded truncate command instead of fixing it
> 
>  tests/generic/175 | 1 -
>  tests/generic/297 | 1 -
>  tests/generic/298 | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/tests/generic/175 b/tests/generic/175
> index 07af2199..f827beb6 100755
> --- a/tests/generic/175
> +++ b/tests/generic/175
> @@ -33,7 +33,6 @@ _pwrite_byte 0x61 0 $blksz "$testdir/file1" >> "$seqres.full"
>  
>  fnr=19
>  echo "Create extents"
> -truncate -s $(( (2 ** i) * blksz)) "$testdir/file1"
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> "$seqres.full"
>  	n=$(( (2 ** i) * blksz))
> diff --git a/tests/generic/297 b/tests/generic/297
> index 6bdc3e1c..54c2ac21 100755
> --- a/tests/generic/297
> +++ b/tests/generic/297
> @@ -42,7 +42,6 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
>  fnr=26		# 2^26 reflink extents should be enough to find a slow op?
>  timeout=8	# guarantee a good long run...
>  echo "Find a reflink size that takes a long time"
> -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
>  	n=$(( (2 ** i) * blksz))
> diff --git a/tests/generic/298 b/tests/generic/298
> index 95d4c02b..115a9bf7 100755
> --- a/tests/generic/298
> +++ b/tests/generic/298
> @@ -42,7 +42,6 @@ _pwrite_byte 0x61 0 $blksz $testdir/file1 >> $seqres.full
>  fnr=26		# 2^26 reflink extents should be enough to find a slow op?
>  timeout=8	# guarantee a good long run...
>  echo "Find a reflink size that takes a long time"
> -truncate -s $(( (2 ** i) * blksz)) $testdir/file1
>  for i in $(seq 0 $fnr); do
>  	echo " ++ Reflink size $i, $((2 ** i)) blocks" >> $seqres.full
>  	n=$(( (2 ** i) * blksz))
> -- 
> 2.34.1
> 

