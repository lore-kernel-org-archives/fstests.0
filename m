Return-Path: <SRS0=ARln=6E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD98BC3815B
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 14:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA595206DD
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Apr 2020 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md3uV6vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgDTOYh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:24:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29020 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728371AbgDTOYh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Apr 2020 10:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587392675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxO3Gb9YS2WnU3We2vwG5Ebh2DmOqXRT7bTsemugxqU=;
        b=Md3uV6vhaLUosCnBSpH3E9/nuwac9I+LOF2vOwTjARlme4bqhmO2a6M6gCfGo0P1vipwiV
        GWLvzYgst+RZvRbtR9Zujz64rHyPSfxSOMHAdXP76LyIZiRM13zHBdOHPB0PWjWfPAsnTh
        cdro6xyXizA3FxOWI3q5QxJYlmrhxXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-ApaYeZm8OeyzXmgUhj5syw-1; Mon, 20 Apr 2020 10:24:23 -0400
X-MC-Unique: ApaYeZm8OeyzXmgUhj5syw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80A158017FC;
        Mon, 20 Apr 2020 14:24:22 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECC6C11E7F3;
        Mon, 20 Apr 2020 14:24:21 +0000 (UTC)
Date:   Mon, 20 Apr 2020 10:24:20 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH xfstests] generic: test reporting of wb errors via
 syncfs
Message-ID: <20200420142420.GK27516@bfoster>
References: <20200414120740.293998-1-jlayton@kernel.org>
 <20200417153620.GA13463@bfoster>
 <d80c659f7755dadf218ba03f23da277811840475.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d80c659f7755dadf218ba03f23da277811840475.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 20, 2020 at 07:33:27AM -0400, Jeff Layton wrote:
> On Fri, 2020-04-17 at 11:36 -0400, Brian Foster wrote:
> > On Tue, Apr 14, 2020 at 08:07:40AM -0400, Jeff Layton wrote:
> > > From: Jeff Layton <jlayton@redhat.com>
> > > 
> > > Add a test for new syncfs error reporting behavior. When an inode fails
> > > to be written back, ensure that a subsequent call to syncfs() will also
> > > report an error.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  tests/generic/999     | 98 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/999.out |  8 ++++
> > >  tests/generic/group   |  1 +
> > >  3 files changed, 107 insertions(+)
> > >  create mode 100755 tests/generic/999
> > >  create mode 100644 tests/generic/999.out
> > > 
> > > diff --git a/tests/generic/999 b/tests/generic/999
> > > new file mode 100755
> > > index 000000000000..7383ce24c8fd
> > > --- /dev/null
> > > +++ b/tests/generic/999
> > > @@ -0,0 +1,98 @@
> > > +#! /bin/bash
> > > +# FS QA Test No. 999
> > > +#
> > > +# Open a file and write to it and fsync. Then, flip the data device to throw
> > > +# errors, write to it again and do an fdatasync. Then open an O_RDONLY fd on
> > > +# the same file and call syncfs against it and ensure that an error is reported.
> > > +# Then call syncfs again and ensure that no error is reported. Finally, repeat
> > > +# the open and syncfs and ensure that there is no error reported.
> > > +#
> > > +#-----------------------------------------------------------------------
> > > +# Copyright (c) 2020, Jeff Layton <jlayton@kernel.org>
> > > +#
> > > +# This program is free software; you can redistribute it and/or
> > > +# modify it under the terms of the GNU General Public License as
> > > +# published by the Free Software Foundation.
> > > +#
> > > +# This program is distributed in the hope that it would be useful,
> > > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > +# GNU General Public License for more details.
> > > +#
> > > +# You should have received a copy of the GNU General Public License
> > > +# along with this program; if not, write the Free Software Foundation,
> > > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > > +#-----------------------------------------------------------------------
> > 
> > I think the big copyright hunk has been replaced with the
> > SPDX-License-Identifier thing (see other tests for reference).
> > 
> 
> Thanks. Will fix.
> 
> > > +
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +here=`pwd`
> > > +tmp=/tmp/$$
> > > +status=1    # failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +	_dmerror_cleanup
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/dmerror
> > > +
> > > +# real QA test starts here
> > > +_supported_os Linux
> > > +_require_scratch_nocheck
> > > +# This test uses "dm" without taking into account the data could be on
> > > +# realtime subvolume, thus the test will fail with rtinherit=1
> > > +_require_no_rtinherit
> > > +_require_dm_target error
> > > +
> > > +rm -f $seqres.full
> > > +
> > > +echo "Format and mount"
> > > +_scratch_mkfs > $seqres.full 2>&1
> > > +_dmerror_init
> > > +_dmerror_mount
> > > +
> > > +datalen=65536
> > > +_require_fs_space $SCRATCH_MNT $datalen
> > 
> > That seems unnecessary for such a small value. BTW, any reason this
> > needs to write more than a page?
> > 
> 
> No reason for that size. I think I just copied that from generic/487
> since I started with that one as a template. I'll cut it down to a page.
> 
> Should I not bother calling _require_fs_space here since it's so small?
> I wasn't sure how strict that was...
> 

I'm not sure there's a rule for when to use it or not (it's probably
just up to Eryu's preference), but yeah, it's probably overkill for a
test that's only writing a handful of pages.

Brian

> > > +
> > > +# use fd 5 to hold file open
> > > +testfile=$SCRATCH_MNT/syncfs-reports-errors
> > > +exec 5>$testfile
> > > +
> > 
> > Also what's the reason for holding an fd on the test file like this?
> > Does this affect error reporting behavior in some way? Otherwise the
> > rest looks reasonable to me.
> > 
> 
> Again, copied from 487. It's not necessary for this test. I'll switch
> that to just "touch testfile" at the start and get rid of the follow-on
> close.
> 
> Thanks for the review!
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

