Return-Path: <SRS0=6UmA=54=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A65C2BA2B
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Apr 2020 06:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB10206C3
	for <linux-fstests@archiver.kernel.org>; Sun, 12 Apr 2020 06:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZB3c7YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDLG0K (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 12 Apr 2020 02:26:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49449 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725832AbgDLG0K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 12 Apr 2020 02:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586672770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KlSAFMTFBmHmZDJTQWvEfgX6j80URK3qDJmmjsL2HeM=;
        b=NZB3c7YRsk61tJZACeSrOwATd+JtOKOs+pjIXR2eY/jG/rKOGNT0qxYziAU4Rjul6ymM6W
        gy4pZNAoDjvZH6coBgNtn6pUgQ69v8fvR2zh8JXrtkbbdWQxSMnNrybMq8JTpkRMsU7Kqm
        ux8vwUyQDBCOiX2CtEMTmn/G1fT1Aag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-eEUzC-uWPmm6JNiYdSfAtA-1; Sun, 12 Apr 2020 02:26:06 -0400
X-MC-Unique: eEUzC-uWPmm6JNiYdSfAtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C7EE107ACCA
        for <fstests@vger.kernel.org>; Sun, 12 Apr 2020 06:26:05 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E426B11A260
        for <fstests@vger.kernel.org>; Sun, 12 Apr 2020 06:26:04 +0000 (UTC)
Date:   Sun, 12 Apr 2020 14:38:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 0/4] Assign a few generic tests to additional groups
Message-ID: <20200412063814.GW14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <20200408135648.5824-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408135648.5824-1-vladimir@tuxera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 08, 2020 at 04:56:44PM +0300, Vladimir Zapolskiy wrote:
> The rationale behind the proposed changes is to correct and improve
> granularity of some generic tests, so it becomes possible to control
> lists of run tests better, if there is given additional information
> about a test environment and tested filesystems.
> 
> Vladimir Zapolskiy (4):
>   Add generic/459 test to freeze group of tests
>   Add generic/482 test to thin group of tests
>   Add generic/529 test to acl group of tests
>   Add generic/530 test to shutdown group of tests

That's fine for me, to set more sub-cases in proper groups. Due to generally
when someone writes a case, we don't take care of its group list so much.

> 
>  tests/generic/group | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> -- 
> 2.25.1
> 

