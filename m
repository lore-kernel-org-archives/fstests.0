Return-Path: <SRS0=6hky=CY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20CCC43461
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 12:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0832078E
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 12:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpBThftQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIOMVq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 08:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgIOMVo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 08:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600172503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=haOaeHADN3ilm54lTgFJYoIj33cumll3UIGbqpOmTEM=;
        b=GpBThftQXJxon1NvXK0HU+oBX81Qxe2oxLBXnGM7XxdOlxl2P4kNtWK4tKdMVHjZYmKGbA
        J6NiO39C9lXE5rgxaJ119QXybHGhCz2ti/cijj8a2LhyLjA+xLZFPYiVzCfiTEC81c45VP
        2QRuK4hsDXfauLZZYxJiqmg0dQDpojM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-PVtRqhmzNtieDUAWuAwPCA-1; Tue, 15 Sep 2020 08:21:41 -0400
X-MC-Unique: PVtRqhmzNtieDUAWuAwPCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85F11801AAF
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 12:21:40 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 026A160FC2;
        Tue, 15 Sep 2020 12:21:39 +0000 (UTC)
Date:   Tue, 15 Sep 2020 20:35:37 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
Message-ID: <20200915123536.GQ2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Pavel Reichl <preichl@redhat.com>,
        fstests@vger.kernel.org
References: <20200914153213.76894-1-preichl@redhat.com>
 <20200914153213.76894-2-preichl@redhat.com>
 <20200915115612.GP2937@dhcp-12-102.nay.redhat.com>
 <5ab30d99-6a9e-8751-d60b-57ceb89846fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab30d99-6a9e-8751-d60b-57ceb89846fe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 15, 2020 at 01:50:11PM +0200, Pavel Reichl wrote:
> 
> > 
> > If you don't need fsck at here, the _scratch_unmount (and the comment) isn't
> > needed either :)
> 
> Hi, thanks for the comment. I guess it's not important for the test itself...should I fix it and send another revision of the patch?

I think that depends on if Eryu would like to help to change it when he merges
your patch :)

> 

