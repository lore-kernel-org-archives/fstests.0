Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8982FC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Apr 2022 05:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiDRFIK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Apr 2022 01:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiDRFIJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Apr 2022 01:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34EE6B7F7
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 22:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650258331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaJubL/awWlezeUmiIM6Q3PJD9+BpcOS/loxKeyEPYQ=;
        b=TRTL91qrqc26nkmhApM73tCp99pKtzeyWzeFvPCbDDV9ASwguzdiXnba5an+nV+JWwXK0a
        sSbxsgn1XgknymyVQMVtIn8fD30L1nkxa+EdQH+OJtPdDH1P0U1a7Gt3iTwYv6W90AjQfL
        vu5iidI9BoZ+pI9Xul1J0APHuxNB8Fw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-WSqM0OkgORWH1h4PaY9eZg-1; Mon, 18 Apr 2022 01:05:27 -0400
X-MC-Unique: WSqM0OkgORWH1h4PaY9eZg-1
Received: by mail-qt1-f198.google.com with SMTP id t20-20020a05622a01d400b002f1f4b6d6d0so1973685qtw.21
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 22:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AaJubL/awWlezeUmiIM6Q3PJD9+BpcOS/loxKeyEPYQ=;
        b=F7OjJ9cBo6q4KOjK/9T55KlPmCqf8LhYSr1efhX5L/Dwb6QbaxTK3LKM9qX4DfBO8Z
         gV7y3FWQZg72fIdUn4FlGGNU6cSrHBvVNp60YsAX5FREXwVjnYWq9Eh0YUSPQo6V/LSe
         uulF57xx68MeBDTG1exj1h+H67hr5W0Ag0iUwt+SjXyiTgHW2Yss9XbtrQgYVwxN953g
         mw9U5QIFrEhOhEyYIAw+nOyjAmjKMkyQzNYVMWUZPmk9s20TuRsTKq7Bwj1/FanQ8/cy
         lPnEF+dahloJplKYD3+xsAZO9jFbeTWY5oALpx9AIYVbUkcqwAUn3P/7VbDIHiKp87nY
         ZCQA==
X-Gm-Message-State: AOAM532udt9nCnrkuYSUmDraXugGRqONjFgDJNBZTLpyrNWq6NgoGN6o
        t3wpy74A0iRhAPmjTYfoZ3vC7HugRgU9+dMcyXt+yRhiX0XyhEJHveEYvM1cu/w5lEFCCJZRqog
        C10lHeiBL+V8KZiM0sQ==
X-Received: by 2002:a37:6412:0:b0:69e:68cf:d889 with SMTP id y18-20020a376412000000b0069e68cfd889mr5392690qkb.443.1650258327047;
        Sun, 17 Apr 2022 22:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCbRUmbvnaUxQKssKz6NB2Bf8OlWReTcFCNp6wAGcPJwvpDN92/L8afti0dZLxbHaTZ7r/rQ==
X-Received: by 2002:a37:6412:0:b0:69e:68cf:d889 with SMTP id y18-20020a376412000000b0069e68cfd889mr5392680qkb.443.1650258326808;
        Sun, 17 Apr 2022 22:05:26 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g9-20020ac85d49000000b002f1fbe305e7sm1863324qtx.80.2022.04.17.22.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 22:05:26 -0700 (PDT)
Date:   Mon, 18 Apr 2022 13:05:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] common: add run option to skip tests for known issues
Message-ID: <20220418050520.h4ufi2qwz6ozpczp@zlang-mailbox>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
References: <20220417174023.3244263-1-amir73il@gmail.com>
 <20220417174023.3244263-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417174023.3244263-4-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 17, 2022 at 08:40:23PM +0300, Amir Goldstein wrote:
> Some tests are written before a fix is merged upstream and some tests
> are written without a known available fix at all. Such is the case with
> test overlay/061.
> 
> Introduce a helper _known_issues_on_fs() which can be used to document
> this situation and print a hint on failure.
> The helper supports specifying specifc fs with the known issue for
> generic tests as well as the notation ^FS1 ^FS2 to indicate a known issue
> on all filesystems expect for FS1 FS2.
> 
> Setting the variable SKIP_KNOWN_ISSUES=yes, will cause all tests
> annotated as known issues for the tested fs to be skipped.
> 
> A future improvement may provide a run option to skip tests based on
> _known_issues_before_kernel when running the tests on an older kernel
> version.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  README            |  2 ++
>  common/rc         | 16 +++++++++++++++-
>  tests/overlay/061 |  2 ++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index 7da66cb6..8abc3840 100644
> --- a/README
> +++ b/README
> @@ -241,6 +241,8 @@ Misc:
>     this option is supported for all filesystems currently only -overlay is
>     expected to run without issues. For other filesystems additional patches
>     and fixes to the test suite might be needed.
> + - set SKIP_KNOWN_ISSUES=yes to skip tests for bug without a known fix.
> +   Those tests are annotated with _known_issue_on_fs helper.
>  
>  ______________________
>  USING THE FSQA SUITE
> diff --git a/common/rc b/common/rc
> index 2e9dc408..3cf60a7e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1597,8 +1597,23 @@ _supported_fs()
>  		_notrun "not suitable for this filesystem type: $FSTYP"
>  }
>  
> +_known_issue_on_fs()
> +{
> +	# Only "supported" fs have the known issue
> +	_check_supported_fs $* || return
> +
> +	if [ "$SKIP_KNOWN_ISSUES" = "yes" ]; then
> +		_notrun "known issue for this filesystem type: $FSTYP"
> +	fi
> +
> +	echo "HINT: You _MAY_ be hit by a known issue for filesystem type $FSTYP." >> $seqres.hints
> +	echo >> $seqres.hints
> +}
> +
>  _known_issue_before_kernel()
>  {
> +	# TODO: don't run if $SKIP_KNOWN_ISSUES and kernel version < $1
> +

As I said in last patch review, it's only for one kernel base line, it might cause
downstream kernel testing can't run a case, even if it had backported the patches.

>  	echo "HINT: You _MAY_ be hit by a known issue on kernel version < $1." >> $seqres.hints
>  	echo >> $seqres.hints
>  }
> @@ -4929,7 +4944,6 @@ _require_kernel_config()
>  	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
>  }
>  
> -
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/overlay/061 b/tests/overlay/061
> index b80cf5a0..36be3391 100755
> --- a/tests/overlay/061
> +++ b/tests/overlay/061
> @@ -22,6 +22,8 @@ _begin_fstest posix copyup
>  
>  # real QA test starts here
>  _supported_fs overlay
> +_known_issue_on_fs overlay

If it's a overlay case, it's absolutely cover an overlay known issue at first.
Even if it hit a mm or underlying fs bug, the _known_issue_on_fs is helpless
for that.

I can understand above 2 patches, but this patch looks weird to me. We can
give a hint to downstream testing (from upstream commit side). But deal with
known issues, that's another story. I'd like to let testers from different
downstream kernels to deal with their known issues checking by themselves,
don't depend on upstream fstests for all.

Thanks,
Zorro

> +
>  _require_scratch
>  _require_xfs_io_command "open"
>  
> -- 
> 2.35.1
> 

