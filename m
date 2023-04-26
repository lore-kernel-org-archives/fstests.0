Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016EBC77B78
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 15:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbjDZPzr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbjDZPzq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 11:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDAB44A1
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682524499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CkdMdL47XPe744Y0oTPDh9ugzpqZX4JDLYhkSvC/k6o=;
        b=VOVM8T9ayg28fdclAcWV781MT5tNV5/MOXAOO+m8yK3L9+zg9lsluhGyEYav8dzEOL934J
        f9pPdKfWeCLVSTXVzUqtdHtcQlhGYbcKPnLN655tK8AJKQeidi0khzyF8j4p3qPfanYQo4
        tDfG09yMvXsdLfCzvx+Pz+ZtAah0Bzc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-TEJ968QcM8C4xgf6Lww7Mg-1; Wed, 26 Apr 2023 11:54:56 -0400
X-MC-Unique: TEJ968QcM8C4xgf6Lww7Mg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 408B610504AD;
        Wed, 26 Apr 2023 15:54:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30276492B03;
        Wed, 26 Apr 2023 15:54:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230426144014.x73py4loqo6qkahz@zlang-mailbox>
References: <20230426144014.x73py4loqo6qkahz@zlang-mailbox> <20230424141042.450535-1-dhowells@redhat.com> <20230424141042.450535-4-dhowells@redhat.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 3/6] generic/317, afs: Allow for a filesystem not to honour the local uid/gid
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <868954.1682524494.1@warthog.procyon.org.uk>
Date:   Wed, 26 Apr 2023 16:54:54 +0100
Message-ID: <868955.1682524494@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Zorro Lang <zlang@redhat.com> wrote:

> Make sense. Maybe not only AFS need this, but that's another story in other
> patches

Yeah - it's something that network filesystems are likely to have to deal
with.

David

