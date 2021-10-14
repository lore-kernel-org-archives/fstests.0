Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C5FC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Oct 2021 15:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC1860EBB
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Oct 2021 15:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhJNPdp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhJNPdp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Oct 2021 11:33:45 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF22C061753
        for <fstests@vger.kernel.org>; Thu, 14 Oct 2021 08:31:40 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id z24so6073916qtv.9
        for <fstests@vger.kernel.org>; Thu, 14 Oct 2021 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NYhpjnJe3Ldv/p/ooJYD2dzTW/NkIazd2O5VT97PixQ=;
        b=4yaidbKW+Ktrie9xc6IEgmq4y7t3HY94yHtAfCWZtkerxO/JKwLNlPA/I9/eRetLB0
         7ikkSK9d4VTa/pUBBYqYp9uCbLCJ3uIAplIBzFMvCw6CmFbIW8TxTafn4zvOwgUnXtkS
         q2tMM2fG7hlnPzHkbMYRjKz1p2QfLVOVFXso8x2ZmA02m9ZSOgWVHn1H/Gj76//MI+3K
         bLD6MV5D4pp3rAAsmeFG6rve5R+UkIr4bZFpNW09b+KB2TiGUwmi6dR2E+M8OQsebWpa
         9toP2n/9UnRrSobNnLoSnex/mt8jSZzwDb3DL2LEu5LU+wn6bILLBW4C5HXn3IJuW5DZ
         uGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYhpjnJe3Ldv/p/ooJYD2dzTW/NkIazd2O5VT97PixQ=;
        b=rLoE2HuUZSiO6DYn17SDpPyez/vQdUAZghxmKmE+KNm8oMh0B9Clw7FdYtxxnfAMRG
         x5YWciXg768foJB0NEpF9JxAanXMw7yAm5uOlldqtPTzQev2D9JrF8fRmn6yLrZW2ymt
         aig9mZN0oFR7ZI382Py5ZPkmbrbRI9we5aPHCUbWcWilIDRFuehuvCRUC5T82+tVlUIv
         kqUhGI5N7aFAfaQP75+3/qr3arMfrDxgHnjzpiNg/gu+WU0CUuVFSIdBVhxnSiVbiI1W
         S4ZfQz5nKoMpCbqJYgBdGQ/P6B8UHVa89Ntv/o6YA+sqi9QdSE11nUr1mMHeACZtbsj6
         225Q==
X-Gm-Message-State: AOAM531EkAYNg2hf2r7EiQ0DF3SGtkUgIQc3o/98SGm3cXrHARRHigb7
        B50XNFsKYH1VrcvdXyFu8o0nqQ==
X-Google-Smtp-Source: ABdhPJwrJQfOvT9dSBxfTojbH6s+nfajckVh1y3M4cpOd7mlQm5NUUpFruxcOHe1omJMx9T9fGoE9g==
X-Received: by 2002:a05:622a:1652:: with SMTP id y18mr7407357qtj.226.1634225499277;
        Thu, 14 Oct 2021 08:31:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q6sm1506854qtn.65.2021.10.14.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:31:38 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:31:37 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: perf/001
Message-ID: <YWhNWZrt/QMVOuWi@localhost.localdomain>
References: <d236c364-3bf6-d404-e3c4-2d82b7db6355@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d236c364-3bf6-d404-e3c4-2d82b7db6355@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 13, 2021 at 03:39:07PM +0800, Anand Jain wrote:
> 
> perf/001 fails to update the SQL with the key trim_bw_bytes.
> 
> Traceback (most recent call last):
>   File "/xfstests-dev/src/perf/fio-insert-and-compare.py", line 31, in
> <module>
>     result_data.insert_result(data)
>   File "/xfstests-dev/src/perf/ResultData.py", line 45, in insert_result
>     self._insert_obj('fio_jobs', job)
>   File "/xfstests-dev/src/perf/ResultData.py", line 37, in _insert_obj
>     cur.execute(cmd, tuple(values))
> sqlite3.OperationalError: table fio_jobs has no column named trim_bw_bytes
> 
> I tried to add the missing keys (which are probably present only in the
> current version of the fio) as below, but the error is still the same. Any
> inputs, how to fix this?
> 

I think this was a failed experiment to add performance testing to xfstests, I
think we should just rip it out.  Thanks,

Josef
