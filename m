Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD32C47080
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AAE61209
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 14:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhFAOdj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234014AbhFAOdj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Jun 2021 10:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622557917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0kIVxFFLvd0VubAw03D0PdMy33h9cH2W370Me+anBzE=;
        b=Ltpmdizp5k7hWwlHI7GXaA4eNbc94avqwyR5bk0ccxWe9yL/sBrZV5T1/G+5CUwOS8h2uk
        rLk/4xZSoD9A7Yb1n3aCorZ1cPVsV7k/TKoWWlWl15eRJSgKuRz6cfRTQYfL9o9WUuwtfm
        SCysoa4CdawwhaHOHk1b2gmI9PHtU7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-AZnsDlA7Ny6uTA2MOvEiEQ-1; Tue, 01 Jun 2021 10:31:54 -0400
X-MC-Unique: AZnsDlA7Ny6uTA2MOvEiEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C040E106BB3E;
        Tue,  1 Jun 2021 14:31:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8AFC5D769;
        Tue,  1 Jun 2021 14:31:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YLOJ9h734bmR140Z@desktop>
References: <YLOJ9h734bmR140Z@desktop> <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk> <162194964249.4011860.17729034205311880257.stgit@warthog.procyon.org.uk>
To:     Eryu Guan <guan@eryu.me>
Cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH 2/9] generic/294, afs: Allow for mknod subtest failing if mknod not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1448891.1622557912.1@warthog.procyon.org.uk>
Date:   Tue, 01 Jun 2021 15:31:52 +0100
Message-ID: <1448892.1622557912@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Eryu Guan <guan@eryu.me> wrote:

> _require_mknod checks for mknod support by trying to mknod and _notrun
> the test if mknod fails.
> 
> So does afs return any failure like EOPNOTSUPP? If so I think we could
> refactor _require_mknod into something like

afs doesn't provide a ->mknod implementation as it doesn't support anything
you'd create with it, so you get the VFS default in such an instance - which
would be EPERM.

David

