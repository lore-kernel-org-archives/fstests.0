Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC8C7618E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 20:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjDZUdb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 16:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZUda (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 16:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A2F2121
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682541165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjZLrZ4HWCAbjYN9DFcg+Pzuq7bM354wueAHS+wuQ5c=;
        b=JY0mpB1rRkZtV2oKuYSbyRNDrkrcqhH1cloHAIqRYOTET1JCtvYr8OM4eaZDmFXBT2zTPL
        W3G9zOuVoIQ+LjSeuolKTBhKARYIpVizdF3J9889BM9Nc5eUaN+zmZ3KlAZ8rL4u5cJOJM
        TisL4qcxUdmj8r1GeOwS/doCjcnOzaI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-Ja1dNI7DOi2d_j9qiWY15g-1; Wed, 26 Apr 2023 16:32:43 -0400
X-MC-Unique: Ja1dNI7DOi2d_j9qiWY15g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 829721C05137;
        Wed, 26 Apr 2023 20:32:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88E241121315;
        Wed, 26 Apr 2023 20:32:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230426194018.hrq3pme5wkxia5pm@zlang-mailbox>
References: <20230426194018.hrq3pme5wkxia5pm@zlang-mailbox> <20230426143011.lktpz46bytvub6kh@zlang-mailbox> <20230424141042.450535-1-dhowells@redhat.com> <20230424141042.450535-2-dhowells@redhat.com> <868873.1682524402@warthog.procyon.org.uk>
To:     Zorro Lang <zlang@redhat.com>
Cc:     dhowells@redhat.com, fstests@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 1/6] Add AFS support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <883620.1682541160.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 26 Apr 2023 21:32:40 +0100
Message-ID: <883621.1682541160@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Zorro Lang <zlang@redhat.com> wrote:

> > The in-kernel afs fs takes a string in afs mountpoint format as its so=
urce.
> =

> So do we need to change the below line:
> =

>   echo $SCRATCH_DEV | grep -q "^%" > /dev/null 2>&1
> =

> to
> =

>   echo "$SCRATCH_DEV" | grep -q ^[%#] =

> =

> ?

I think we want to require '%' to force a RW volume.  xfstests probably wo=
n't
work on a RO or backup volume.

David

