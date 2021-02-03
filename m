Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C850DC433DB
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Feb 2021 16:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653DB64F84
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Feb 2021 16:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhBCQXe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhBCQXd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Feb 2021 11:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612369325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICWJx4U2adppRDDBtUd1WuII3N4DJD/7QKLzoOX7EPs=;
        b=XVuOFXQRHA+Qs8JFxEI8t7yjbDy8Xcio1bGI5XZJ3ztgakQYp/ftzusEbbGEdNVmfPDBsd
        puz5r56fP5qZTK9YXqbbUST/g3is4ByA/h85hFwo/3n8WtV1+C2mK4oPcEFIpjSxlXLlHY
        NCQ3v6Zj2ljp9tUq/cdMRodxk+68KqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-XuGrNrafPzezWoLXgpBuBQ-1; Wed, 03 Feb 2021 11:22:04 -0500
X-MC-Unique: XuGrNrafPzezWoLXgpBuBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28E53AFA83
        for <fstests@vger.kernel.org>; Wed,  3 Feb 2021 16:22:03 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C445B5D9E3;
        Wed,  3 Feb 2021 16:22:02 +0000 (UTC)
Date:   Wed, 3 Feb 2021 11:22:01 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: don't silence fio error output
Message-ID: <20210203162201.GG3647012@bfoster>
References: <20210202062253.24478-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202062253.24478-1-zlang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 02, 2021 at 02:22:53PM +0800, Zorro Lang wrote:
> This case print both fio stdout and stderr to .full file, that cause
> we miss some unexpected failures when there's a bug. For example:
> 
>   file:io_u.c:1803, func=io_u error, error=Block device required
> 
> This's an regression issue we find on a downstream kernel, not in
> upstream. So release unexpected fio error output to find more issues.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---

Seems reasonable:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/generic/095 | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/095 b/tests/generic/095
> index 9afaa761..30fe77a5 100755
> --- a/tests/generic/095
> +++ b/tests/generic/095
> @@ -98,8 +98,11 @@ _require_fio $fio_config
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
>  
> +# There's a known EIO failure to report collisions between directio and buffered
> +# writes to userspace, refer to upstream linux 5a9d929d6e13. So ignore EIO error
> +# at here.
> +$FIO_PROG $fio_config --ignore_error=,EIO --output=$seqres.full
>  echo "Silence is golden"
> -$FIO_PROG $fio_config >>$seqres.full 2>&1
>  
>  # xfs generates WARNINGs on purpose when applications mix buffered/mmap IO with
>  # direct IO on the same file. On the other hand, this fio job has been proven
> -- 
> 2.29.2
> 

