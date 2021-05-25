Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F631C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E7661413
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEYQVR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhEYQVQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 12:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621959586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XtemXv9oiuoigVCj6nfsKmFkiRe7ld/rOJSj64CZr2Y=;
        b=EO51mGmJDiXoliFOgEmMY97JjGn4MvFHy31yXkSSdo0Pe8XCjCN8VCyIqd6v+M/IWTzzzC
        IrYoJvl2JbdQstZ2j01euX73+bjScSS8ln3MNKY2o6+dWF0a/dTKz/xmgSJcZJWATOQt2g
        cgTomYdcqMvvzBgk4zWoDbVjDYbfDUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-5m2mkDihOE2nupeHsOALsw-1; Tue, 25 May 2021 12:19:44 -0400
X-MC-Unique: 5m2mkDihOE2nupeHsOALsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2050FC88;
        Tue, 25 May 2021 16:19:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E345B5D9CD;
        Tue, 25 May 2021 16:19:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210525160959.GC202095@locust>
References: <20210525160959.GC202095@locust> <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk> <162194964249.4011860.17729034205311880257.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH 2/9] generic/294, afs: Allow for mknod subtest failing if mknod not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4141824.1621959580.1@warthog.procyon.org.uk>
Date:   Tue, 25 May 2021 17:19:41 +0100
Message-ID: <4141825.1621959581@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Darrick J. Wong <djwong@kernel.org> wrote:

> > +	_require_mknod
> 
> I don't see a _require_mknod being added to common/rc?

It preexists:

	warthog>git grep _require_mknod
	common/rc:_require_mknod()

but it seems that _has_mknod should be documented in conjunction with it so
that the difference is more obvious.

David

