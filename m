Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29736C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0572E6141D
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhEYQm5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230377AbhEYQm4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 12:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621960886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CbLbI64hFVMjOZ/WN3KJVLMI8ZZo0LNM8ndJuEGsWB4=;
        b=PGBxi/1JWLcnh6ogKG7rWHOmi1gPRLDo9NPOcuqkg8MOL9b6dTG0F4Iwzs2kYKna/EE0+h
        1IF9scGolRZlHVnHUeWkGkIvwwDY/YIcvVcOuydqIw8GAPSsvHCs3/59tpOM6EeTZ2zQxJ
        MjaTBxsAJKzR818yDr/Nzqt6UntsgCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-fawJUXeyNruBMa0X2fKLYQ-1; Tue, 25 May 2021 12:41:22 -0400
X-MC-Unique: fawJUXeyNruBMa0X2fKLYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64465803622;
        Tue, 25 May 2021 16:41:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943FC5D6AC;
        Tue, 25 May 2021 16:41:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210525161730.GE202095@locust>
References: <20210525161730.GE202095@locust> <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk> <162194965595.4011860.7333324355639736586.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH 4/9] generic/317, afs: Allow for a filesystem not to honour the local uid/gid
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4143271.1621960877.1@warthog.procyon.org.uk>
Date:   Tue, 25 May 2021 17:41:17 +0100
Message-ID: <4143272.1621960877@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Darrick J. Wong <djwong@kernel.org> wrote:

> > +_require_use_local_uidgid()
> 
> I find "local uid" to be misleading here -- I read it as "requires
> system to use local user/group ids", as opposed to getting user and
> group data from an external service like NIS/YP/AD.
>
> What you're really testing for is that new files inherit the fs[ug]id of
> the process.  How about we make that explicit in the name:
> 
> _require_inherit_process_fsuid()
> _require_inherit_process_fsgid()
> 
> ?

Um.  I'm not sure "inherit" is the right verb here.  Or "require" for that
matter.  Would it make more sense to state it differently?  Maybe say what is
being checked:

	_test_expects_inode_to_get_fsuid
	_test_expects_inode_to_get_fsgid

or maybe:

	_expects_filesystem_to_set_owner_from_fsuid

though that could also be:

	_require_filesystem_to_set_owner_from_fsuid

David

