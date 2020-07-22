Return-Path: <SRS0=o+XN=BB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DACC433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 05:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9686207BB
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 05:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nie5kFV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGVFEA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:04:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38979 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727001AbgGVFEA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jul 2020 01:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595394238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QP3HzPIk/hYmRBou710NypXrwrB75xjSacRo3zsvjU=;
        b=Nie5kFV1Fu+kCiD02BQyE92xZfRuXPGviSDtxMrg9sntqEPbQIjEGbP8Wx9NHMzKZ82491
        9wyBsPH7tggkVgC6dHhEIIzJ0nC6QpJ/+CJUN14yKfHJ5hdNtHtgv3p12pCfMNlCWOReEs
        eoKRNwRkNWmmjlrxPiLKhlYKWuOEFw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-38eaUKukP9ekFXhCAN6wOw-1; Wed, 22 Jul 2020 01:03:56 -0400
X-MC-Unique: 38eaUKukP9ekFXhCAN6wOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C66580183C;
        Wed, 22 Jul 2020 05:03:55 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9E7C5D9CA;
        Wed, 22 Jul 2020 05:03:54 +0000 (UTC)
Date:   Wed, 22 Jul 2020 13:16:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/175, generic/176: cleanup testdir before exit
Message-ID: <20200722051602.GA2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Murphy Zhou <jencce.kernel@gmail.com>,
        fstests@vger.kernel.org
References: <20200717044017.1598-1-jencce.kernel@gmail.com>
 <20200717055853.GB1938@dhcp-12-102.nay.redhat.com>
 <20200722031131.amr6qntxtihjcuzt@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722031131.amr6qntxtihjcuzt@xzhoux.usersys.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 22, 2020 at 11:11:31AM +0800, Murphy Zhou wrote:
> On Fri, Jul 17, 2020 at 01:58:53PM +0800, Zorro Lang wrote:
> > On Fri, Jul 17, 2020 at 12:40:17PM +0800, Murphy Zhou wrote:
> > > Usually the _mkfs helper will cleanup these directories at the
> > > beginning of testcase. However, when testing on NFS, the cleanup
> > > could be very slow and it is confusing that: We have already
> > 
> > The _scratch_mkfs logic for NFS is:
> >   [ -n "$SCRATCH_MNT" ] || return 1
> >   _scratch_mount
> >   rm -rf $SCRATCH_MNT/*
> >   _scratch_unmount
> > 
> > If you feel NFS is 'very slow', and isn't normal, you can check how
> > NFS is dealing with the reflink file of g/175.
> > 
> > > started to run generic/176 but we get stuck in _mkfs, cleaning
> > > up files left by the previous testcase generic/175.
> > 
> > Hmm... that makes more sense than above reason, although we generally
> > don't cleanup SCRATCH_MNT/* at the end of a case. Due to if you need to
> > cleanup SCRATCH_MNT/* for NFS, why only these 2 cases need to do that?
> > We might need a better reason/comment to explain, e.g. it cover a issue
> > of NFS?
> > 
> > BTW, the cleanup operation can be in _cleanup() function, likes:
> >   [ -d "$testdir" ] && rm -rf $testdir
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > To be clear, cleanup testdir before exit. Also, deleting files
> > > should be part of the stress test.
> 
> These 2 lines are the real reasons for adding this.

Yeah, I see. I mean if for this reason, too lots of cases need to do
'rm -rf $SCRATCH_MNT/*' at the end, due to most of them leave something
in $SCRATCH_MNT/ , and will be cleaned by next _scratch_mkfs*, especially
for un-local filesystem(e.g. NFS, CIFS, glusterfs ...). They all make no
sense.

If only cleanup $SCRATCH_MNT/* in g/175 and g/176, the reason is better to be
'cover a known issue' when cleanup $SCRATCH_MNT in g/175 and g/176. That's
my personal review point :)

Thanks,
Zorro



> 
> Thanks!
> 
> > > 
> > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > ---
> > >  tests/generic/175 | 1 +
> > >  tests/generic/176 | 1 +
> > >  2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/tests/generic/175 b/tests/generic/175
> > > index 79e5b3d6..bd966a28 100755
> > > --- a/tests/generic/175
> > > +++ b/tests/generic/175
> > > @@ -61,6 +61,7 @@ bytes=$((blks * blksz))
> > >  echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
> > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > >  
> > > +rm -rf $testdir
> > >  # success, all done
> > >  status=0
> > >  exit
> > > diff --git a/tests/generic/176 b/tests/generic/176
> > > index a084578a..bc83762e 100755
> > > --- a/tests/generic/176
> > > +++ b/tests/generic/176
> > > @@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
> > >  echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
> > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > >  
> > > +rm -rf $testdir
> > >  # success, all done
> > >  status=0
> > >  exit
> > > -- 
> > > 2.20.1
> > > 
> > 
> 
> -- 
> Murphy
> 

