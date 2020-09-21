Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4670CC43463
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 02:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E694F2078E
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 02:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akfoHahE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIUCr6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 20 Sep 2020 22:47:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726104AbgIUCr6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 Sep 2020 22:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600656477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvrO1ekBqVsW+Yzw5ZPy8FmC9GoI9w9kuLOZN8pgLvs=;
        b=akfoHahEUlldpgxVwZmCPXoNvvvUTsygRQ7xtC6PNlQ0In+2nrJPMiBnpQG4atMD06fSXT
        F/D93c4m2fFpe31NKi9YrrBJ9LtyfF/rGeRlprDkSHdzlXuctfFMd1sKLtvU/2Jd0ktGfN
        wL4SS+YD5twpaOCpbATblmpm2Sk5QHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-eG8RLIM5Pk-4TccYuO7uXA-1; Sun, 20 Sep 2020 22:47:52 -0400
X-MC-Unique: eG8RLIM5Pk-4TccYuO7uXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 842DD1074647;
        Mon, 21 Sep 2020 02:47:51 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F064F60C47;
        Mon, 21 Sep 2020 02:47:50 +0000 (UTC)
Date:   Mon, 21 Sep 2020 11:01:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     guaneryu@gmail.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v5 0/5] fsstress,fsx: add io_uring test and do some fix
Message-ID: <20200921030159.GQ2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: guaneryu@gmail.com, fstests@vger.kernel.org
References: <20200911071555.31506-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911071555.31506-1-zlang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 11, 2020 at 03:15:50PM +0800, Zorro Lang wrote:
> This patchset tries to add new IO_URING test into fsstress [1/5] and fsx
> [4/5 and 5/5]. And then do some changes and bug fix by the way [2/5 and 3/5].
> 
> fsstress and fsx are important tools in xfstests to do filesystem I/Os test,
> lots of test cases use it. So add IO_URING operation into fsstress and fsx
> will help to cover IO_URING test from fs side.
> 
> I'm not an IO_URING expert, so cc io-uring@ list, please feel free to
> tell me if you find something wrong or have any suggestions to improve
> the test.

Hi Eryu,

We're waiting for this patchset get merged. It's been reviewed-by Brian, do you
still need more ACK?

Thanks,
Zorro

> 
> V2 did below changes:
> 1) 1/4 change the definition of URING_ENTRIES to 1
> 2) 2/4 change the difinition of AIO_ENTRIES to 1, undo an unrelated changed line
> 3) 4/4 turn to use io_uring_prep_readv/io_uring_prep_writev, due to old
>        liburing(0.2-2) doesn't support io_uring_prep_read/io_uring_prep_write.
> 
> V3 changed io_uring_submit(&ring) to io_uring_submit_and_wait(&ring, 1). I'm
> not sure if this's the real mean of Jens Axboe's review point, please check.
>   https://marc.info/?l=fstests&m=159811932808057&w=2
> 
> V4 did below changes:
> 1) 1/5 change the "goto" related code of do_uring_rw()
> 2) 3/5 similar change as above
> 3) 4/5 new patch, separated from original 4/4 patch
> 3) 5/5 change #elif to #else
> 4) 5/5 change __uring_rw to uring_rw.
> 5) 5/5 change the loop logic in uring_rw().
> 
> V5 did below changes:
> 1) 1/5 turn to use (fd != -1)
> 2) 3/5 turn to use (fd != -1)
> 3) 5/5 change res to ret, change res2 to res.
> 
> Thanks,
> Zorro
> 
> 
> 

