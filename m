Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E4CEB64DA
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 18:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGLSAA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjGLR77 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 13:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9301A1FF7
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689184751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5M3Ra+Z/cKCO1Uy3+O8XQbGHBrCGYwJZ1mCOq4gOuEE=;
        b=dSkaEzluAd+bGXx+6CC+mUWRKJ5Zn5BMfcl71eh8cvFKyWLNB6H2HATULUs0oOkKtRK7gN
        +i6Bh8Ig3ZxqQyBHfuihYwQTr4BmlNEVJNxA6VpGz1BNPzoBeyXHMmU/U5+WXEFbmMckPH
        W4g1LVl4P29PNK17scWWwOfnjaWgeCw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-iLN9rbzEP9aNyxf_hzD0Vg-1; Wed, 12 Jul 2023 13:59:08 -0400
X-MC-Unique: iLN9rbzEP9aNyxf_hzD0Vg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF0391C0E0CC;
        Wed, 12 Jul 2023 17:59:07 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9648492B01;
        Wed, 12 Jul 2023 17:59:07 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id A655B3096A42; Wed, 12 Jul 2023 17:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id A29C83F7CF;
        Wed, 12 Jul 2023 19:59:07 +0200 (CEST)
Date:   Wed, 12 Jul 2023 19:59:07 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
In-Reply-To: <20230712145252.35xgebxg4i4a6g7e@moria.home.lan>
Message-ID: <173ce5a9-5494-3ac2-e121-63a838734e1c@redhat.com>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com> <20230711234439.GC11442@frogsfrogsfrogs> <20230712010939.2htp62rd7qvshgiy@moria.home.lan> <758f1d7d-2411-848f-6773-b8873d8dce83@redhat.com> <20230712145252.35xgebxg4i4a6g7e@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On Wed, 12 Jul 2023, Kent Overstreet wrote:

> On Wed, Jul 12, 2023 at 12:10:05PM +0200, Mikulas Patocka wrote:
> > If we hit the limit of total open files, we already killed the system. At 
> > this point the user can't execute any program because executing a programs 
> > requires opening files.
> > 
> > I think that it is possible to setup cgroups so that a process inside a 
> > cgroup can't kill the machine by exhausting resources. But distributions 
> > don't do it. And they don't do it for a root user (the test runs under 
> > root).
> 
> When I looked at this test before I missed the fork bomb aspect - was
> just looking at the crazy numbers of pinned inodes (which is still a
> significant fraction of system memory, looking again...)
> 
> If we change bcachefs to not report a maximum number of inodes, might
> that be more in line with other filesystems? Or is it really just
> because bcachefs inodes are tiny?

I think that it's OK to report as many free inodes as it fits on the 
filesystem. I think it is not a bug - we should fix the test, not lie to 
make the test pass.

There is one misbehavior though. As the test allocates the inodes on 
bcachefs, the total number of inodes is decreasing. The other filesystems 
don't behave in this way and I think that bcachefs shouldn't change the 
total number of inodes too.

Mikulas

