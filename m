Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630BCEB64D9
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jul 2023 09:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGLJ6n (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGLJ6m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 05:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88681711
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 02:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689155873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFS9j56BRcd0O3sofSGF4mNiBoVJjk1/Ax2DlPDn9lw=;
        b=ICU9SqFfefvrITjIHtkfi5Qekzlt0BtwLcdfFPumeMiuBOEFSvd8NWAit53uv1poymQOaz
        4EYqlmwzg0IGrJ8fSTRRJsKzpukftQgokhnHtJHUXK5wDJpSUqYP6SZOuIvxhELWS/ovZS
        M1nAm+7OsoTP6wnm1zFF8/h60stipto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-XoD3SbezOW-qaOisz3wLCQ-1; Wed, 12 Jul 2023 05:57:50 -0400
X-MC-Unique: XoD3SbezOW-qaOisz3wLCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A45701044589;
        Wed, 12 Jul 2023 09:57:49 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9013640C206F;
        Wed, 12 Jul 2023 09:57:49 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 7AEB530C0457; Wed, 12 Jul 2023 09:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 770833FB76;
        Wed, 12 Jul 2023 11:57:49 +0200 (CEST)
Date:   Wed, 12 Jul 2023 11:57:49 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
cc:     Eryu Guan <eguan@redhat.com>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
In-Reply-To: <20230711234439.GC11442@frogsfrogsfrogs>
Message-ID: <95f466a-56ef-291f-cad4-474617814a19@redhat.com>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com> <20230711234439.GC11442@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On Tue, 11 Jul 2023, Darrick J. Wong wrote:

> On Tue, Jul 11, 2023 at 05:51:42PM +0200, Mikulas Patocka wrote:
> > When I run the test 558 on bcachefs, it works like a fork-bomb and kills
> > the machine. The reason is that the "while" loop spawns "create_file"
> > subprocesses faster than they are able to complete.
> > 
> > This patch fixes the crash by limiting the number of subprocesses to 128.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > ---
> >  tests/generic/558 |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > Index: xfstests-dev/tests/generic/558
> > ===================================================================
> > --- xfstests-dev.orig/tests/generic/558
> > +++ xfstests-dev/tests/generic/558
> > @@ -48,6 +48,7 @@ echo "Create $((loop * file_per_dir)) fi
> >  while [ $i -lt $loop ]; do
> >  	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
> >  	let i=$i+1
> > +	if [ $((i % 128)) = 0 ]; then wait; fi
> 
> Hm.  $loop is (roughly) the number of free inodes divided by 1000.  This
> test completes nearly instantly on XFS; how many free inodes does
> bcachefs report after _scratch_mount?
> 
> XFS reports ~570k inodes, so it's "only" starting 570 processes.
> 
> I think it's probably wise to clamp $loop to something sane, but let's
> get to the bottom of how the math went wrong and we got a forkbomb.
> 
> --D

bcachefs reports 14509106 total inodes (for a 1GB filesystem)

As the test proceeds, the number of total inodes (as well as the number of 
free inodes) decreases.

Mikulas

