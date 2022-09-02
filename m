Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3881AECAAD3
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Sep 2022 02:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiIBC2E (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 1 Sep 2022 22:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBC2D (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 1 Sep 2022 22:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC13D8C
        for <fstests@vger.kernel.org>; Thu,  1 Sep 2022 19:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662085681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YYdvjm5GB+jrMEGjl5J8cEs5EIE6VGdkpOoFW4clzEM=;
        b=PcR+kQpcQG2k2CAbMGwpS9lpxUTZS9pWhnqGdaC3lr5tMf+HZadKFmJA/hHCWXAZi79T1M
        4JqLV5TuBtoo3JfV/npmGN6hGsRlV5BNwLqjnqKOdwukgp3fD/vrew22qP+wCwmywFWQS9
        q+hHB8BEQCBh5rWF2Fy2ZUDDB4Ty36E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-xaWukapsP6O-WAjCVs97xg-1; Thu, 01 Sep 2022 22:27:58 -0400
X-MC-Unique: xaWukapsP6O-WAjCVs97xg-1
Received: by mail-qt1-f200.google.com with SMTP id fv24-20020a05622a4a1800b003445e593889so600402qtb.2
        for <fstests@vger.kernel.org>; Thu, 01 Sep 2022 19:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YYdvjm5GB+jrMEGjl5J8cEs5EIE6VGdkpOoFW4clzEM=;
        b=5ZINQJHxDtBWVgaLimXnr/BIiWb290XPxy78EKiKEHcrMWuWlYLCmGiv9RfJcZimSg
         yMrVN1fiTr9GyJ69BBydyUtEvfTZSmV2B2RDJGiD2LTMN6LPVMB3MSxwWAnhUgXUMEz4
         zBOaADAVwvBe8/oWubUGn4q8gEWH5hIIfFgzRwqUk3CIFKQqq0YBnQ2oWe6gNaSOAajW
         dZhi4iCVgMA6Sn7BbyMOQgTubriYl7fiED02L6PRSdoZlml0gPENtxqdc5VdXIz5cMAc
         xRwTI5d/FYfNzLxopFncGp9lJiRBZs7+zh0hJjYdrJCZGDj1RZ09af4StnDYoGN50e3h
         wElA==
X-Gm-Message-State: ACgBeo0/TR73VMHE8q/ejsS5XHS9PGMaYTmqWXGKCE9bFxeknTxI3S7f
        N/7KAtITueUA08iRQPryD0O2BL7HA1PqWWdg18ozu4OncShRrk3y56raFAtTLu45u1yv4fY4m8S
        QmjvMSO6PyES/JbmLQQ==
X-Received: by 2002:a05:620a:254f:b0:6bb:dcb6:4279 with SMTP id s15-20020a05620a254f00b006bbdcb64279mr22595342qko.79.1662085677674;
        Thu, 01 Sep 2022 19:27:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5uHBPnNZ/mj1TyVajLNwrfC6qXsehPkmNkagFeRkqd+VT37EA+DWngOWa9DPLutnlS7HIAHg==
X-Received: by 2002:a05:620a:254f:b0:6bb:dcb6:4279 with SMTP id s15-20020a05620a254f00b006bbdcb64279mr22595335qko.79.1662085677423;
        Thu, 01 Sep 2022 19:27:57 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c8-20020a37e108000000b006b9264191b5sm471918qkm.32.2022.09.01.19.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 19:27:57 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:27:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix btrfs/271 failure due to missing source of
 fail_make_request
Message-ID: <20220902022751.4q7uvzzljzstakg3@zlang-mailbox>
References: <62ccab661ea8591cbc5f8b936fc4e0a47f2bfc86.1662063388.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ccab661ea8591cbc5f8b936fc4e0a47f2bfc86.1662063388.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 01, 2022 at 09:17:02PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The recent commit 49272aacac850c ("common: refactor fail_make_request
> boilerplate") moved _require_fail_make_request() from common/rc into
> common/fail_make_request, but it forgot to make btrfs/271 source this
> new file, so now the test always fails:
> 
>   $ ./check btrfs/271
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian9 6.0.0-rc2-btrfs-next-122 #1 SMP PREEMPT_DYNAMIC Mon Aug 29 09:45:59 WEST 2022
>   MKFS_OPTIONS  -- /dev/sdb
>   MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1
> 
>   btrfs/271 4s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad)
>       --- tests/btrfs/271.out	2022-08-08 10:36:20.404812893 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad	2022-09-01 21:12:29.689481068 +0100
>       @@ -1,4 +1,5 @@
>        QA output created by 271
>       +/home/fdmanana/git/hub/xfstests/tests/btrfs/271: line 17: _require_fail_make_request: command not found
>        Step 1: writing with one failing mirror:
>        wrote 8192/8192 bytes at offset 0
>        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/271.out /home/fdmanana/git/hub/xfstests/results//btrfs/271.out.bad'  to see the entire diff)
>   Ran: btrfs/271
>   Failures: btrfs/271
>   Failed 1 of 1 tests
> 
> Fix that by sourcing common/fail_make_request at btrfs/271.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks for fixing it! Looks like we missed the btrfs/271 ...

  $ grep -rsn _require_fail_make_request tests/
  tests/btrfs/271:16:_require_fail_make_request
  tests/btrfs/088:26:_require_fail_make_request
  tests/btrfs/150:25:_require_fail_make_request
  tests/generic/019:21:_require_fail_make_request

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/271 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/271 b/tests/btrfs/271
> index c21858d1..681fa965 100755
> --- a/tests/btrfs/271
> +++ b/tests/btrfs/271
> @@ -10,6 +10,7 @@
>  _begin_fstest auto quick raid
>  
>  . ./common/filter
> +. ./common/fail_make_request
>  
>  _supported_fs btrfs
>  _require_scratch
> -- 
> 2.35.1
> 

