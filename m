Return-Path: <SRS0=YiqY=32=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED55C2D0B1
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Feb 2020 04:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C9B214AF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Feb 2020 04:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4gNvF/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgBFEeR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Feb 2020 23:34:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44928 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727415AbgBFEeR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Feb 2020 23:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580963655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uT1YEnQpKR24TfgxPzf9UuCZNpuFKqUFfxsZs5GZejg=;
        b=F4gNvF/gOGa25nonREFB0hWDtTfy+yPTVtcqUJrA9yrM7WPaMvWnmBT2F2JM0WibuW9MIr
        i2Lh7TmQnCYxl7fZgG22E6kxiSlJkhRkDePUkhq2iJMeQCaYZhulTy42PoN2uUzeqYIeb4
        fJrERaUqsO+KbA0zOoa8pCYV1lLn5/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-rhf4SF8gMQ2rNNzsY9z-Ow-1; Wed, 05 Feb 2020 23:34:13 -0500
X-MC-Unique: rhf4SF8gMQ2rNNzsY9z-Ow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8BA91413;
        Thu,  6 Feb 2020 04:34:11 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D5D98DC0F;
        Thu,  6 Feb 2020 04:34:11 +0000 (UTC)
Date:   Thu, 6 Feb 2020 12:44:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] xfs/449: filter out "Discarding..." from output
Message-ID: <20200206044405.GP14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <158086090225.1989378.6869317139530865842.stgit@magnolia>
 <158086090849.1989378.625300470019425718.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158086090849.1989378.625300470019425718.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 04, 2020 at 04:01:48PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> xfsprogs 5.4 prints "Discarding..." if the disk supports the trim
> command.  Filter this out of the output because xfs_info and friends
> won't print that out.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  tests/xfs/449 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/449 b/tests/xfs/449
> index 7aae1545..83c3c493 100755
> --- a/tests/xfs/449
> +++ b/tests/xfs/449
> @@ -39,7 +39,7 @@ _require_scratch_nocheck
>  _require_xfs_spaceman_command "info"
>  _require_command "$XFS_GROWFS_PROG" xfs_growfs
>  
> -_scratch_mkfs > $tmp.mkfs
> +_scratch_mkfs | sed -e '/Discarding/d' > $tmp.mkfs

Looks good to me.

>  echo MKFS >> $seqres.full
>  cat $tmp.mkfs >> $seqres.full
>  
> 

