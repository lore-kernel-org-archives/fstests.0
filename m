Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35B8C7618E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 15:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbjDZPyT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbjDZPyS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 11:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444FA4495
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682524406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+GmJ/ykKNACImgWGAfUrF7ql2iTpLYV776t7F918fA=;
        b=XZ4qerDxXxeXgxNamgmQfAJrEKn1kILzEmSlIjQqwfVoMG+vYDtHRXIcxUm7UiIN5PobCF
        m+6lJ5KWt0tLy7AFX235DtQ58aUDqrI2/Yk/ZXqXmCqr/dDODENvxCNjLqQkRZBC2E0s7q
        f+PcbQieXVbCciU18yU0sf9K5bPbQtU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-pbHgQt9JOmSXDP8MoJhzcA-1; Wed, 26 Apr 2023 11:53:24 -0400
X-MC-Unique: pbHgQt9JOmSXDP8MoJhzcA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9A81A0F385;
        Wed, 26 Apr 2023 15:53:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D93B5492B03;
        Wed, 26 Apr 2023 15:53:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230426143011.lktpz46bytvub6kh@zlang-mailbox>
References: <20230426143011.lktpz46bytvub6kh@zlang-mailbox> <20230424141042.450535-1-dhowells@redhat.com> <20230424141042.450535-2-dhowells@redhat.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 1/6] Add AFS support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <868872.1682524402.1@warthog.procyon.org.uk>
Date:   Wed, 26 Apr 2023 16:53:22 +0100
Message-ID: <868873.1682524402@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Zorro Lang <zlang@redhat.com> wrote:

> 
> I nearly forget we have this file :-D
> 
> If you'd like to update some docs about AFS testing, you can check
> README and README.config-sections.

I'll have a look at that.

> So I hope to double check with you if the mount source must be started with
> "%" ?

or "#", yes.  Have a look here:

	http://docs.openafs.org/AdminGuide/HDRWQ208.html#HDRWQ211

The in-kernel afs fs takes a string in afs mountpoint format as its source.

David

