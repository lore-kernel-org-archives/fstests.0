Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D65EC433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jan 2021 02:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E4064DD6
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Jan 2021 02:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhA1Cqs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Jan 2021 21:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhA1Cqq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jan 2021 21:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611801918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D35EkOob8nTi5oBepUcf0H247CsQXrdMY7H34B4hTSw=;
        b=HgXXqYS3RLuPE4fASrRQZJq3oDjZcc0ATj3dcRRgJ2xht6SHniOEM+B2txxv6B0DkzSGfb
        /ofoJWHWSFaFwdZvvuTb1JiiAPuGKt4L+r17hyeZfv+vY7UI6hxBoNMy7tbWG85wVYWAno
        O/9/03Kde8O2nvAiXxKz2u8l2GdiWD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-KuFoeGz4P1OOdqFUFmNAiw-1; Wed, 27 Jan 2021 21:45:16 -0500
X-MC-Unique: KuFoeGz4P1OOdqFUFmNAiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B54107ACF5;
        Thu, 28 Jan 2021 02:45:16 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7755C10016F5;
        Thu, 28 Jan 2021 02:45:15 +0000 (UTC)
Date:   Thu, 28 Jan 2021 11:02:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/233,270: unlimit the max locked memory size for
 io_uring
Message-ID: <20210128030209.GO14354@localhost.localdomain>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org
References: <20210127072143.247849-1-zlang@redhat.com>
 <20210127234340.GD7695@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127234340.GD7695@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 27, 2021 at 03:43:40PM -0800, Darrick J. Wong wrote:
> On Wed, Jan 27, 2021 at 03:21:43PM +0800, Zorro Lang wrote:
> > The ltp/fsstress always fails on io_uring_queue_init() by returnning
> > ENOMEM. Due to io_uring accounts memory it needs under the rlimit
> > memlocked option, which can be quite low on some setups, especially
> > on 64K pagesize machine. root isn't under this restriction, but
> > regular users are. So only g/233 and g/270 which use $qa_user to run
> > fsstress are failed.
> > 
> > To avoid this failure, set max locked memory to unlimited before doing
> > fsstress, then restore it after test done.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/generic/233 | 8 ++++++++
> >  tests/generic/270 | 8 ++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/tests/generic/233 b/tests/generic/233
> > index 7eda5774..342690c2 100755
> > --- a/tests/generic/233
> > +++ b/tests/generic/233
> > @@ -43,6 +43,13 @@ _fsstress()
> >  -f rename=10 -f fsync=2 -f write=15 -f dwrite=15 \
> >  -n $count -d $out -p 7`
> >  
> > +	# io_uring accounts memory it needs under the rlimit memlocked option,
> > +	# which can be quite low on some setups (especially 64K pagesize). root
> > +	# isn't under this restriction, but regular users are. To avoid the
> > +	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
> > +	# temporarily.
> > +	lmem=`ulimit -l`
> > +	ulimit -l unlimited
> 
> Should this apply to all the other tests that run fsstress?
> 
> $ grep -l FSSTRESS_PROG tests/ | wc -l
> 94

The root user isn't under this restriction, only g/233 and g/270 run fsstress
with non-root user ($qa_user).
Hmm... is that possible to run xfstests with a non-root user? Or you'd like to
write a common helper _fsstress() (if run fsx with non-root user, I doubt it's
needed too)...

Thanks,
Zorro

> 
> --D
> 
> >  	echo "fsstress $args" >> $seqres.full
> >  	if ! su $qa_user -c "$FSSTRESS_PROG $args" | tee -a $seqres.full | _filter_num
> >  	then
> > @@ -50,6 +57,7 @@ _fsstress()
> >  		cat $tmp.out | tee -a $seqres.full
> >  		status=1
> >  	fi
> > +	ulimit -l $lmem
> >  }
> >  
> >  # real QA test starts here
> > diff --git a/tests/generic/270 b/tests/generic/270
> > index 3d8656d4..bd52d56e 100755
> > --- a/tests/generic/270
> > +++ b/tests/generic/270
> > @@ -37,6 +37,13 @@ _workout()
> >  	cp $FSSTRESS_PROG  $tmp.fsstress.bin
> >  	$SETCAP_PROG cap_chown=epi  $tmp.fsstress.bin
> >  
> > +	# io_uring accounts memory it needs under the rlimit memlocked option,
> > +	# which can be quite low on some setups (especially 64K pagesize). root
> > +	# isn't under this restriction, but regular users are. To avoid the
> > +	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
> > +	# temporarily.
> > +	lmem=`ulimit -l`
> > +	ulimit -l unlimited
> >  	(su $qa_user -c "$tmp.fsstress.bin $args" &) > /dev/null 2>&1
> >  
> >  	echo "Run dd writers in parallel"
> > @@ -50,6 +57,7 @@ _workout()
> >  	done
> >  
> >  	$KILLALL_PROG -w $tmp.fsstress.bin
> > +	ulimit -l $lmem
> >  }
> >  
> >  # real QA test starts here
> > -- 
> > 2.29.2
> > 
> 

