Return-Path: <SRS0=nbej=YQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614BBCA9EB6
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 15:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBC12173B
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 15:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSnYNPLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406601AbfJWPUl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:20:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42590 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406620AbfJWPUk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Oct 2019 11:20:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id 21so1882868pfj.9
        for <fstests@vger.kernel.org>; Wed, 23 Oct 2019 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vR681c87X0SPTv4Aea8Vm4SvmiDLCHqHXpCoDV9s+KQ=;
        b=VSnYNPLnrBIq4xsZhZjZKYiw+WLfFuxZke/esLhOwKyYDRxoXqEni4JU4GP0UZXJiH
         M6nekzaxOD1ADyjUHYIVvWX3itqse8ldM6fUjlK5KWjXlD7Gn9Ftu1g+GViuwi7f3e88
         dnEp8JrgCvJyjs9Ej/Xfr090wZ8RcvpGlcjN+k4AiUNcK4cL8GUEt9YBN6CbxcjFDWuz
         /924WO+mMCpuJGFv0l/7EJbufhAP3Hmo4BPjc5jg8rGlylI5wxmOOggggH8zcArH7w5P
         AemaCgiQFcM2HthEu6dLd2WqOXC762NImJ7xDnKjIe5jydandJR4yjXSx+8JzHi+sKp9
         M/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vR681c87X0SPTv4Aea8Vm4SvmiDLCHqHXpCoDV9s+KQ=;
        b=JXn6d0fl+qcT6QzBFDjotumD33eo/iRJWFY8u+bZEDY7yvvMG8OgAlcuob1y2Helfn
         T8gRsDkJ6ewfaiLKLlN7FYtpZSeRO23athYMCQpKiXcMlC3oSphBAdhi147KpbaMe1K6
         C9VYSHbRZVkWwd7BUIWr0aA77V4xgVcNDEKwl1JlcRFTkbfxgqnaEmuWA/xluLrig9/a
         s2ZkBP81gLWz74YqTXc7I1NqDlKf5yCgQ0wjBviAAt6pc9vD6Kmo/QlhhEepU9Urvw58
         67/1WcvmMwMsmPgwCk3c9XAGoU0WJGYcbA61zy9epfVQpV+/zqucmrg54O6S+W++yPjx
         jUsw==
X-Gm-Message-State: APjAAAVP99Ceg918/o37Tx81CEAf147WHTZFAM036X5AEe/5XwvTWEcP
        fEuLz1M5Vo+WIfpWKTW5Rnc=
X-Google-Smtp-Source: APXvYqzDlhJLvUBxmcd24zcQn9wlqhFfPuG7e7YBOikBiMeJKo2eiup7gg/Zm8+ZFLZKBXmZFPNDjg==
X-Received: by 2002:a17:90a:8c07:: with SMTP id a7mr570276pjo.93.1571844039875;
        Wed, 23 Oct 2019 08:20:39 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id ce16sm21948864pjb.29.2019.10.23.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 08:20:38 -0700 (PDT)
Date:   Wed, 23 Oct 2019 23:20:32 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     darrick.wong@oracle.com, ebiggers@google.com, yi.zhang@huawei.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH xfstests v3] fstests: Add path $here before src/<file>
Message-ID: <20191023152024.GC2543@desktop>
References: <1571664946-105756-1-git-send-email-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571664946-105756-1-git-send-email-chengzhihao1@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 21, 2019 at 09:35:46PM +0800, Zhihao Cheng wrote:
> Calling src/<file> without path '$here' may cause the problem that the
> file cannot be found.
> For example, Running generic/192 with overlayfs(Let ubifs as base fs)
> yields the following output:
> 
>   generic/192 - output mismatch
>      QA output created by 192
>      sleep for 5 seconds
>      test
>     +./common/rc: line 316: src/t_dir_type: No such file or directory
>      delta1 is in range
>      delta2 is in range
>     ...
> 
> When the use case fails, the call stack in generic/192 is:
> 
>   local unknowns=$(src/t_dir_type $dir u | wc -l)	common/rc
>   _supports_filetype					common/rc
>   _overlay_mount					common/overlay
>   _overlay_test_mount					common/overlay
>   _test_mount						common/rc
>   _test_cycle_mount					generic/192
> 
> Before _test_cycle_mount() being invoked, generic/192 executed 'cd /'
> to change work dir from 'xfstests-dev' to '/', so src/t_dir_type was not
> found.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks a lot for the work!

I found that some tests started to fail after applying this patch, they
are

generic/093 generic/125 generic/462

as these tests run the test binary as a regular user (either via su or
_user_do helper), and "$here" may contain path component that a regular
user can't access, e.g. /root. So I skip adding $here prefix in above
tests and add comments accordingly.

Thanks,
Eryu
