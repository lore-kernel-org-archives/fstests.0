Return-Path: <SRS0=6hky=CY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C78C433E2
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D03208E4
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 12:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flP2WkzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgIOM0x (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 08:26:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55066 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgIOM0G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 08:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600172765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OkKYSkKyk8wqT+OScl34FkUVe3j0wndiq0Ur+o1OS04=;
        b=flP2WkzTGHkIMsV1VrcPJvjDT4qkA0kNlrDoK009acU9k/OeOuqbutXRjxVk18V6nVjlIC
        4BgYbY1g81ZfrDfjP3fWTE5BNdEQMvWqlGmJTuVekIEeX/EU4WJWaA6xnI4kZGhv1P0Nar
        upTLXq1C0rOAxL1gdMcAI6b64RHZKlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-kVF_AJT_OhyqOe5C87zZeg-1; Tue, 15 Sep 2020 08:26:03 -0400
X-MC-Unique: kVF_AJT_OhyqOe5C87zZeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D7E419611CB
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 12:25:56 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28ACA19C4F
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 12:25:55 +0000 (UTC)
Date:   Tue, 15 Sep 2020 20:39:53 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 01/24] xfs/331: don't run this test if fallocate isn't
 supported
Message-ID: <20200915123952.GR2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013418077.2923511.4423324916550074038.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013418077.2923511.4423324916550074038.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:00PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> This test requires fallocate, so make sure that actually works before
> running it.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  tests/xfs/331 |    1 +
>  1 file changed, 1 insertion(+)
> 
> 
> diff --git a/tests/xfs/331 b/tests/xfs/331
> index b26ea155..501dd1f8 100755
> --- a/tests/xfs/331
> +++ b/tests/xfs/331
> @@ -32,6 +32,7 @@ _supported_fs xfs
>  _require_scratch
>  _require_xfs_scratch_rmapbt
>  _require_scratch_reflink
> +_require_xfs_io_command "falloc"

Good to me.
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _require_test_program "punch-alternating"
>  
>  rm -f "$seqres.full"
> 

