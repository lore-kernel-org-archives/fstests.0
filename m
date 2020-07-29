Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A355C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 15:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EC020829
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 15:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyoOXDCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgG2PwU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:52:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36009 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726341AbgG2PwT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jul 2020 11:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596037938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yu0IL7h/q6OEyVqB5oeRjwWB9ifeRX4IEvepjdTHd8I=;
        b=RyoOXDCD//qFL49xDSU3B2oGp4JWi37V/d4FkQ95QcYpNfhnWc6HgWuVpVC5PTmD2+0nzk
        7IZozRp9oqKvMHhLci5C2q6u0705fnccBk6NKpwHXN7LmQOULkL/ousyhOIfvkJTXuVE4g
        HXXBjfwTQtj+2cH1g0RRBROz71v0qsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-CnJ8jab_MzWK7lGRwMNFJA-1; Wed, 29 Jul 2020 11:52:16 -0400
X-MC-Unique: CnJ8jab_MzWK7lGRwMNFJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BACBD1902EA2;
        Wed, 29 Jul 2020 15:52:15 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3541A10013D7;
        Wed, 29 Jul 2020 15:52:14 +0000 (UTC)
Date:   Thu, 30 Jul 2020 00:04:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] xfs/030: repair should actually find the zeroed block
 pointer in the agfl
Message-ID: <20200729160437.GI2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        fstests <fstests@vger.kernel.org>
References: <20200729145322.GZ7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729145322.GZ7600@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 29, 2020 at 07:53:22AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> In xfs/030, at some point we zero the entire AGFL.  Repair should really
> find and complain about the AGFL list item that points to the AG
> superblock.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
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

So this line is expected? This cause xfs/030 fails on old xfsprogs (on RHEL7 and
RHEL8).

>          - found root inode chunk
>  Phase 3 - for each AG...
>          - scan and clear agi unlinked lists...
> 

