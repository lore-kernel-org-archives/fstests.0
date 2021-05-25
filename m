Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBDC2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BBE61420
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhEYQrg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:47:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232935AbhEYQrf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 12:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621961165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VprZ4po5funiAZCEHkaoe1/DG/Uj/7X+Z8MTSVtsL+Q=;
        b=Dniqw7+QtGpq0+IDXpQy5xPzpYJBqjFcuXCo3ue6HUmnrpU59oF5qnTmfl2eHHoYJFYCKZ
        R2H+lY7voCeN4PxBHd8ApLVSoIC0Fa1efiCppV4Kj2Cd1aT+nr6m3jrwfuxoDJCetl2ubn
        wpbquVt90IR86NjR9sN+mKFa0rRP5i0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-D6Wo3I9IPSCk6Jjcmwa1PQ-1; Tue, 25 May 2021 12:46:03 -0400
X-MC-Unique: D6Wo3I9IPSCk6Jjcmwa1PQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCC36501E8;
        Tue, 25 May 2021 16:46:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 027FD60855;
        Tue, 25 May 2021 16:46:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210525162514.GH202095@locust>
References: <20210525162514.GH202095@locust> <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk> <162194968267.4011860.3593730881184557924.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH 8/9] generic/465: Fix handling of DIO alignment < sizeof(long)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4143734.1621961161.1@warthog.procyon.org.uk>
Date:   Tue, 25 May 2021 17:46:01 +0100
Message-ID: <4143735.1621961161@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Darrick J. Wong <djwong@kernel.org> wrote:

> I wonder if you ought to just change the posix_memalign call to match
> (somewhat more closely) what the other directio testers do:
> 
> 	ret = posix_memalign((void **)&wbuf, sysconf(_SC_PAGESIZE), blksize);
> 
> Since the alignment of the memory buffer doesn't necessarily have
> anything to do with the alignment of the read/write offset.

Fine by me, but I don't know if someone specifically wanted it to work like
this.

> (Longer term it would be /really/ nice to hoist DIOINFO to all the
> filesystems, and refactor fstests to use it consistently, but that's way
> too big of a request for this patchset.)

One thing I wanted for fsinfo() it to use the information exported by that to
inform testsuites of what a filesystem's capabilities are.

David

