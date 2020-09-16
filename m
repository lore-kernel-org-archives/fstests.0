Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16895C433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 20:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A463E21D1B
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 20:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfmyZn6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgIPUeH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgIPRMy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Sep 2020 13:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600276331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCnyhxSmKF8P6lnAJEr7cg9JvXN2aPIvaTDGaBOlIo4=;
        b=dfmyZn6hdjQjTGF7PC4gnHAPYPeL0J77XpX6VM7RoNdmrJr56YlXS7b9x8hbrBwxMNcHza
        yGL/lEHoR7a5qI/mZs8px7SeKVJBNhsc7Y7sV6uEoazzFcqVqgDsq9FLMCQgqtTVekHMUD
        oAXMD5uYhSx+DnbrYaknjMRtJdyMRXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-gpW7HsCVPHGpqUgTSRSVtw-1; Wed, 16 Sep 2020 07:34:31 -0400
X-MC-Unique: gpW7HsCVPHGpqUgTSRSVtw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C14301017DD1
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:34:30 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BF4478806
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:34:29 +0000 (UTC)
Date:   Wed, 16 Sep 2020 19:48:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 19/24] xfs/424: disable external devices
Message-ID: <20200916114829.GJ2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013429643.2923511.17476130717295164051.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013429643.2923511.17476130717295164051.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:44:56PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> This test uses an open-coded call to mkfs, so we need to disable the
> external devices so that _scratch_xfs_db doesn't get confused.  We also
> disable the post-check fsck because it's run by the parent ./check
> program, which won't know that we didn't use the external devices.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/424 |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/424 b/tests/xfs/424
> index 66d79458..4907cf0f 100755
> --- a/tests/xfs/424
> +++ b/tests/xfs/424
> @@ -47,7 +47,13 @@ rm -f $seqres.full
>  # Modify as appropriate
>  _supported_os Linux
>  _supported_fs xfs
> -_require_scratch
> +
> +# Since we have an open-coded mkfs call, disable the external devices and
> +# don't let the post-check fsck actually run since it'll trip over us not
> +# using the external devices.
> +_require_scratch_nocheck
> +export SCRATCH_LOGDEV=
> +export SCRATCH_RTDEV=
>  
>  echo "Silence is golden."
>  
> 

