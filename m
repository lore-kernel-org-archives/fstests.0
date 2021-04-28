Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CC7C433ED
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8C961107
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Apr 2021 17:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbhD1RsF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Apr 2021 13:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42623 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242663AbhD1RsE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Apr 2021 13:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619632038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83nCVKgrGf4sedjQS2BrTng2JSzKHnjwsCGqg6tJ03I=;
        b=QfrSsj18yjhduiaD3Zh3gX2awoeUv5FIWbxNNB/M0B5M8XkCPJVFcRGixM5xJAtie2ZAlU
        3z/D+/9RKs5nzcoxJ96kOh1SaFtBmPUFbcdbBN8saTvBetjWBN8GQxCojTZ9xuLeYq0Gc4
        m1zsiEkxHp8UHwJdvAdGDbEt3kdWRik=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-uPiP61aMPeOVlczRjGvTCA-1; Wed, 28 Apr 2021 13:47:16 -0400
X-MC-Unique: uPiP61aMPeOVlczRjGvTCA-1
Received: by mail-qv1-f69.google.com with SMTP id l19-20020a0ce5130000b02901b6795e3304so9187714qvm.2
        for <fstests@vger.kernel.org>; Wed, 28 Apr 2021 10:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83nCVKgrGf4sedjQS2BrTng2JSzKHnjwsCGqg6tJ03I=;
        b=Xw7qxEdX278l6Qv7ZRHeKYiN2ABnV4B+hRxQzGxHQ9qKYN/XtBrsM9KcNFqMQx47ki
         dK2mSuzEkPP1scV4/fJNVD3C/X6QxE5SqqzsF4fXoNxEgCFYQxJhEIwJqHlyTTfjvYb/
         SJyKOLSX7FqF3w/MR+sKB4O3whhSrA+Ex5Lcd2eDnej2oO6+wfzesMfkNf7qRNX5OLo6
         QSVxKODaIn5i7O4lb8RZhIthPQPUClvAWJU/CCjonQRhS5PKdzS+xvqe4TtoUHhiPYuv
         ODJdYoxfXBsvEGKqPE7OtIQmD/Bw5dcePMXOYk5Juqf6iUXinGGGLzTTyCmkrY0L8VQA
         61Gg==
X-Gm-Message-State: AOAM532ZUrzW1FaMMbdj+sUqg5Rmza1QkXed7shkZpfgiyGHUCv53tSt
        OG+N1zRllna8y8D7Q7TSYe9yOTutu1ABY6ZYNXbJ03ij/jwYAs3FNFzuy3qlUO8rEPeMHc814Vb
        Ga8JufTvKP1Mq/3E0Pg==
X-Received: by 2002:a0c:d80a:: with SMTP id h10mr30086073qvj.25.1619632036027;
        Wed, 28 Apr 2021 10:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjsnW5rm8VV1T/HnIZrNt6A3Cez2ZkYoQ4tCK6tG8KPN59h5aVorg14EnKbHOK4vtTslgr+g==
X-Received: by 2002:a0c:d80a:: with SMTP id h10mr30086064qvj.25.1619632035901;
        Wed, 28 Apr 2021 10:47:15 -0700 (PDT)
Received: from bfoster ([98.216.211.229])
        by smtp.gmail.com with ESMTPSA id k18sm295558qkg.53.2021.04.28.10.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:47:15 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:47:13 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 1/5] xfs/276: remove unnecessary mkfs golden output
Message-ID: <YImfodtIxRrG4XAF@bfoster>
References: <161958293466.3452351.14394620932744162301.stgit@magnolia>
 <161958294062.3452351.18374824154438201788.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161958294062.3452351.18374824154438201788.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 27, 2021 at 09:09:00PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> A previous update to this test dropped the clause where the mkfs
> standard output gets sent to /dev/null.  The filtered mkfs output isn't
> needed here and it breaks the test, so fix that.
> 
> Fixes: e97f96e5 ("xfs/27[26]: force realtime on or off as needed")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/xfs/276 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/276 b/tests/xfs/276
> index 6e2b2fb4..afea48ad 100755
> --- a/tests/xfs/276
> +++ b/tests/xfs/276
> @@ -35,7 +35,7 @@ _require_test_program "punch-alternating"
>  rm -f "$seqres.full"
>  
>  echo "Format and mount"
> -_scratch_mkfs | _filter_mkfs 2> "$tmp.mkfs"
> +_scratch_mkfs | _filter_mkfs 2> "$tmp.mkfs" >/dev/null
>  . $tmp.mkfs
>  cat "$tmp.mkfs" > $seqres.full
>  _scratch_mount
> 

