Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA07FECAAD8
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Aug 2022 07:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiH3Htw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Aug 2022 03:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiH3Htv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Aug 2022 03:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B5B0C
        for <fstests@vger.kernel.org>; Tue, 30 Aug 2022 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661845784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SBwkg2d90U//c38QsxRGKMCraHKC2z+i+jRzmfhcsFE=;
        b=gM5lWylMJYclGJfzY2ORnPaOr5FUublSeZpq8V8sT5Uj/eZzyQe5PJeCHRcjR2Wuo3IVV/
        3Kxyj4kyG9uuh3GDzeOQmO/XPbWBIDdbKmtbdaImz2FpYako/JPsUgEqMUIWN0/LjzVgTg
        4U9Ryq9ybTqJU8qjn/u4aVGaNit7Y5o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-ZS--hupbMn2gG3e5WfIedA-1; Tue, 30 Aug 2022 03:49:43 -0400
X-MC-Unique: ZS--hupbMn2gG3e5WfIedA-1
Received: by mail-qk1-f198.google.com with SMTP id bs43-20020a05620a472b00b006bb56276c94so8549962qkb.10
        for <fstests@vger.kernel.org>; Tue, 30 Aug 2022 00:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=SBwkg2d90U//c38QsxRGKMCraHKC2z+i+jRzmfhcsFE=;
        b=hldTluSjBtOM0nCnoTSiCZCPxSbq8c2onLmnFwLun2jBwJpcZIEZbV0Wb2yjMTbbS3
         wi+zBQasTWKL77S58DSAFZIqNeqpIKchJoIfSao8m9cH/E4OhP6nbHwCHk/as1aU8D9e
         xCn0Pg/Y0q7p0ctKTN2nyFo5/T74x3Eg1OPFKKoEWKoezTZjM4BKNI0VLkhsHBDQcLbu
         SLC9pttYhQFrU7JwuBahRp3bBGagj+a0EVPhTnqJkBzQV+IjzddcQnEgoCNblAIOJmTU
         ovWKBi+Yj7UeuSwFgjCxuyRIlhqh3+uRQLn9mMjGaZBiCuyplIhHAlS4vvVOiQc/ovdA
         MfNg==
X-Gm-Message-State: ACgBeo31bpxfNAk34Yq6+ViT9cZQAL16+VjCRSYTiAFz4VLwz/ZrG0cp
        vyHLHegHJfMceW/aC2Xmb+nO7noa3//pHh4EJspUvDIffOPKhIwJgkv1NG9C937TWaXwHJWrZAb
        Hg6XsyDeFkMrlJvH+4w==
X-Received: by 2002:a05:6214:f6c:b0:476:6e82:7af4 with SMTP id iy12-20020a0562140f6c00b004766e827af4mr13665130qvb.129.1661845782353;
        Tue, 30 Aug 2022 00:49:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6jV2XlYWmD/OhqYULkya2PtYbwbc5QKRdd3w44vl6+yppn7R/d3Ljn2+p96plnKK8VaBoWGQ==
X-Received: by 2002:a05:6214:f6c:b0:476:6e82:7af4 with SMTP id iy12-20020a0562140f6c00b004766e827af4mr13665121qvb.129.1661845782102;
        Tue, 30 Aug 2022 00:49:42 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h5-20020a05622a170500b0034490214788sm6851304qtk.49.2022.08.30.00.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 00:49:41 -0700 (PDT)
Date:   Tue, 30 Aug 2022 15:49:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 4/4] xfs/144: remove testing root dir inode in AG 1
Message-ID: <20220830074936.eprwzg4auxtlhsom@zlang-mailbox>
References: <20220830044433.1719246-1-jencce.kernel@gmail.com>
 <20220830044433.1719246-5-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830044433.1719246-5-jencce.kernel@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 30, 2022 at 12:44:33PM +0800, Murphy Zhou wrote:
> Since this xfsprogs commit
>   1b580a773 mkfs: don't let internal logs bump the root dir inode chunk to AG 1
> this operation is not allowed.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  tests/xfs/144 | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/tests/xfs/144 b/tests/xfs/144
> index 706aff61..3f80d0ee 100755
> --- a/tests/xfs/144
> +++ b/tests/xfs/144
> @@ -17,9 +17,6 @@ _begin_fstest auto mkfs
>  _supported_fs xfs
>  _require_test
>  
> -# The last testcase creates a (sparse) fs image with a 2GB log, so we need
> -# 3GB to avoid failing the mkfs due to ENOSPC.
> -_require_fs_space $TEST_DIR $((3 * 1048576))
>  echo Silence is golden
>  
>  testfile=$TEST_DIR/a
> @@ -36,7 +33,7 @@ test_format() {
>  }
>  
>  # First we try various small filesystems and stripe sizes.
> -for M in `seq 298 302` `seq 490 520`; do
> +for M in `seq 1024 1030` ; do

Can `seq 1024 1030` replace `seq 298 302` `seq 490 520`? I don't know how
Darrick choose these numbers, better to ask the original authoer of this
case. Others looks reasonable for me.

Thanks,
Zorro

>  	for S in `seq 32 4 64`; do
>  		test_format "M=$M S=$S" -dsu=${S}k,sw=1,size=${M}m -N
>  	done
> @@ -45,11 +42,6 @@ done
>  # log end rounded beyond EOAG due to stripe unit
>  test_format "log end beyond eoag" -d agcount=3200,size=6366g -d su=256k,sw=4 -N
>  
> -# Log so large it pushes the root dir into AG 1.  We can't use -N for the mkfs
> -# because this check only occurs after the root directory has been allocated,
> -# which mkfs -N doesn't do.
> -test_format "log pushes rootdir into AG 1" -d agcount=3200,size=6366g -lagnum=0
> -
>  # success, all done
>  status=0
>  exit
> -- 
> 2.31.1
> 

