Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54BDC6FA82
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 14:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIVOgt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiIVOgq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 10:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9662F685D
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663857404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdlimTdqnU7cx3fIabOIXWxNClfLh7yHsmII1GdaRLA=;
        b=MgKXCT8h9GXKEGs5iYiK5hOQRhWSIDA2Yvs4wnj67MztE88j+Fr4ABmTFXJ9wSnDvING0X
        yDaE2S0YUhuUBFes5n0xvN7UQC/xW2SEiGGSO+JrG1B8K+KfF2IbvhwnKI7JYJSMf/pox/
        OhyeUbiroZEVurqh6QYzPpMLjql/iFQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-Hmj3spTFNlapsPne9-Qf7w-1; Thu, 22 Sep 2022 10:36:43 -0400
X-MC-Unique: Hmj3spTFNlapsPne9-Qf7w-1
Received: by mail-qt1-f199.google.com with SMTP id h7-20020ac85047000000b0035a6794699bso6513670qtm.3
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 07:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IdlimTdqnU7cx3fIabOIXWxNClfLh7yHsmII1GdaRLA=;
        b=xt2ZywJIdz+1PsUqLRt2V7ZhGRnjIapTNkSOWlidZedpmdLytTvi12aU9L/5s8igUu
         d8gxXHlwUnEpYI1T2ovrpJSXRsH8Acb1vPlqb9OXPjjxMTNGw9BQxeSBlP8bSsxDx243
         TtJ0DLA/g7QtvB42fpykEa5fEcsNgKjFZJNHFDDBCEM1lAB+pDK397x33dKMjNd8XsaP
         GX1Tx23BNto+eubpqxnCNFFc+BJM85ghWMY9YpEJlsLBUfC8jtdfKuWg3wrmjRGP3cx4
         8LZgAXKXFtqB43QAWPTE51Ml7HsQCZ6Bw/XRyrpRb/FNJtioRyo/isCuYVIfSuwrMO2f
         Vy4Q==
X-Gm-Message-State: ACrzQf34iPujL2cE9SGsKeHEOWiSt8lwiL2J/wbHlj1wr5Yl1a3rRwxa
        3llLQZw+1GCshT5jcQ+yEcgxiD8TGfZqT5WhJQ7LJqnSOUvYEGiZg+c6Dqh4rFDJT+VQMH1OFs7
        YlBglp4fDNIvdwR9JWg==
X-Received: by 2002:a05:622a:178c:b0:35b:b8cc:e711 with SMTP id s12-20020a05622a178c00b0035bb8cce711mr3031503qtk.111.1663857402925;
        Thu, 22 Sep 2022 07:36:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5OWNy9EXCDdbT5fHCzejEOIrmo+Sqkfkvp9fmYOC51u/vPYWBMpaeDBKgTLcA3HUXiiWFgFQ==
X-Received: by 2002:a05:622a:178c:b0:35b:b8cc:e711 with SMTP id s12-20020a05622a178c00b0035bb8cce711mr3031472qtk.111.1663857402601;
        Thu, 22 Sep 2022 07:36:42 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r1-20020ae9d601000000b006cbbc3daaacsm3919270qkk.113.2022.09.22.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 07:36:42 -0700 (PDT)
Date:   Thu, 22 Sep 2022 22:36:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/4] generic: cleanup test files
Message-ID: <20220922143638.ruwujtwblv43sgfo@zlang-mailbox>
References: <20220922134822.1020119-1-preichl@redhat.com>
 <20220922134822.1020119-3-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922134822.1020119-3-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 03:48:21PM +0200, Pavel Reichl wrote:
> There seems to be some seek_sanity_testfile files that are not
> cleaned up and take up space.
> 
> -rwxr-xr-x. 1 root root 8.0G Sep 22 13:39 seek_sanity_testfile10
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  tests/generic/285 | 2 +-
>  tests/generic/436 | 2 +-
>  tests/generic/445 | 2 +-
>  tests/generic/448 | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/285 b/tests/generic/285
> index 6c755b5f..d1850021 100755
> --- a/tests/generic/285
> +++ b/tests/generic/285
> @@ -28,7 +28,7 @@ _require_test_program "seek_sanity_test"
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	eval "rm -f $BASE_TEST_FILE.*"
> +	rm -f $BASE_TEST_FILE*

OK, this eval looks not reasonable.

>  }
>  
>  _run_seek_sanity_test $BASE_TEST_FILE > $seqres.full 2>&1 ||
> diff --git a/tests/generic/436 b/tests/generic/436
> index 7fb24b41..d54af436 100755
> --- a/tests/generic/436
> +++ b/tests/generic/436
> @@ -16,7 +16,7 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile

I'm wondering two questions:
1) If these cases all use $TEST_DIR/seek_sanity_testfile, and don't really
   remove these seek_sanity_testfile* files, will them affect each testing
   result? Can we set BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile_$seq
   at least, to avoid they use same files?

2) If these $BASE_TEST_FILE* files won't take too much space, and won't affect
   later testing, how about keeping them in $TEST_DIR, then remove these
   specific _cleanup(). From my testing, after running g/285, g/436, g/445 and
   g/448, I got [1]. Looks like they only takes ~25M space.

Thanks,
Zorro

[1]
# du -h /mnt/test/
25M     /mnt/test/
# du -h /mnt/test/seek_sanity_testfile*
4.0K    /mnt/test/seek_sanity_testfile
0       /mnt/test/seek_sanity_testfile01
4.0K    /mnt/test/seek_sanity_testfile02
12K     /mnt/test/seek_sanity_testfile03
4.0K    /mnt/test/seek_sanity_testfile04
4.0K    /mnt/test/seek_sanity_testfile05
8.0K    /mnt/test/seek_sanity_testfile06
44K     /mnt/test/seek_sanity_testfile07
44K     /mnt/test/seek_sanity_testfile08
404K    /mnt/test/seek_sanity_testfile09
128K    /mnt/test/seek_sanity_testfile10
128K    /mnt/test/seek_sanity_testfile11
128K    /mnt/test/seek_sanity_testfile12
4.0M    /mnt/test/seek_sanity_testfile13
4.0M    /mnt/test/seek_sanity_testfile14
12M     /mnt/test/seek_sanity_testfile15
4.0M    /mnt/test/seek_sanity_testfile16
0       /mnt/test/seek_sanity_testfile17
0       /mnt/test/seek_sanity_testfile_44818


>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	rm -f $tmp.* $BASE_TEST_FILE.*
> +	rm -f $tmp.* $BASE_TEST_FILE*
>  }
>  
>  # Import common functions.
> diff --git a/tests/generic/445 b/tests/generic/445
> index 05d1c5b3..d9e9f84b 100755
> --- a/tests/generic/445
> +++ b/tests/generic/445
> @@ -16,7 +16,7 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -	rm -f $tmp.* $BASE_TEST_FILE.*
> +	rm -f $tmp.* $BASE_TEST_FILE*
>  }
>  
>  # Import common functions.
> diff --git a/tests/generic/448 b/tests/generic/448
> index d66967bc..11945549 100755
> --- a/tests/generic/448
> +++ b/tests/generic/448
> @@ -15,7 +15,7 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile_$seq
>  _cleanup()
>  {
>  	cd /
> -	rm -f $tmp.* $BASE_TEST_FILE
> +	rm -f $tmp.* $BASE_TEST_FILE*



>  }
>  
>  # Import common functions.
> -- 
> 2.37.3
> 

