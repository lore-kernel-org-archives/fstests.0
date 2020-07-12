Return-Path: <SRS0=q2aQ=AX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828CFC433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Jul 2020 11:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5954420725
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Jul 2020 11:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlM0oa8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgGLLKD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Jul 2020 07:10:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24560 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbgGLLKD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Jul 2020 07:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594552200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z8iVH0YQXEn/vFF+BjIlUAcEOwmAeBg8c6tXmgKbNi4=;
        b=hlM0oa8Q6TrkUzwdY4IQXbdR3cNAupr94Hz8oHSv7VQkAOKjCl/FlEfl6di49ra+BxD7MC
        jSrGApRqIjO3X6f4bqMsoPo4nLLb3C1kRHw06nClxUjr8iS3TiOkPGagXxZWLKxFNUvmHr
        rR3E2RM/ONG8/7FSn4gPcwG4MdZ6qbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-tCFS3JPNOaqp-V9TpelEKQ-1; Sun, 12 Jul 2020 07:09:58 -0400
X-MC-Unique: tCFS3JPNOaqp-V9TpelEKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E96F10059AF;
        Sun, 12 Jul 2020 11:09:57 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF6C45D9D3;
        Sun, 12 Jul 2020 11:09:56 +0000 (UTC)
Date:   Sun, 12 Jul 2020 19:22:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Vladimir Zapolskiy <vladimir@tuxera.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: reorder output to stderr and stdout from
 _scratch_mkfs
Message-ID: <20200712112243.GV1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Vladimir Zapolskiy <vladimir@tuxera.com>,
        fstests@vger.kernel.org
References: <20200711092319.14441-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711092319.14441-1-vladimir@tuxera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jul 11, 2020 at 12:23:19PM +0300, Vladimir Zapolskiy wrote:
> The change fixes false positives from generic/554 and generic/565 tests,
> when supplementary output of an mkfs utility to stderr apprears to be mixed
> into the test output, which results into non-empty diff with the expected
> output found in *.out files.
> 
> The change unifies _scratch_mkfs redirections among all generic tests, these
> two modified tests are the only ones with the swapped order of output
> redirections.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
> ---
>  tests/generic/554 | 2 +-
>  tests/generic/565 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/554 b/tests/generic/554
> index eaf1f45a8d15..9a23c0eb729f 100755
> --- a/tests/generic/554
> +++ b/tests/generic/554
> @@ -38,7 +38,7 @@ _require_scratch
>  _require_xfs_io_command "copy_range"
>  _require_scratch_swapfile
>  
> -_scratch_mkfs 2>&1 >> $seqres.full
> +_scratch_mkfs >>$seqres.full 2>&1

Make sense to me. If the case hopes to catch the mkfs error, it can remove
the "2>&1" directly. Or I think it hopes to write both stderr and stdout into
$seqres.full.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _scratch_mount
>  
>  rm -f $seqres.full
> diff --git a/tests/generic/565 b/tests/generic/565
> index 41d85b919553..e23e97b763f8 100755
> --- a/tests/generic/565
> +++ b/tests/generic/565
> @@ -38,7 +38,7 @@ _require_test
>  _require_scratch
>  _require_xfs_io_command "copy_range"
>  
> -_scratch_mkfs 2>&1 >> $seqres.full
> +_scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
>  
>  
> -- 
> 2.25.1
> 

