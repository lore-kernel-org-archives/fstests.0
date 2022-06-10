Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B89C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jun 2022 04:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiFJEYT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Jun 2022 00:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiFJEYR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Jun 2022 00:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61218B8F
        for <fstests@vger.kernel.org>; Thu,  9 Jun 2022 21:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654835053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3XuvqmWYizhZybL2AIIT52pdCvtSlLzfj1wBUfFo/+I=;
        b=bNrBzvcurHtf+9h3k6UmBkd7NphGmJ67fPjiTFcG7ajyQ7MNdZXkfaDUl1ccMQCnEIKL/D
        Xwy/7b18TG3D5wxamwIs6R7s2XF/bJKfZwe6QUDd10qPVjK/q/zY/P3mTp1SMFWGfH1L1c
        LTdNPJgqEwAjWIjLVHOiFIYJGBVtcV8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-J9s5oIHWMr-lkcAyXHBZiQ-1; Fri, 10 Jun 2022 00:24:12 -0400
X-MC-Unique: J9s5oIHWMr-lkcAyXHBZiQ-1
Received: by mail-qk1-f197.google.com with SMTP id i5-20020a05620a404500b006a6d7a765d9so7816919qko.7
        for <fstests@vger.kernel.org>; Thu, 09 Jun 2022 21:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3XuvqmWYizhZybL2AIIT52pdCvtSlLzfj1wBUfFo/+I=;
        b=AEhw7Ll66i55Nirj/dBsWwREKqqVj42dhQS+K5E/qJhT26wZRPbA66dpneJdhQwTWh
         g1qI4uDjkD6vGraY/viIQEvsdnin9J7z78ScHQHhigcY9PuBwiWoQ3FIpcDcmzX0F0qP
         ChFZm5QNnLhHmAZGm6ZCWuipIM6njO5Wa5046ZdJGijknCNb0R6XF1XU6S6h9FoORRsd
         JVWWcv2v5/xEzUUU/y7P2YR46Cwp02SpMB8uCBJ1b4/SnmLjAiL6KQPuBn3TtFZrodqq
         9Fy0v7nd3AhozHUNnbn53U/09WmxU+PM5R3cxDRoSDiTCDFankQDcatjB4nlmxNlbRuy
         OsxA==
X-Gm-Message-State: AOAM530K5DzQwzh1en0wBJbwgUz7c8s+54vwxr+9t9IM58nLL72+GyNR
        Y/cXINIVeE7WzLj8ddknaZOGiuXJk2idYa4cPYn1VrnSe1M17Nxmwr0RL2Xwl5XON0cvSNgqTFK
        Z0rwKDCdPGTggSXr78A==
X-Received: by 2002:a05:620a:1590:b0:6a6:ad22:48c3 with SMTP id d16-20020a05620a159000b006a6ad2248c3mr20361828qkk.120.1654835051590;
        Thu, 09 Jun 2022 21:24:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+8KB9OIkcnTiQSNEP1TGhe1TdI+D6n3XifUvhh4KrPruAxu3HijBDvq/Pwt6NZUchCG/jgQ==
X-Received: by 2002:a05:620a:1590:b0:6a6:ad22:48c3 with SMTP id d16-20020a05620a159000b006a6ad2248c3mr20361822qkk.120.1654835051357;
        Thu, 09 Jun 2022 21:24:11 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b9-20020ac87549000000b0030515120916sm2061269qtr.44.2022.06.09.21.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 21:24:10 -0700 (PDT)
Date:   Fri, 10 Jun 2022 12:24:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/297: fix the delta time based on stat
Message-ID: <20220610042405.z2ou4uwwgoiympxx@zlang-mailbox>
References: <20220610023553.24418-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610023553.24418-1-wangyugui@e16-tech.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 10, 2022 at 10:35:53AM +0800, Wang Yugui wrote:
> stat -c '%Y' report seconds as int, so the delta 2.01s may result as 3s.
> 
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> ---
>  tests/generic/297 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/297 b/tests/generic/297
> index 6bdc3e1c..e3082202 100755
> --- a/tests/generic/297
> +++ b/tests/generic/297
> @@ -51,7 +51,7 @@ for i in $(seq 0 $fnr); do
>  	touch $TEST_DIR/after
>  	before=$(stat -c '%Y' $TEST_DIR/before)
>  	after=$(stat -c '%Y' $TEST_DIR/after)
> -	delta=$((after - before))
> +	delta=$((after - before -1)) # 2.01s may result as 3s; so -1

What issue is this change trying to fix? "timeout=8"s is not long enough?

Thanks,
Zorro

>  	test $delta -gt $timeout && break
>  done
>  
> @@ -64,7 +64,7 @@ $TIMEOUT_PROG -s INT ${kill_after}s $XFS_IO_PROG -f -c "reflink $testdir/file1 0
>  touch $TEST_DIR/after
>  before=$(stat -c '%Y' $TEST_DIR/before)
>  after=$(stat -c '%Y' $TEST_DIR/after)
> -delta=$((after - before))
> +delta=$((after - before - 1)) # 2.01s may result as 3s; so -1
>  echo "reflink of $n bytes took $delta seconds" >> $seqres.full
>  test $delta -gt $timeout && _fail "reflink didn't stop in time, n=$n t=$delta"
>  
> -- 
> 2.36.1
> 

