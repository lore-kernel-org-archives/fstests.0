Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0007EC7618E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 15:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbjDZP6l (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbjDZP6k (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 11:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1804495
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682524674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/qNNaGb4sjDJe9mhC1HPe3Qm+4QSomF30PTYqejeMU=;
        b=LgrwoZUIMi7XgCYlTijN96XLjONFUIxZRQNL/X7JrD1ijuMi/cvYohjQdUiIQzYf/Eoxse
        gU4NZYUz820vmBBbHkgV7HpgNQtTGqIeLv58anNzGj7aMX0/5iBkTQzdqw7wwUehjSAJbW
        mknTKPW7tNKRcfQiEvaK2eqvDZQD3OM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-bmw0Uy7YMoOMGjsU5FnMVw-1; Wed, 26 Apr 2023 11:57:52 -0400
X-MC-Unique: bmw0Uy7YMoOMGjsU5FnMVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AEB2185A7A4;
        Wed, 26 Apr 2023 15:57:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0108A2166B41;
        Wed, 26 Apr 2023 15:57:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230426145149.mjsuugpgusqr6oj2@zlang-mailbox>
References: <20230426145149.mjsuugpgusqr6oj2@zlang-mailbox> <20230424141042.450535-1-dhowells@redhat.com> <20230424141042.450535-6-dhowells@redhat.com> <20230426144931.uxapfrnh6adcwevd@zlang-mailbox>
To:     Zorro Lang <zlang@redhat.com>
Cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 5/6] generic/531: Check for O_TMPFILE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <869115.1682524669.1@warthog.procyon.org.uk>
Date:   Wed, 26 Apr 2023 16:57:49 +0100
Message-ID: <869116.1682524669@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Zorro Lang <zlang@redhat.com> wrote:

> Oh, generic/530 is similar with 531, why only 531 need this one?

I didn't see it because 530 is already skipped:

	generic/530       [not run] afs does not support shutdown

David

