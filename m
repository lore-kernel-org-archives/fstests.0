Return-Path: <SRS0=r5/b=CK=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9981C433E2
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Sep 2020 05:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA972087D
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Sep 2020 05:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBLKie7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAFDW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:03:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32573 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726006AbgIAFDV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Sep 2020 01:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598936600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9GMpXEZUGyPdgNQVwfBNqbATzTMmK9KLOKqX39oHHFI=;
        b=JBLKie7NEMxw4zDXewCF3I3C5Eqewl4GGV6goKV8easOHOWkHKSyPEK6gdug5RkHDvxBl2
        x2St+wfjWBhKWUb/qEtExQBqgOewHrF5uO9LzYnGqma/8LyOhQSPDqFoCBIwGbKcgwhzLQ
        yaIRa15qu+NHZRuyD4gaMKm6TRuAWEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-_9C72mjXPlSO3qLpt6jACg-1; Tue, 01 Sep 2020 01:03:16 -0400
X-MC-Unique: _9C72mjXPlSO3qLpt6jACg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F9341888A1F;
        Tue,  1 Sep 2020 05:03:15 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7E4E7D511;
        Tue,  1 Sep 2020 05:03:14 +0000 (UTC)
Date:   Tue, 1 Sep 2020 13:16:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     axboe@kernel.dk
Subject: Re: [PATCH v3 0/4] fsstress,fsx: add io_uring test and do some fix
Message-ID: <20200901051642.GY2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org, axboe@kernel.dk
References: <20200823063032.17297-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823063032.17297-1-zlang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 23, 2020 at 02:30:28PM +0800, Zorro Lang wrote:
> This patchset tries to add new IO_URING test into fsstress [1/4] and fsx [4/4].
> And then do some changes and bug fix by the way [2/4 and 3/4].
> 
> fsstress and fsx are important tools in xfstests to do filesystem I/Os test,
> lots of test cases use it. So add IO_URING operation into fsstress and fsx
> will help to cover IO_URING test from fs side.
> 
> I'm not an IO_URING expert, so cc io-uring@ list, please feel free to
> tell me if you find something wrong or have any suggestions to improve
> the test.
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

Ping, any review point about this version, it only has a little change.

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> 
> 

