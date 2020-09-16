Return-Path: <SRS0=FsZq=CZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082F2C433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 17:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F2822287
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Sep 2020 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ltdlf9+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIPRHl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Sep 2020 13:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726764AbgIPRFj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Sep 2020 13:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/agz4GNcXrJHHBE6tYbNPsvfJC8Zssrd12CYI04k6w=;
        b=Ltdlf9+IowrlD1QoGb+FOhpTK8ltFam5R0TkJTWXv+w3VxHLHzVevv4mNnoAC5iWaXhOHr
        0g2+MrtuP27yBIEenx9um3QWgeJn5l/Qb6zHvT4PDDm2N0UXUkzSajYI7ZOwy+UHZCTcBp
        +hgfKIZto0d2QRCXemzTyQK1mRbWXP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-RcmA32exNnaQ7U946tbc5Q-1; Wed, 16 Sep 2020 07:25:37 -0400
X-MC-Unique: RcmA32exNnaQ7U946tbc5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E1C8186DD23
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:25:36 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A2885DA71
        for <fstests@vger.kernel.org>; Wed, 16 Sep 2020 11:25:35 +0000 (UTC)
Date:   Wed, 16 Sep 2020 19:39:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 17/24] xfs: refactor _xfs_check calls to the scratch
 device
Message-ID: <20200916113935.GH2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013428386.2923511.798805055641192515.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013428386.2923511.798805055641192515.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:44:43PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Use _scratch_xfs_check, not _xfs_check $SCRATCH_DEV.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/291 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/291 b/tests/xfs/291
> index 8a4b1354..adef2536 100755
> --- a/tests/xfs/291
> +++ b/tests/xfs/291
> @@ -102,7 +102,7 @@ done
>  _scratch_unmount
>  # Can xfs_repair and xfs_check cope with this monster?
>  _scratch_xfs_repair >> $seqres.full 2>&1 || _fail "xfs_repair failed"
> -_xfs_check $SCRATCH_DEV >> $seqres.full 2>&1 || _fail "xfs_check failed"
> +_scratch_xfs_check >> $seqres.full 2>&1 || _fail "xfs_check failed"
>  
>  # Yes they can!  Now...
>  # Can xfs_metadump cope with this monster?
> 

