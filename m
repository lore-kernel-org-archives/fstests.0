Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77921EB64DC
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Jul 2023 13:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGQNev (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Jul 2023 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjGQNet (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Jul 2023 09:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5BCAD
        for <fstests@vger.kernel.org>; Mon, 17 Jul 2023 06:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689600840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugGo+z9p3MDf5OH3St7ZwGVe2a6YZTIkFZ16p9UQmkE=;
        b=CQ0bPc0jXRYGzICovTOVVxZmBAM12CTKechVYa25aTww4KMov7Cgh9ZB/7nKVn+RnAoTKj
        Koajow74/u2J2rjFzGaCdNieh4hAQvHNz1E2YAgd4N9LiCT4A4edubzkTuFMBPaUK0AbJZ
        jIyiwEKSY9kMqdAXKPVOBgxI/EMSJgo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-3a5BH6j3NT6VfXfieg_1zw-1; Mon, 17 Jul 2023 09:27:53 -0400
X-MC-Unique: 3a5BH6j3NT6VfXfieg_1zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4D488A2D04;
        Mon, 17 Jul 2023 13:27:52 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BEF11454142;
        Mon, 17 Jul 2023 13:27:52 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id E7EA53096A42; Mon, 17 Jul 2023 13:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id E453A3F7CF;
        Mon, 17 Jul 2023 15:27:48 +0200 (CEST)
Date:   Mon, 17 Jul 2023 15:27:48 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
cc:     Zorro Lang <zlang@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] bcachefs: mark bch_inode_info and bkey_cached as
 reclaimable
In-Reply-To: <20230714171203.cwnid7jjs6oed5s6@moria.home.lan>
Message-ID: <df26cd9c-70b2-4353-2fc-73ee4c6e9f9@redhat.com>
References: <ea7fe56-dbac-27b8-33cc-5c722f366e63@redhat.com> <20230714171203.cwnid7jjs6oed5s6@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On Fri, 14 Jul 2023, Kent Overstreet wrote:

> On Thu, Jul 13, 2023 at 06:00:28PM +0200, Mikulas Patocka wrote:
> > Mark these caches as reclaimable, so that available memory is correctly
> > reported when there is a lot of cached inodes.
> > 
> > Note that more work is needed - you should add __GFP_RECLAIMABLE to some 
> > of the kmalloc calls, so that they are allocated from the "kmalloc-rcl-*" 
> > caches.
> 
> What's that actualy do? grepping for __GFP_RECLAIMABLE doesn't turn up
> much. Is it just about segragating objects based on expected lifetime,
> or is there more going on?

If you run the test 558 of the XFS testsuite (with the Darrick's forkbomb 
fix), the "free" command shows that there is large amount of memory in the 
"used" column. That is wrong because the test doesn't allocate much memory 
and it doesn't pin down many inodes simultaneously.

If you mark the slab cache with SLAB_RECLAIM_ACCOUNT, the memory allocated 
from this slab cache will be accounted in the "SReclaimable" bucket in 
/proc/meminfo and the "free" command will report it in the "buff/cache" 
column rather than in the "used" column.

If you use __GFP_RECLAIMABLE on kmalloc, the memory is allocated from the 
"kmalloc-rcl-*" caches and it will be accounted in the "SReclaimable" 
bucket.


When I run that test (with slab_nomerge kernel parameter), "slabtop" shows 
that there is large amount of memory allocated from "bch_inode_info", 
"bkey_cached", "dentry" and "kmalloc-256" slab caches.

"dentry" is already reclaimable. "bch_inode_info" and "bkey_cached" is 
fixed by my patch. I don't know where the "kmalloc-256" allocation is 
coming from, but you should use __GFP_RECLAIMABLE there, so that the 
used-vs-cached memory is properly reported.

Mikulas

