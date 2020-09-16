Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16497C43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74932087D
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYo/Q0n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIPC3L (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbgIPC26 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 22:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600223335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ge5zwYZD2ssJO5ZPtt2DyFRH+aA63YyBQsBEigrZSps=;
        b=MYo/Q0n9lIauRpE2jtmjAOVRCulOjQRF82hIN0OndNzhYupLAzxCGTrOaodex+9+1LJYkm
        7GCh9Pny2NI2g3pQcqa1yGBLC5OMJGdD+kbg6Rh4CLZisez9Zbvj597c+7VAUWqVp9y1da
        P2d7dqZbW8IZal/x9/+AGQjH82vQ3no=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-ph96LNd1MbiDwF3FMEytjQ-1; Tue, 15 Sep 2020 22:28:50 -0400
X-MC-Unique: ph96LNd1MbiDwF3FMEytjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B31C81868409;
        Wed, 16 Sep 2020 02:28:49 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DC2B60E1C;
        Wed, 16 Sep 2020 02:28:48 +0000 (UTC)
Date:   Wed, 16 Sep 2020 10:42:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 09/24] xfs/070: add scratch log device options to direct
 repair invocation
Message-ID: <20200916024247.GA2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013423329.2923511.3252823001209034556.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013423329.2923511.3252823001209034556.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:53PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  tests/xfs/070 |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/070 b/tests/xfs/070
> index 5d52a830..313864b7 100755
> --- a/tests/xfs/070
> +++ b/tests/xfs/070
> @@ -41,9 +41,11 @@ _cleanup()
>  _xfs_repair_noscan()
>  {
>  	# invoke repair directly so we can kill the process if need be
> +	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> +		log_repair_opts="-l $SCRATCH_LOGDEV"
>  	[ "$USE_EXTERNAL" = yes ] && [ -n "$SCRATCH_RTDEV" ] && \
>  		rt_repair_opts="-r $SCRATCH_RTDEV"
> -	$XFS_REPAIR_PROG $rt_repair_opts $SCRATCH_DEV 2>&1 |
> +	$XFS_REPAIR_PROG $log_repair_opts $rt_repair_opts $SCRATCH_DEV 2>&1 |
>  		tee -a $seqres.full > $tmp.repair &

Why not use _scratch_xfs_repair at here?

Thanks,
Zorro

>  	repair_pid=$!
>  
> 

