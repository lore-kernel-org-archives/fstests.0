Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8491C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F886141C
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhEYQpw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230377AbhEYQpu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 May 2021 12:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621961060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZFV0R4NluznbKaCAd+CCI0EvwV+gPxS6SZX14jG8K4k=;
        b=T3resDlx9PA1P46U0TnTV29jfYOQMD974da9ZqrhQQ188QzGDs/vRAyRUiNO0MOkWlnANO
        51l22LuhHEmE8YbOj0DyzC0rs5a2QIbEt6BPkHbTM2WfR04rqtCF4l8U4uo/qtvxGfdSsc
        JPM8Znn7qkpXMSlA40A6N/6oVXRcGJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-rdtSJB2KPRKa8-3vpNM3UA-1; Tue, 25 May 2021 12:44:18 -0400
X-MC-Unique: rdtSJB2KPRKa8-3vpNM3UA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 984021007477;
        Tue, 25 May 2021 16:44:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-24.rdu2.redhat.com [10.10.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5A215D6AC;
        Tue, 25 May 2021 16:44:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210525161926.GF202095@locust>
References: <20210525161926.GF202095@locust> <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk> <162194966265.4011860.229488885734976223.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH 5/9] generic/123, generic/128, afs: Allow for an fs that does its own perm management
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4143610.1621961055.1@warthog.procyon.org.uk>
Date:   Tue, 25 May 2021 17:44:15 +0100
Message-ID: <4143611.1621961055@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Darrick J. Wong <djwong@kernel.org> wrote:

> > Signed
> 
> Looks ok,
> Reviewed
> 
> (I'll send the rest when the remainder of the SoB comes in. :P)

Oops.  That should be:

Signed-off-by: David Howells <dhowells@redhat.com>

