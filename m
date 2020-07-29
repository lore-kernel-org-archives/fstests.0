Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B091DC433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 16:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD60206D8
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 16:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvdqtC7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgG2Qzy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:55:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726385AbgG2Qzy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jul 2020 12:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596041752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=trcwX941kzbf865JtJQp651RhHuqQuH1uYun9W0C7/A=;
        b=dvdqtC7geAX1TqWgcigN5fJOX1ct34WOm6ElOirMVZQjthH9vcKwOQTSR+v3HUfOUZqy6i
        xqrTI5B40+y9ElCnnosaOnUkjTbl/xcbSU5AmpZvh2WeogN1JtfgsxQJpqx46cymu6rhoZ
        CoYOHICZmqqFvcEtKRxOVs1NInynv2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-vVNJoMTsN1qrw8CG7HNP-g-1; Wed, 29 Jul 2020 12:55:50 -0400
X-MC-Unique: vVNJoMTsN1qrw8CG7HNP-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5E6980183C;
        Wed, 29 Jul 2020 16:55:49 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DA515DA76;
        Wed, 29 Jul 2020 16:55:48 +0000 (UTC)
Date:   Thu, 30 Jul 2020 01:08:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v2] xfs/030: repair should actually find the zeroed block
 pointer in the agfl
Message-ID: <20200729170811.GJ2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        fstests <fstests@vger.kernel.org>
References: <20200729161443.GA7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729161443.GA7600@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 29, 2020 at 09:14:43AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> In xfs/030, we zero the entire AGFL which makes it corrupt because the
> AG superblock block is /never/ free.  In commit dcd6c2e1 ("xfs_repair:
> convert to libxfs_verify_agbno") we enhanced repair to complain about
> zeroed entries in the AGFL, so add that to the golden output.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
> v2: point out which commit we're testing

Thanks for pointing out the commit.
Reviewed-by: Zorro Lang <zlang@redhat.com>

> ---
>  tests/xfs/030.out |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/030.out b/tests/xfs/030.out
> index 4a7c4b8b..53299438 100644
> --- a/tests/xfs/030.out
> +++ b/tests/xfs/030.out
> @@ -105,6 +105,7 @@ Phase 1 - find and verify superblock...
>  Phase 2 - using <TYPEOF> log
>          - zero log...
>          - scan filesystem freespace and inode maps...
> +bad agbno AGBNO in agfl, agno 0
>          - found root inode chunk
>  Phase 3 - for each AG...
>          - scan and clear agi unlinked lists...
> 

