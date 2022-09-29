Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F42C32771
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Sep 2022 01:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiI2B6N (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Sep 2022 21:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiI2B6M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Sep 2022 21:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB95B74B8A
        for <fstests@vger.kernel.org>; Wed, 28 Sep 2022 18:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664416689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMcaJXDtEX/hBBlWlG1kjqSS1ondtHDNxf02/jBIxxo=;
        b=Ok7YQV9GC+VL6iyZ1dUc/GWzRJ/IqXviG4k9zSs3GdgDRU5X09d6vAb9wO1cvqnWKnyWgU
        ZnthvITDe5Mbp9yWy1805GjQ63QEpD/hOyrRM7pkTPF7v1x772rgEai/YJHZZYAz24pwUC
        /jMv8MOxH36UwHDLsx3mAaea4mO6bjs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-F9FKWFTaPTyXQCxq1SfRRg-1; Wed, 28 Sep 2022 21:58:08 -0400
X-MC-Unique: F9FKWFTaPTyXQCxq1SfRRg-1
Received: by mail-pl1-f197.google.com with SMTP id d14-20020a170902cece00b001784b73823aso14150plg.1
        for <fstests@vger.kernel.org>; Wed, 28 Sep 2022 18:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pMcaJXDtEX/hBBlWlG1kjqSS1ondtHDNxf02/jBIxxo=;
        b=zXne6exF5hNfnhgUxfmpqbqjpCsJ8OSFRcCjdvamMja+3010VsWxjg9Bj8XHbccHc3
         vYF+rLBe/g7aeZhSPt+T0kRitM6GwPElo5QLquu033U/Bk5btkBKYswKS5gMj548dG5d
         7nnZe7/7sw1wlvh7+fuPNcvcGGekdhZQjGnpp9z2p+kike4Z02mOIOFF+aIiDHrhI3Ve
         Tyhgg/bCsayJZBPvoyhSdyLAnt2YBL2FDiljwvY3kgNBVWQMY1qMcYq3ai1N9U9xHCWL
         2scVBDDfWN/vkTjsTOuKkc+5P1AjpKG5deuzX4tddEiU1yO7Yu5wYS3wD/vtC6nFh0SJ
         uK2Q==
X-Gm-Message-State: ACrzQf2X5+V7jNZDIEkT+IbEWlG+WmUUk99SqfklwNMw86SR9WPRzDXX
        b4fzQL9eqTHJQzHPIcvfMeAOrbUft6dyGzrdtzs1syELVgzZVNomkqlhBJjRQVT2PRCYlTNOFZ6
        QtqhndE6hKJvJLNgoSA==
X-Received: by 2002:a17:903:c1:b0:179:ee54:1c12 with SMTP id x1-20020a17090300c100b00179ee541c12mr978851plc.65.1664416687102;
        Wed, 28 Sep 2022 18:58:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6LQoFdJ0n+96lDLPchkcdCAg9pZaAw0vQSLUuys/W/pC4O+tBDK+X9KggwaAC7f9A9kHcMxg==
X-Received: by 2002:a17:903:c1:b0:179:ee54:1c12 with SMTP id x1-20020a17090300c100b00179ee541c12mr978830plc.65.1664416686727;
        Wed, 28 Sep 2022 18:58:06 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090a4f8500b001fbb0f0b00fsm2237186pjh.35.2022.09.28.18.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 18:58:06 -0700 (PDT)
Date:   Thu, 29 Sep 2022 09:58:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clean-up; Remove left files after test finishes
Message-ID: <20220929015802.xb32k5ifrn33rojz@zlang-mailbox>
References: <20220922185502.1046115-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922185502.1046115-1-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 22, 2022 at 08:55:01PM +0200, Pavel Reichl wrote:
> Fix file leak in _get_max_file_size - This is obviously mostly
> problematic for FS lacking support for sparse files.
> 
> There seems to be some seek_sanity_testfile files that are not
> cleaned up and take up space:
> 
> -rwxr-xr-x. 1 root root 8.0G Sep 22 13:39 seek_sanity_testfile10
> 
> g/394: Clean up test files taking space:
> 
> -rwxr-xr-x. 1 root root 1.0G Sep 22 14:58 394.1183899
> -rwxr-xr-x. 1 root root 1.0G Sep 22 14:58 394.1183899-1
> -rwxr-xr-x. 1 root root    0 sep 22 14:58 394.1183899+1
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---

This patch looks good to me, although I doubt _get_max_file_size() really can
give you a proper max file size for your exfat testing. I even doubt if those
cases test max file size are suit for exfat which doesn't support sparse file
and fallocate. Anyway, you can deal with that problem later, this patch can be
merged at first. Thanks.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc         | 1 +
>  tests/generic/285 | 2 +-
>  tests/generic/394 | 2 +-
>  tests/generic/436 | 2 +-
>  tests/generic/445 | 2 +-
>  tests/generic/448 | 2 +-
>  6 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 228fcb37..c9078649 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4637,6 +4637,7 @@ _get_max_file_size()
>  			l=$m
>  		fi
>  	done
> +	rm -f $testfile
>  	echo $l
>  }
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
>  }
>  
>  _run_seek_sanity_test $BASE_TEST_FILE > $seqres.full 2>&1 ||
> diff --git a/tests/generic/394 b/tests/generic/394
> index fc03e2f3..cbc2ce13 100755
> --- a/tests/generic/394
> +++ b/tests/generic/394
> @@ -14,7 +14,7 @@ _cleanup()
>  {
>  	cd /
>  	ulimit -f unlimited
> -	rm -f $tmp.*
> +	rm -f $tmp.* $TEST_DIR/$seq.*
>  }
>  
>  # Import common functions.
> diff --git a/tests/generic/436 b/tests/generic/436
> index 7fb24b41..d54af436 100755
> --- a/tests/generic/436
> +++ b/tests/generic/436
> @@ -16,7 +16,7 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
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

