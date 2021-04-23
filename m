Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D623AC433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEE961027
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 11:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhDWLOY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Apr 2021 07:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242160AbhDWLOV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Apr 2021 07:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619176424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IvAqS9c5/e3p2WfV3CDs1qqisTTUK/3Eui3oif3e9s=;
        b=DmaxW2c2fk0eLvB1flXxvQZCkY8XLggHj2/YJPdtnEnbw0rIav36wG2zJQgtI6yqIn8gTx
        LM7vUAR6OiM32NWQgFnOl2AJtv1Dxj6FcvSfLBFX/sX6UnkAc+naIhAoVbkOeRN/QxOVJl
        INjwocA/zBr+s5X0aThmDujcohdtLuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-f1EhkIjxP3uPhuuNageq7w-1; Fri, 23 Apr 2021 07:13:42 -0400
X-MC-Unique: f1EhkIjxP3uPhuuNageq7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA3F310054F6;
        Fri, 23 Apr 2021 11:13:41 +0000 (UTC)
Received: from bfoster (ovpn-112-25.rdu2.redhat.com [10.10.112.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6413C5C5FD;
        Fri, 23 Apr 2021 11:13:41 +0000 (UTC)
Date:   Fri, 23 Apr 2021 07:13:39 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, Jinhui Huang <huangjh.jy@fujitsu.com>
Subject: Re: [PATCH] xfs/145: Remove useless -f option for xfs_quota command
Message-ID: <YIKr47vkI1PsjJeY@bfoster>
References: <1619067943-3859-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619067943-3859-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 22, 2021 at 01:05:43PM +0800, Yang Xu wrote:
> Since it is a xfs specifal case, we don't need to use foreign filesystem mode.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> Signed-off-by: Jinhui Huang <huangjh.jy@fujitsu.com>
> ---

Seems reasonable. Any particular reason for this change, or just an
observation?

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  tests/xfs/145 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/145 b/tests/xfs/145
> index 3b3c375d..3ccbb923 100755
> --- a/tests/xfs/145
> +++ b/tests/xfs/145
> @@ -51,7 +51,7 @@ $FILEFRAG_PROG -v $SCRATCH_MNT/testy 2>&1 | grep -q delalloc || \
>  rm -f $SCRATCH_MNT/testy
>  
>  echo "Run test program"
> -$XFS_QUOTA_PROG -f -x -c 'report -ap' $SCRATCH_MNT >> $seqres.full
> +$XFS_QUOTA_PROG -x -c 'report -ap' $SCRATCH_MNT >> $seqres.full
>  $here/src/chprojid_fail $SCRATCH_MNT/blah
>  
>  # The regression we're testing for is an accounting bug involving delalloc
> @@ -64,7 +64,7 @@ $FILEFRAG_PROG -v $SCRATCH_MNT/blah 2>&1 | grep -q delalloc || \
>  	echo "file didn't get delalloc extents, test invalid?"
>  
>  # Make a note of current quota status for diagnostic purposes
> -$XFS_QUOTA_PROG -f -x -c 'report -ap' $SCRATCH_MNT >> $seqres.full
> +$XFS_QUOTA_PROG -x -c 'report -ap' $SCRATCH_MNT >> $seqres.full
>  
>  # success, all done
>  status=0
> -- 
> 2.23.0
> 

