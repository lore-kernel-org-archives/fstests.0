Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09616C43461
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B8F2087D
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 02:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrSb9UVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIPCPK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbgIPCPG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 22:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600222505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kj+RawwgNFcBqbnyn2jgmmTKUSQn4PwW/+ofL7tamo=;
        b=FrSb9UVGAw5THG23+kxRKbVj5SdggpDWwDynkI0KNGlr+ClOXJroljmJc9e4LZlFueB1L9
        cPBRNEIW+NV1rHf9/iU6YpssmfnN1RifQrgjSG5d3AXLGcvTJgL4BpHGIp7NuzfIwyNrz7
        SQAI4gcRwe1vPgiR14CE7bUhHCjTWBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-AfG-tLSWMgWihd96CkrmdA-1; Tue, 15 Sep 2020 22:15:03 -0400
X-MC-Unique: AfG-tLSWMgWihd96CkrmdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39BC61005E6E
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 02:15:02 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3B0C2C31E
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 02:15:01 +0000 (UTC)
Date:   Wed, 16 Sep 2020 10:28:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 07/24] xfs/{111,137}: replace open-coded calls to repair
 with _scratch_xfs_repair
Message-ID: <20200916022859.GY2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013422059.2923511.8441653519485642397.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013422059.2923511.8441653519485642397.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:40PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/111 |    2 +-
>  tests/xfs/137 |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/tests/xfs/111 b/tests/xfs/111
> index 0db33cb8..1f778966 100755
> --- a/tests/xfs/111
> +++ b/tests/xfs/111
> @@ -62,7 +62,7 @@ $XFS_FSR_PROG -g $SCRATCH_MNT | _filter_scratch
>  
>  # Fix up intentional corruption so test can pass
>  _scratch_unmount
> -$XFS_REPAIR_PROG $SCRATCH_DEV >> $seqres.full 2>&1
> +_scratch_xfs_repair >> $seqres.full 2>&1
>  
>  status=0
>  exit
> diff --git a/tests/xfs/137 b/tests/xfs/137
> index 79106c66..c10860bb 100755
> --- a/tests/xfs/137
> +++ b/tests/xfs/137
> @@ -64,11 +64,11 @@ else
>  fi
>  
>  # verify that repair detects invalid LSNs as well
> -$XFS_REPAIR_PROG -n $SCRATCH_DEV >> $seqres.full 2>&1 || \
> +_scratch_xfs_repair -n >> $seqres.full 2>&1 || \
>  	echo repair failure detected
>  
>  # repair for real so the post-test check can verify repair fixed things up
> -$XFS_REPAIR_PROG $SCRATCH_DEV >> $seqres.full 2>&1
> +_scratch_xfs_repair >> $seqres.full 2>&1
>  
>  # success, all done
>  status=0
> 

