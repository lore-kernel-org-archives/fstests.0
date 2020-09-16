Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5706C433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8312087D
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZMJFCLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgIPCWG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:22:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54564 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726028AbgIPCWG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 22:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600222925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NIUGLfp0t0ibv6JtyAiJcTcUHBR7RNfRDZQmthsG/To=;
        b=cZMJFCLkAX/R6LlQFaGnK/PAG7rP1URFPVosQBrqG2eCzW8PyP9RRWZRGLZcNOELDywyYl
        No3tcwNEMNz8K6A5YohMSDkuvBxAzuEQLxGbglt8MCFgbxPm+dup2mAzrUNMCEhfbLpjWo
        gXRkra7qamSBpFvHWpmFDUB+RWB4NGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-Sk5ueJxrNhCVirkISg6rHg-1; Tue, 15 Sep 2020 22:22:03 -0400
X-MC-Unique: Sk5ueJxrNhCVirkISg6rHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 442411074648
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 02:22:02 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3957702E7
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 02:22:01 +0000 (UTC)
Date:   Wed, 16 Sep 2020 10:35:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 08/24] xfs: replace open-coded calls to xfs_logprint with
 helpers
Message-ID: <20200916023559.GZ2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013422703.2923511.4608245885181531356.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013422703.2923511.4608245885181531356.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:47PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Use the test/scratch xfs_logprint helpers.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/135 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/135 b/tests/xfs/135
> index cc505980..9783cfc2 100755
> --- a/tests/xfs/135
> +++ b/tests/xfs/135
> @@ -48,7 +48,7 @@ for i in 16 32 64 128 256; do
>  	_scratch_xfs_db -x -c "logformat -c 3 -s $lsunit" | \
>  		tee -a $seqres.full
>  	# don't redirect error output so it causes test failure
> -	$XFS_LOGPRINT_PROG $SCRATCH_DEV >> $seqres.full
> +	_scratch_xfs_logprint >> $seqres.full
>  done
>  
>  # success, all done
> 

